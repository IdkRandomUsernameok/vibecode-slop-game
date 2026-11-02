-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Icons = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Icons");
local Sprite = require(Modules.Main.Sprite);
local Logger = require(Modules.Other.Logger);
local u1, u2, v3 = Sprite:Extend();

function u1.new(p4: userdata, p5: any, p6: any) -- Line: 12
    -- upvalues: u2 (copy)
    local v7 = u2(p4, Vector2.new(150, 150), false, true);
    merge(v7, {
        XMLFile = nil,
        XMLPath = nil,
        animatedIcon = false,
        facing = "Left",
        iconCount = 2,
        iconScale = 1,
        metadata = nil,
        iconState = "Idle",
        doEvents = true,
        overrideFrames = false,
        overrideBop = false,
        overridePos = false,
        posIndex = nil,
        iconColor = Color3.new(1, 1, 1),
        iconSize = Vector2.new(150, 150),
        iconOffset = UDim2.fromScale(0, 0),
        variant = p5,
        posOffset = UDim2.new()
    }, true);
    v7:ChangeIcon(p5, p6);

    return v7;
end;

local u8 = {
    Overwin = "Win",
    Overlose = "Lose",
    Win = "Idle",
    Lose = "Idle"
};

function u1.ChangeState(p9: table, p10: userdata, p11: boolean?) -- Line: 53
    -- upvalues: u8 (copy)
    if p9.iconState == p10 and not p11 then
        return;
    end;

    local v12;

    if p9.Animations[p10] then
        v12 = p10;
    else
        local v13 = u8[p10] or "Idle";
        v12 = not p9.Animations[v13] and "Idle" or v13;
    end;

    local v14 = p9.prevAnimState or p9.iconState;

    if v14 == v12 and not p11 then
        return;
    end;

    p9.iconState = p10;
    p9.prevAnimState = v12;
    local v15 = `Trans_{v14}{v12}`;

    if not p9.Animations[v15] or p11 then
        p9.playingEvent = false;

        return p9:Play(v12);
    end;

    local v16 = p9:Play(v15, true);
    v16.resetAnim = v12;
    v16.resetOnAnimEnd = true;
end;

function u1.PlayEvent(u17: table, p18: string, p19: boolean?) -- Line: 81
    if not u17.doEvents then
        return;
    end;

    if not u17.Animations[p18] then
        return;
    end;

    local v20 = p19 == nil and true or p19;

    if u17.playingEvent and (u17.playingPriority and not v20) then
        return;
    end;

    u17.playingEvent = true;
    u17.playingPriority = v20;
    local v21 = u17:Play(p18, true);
    v21.resetOnAnimEnd = true;
    setmetatable(v21, {
        __index = function(p22, p23) -- Line: 95, Name: __index
            -- upvalues: u17 (copy)
            if p23 == "resetAnim" then
                return u17.prevAnimState;
            end;

            return nil;
        end
    });
end;

function u1.ChangeIcon(p24, p25, p26) -- Line: 101
    -- upvalues: Icons (copy), Logger (copy)
    if p26 == nil then
        p26 = Icons;
    else
        local v27 = typeof(p26) == "string" and (Icons:FindFirstChild(p26) and Icons[p26] or Icons);

        if v27 then
            p26 = v27;
        elseif not p26 then
            p26 = Icons;
        end;
    end;

    if typeof(p25) == "string" then
        p25 = p26:FindFirstChild(p25) or p25;
    end;

    if p25 == nil then
        return;
    end;

    if typeof(p25) ~= "Instance" then
        p24.variant = "Custom";
        p24.facing = p25.Facing or "Right";
        p24.iconSize = p25.Size or Vector2.new(150, 150);
        p24.iconScale = p25.Scale or 1;
        p24.iconColor = p25.Color or Color3.new(1, 1, 1);
        p24.iconCount = p25.IconCount or 2;
        p24.iconOffset = UDim2.fromScale(p25.Offset and (p25.Offset.X or 0) or 0, p25.Offset and (p25.Offset.Y or 0) or 0);
        p24.offsets.set("alpha", "iconAlphaOffset", p25.Transparency or 1);
        local Antialiasing = p25.Antialiasing;
        p24.antialiasing = Antialiasing == nil and true or Antialiasing;
        p24.metadata = p25;

        return;
    end;

    local Metadata = p25:FindFirstChild("Metadata");

    if Metadata == nil then
        Logger.log("No metadata for icon " .. p25.Name);

        return;
    end;

    local v28 = require(Metadata);
    p24.variant = p25.Name;
    p24.iconScale = v28.Scale or 1;
    p24.facing = v28.Facing or "Right";
    p24.iconSize = v28.Size or Vector2.new(150, 150);
    p24.iconColor = v28.Color or Color3.new(1, 1, 1);
    p24.iconCount = v28.IconCount or 3;
    p24.animatedIcon = v28.Animated or false;
    p24.iconOffset = v28.Offset or UDim2.fromScale(0, 0);
    p24.metadata = v28 or {};

    if v28.Animated then
        p24.iconCount = #p24.metadata.Animations;
        p24.XMLFile = p25:FindFirstChild("XML") or nil;
        p24.XMLPath = p25:FindFirstChild("Animations") or nil;
    end;

    local Antialiasing = p24.metadata.Antialiasing;
    p24.offsets.set("alpha", "iconAlphaOffset", p24.metadata.Transparency or 1);
    p24.antialiasing = Antialiasing == nil and true or Antialiasing;
end;

function u1.Clone(p29) -- Line: 160
    local v30 = p29.super:Copy(true);
    merge(v30, {
        XMLFile = p29.XMLFile,
        XMLPath = p29.XMLPath,
        animatedIcon = p29.animatedIcon,
        iconColor = p29.iconColor,
        variant = p29.variant,
        facing = p29.facing,
        iconSize = p29.iconSize,
        iconCount = p29.iconCount,
        metadata = p29.metadata,
        overrideFrames = p29.overrideFrames
    }, true);

    return v30;
end;

function merge(p31: table, p32: table, p33: boolean)
    if p33 then
        for i, v in p32 do
            rawset(p31, i, v);
        end;

        return;
    end;

    for i, v in p32 do
        p31[i] = v;
    end;
end;

function u1.__call(...) -- Line: 193
    -- upvalues: u1 (copy)
    return u1.new(...);
end;

v3();

return u1;