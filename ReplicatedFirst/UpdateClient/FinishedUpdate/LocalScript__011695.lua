-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Screen = script.Parent.Screen;
task.wait(3);
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
TweenService:Create(Screen.BlackBot, TweenInfo_new_ret, {
    Position = UDim2.fromScale(0.823, 1.542)
}):Play();
TweenService:Create(Screen.BlackTop, TweenInfo_new_ret, {
    Position = UDim2.fromScale(0.178, -0.542)
}):Play();
TweenService:Create(Screen.RestartServer.Info.AfnArrow, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
    ImageTransparency = 1
}):Play();
task.wait(0.05);
TweenService:Create(Screen.RestartServer.Info.Restart, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
    TextTransparency = 1
}):Play();
task.wait(0.1);
TweenService:Create(Screen.RestartServer.Info.EndText, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
    TextTransparency = 1
}):Play();
task.wait(TweenInfo_new_ret.Time + 0.85);
Screen:Destroy();