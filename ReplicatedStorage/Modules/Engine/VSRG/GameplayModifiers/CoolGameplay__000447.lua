-- Decompiled with Potassium's decompiler.

shared.getApi();
local TweenService = game:GetService("TweenService");
local u1 = nil;

function doSpin()
    -- upvalues: u1 (ref), TweenService (copy)
    if u1 == nil then
        return;
    end;

    TweenService:Create(u1.Sprite, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false), {
        Rotation = 360
    }):Play();
end;

return {
    onCreate = function(p2) -- Line: 13, Name: onCreate
        -- upvalues: u1 (ref)
        u1 = script.CoolGameplay:Clone();
        u1.Parent = p2.Underlay;
        doSpin();
    end,

    clearUp = function() -- Line: 19, Name: clearUp
        -- upvalues: u1 (ref)
        if u1 then
            u1:Destroy();
        end;
    end
};