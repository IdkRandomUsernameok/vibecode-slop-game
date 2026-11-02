-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
Modules:WaitForChild("Assets");
local u1, u2, v3 = require(Modules.Main.Sprite):Extend();
local _ = table.insert;
local _ = table.remove;
local u4 = {};

local function getObjFromPool() -- Line: 18
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

function u1.new(p5, p6) -- Line: 34
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
    v7.possibleSets = { "" };
    v7.objectIsPool = true;
    v7.visible = true;
    v7.anchor = Vector2_new_ret;
    v7.bgAlpha = 0;
    v7.alpha = 1;
    v7.x = p5 or v7.x;
    v7.y = p6 or v7.y;

    return v7;
end;

function u1.getSkinData(p8: table, p9: userdata, p10: userdata?) -- Line: 55
    local v11 = p10 and p10:GetAttribute("Offset") or Vector2.new();
    local v12 = p9:GetAttribute("Offset") or Vector2.new();
    local v13 = tonumber(p9:GetAttribute("SizeMult")) or (p10 and (tonumber(p10:GetAttribute("SizeMult")) or 1) or 1);
    local v14 = tonumber(p9:GetAttribute("Factor")) or (p10 and (tonumber(p10:GetAttribute("Factor")) or 1) or 1);
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

    local v15 = {};
    local v16 = {};

    for i, v in { "0", "ALT0" } do
        local v17 = i - 1;
        local v18 = v17 == 0 and "" or "alt" .. v17 .. "_";
        local v19 = {
            intro = p8:GetAnimFramesByResults(p9, { "Start" .. v }, v14, v13),
            holding = p8:GetAnimFramesByResults(p9, { "Idle" .. v }, v14, v13),
            release = p8:GetAnimFramesByResults(p9, { "End" .. v }, v14, v13)
        };

        if v19.holding then
            v15[v18] = v19;
            table.insert(v16, v18);
        end;
    end;

    local v20 = v11 + v12;

    if v20 ~= Vector2.zero then
        for _, v in v15 do
            for _, v2 in v do
                for _, v4 in v2 do
                    if v4.FrameOffset then
                        v4.FrameOffset = v4.FrameOffset + v20;
                    else
                        v4.FrameOffset = v20;
                    end;

                    v4._fixed = false;
                end;
            end;
        end;
    end;

    return {
        animationSets = v15,
        setsName = v16,
        id = p9:GetAttribute("Image"),
        framerate = tonumber(p9:GetAttribute("Framerate")) or (p10 and tonumber(p10:GetAttribute("Framerate")) or 24),
        antialiasing = Attribute == nil and true or Attribute,
        isUnderlay = Attribute2
    };
end;

function u1.loadSkin(p21, p22) -- Line: 119
    if p22.cachedAnimations then
        p21.Animations = p22.cachedAnimations;
    else
        p21.Animations = {};

        for i, v in p22.animationSets do
            local v23 = i;

            for i2, v2 in v do
                p21:AddAnimation(i2 .. v23, v2, p22.framerate, i2 == "holding", p22.id);
            end;
        end;

        p22.cachedAnimations = p21.Animations;
    end;

    p21.antialiasing = p22.antialiasing;
    p21.possibleSets = p22.setsName;
    p21.skin = p22;
end;

function u1.recolorSkin(p24, p25) -- Line: 140
end;

function u1.Hold(p26, p27) -- Line: 144
    if p26.holding then
        return;
    end;

    p26.holding = true;

    if not p27 then
        local possibleSets = p26.possibleSets;
        p27 = possibleSets[math.random(#possibleSets)] or "";
    end;

    local v28 = "holding" .. p27;

    if not p26.Animations[v28] then
        p27 = "";
        v28 = "holding";
    end;

    p26.currentSet = p27;
    local v29 = "intro" .. p27;

    if not p26.Animations[v29] then
        p26:Play(v28, true);

        return;
    end;

    local v30 = p26:Play(v29, true);
    v30.resetAnim = v28;
    v30.resetOnAnimEnd = true;
end;

function u1.Release(p31) -- Line: 173
    if not p31.holding then
        return;
    end;

    p31.holding = false;
    local v32 = p31.currentSet or "";
    local v33 = "release" .. v32;

    if p31.Animations[v33] then
        p31:Play("release" .. v32, true);

        return;
    end;

    p31.AnimationEnded:Fire(v33);
end;

function u1.SetObj(p34, p35) -- Line: 187
    -- upvalues: u4 (copy)
    if p34.objectIsPool then
        local Obj = p34.Obj;

        if p35 ~= Obj then
            if Obj then
                Obj.Visible = false;
                Obj.ImageTransparency = 1;
                Obj.Position = UDim2.fromScale(-2, -2);
                Obj.Parent = nil;
                table.insert(u4, Obj);
            end;

            p34.objectIsPool = false;
        end;
    end;

    p34.super:SetObj(p35);
end;

function u1.getCacheSize() -- Line: 207
    -- upvalues: u4 (copy)
    return #u4;
end;

function u1.clearCache() -- Line: 211
    -- upvalues: u4 (copy)
    for _, v in u4 do
        v:Destroy();
    end;

    table.clear(u4);
end;

function merge(p36: table, p37: table, p38: boolean)
    if p38 then
        for i, v in p37 do
            rawset(p36, i, v);
        end;

        return;
    end;

    for i, v in p37 do
        p36[i] = v;
    end;
end;

function u1.__call(p39, ...) -- Line: 232
    -- upvalues: u1 (copy)
    return u1.new(...);
end;

v3();

return u1;