-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local Sprite = require(Modules.Main.Sprite);
local VarTweener = require(Modules.Main.VarTweener);
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: number, p4: any, p5: number, p6: boolean, p7, p8, p9: any) -- Line: 9
    -- upvalues: u1 (copy), Sprite (copy)
    local v10 = setmetatable({}, u1);
    local v11 = p2:Clone();

    while v11.Image == "" do
        task.wait(0.1);
    end;

    v10.spr = Sprite.new(v11, nil, true);

    if p9 == nil then
        p9 = v11:FindFirstChild("XML") or p9;
    end;

    v10.xmlPath = p9;
    v10.usingFrameOffsets = p6;
    v10.scale = p7 or Vector2.new(1, 1);
    v10.pos = p8;
    v10.factor = p5 or 1;
    v10.zindex = p3 or -90;
    v10.parent = p4;
    v10.directionMap = {};
    v10:initialize();

    return v10;
end;

function u1.initialize(p12) -- Line: 28
    p12.spr.useFrameOffsets = p12.usingFrameOffsets;
    p12.spr.AnchorPoint = Vector2.new(0.5, 0.5);
    p12.spr.Position = p12.pos or UDim2.fromScale(0.5, 0.5);
    p12.spr.scale.set(p12.scale.X, p12.scale.Y);
    p12.spr.fatherFigure = p12.parent;
    p12.spr.zindex = p12.zindex;
    p12.spr.alpha = 1;
end;

function u1.addAnimation(p13, p14, p15, p16, p17) -- Line: 38
    p13.spr:AddSparrowXml(p13.xmlPath, p14, p15, p16, p17, p13.factor);
end;

function u1.addAnimations(p18, p19, p20, p21, p22) -- Line: 42
    for _, v in p19 do
        local v23;

        if p22 then
            v23 = v:gsub("^%l", string.upper) or v;
        else
            v23 = v;
        end;

        p18:addAnimation(v23, v, p20, p21, p18.factor);
    end;
end;

function u1.addDirectionalAnimations(p24, p25, p26, p27, p28) -- Line: 48
    p24:addAnimation(p26, p26, p27, p28, p24.factor);

    for _, v in p25 do
        p24.directionMap[v] = p26;
    end;
end;

function u1.play(p29, p30, p31) -- Line: 55
    p29.spr:Play(p29.directionMap[p30] or p30, p31);
end;

function u1.createTween(p32: table, p33: userdata, p34: any) -- Line: 59
    -- upvalues: VarTweener (copy)
    local v35 = {};

    for i, v in p34 do
        v35[i] = v;
    end;

    return VarTweener:Create(p32.spr, p33, v35);
end;

function u1.Destroy(p36) -- Line: 66
    if p36.spr then
        p36.spr:Destroy();
    end;

    p36.xmlPath = nil;
    p36.scale = nil;
    p36.pos = nil;
    p36.factor = nil;
    p36.zindex = nil;
    p36.parent = nil;
    p36.directionMap = nil;
end;

return u1;