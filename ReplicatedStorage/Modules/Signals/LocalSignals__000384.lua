-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Signal = require(ReplicatedStorage.Modules.Lib.Signal);
local ScriptFunction = require(ReplicatedStorage.Modules.Lib.ScriptFunction);

return {
    func_GetCamSubjectPos = ScriptFunction.new(),
    func_GetObject = ScriptFunction.new(),
    func_GetFastFlagEnabled = ScriptFunction.new(),
    TitleFinished = Signal.new(),
    FirstTimeSetupCompleted = Signal.new(),
    PhotosensitivityWarningCompleted = Signal.new(),
    ClientLoaded = Signal.new(),
    APILoaded = Signal.new(),
    PlayingRound = Signal.new(),
    SendNotification = Signal.new(),
    SetNotificationSide = Signal.new(),
    AnyButtonPressed = Signal.new()
};