--## SERVER

global MPModeInstance:table = nil;

function RegisterRoundBasedMPMode(startupArgs:MPModeStartupArgs):void
	RegisterGlobalEvent(g_eventTypes.roundStartEvent, MPModeRoundStartHandler, startupArgs);

	RegisterIntroEventHandlers(startupArgs.matchIntroMPLuaCall);
end

function MPModeRoundStartHandler(eventArgs:RoundStartEventStruct, modeStartupArgs:MPModeStartupArgs):void
	local initArgs = modeStartupArgs.defaultInitArgs;

	if (modeStartupArgs.overrideInitArgsFuncName ~= nil and modeStartupArgs.overrideInitArgsFuncName ~= "") then
		local overrideInitArgsFunc:ifunction = _G[modeStartupArgs.overrideInitArgsFuncName];
		if (overrideInitArgsFunc ~= nil) then
			local overrideArgs = overrideInitArgsFunc();
			if (overrideArgs ~= nil) then
				initArgs = overrideArgs;
			end
		end
	end

	if (modeStartupArgs.initArgsTransformFunc ~= nil) then
		initArgs = modeStartupArgs.initArgsTransformFunc(initArgs, eventArgs.roundIndex);
	end

	MPModeInstance = modeStartupArgs.modeParcel:New(initArgs);
	ParcelAddAndStart(MPModeInstance, initArgs.instanceName or "MPGameModeInstance");

	if (eventArgs.isOvertimeRound and modeStartupArgs.overtimeBonusRoundScoreLimitOverride ~= nil and modeStartupArgs.overtimeBonusRoundScoreLimitOverride >= 0) then
		VariantOverrides_SetScoreToWinRound(modeStartupArgs.overtimeBonusRoundScoreLimitOverride);
	end
end

function HandleMPModeMatchIntro_MapFlyBy(eventStruct:MapFlybyIntroStartEventStruct, introMpLuaCall:string):void
	local targetPlayer = nil;
	if eventStruct ~= nil then
		targetPlayer = eventStruct.targetPlayer;
	end
	MPLuaCall(introMpLuaCall, targetPlayer);
end

function HandleMPModeMatchIntro_Standard(eventArgs:RoundStartGameplayEventStruct, introMpLuaCall:string):void
	MPLuaCall(introMpLuaCall);
end

function RegisterIntroEventHandlers(introMpLuaCall:string):void
	if (introMpLuaCall ~= nil) then
		if (use_map_flyby_intro) then
			RegisterGlobalEvent(g_eventTypes.mapFlybyIntroStartEvent, HandleMPModeMatchIntro_MapFlyBy, introMpLuaCall);
		else
			RegisterGlobalEventOnce(g_eventTypes.roundStartGameplayEvent, HandleMPModeMatchIntro_Standard, introMpLuaCall);
		end
	end
end
