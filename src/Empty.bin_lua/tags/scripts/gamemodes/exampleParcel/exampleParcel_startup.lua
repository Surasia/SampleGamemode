--## SERVER

REQUIRES('scripts\ParcelLibrary\GlobalParcels\RoundBasedMPModeStartupHelper.lua');
REQUIRES('scripts\GameModes\ExampleParcel\ExampleParcel.lua');

function startup.ExampleParcel():void
	local modeStartupArgs = hmake MPModeStartupArgs
	{
		modeParcel = ExampleParcel,

		defaultInitArgs = GlobalModeInitData.Slayer.DefaultArgs,
		initArgsClassType = "SlayerInitArgs",
		overrideInitArgsFuncName = "GetOverrideSlayerArgs",

		matchIntroMPLuaCall = "__OnExampleParcelIntro",
	};

	RegisterRoundBasedMPMode(modeStartupArgs);
end