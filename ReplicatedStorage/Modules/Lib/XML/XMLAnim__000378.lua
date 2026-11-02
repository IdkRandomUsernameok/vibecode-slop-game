-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("ReplicatedStorage");
local Other = script:FindFirstAncestor("Modules").Other;
local Util = require(Other.Util);
local XMLParser = require(script.Parent.XMLParser);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 14
    -- upvalues: u1 (copy)
    local v3 = {
        AnimationCompleted = true,
        CurrentFrame = 0,
        AnimationTimer = 0,
        CurrentAnimationName = "",
        CurrentAnimation = nil,
        XMLSprite = p2,
        Animations = {},
        Size = Vector2.new(1, 1),
        Position = Vector2.new(0, 0)
    };

    return setmetatable(v3, u1);
end;

function u1.AddByPrefix(p4, p5, p6, p7, p8, p9, p10) -- Line: 32
    -- upvalues: XMLParser (copy)
    local v11 = type(p5) == "string" and true or type(p5) == "userdata";
    local v12 = "Invalid argument #1 to XMLSprite:AddByPrefix(). Expected string or ModuleScript. Got \'" .. type(p5) .. "\'";
    assert(v11, v12);

    if p4.Animations[p9] then
        warn("\'" .. p9 .. "\' has already been used as an animation name.");

        return;
    end;

    if type(p5) == "userdata" then
        p5 = require(p5);
    end;

    local children = XMLParser.parse(p5, true).children[1].children;
    local v13 = {
        Frames = {},
        Framerate = p8 or 60,
        ImageID = p6
    };

    for i = 1, #children do
        local attrs = children[i].attrs;
        local name = attrs.name;
        local string_len_ret = string.len(p10);
        local string_sub_ret = string.sub(name, 1, string_len_ret);
        local name2 = attrs.name;
        local v14 = string.len(p10) + 1;
        local string_len_ret2 = string.len(attrs.name);
        local string_sub_ret2 = string.sub(name2, v14, string_len_ret2);
        local v15;

        if string_sub_ret == p10 and tonumber(string_sub_ret2) then
            local v16 = {
                ImageRectOffset = Vector2.new(attrs.x, attrs.y) * Vector2.new(p7, p7),
                ImageRectSize = Vector2.new(attrs.width, attrs.height) * Vector2.new(p7, p7),
                ImageSize = Vector2.new(attrs.width, attrs.height),
                Name = attrs.name,
                Prefix = p10
            };
            table.insert(v13.Frames, v16);
            v15 = i;
        else
            v15 = i;
        end;
    end;

    p4.Animations[p9] = v13;
end;

function u1.Play(p17, p18, p19, p20) -- Line: 90
    if p17.AnimationCompleted or p20 then
        p17.AnimationCompleted = true;
        p17.CurrentFrame = 1;
        p17.AnimationTimer = 0;
        p17.CurrentAnimationName = p19;
        p17.CurrentAnimation = p17.Animations[p19];
        p18.Image = p17.Animations[p19].ImageID;
        p17.AnimationCompleted = false;
        p17:UpdateImageLabel(p18);
    end;
end;

function u1.StopAll(p21) -- Line: 107
    p21.AnimationCompleted = true;
    p21.CurrentFrame = 1;
    p21.AnimationTimer = 0;
    p21.CurrentAnimation = nil;
    p21.CurrentAnimationName = "";
end;

function u1.UpdateImageLabel(p22, p23) -- Line: 115
    -- upvalues: Util (copy)
    local v24 = p22.CurrentAnimationName ~= "" and p22.CurrentAnimation.Frames[p22.CurrentFrame];

    if v24 then
        p23.ImageRectOffset = v24.ImageRectOffset;
        p23.ImageRectSize = v24.ImageRectSize;
        p23.Size = UDim2.fromScale(v24.ImageSize.X * p22.Size.X / Util.ScreenSize.X, v24.ImageSize.Y * p22.Size.Y / Util.ScreenSize.Y);
        p23.Position = UDim2.fromScale(p22.Position.X / Util.ScreenSize.X, p22.Position.Y / Util.ScreenSize.Y);
    end;
end;

function u1.Update(p25, p26, p27) -- Line: 142
    if not p25.AnimationCompleted then
        p25.AnimationTimer = p25.AnimationTimer + p26;
        local v28 = #p25.CurrentAnimation.Frames;

        if 1 / p25.CurrentAnimation.Framerate < p25.AnimationTimer then
            p25.AnimationTimer = 0;
            p25.CurrentFrame = p25.CurrentFrame + 1;

            if v28 <= p25.CurrentFrame then
                if p25.CurrentFrame == v28 then
                    p25:UpdateImageLabel(p27);
                end;

                p25.AnimationCompleted = true;
                p25.CurrentFrame = v28;
            end;
        end;
    end;

    p25:UpdateImageLabel(p27);
end;

return u1;