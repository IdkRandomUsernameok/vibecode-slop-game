-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local Signal = require(Modules.Lib.Signal);
local v1 = {
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2,
    Enum.UserInputType.MouseButton3,
    Enum.UserInputType.MouseMovement,
    Enum.UserInputType.MouseWheel,
    Enum.UserInputType.Keyboard
};
local v2 = { Enum.UserInputType.Touch };
local v3 = {
    Enum.UserInputType.Gamepad1,
    Enum.UserInputType.Gamepad2,
    Enum.UserInputType.Gamepad3,
    Enum.UserInputType.Gamepad4,
    Enum.UserInputType.Gamepad5,
    Enum.UserInputType.Gamepad6,
    Enum.UserInputType.Gamepad7,
    Enum.UserInputType.Gamepad8
};
local u4 = {};
local u5 = {};

for _, v in v1 do
    u4[v] = "PC";
end;

for _, v in v2 do
    u4[v] = "Mobile";
end;

for _, v in v3 do
    u4[v] = "Console";
end;

local _ = {
    [Enum.PreferredInput.Touch] = "Mobile",
    [Enum.PreferredInput.Gamepad] = "Console",
    [Enum.PreferredInput.KeyboardAndMouse] = "PC"
};
local u6 = Signal.new();
local u7 = Signal.new();
u5.deviceChanged = u6;
u5.inputDeviceChanged = u7;
u5.Icons = {
    Console = "rbxassetid://17159104876",
    Mobile = "rbxassetid://17159105036",
    PC = "rbxassetid://17159104690"
};
u5.controllerEnabled = UserInputService.GamepadEnabled;
u5.keyboardEnabled = UserInputService.KeyboardEnabled;
u5.touchEnabled = UserInputService.TouchEnabled;

function u5.GetRealDevice(p8) -- Line: 72
    -- upvalues: UserInputService (copy)
    if game:GetService("GuiService"):IsTenFootInterface() then
        return "Console";
    end;

    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        return "Mobile";
    end;

    if UserInputService.KeyboardEnabled then
        return "PC";
    end;
end;

function u5.GetLatestDevice(p9) -- Line: 99
    -- upvalues: u4 (copy), UserInputService (copy)
    return u4[UserInputService:GetLastInputType()] or p9.currentDevice;
end;

UserInputService.LastInputTypeChanged:Connect(function() -- Line: 103
    -- upvalues: u5 (copy), u6 (copy)
    local currentDevice = u5.currentDevice;
    local LatestDevice = u5:GetLatestDevice();

    if currentDevice == LatestDevice then
        return;
    end;

    u5.currentDevice = LatestDevice;
    u6:Fire(LatestDevice);
end);
u5.currentDevice = u5:GetLatestDevice() or u5:GetRealDevice();
u5.realDevice = u5:GetRealDevice();
UserInputService:GetPropertyChangedSignal("GamepadEnabled"):Connect(function() -- Line: 117
    -- upvalues: u5 (copy), UserInputService (copy), u7 (copy)
    u5.controllerEnabled = UserInputService.GamepadEnabled;
    u7:Fire();
end);
UserInputService:GetPropertyChangedSignal("KeyboardEnabled"):Connect(function() -- Line: 122
    -- upvalues: u5 (copy), UserInputService (copy), u7 (copy)
    u5.keyboardEnabled = UserInputService.KeyboardEnabled;
    u7:Fire();
end);
UserInputService:GetPropertyChangedSignal("TouchEnabled"):Connect(function() -- Line: 127
    -- upvalues: u5 (copy), UserInputService (copy), u7 (copy)
    u5.touchEnabled = UserInputService.TouchEnabled;
    u7:Fire();
end);

return u5;