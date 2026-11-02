-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local Sprite = require(Modules.Main.Sprite);
local VarTweener = require(Modules.Main.VarTweener);
local u1, u2, v3 = Sprite:Extend();

function merge(p4: table, p5: table, p6: boolean)
    if p6 then
        for i, v in p5 do
            rawset(p4, i, v);
        end;

        return;
    end;

    for i, v in p5 do
        p4[i] = v;
    end;
end;

function u1.new(p7: userdata, p8: number, p9: any, p10: number, p11: boolean, p12, p13, p14: any) -- Line: 23
    -- upvalues: u2 (copy)
    local v15 = u2(p7, nil, true, nil, false);
    local l_merge = merge;
    local v16 = {
        directionMap = {}
    };

    if p14 == nil then
        p14 = p7:FindFirstChild("XML") or p14;
    end;

    v16.xmlPath = p14;
    l_merge(v15, v16, true);
    v15.useFrameOffsets = p11;
    v15.AnchorPoint = Vector2.new(0.5, 0.5);
    v15.Position = p13 or UDim2.fromScale(0.5, 0.5);
    v15.scale.set(p12.X, p12.Y);
    v15.fatherless = p9;
    v15.zindex = p8;
    v15.alpha = 1;

    return v15;
end;

function u1.AddCharacterAnimation(p17, p18, p19, p20, p21) -- Line: 42
    p17:AddSparrowXml(p17.xmlPath, p18, p19, p20, p21, p17.factor);
end;

function u1.AddCharacterAnimations(p22, p23, p24, p25, p26) -- Line: 46
    for _, v in p23 do
        local v27;

        if p26 then
            v27 = v:gsub("^%l", string.upper) or v;
        else
            v27 = v;
        end;

        p22:AddCharacterAnimation(v27, v, p24, p25, p22.factor);
    end;
end;

function u1.AddDirectionalAnimations(p28, p29, p30, p31, p32) -- Line: 52
    p28:AddCharacterAnimation(p30, p30, p31, p32, p28.factor);

    for _, v in p29 do
        p28.directionMap[v] = p30;
    end;
end;

function u1.Play(p33, p34, p35) -- Line: 59
    p33.super:Play(p33.directionMap[p34] or p34, p35);
end;

function u1.CreateTween(p36: table, p37: userdata, p38: any) -- Line: 63
    -- upvalues: VarTweener (copy)
    local v39 = {};

    for i, v in p38 do
        v39[i] = v;
    end;

    return VarTweener:Create(p36, p37, v39);
end;

function u1.__call(p40, ...) -- Line: 70
    -- upvalues: u1 (copy)
    return u1.new(...);
end;

v3();

return u1;