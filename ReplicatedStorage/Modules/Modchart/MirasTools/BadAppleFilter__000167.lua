-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EasyHighlight = require(ReplicatedStorage:WaitForChild("Modules").Modchart.MirasTools.EasyHighlight);

function u1.new(p2: userdata, p3: table) -- Line: 20
    -- upvalues: u1 (copy), EasyHighlight (copy)
    local v4 = setmetatable({}, u1);
    v4.stage = p2;
    v4.config = p3 or {};
    v4.config.WorldColor = v4.config.WorldColor or Color3.new(0, 0, 0);
    v4.config.WorldTransparency = v4.config.WorldTransparency or 0;
    v4.characters = {};
    v4.worldHighlight = EasyHighlight.new(nil);
    v4.worldHighlight.highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    v4.worldHighlight:SetColor(v4.config.WorldColor, v4.config.WorldColor);
    v4.worldHighlight:SetTransparency(v4.config.WorldTransparency, v4.config.WorldTransparency);
    v4.worldHighlight.highlight.Enabled = false;
    v4.skyThing = script.SkyThing:Clone();
    v4.skyThing.Parent = v4.stage;
    local v5 = v4.stage:FindFirstChild("Cameras") and v4.stage.Cameras:FindFirstChild("Camera");

    if v5 then
        v4.skyThing.CFrame = v5.CFrame;
    end;

    v4.skyThing.Transparency = 1;
    v4.skyThing.Color = v4.config.WorldColor;

    return v4;
end;

function u1.addCharacters(p6: table, p7: table, p8: table) -- Line: 50
    for i, v in p7 do
        p6:addCharacter(v, {
            Alias = i,
            Color = p8.Color,
            Transparency = p8.Transparency
        });
    end;
end;

function u1.addCharacter(p9: table, p10: userdata, p11: table) -- Line: 60
    -- upvalues: EasyHighlight (copy)
    local Alias = p11.Alias;
    local v12 = p11.Color or Color3.new(1, 1, 1);
    local v13 = p11.Transparency or 0;
    local v14 = EasyHighlight.new(nil);
    v14.highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    v14:SetColor(v12, v12);
    v14:SetTransparency(v13, v13);
    v14.highlight.Enabled = false;
    v14.highlight.Parent = p10;
    p9.characters[Alias] = {
        obj = v14,
        model = p10,
        defaultColor = v12,
        defaultTrans = v13
    };
end;

function u1.setColor(p15: table, p16: string, p17) -- Line: 80
    local v18 = p15.characters[p16];

    if v18 then
        v18.defaultColor = p17;
        v18.obj:SetColor(p17, p17);
    end;
end;

function u1.setWorldColor(p19: table, p20) -- Line: 88
    p19.config.WorldColor = p20;
    p19.worldHighlight:SetColor(p20, p20);

    if p19.skyThing then
        p19.skyThing.Color = p20;
    end;
end;

function u1.setWorldTransparency(p21: table, p22: number) -- Line: 96
    p21.config.WorldTransparency = p22;
    p21.worldHighlight:SetTransparency(p22, p22);

    if p21.skyThing and p21.worldHighlight.highlight.Enabled then
        p21.skyThing.Transparency = p22;
    end;
end;

function u1.setTransparency(p23: table, p24: string, p25: number) -- Line: 104
    local v26 = p23.characters[p24];

    if v26 then
        v26.defaultTrans = p25;
        v26.obj:SetTransparency(p25, p25);
    end;
end;

function u1.removeCharacter(p27: table, p28: string) -- Line: 112
    local v29 = p27.characters[p28];

    if v29 then
        v29.obj:Destroy();
        p27.characters[p28] = nil;
    end;
end;

function u1.WorldToggle(p30: table, p31: boolean) -- Line: 120
    if p30.worldHighlight then
        p30.worldHighlight.highlight.Parent = p31 and workspace or nil;
        p30.worldHighlight.highlight.Enabled = p31;
    end;

    if p30.skyThing then
        p30.skyThing.Transparency = p31 and p30.config.WorldTransparency or 1;
    end;
end;

function u1.Toggle(p32: table, p33: string, p34: boolean) -- Line: 131
    local v35 = p32.characters[p33];

    if v35 then
        v35.obj.highlight.Enabled = p34;
    end;
end;

function u1.Destroy(p36) -- Line: 138
    p36:WorldToggle(false);

    if p36.worldHighlight then
        p36.worldHighlight:Destroy();
        p36.worldHighlight = nil;
    end;

    for _, v in p36.characters do
        v.obj:Destroy();
    end;

    p36.characters = {};

    if p36.skyThing then
        p36.skyThing:Destroy();
        p36.skyThing = nil;
    end;

    setmetatable(p36, nil);
end;

return u1;