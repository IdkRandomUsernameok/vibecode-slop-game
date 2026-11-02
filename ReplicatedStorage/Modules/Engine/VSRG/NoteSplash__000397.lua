-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
Modules:WaitForChild("Assets");
local u1, u2, v3 = require(Modules.Main.Sprite):Extend();
local u4 = {};

local function getObjFromPool() -- Line: 14
    -- upvalues: u4 (copy)
    local table_remove_ret = table.remove(u4);

    if table_remove_ret then
        table_remove_ret.Visible = false;

        return table_remove_ret;
    end;

    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.BorderSizePixel = 0;
    ImageLabel.Visible = false;

    return ImageLabel;
end;

local Vector2_new_ret = Vector2.new(0.5, 0.5);

function u1.new(p5, p6) -- Line: 30
    -- upvalues: u2 (copy), u4 (copy), Vector2_new_ret (copy)
    local table_remove_ret = table.remove(u4);

    if table_remove_ret then
        table_remove_ret.Visible = false;
    else
        table_remove_ret = Instance.new("ImageLabel");
        table_remove_ret.BackgroundTransparency = 1;
        table_remove_ret.BorderSizePixel = 0;
        table_remove_ret.Visible = false;
    end;

    local v7 = u2(table_remove_ret, nil, false);
    v7.objectIsPool = true;
    v7.possibleSplashes = { "splash" };
    v7.visible = true;
    v7.anchor = Vector2_new_ret;
    v7.bgAlpha = 0;
    v7.alpha = 1;
    v7.x = p5 or v7.x;
    v7.y = p6 or v7.y;

    return v7;
end;

function u1.getSkinData(p8: table, p9: userdata, p10: userdata?) -- Line: 47
    local v11 = p10 and p10:GetAttribute("Offset") or Vector2.new();
    local v12 = p9:GetAttribute("Offset") or Vector2.new();
    local v13 = tonumber(p9:GetAttribute("SizeMult")) or 1;
    local Attribute = p9:GetAttribute("Antialiasing");
    local Attribute2 = p9:GetAttribute("Underlay");

    if Attribute2 == nil then
        if p10 then
            Attribute2 = p10:GetAttribute("Underlay") or false;
        else
            Attribute2 = false;
        end;
    end;

    if Attribute2 == nil then
        Attribute2 = false;
    end;

    local v14 = tonumber(p9:GetAttribute("Factor")) or 1;
    local v15 = {};
    local v16 = {};

    for _, v in p8:GetAnimationsFromXml(p9) do
        local AnimFramesByResults = p8:GetAnimFramesByResults(p9, { v }, v14, v13);

        if AnimFramesByResults then
            local v17 = #v15;
            local v18 = "splash" .. (v17 == 0 and "" or v17);
            v16[v18] = AnimFramesByResults;
            table.insert(v15, v18);
        end;
    end;

    local v19 = v11 + v12;

    if v19 ~= Vector2.zero then
        for _, v in v16 do
            for _, v2 in v do
                if v2.FrameOffset then
                    v2.FrameOffset = v2.FrameOffset + v19;
                else
                    v2.FrameOffset = v19;
                end;

                v2._fixed = false;
            end;
        end;
    end;

    return {
        animations = v16,
        animNames = v15,
        id = p9:GetAttribute("Image"),
        framerate = tonumber(p9:GetAttribute("Framerate")) or (p10 and tonumber(p10:GetAttribute("Framerate")) or 24),
        antialiasing = Attribute == nil and true or Attribute,
        isUnderlay = Attribute2
    };
end;

function u1.loadSkin(p20, p21) -- Line: 108
    if p21.cachedAnimations then
        p20.Animations = p21.cachedAnimations;
    else
        p20.Animations = {};

        for i, v in p21.animations do
            p20:AddAnimation(i, v, p21.framerate, false, p21.id);
        end;

        p21.cachedAnimations = p20.Animations;
    end;

    p20.antialiasing = p21.antialiasing;
    p20.possibleSets = p21.setsName;
    p20.skin = p21;
end;

function u1.Play(p22, p23, ...) -- Line: 127
    if p23 then
        return p22.super:Play(p23, ...);
    end;

    local possibleSplashes = p22.possibleSplashes;

    return p22.super:Play(possibleSplashes[math.random(#possibleSplashes)], ...);
end;

function u1.SetObj(p24, p25) -- Line: 134
    -- upvalues: u4 (copy)
    if p24.objectIsPool then
        local Obj = p24.Obj;

        if p25 ~= Obj then
            if Obj then
                Obj.Visible = false;
                Obj.ImageTransparency = 1;
                Obj.Position = UDim2.fromScale(-2, -2);
                Obj.Parent = nil;
                table.insert(u4, Obj);
            end;

            p24.objectIsPool = false;
        end;
    end;

    p24.super:SetObj(p25);
end;

function u1.getCacheSize() -- Line: 154
    -- upvalues: u4 (copy)
    return #u4;
end;

function u1.clearCache() -- Line: 158
    -- upvalues: u4 (copy)
    for _, v in u4 do
        v:Destroy();
    end;

    table.clear(u4);
end;

function u1.__call(p26, ...) -- Line: 168
    -- upvalues: u1 (copy)
    return u1.new(...);
end;

v3();

return u1;