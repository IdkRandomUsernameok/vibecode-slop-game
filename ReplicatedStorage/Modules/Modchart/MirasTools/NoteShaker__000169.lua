-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.Types);
local u1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
u1.shakingRight = false;
u1.shakingLeft = false;
u1.rightShakeFactor = 5;
u1.leftShakeFactor = 5;

function u1.setShake(p5: boolean, p6: boolean) -- Line: 17
    -- upvalues: u1 (copy)
    u1.shakingLeft = p5 or false;
    u1.shakingRight = p6 or false;
end;

function u1.init(p7) -- Line: 22
    -- upvalues: u2 (ref), u3 (ref), u4 (ref)
    u2 = p7;
    u3 = u2.getStrumline(0);
    u4 = u2.getStrumline(1);
end;

function u1.default() -- Line: 29
    -- upvalues: u3 (ref)
    for _, v in u3.Strums do
        v.x = v.defaultX;
        v.y = v.defaultY;
    end;
end;

function u1.onUpdate(p8) -- Line: 36
    -- upvalues: u1 (copy), u3 (ref), u2 (ref), u4 (ref)
    if u1.shakingLeft then
        for _, v in u3.Strums do
            v.offsets.set("x", "noteShakeX", u2.RNG:NextInteger(1, u1.leftShakeFactor));
            v.offsets.set("y", "noteShakeY", u2.RNG:NextInteger(1, u1.leftShakeFactor));
        end;
    end;

    if u1.shakingRight then
        for _, v in u4.Strums do
            v.offsets.set("x", "noteShakeX", u2.RNG:NextInteger(1, u1.rightShakeFactor));
            v.offsets.set("y", "noteShakeY", u2.RNG:NextInteger(1, u1.rightShakeFactor));
        end;
    end;
end;

return u1;