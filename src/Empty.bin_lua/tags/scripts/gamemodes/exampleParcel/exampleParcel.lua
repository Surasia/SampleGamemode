--## SERVER

REQUIRES('scripts\GameModes\ExampleParcel\debug.lua');

global ExampleParcel:table = Parcel.MakeParcel
{
	complete = false,
	instanceName = "ExampleParcel",
};

function ExampleParcel:New(initArgs:SlayerInitArgs):table
	local newExampleParcel = self:CreateParcelInstance();
	newExampleParcel.instanceName = initArgs.instanceName;
	return newExampleParcel;
end

function ExampleParcel:Run():void
	SleepUntilIntroComplete();
end

function ExampleParcel:Initialize():void
	self:RegisterGlobalEventOnSelf(g_eventTypes.weaponPickupEvent, self.HandleWeaponPickedUp);
end

function ExampleParcel:HandleWeaponPickedUp(eventArgs:WeaponPickupEventStruct):void
	Toggle_RenderDebugMode();
end
