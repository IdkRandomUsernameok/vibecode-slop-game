-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
require(Modules.Main.VarTweener);
local RGBSprite = require(Modules.Main.RGBSprite);
local Note = require(Modules.Main.Note);
local VarTweener = require(Modules.Main.VarTweener);
local u1, u2, v3 = RGBSprite:Extend();

function u1.new(p4) -- Line: 12
    -- upvalues: u2 (copy)
    local v5 = u2(p4);
    merge(v5, {
        laneSpeed = 1,
        incomingAngle = 90
    }, true);

    return v5;
end;

function u1.playFNFIntro(p6: table, p7: number?, p8: number?) -- Line: 23
    -- upvalues: VarTweener (copy)
    local v9 = p8 or p6.lane;
    p6.offsets.set("alpha", "introOffset", 0);
    p6.offsets.set("y", "introOffset", -10);
    local math_clamp_ret = math.clamp((p7 or 4) - 4, 1, 500);
    VarTweener:Create(p6.offsets:GetPropertyOffsets("alpha"), TweenInfo.new(1 / math_clamp_ret, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0, false, 0.5 / math_clamp_ret + 0.2 / math_clamp_ret * v9), {
        introOffset = 1
    }):Play();
    VarTweener:Create(p6.offsets:GetPropertyOffsets("y"), TweenInfo.new(1 / math_clamp_ret, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0, false, 0.5 / math_clamp_ret + 0.2 / math_clamp_ret * v9), {
        introOffset = 0
    }):Play();
end;

u1.getSkinData = Note.getSkinData;

function merge(p10: table, p11: table, p12: boolean)
    if p12 then
        for i, v in p11 do
            rawset(p10, i, v);
        end;

        return;
    end;

    for i, v in p11 do
        p10[i] = v;
    end;
end;

function u1.__call(p13, ...) -- Line: 50
    -- upvalues: u1 (copy)
    return u1.new(...);
end;

v3();

return u1;