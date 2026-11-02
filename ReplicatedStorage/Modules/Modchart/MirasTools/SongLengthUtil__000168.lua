-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local VarTweener = require(ReplicatedStorage.Modules.Main.VarTweener);
local u1 = nil;

return function(u2, p3, p4, p5) -- Line: 6
    -- upvalues: u1 (ref), VarTweener (copy)
    if p4 and p5 then
        if u1 then
            u1:Cancel();
        end;

        u1 = VarTweener:CreateValueTween(p3 / u2.playbackRate, p4 / u2.playbackRate, {
            Time = p5 / u2.playbackRate,
            EasingStyle = Enum.EasingStyle.Cubic,
            EasingDirection = Enum.EasingDirection.Out
        }, function(p6) -- Line: 16
            -- upvalues: u2 (copy)
            u2.songLength = p6;
        end);
        u1:Play();

        return u1;
    end;
end;