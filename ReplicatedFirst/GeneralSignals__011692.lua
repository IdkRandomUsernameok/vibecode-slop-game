-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local LocalSignals = require(Modules:WaitForChild("Signals"):WaitForChild("LocalSignals"));
local u1 = {
    [Enum.UserInputType.Keyboard] = true,
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Touch] = true,
    [Enum.UserInputType.MouseButton1] = true
};
LocalSignals.AnyButtonPressed:Mute(true);
UserInputService.InputBegan:Connect(function(p2, p3) -- Line: 19
    -- upvalues: u1 (copy), LocalSignals (copy)
    if p3 then
        return;
    end;

    if u1[p2.UserInputType] then
        LocalSignals.AnyButtonPressed:Fire(p2);
    end;
end);
local u4 = {};

function LocalSignals.func_GetObject.OnInvoke(p5) -- Line: 31
    -- upvalues: u4 (copy)
    if u4[p5] then
        return u4[p5];
    end;

    local l_game = game;

    for _, v in p5:split(".") do
        l_game = l_game:FindFirstChild(v);

        if l_game == nil then
            return nil;
        end;
    end;

    if l_game == nil then
        return nil;
    end;

    u4[p5] = l_game;

    return l_game;
end;

function LocalSignals.func_GetFastFlagEnabled.onInvoke(p6) -- Line: 48
    local IsUserFeatureEnabled = UserSettings().IsUserFeatureEnabled;
    local v7 = UserSettings();
    local success, result = pcall(IsUserFeatureEnabled, v7, p6);

    return success and result;
end;