-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Icons = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Icons");
local Sprite = require(Modules.Main.Sprite);
local IconBopsV2 = require(Modules.Customization.IconBopsV2);
local u1, u2, v3 = Sprite:Extend();

function u1.new(p4: userdata, p5: string, p6: any, p7: string?) -- Line: 26
    -- upvalues: u2 (copy)
    local v8 = u2(p4, Vector2.new(150, 150), false, true);
    merge(v8, {
        iconScale = 1,
        iconState = "Idle",
        iconSide = "L",
        overrideStates = false,
        overrideFrames = false,
        overrideBop = false,
        overridePos = false,
        posIndex = nil,
        iconColor = Color3.new(1, 1, 1),
        iconOffset = UDim2.fromScale(0, 0),
        side = (p5 == "Left" or p5 == "L") and "L" or "R" or "L",
        posOffset = UDim2.new()
    }, true);

    if p6 then
        v8:LoadIcon(p6, p7);
    end;

    return v8;
end;

local u9 = { { "Idle" }, { "Idle", "Lose" }, { "Idle", "Lose", "Win" }, { "Idle", "Lose", "Win", "Overwin" }, { "Idle", "Lose", "Win", "Overwin", "Overlose" } };
local u10 = {
    Overwin = "Win",
    Win = "Idle",
    Lose = "Idle",
    Overlose = "Lose"
};

function u1.ChangeState(p11: table, p12: string, p13: boolean?) -- Line: 74
    -- upvalues: u10 (copy)
    if p11.iconState == p12 and not p13 then
        return;
    end;

    local v14;

    if p11.Animations[p12] then
        v14 = p12;
    else
        local v15 = u10[p12] or "Idle";
        v14 = not p11.Animations[v15] and "Idle" or v15;
    end;

    local v16 = p11.prevAnimState or p11.iconState;

    if v16 == v14 and not p13 then
        return;
    end;

    p11.iconState = p12;
    p11.prevAnimState = v14;
    local v17 = `Trans_{v16}{v14}`;

    if not p11.Animations[v17] or p13 then
        p11.playingEvent = false;

        return p11:Play(v14);
    end;

    local v18 = p11:Play(v17, true);
    v18.resetAnim = v14;
    v18.resetOnAnimEnd = true;
end;

function u1.PlayEvent(u19: table, p20: string, p21: boolean?) -- Line: 103
    if not u19.Animations[p20] then
        return;
    end;

    local v22 = p21 == nil and true or p21;

    if u19.playingEvent and (u19.playingPriority and not v22) then
        return;
    end;

    u19.playingEvent = true;
    u19.playingPriority = v22;
    local v23 = u19:Play(p20, true);
    v23.resetOnAnimEnd = true;
    setmetatable(v23, {
        __index = function(p24, p25) -- Line: 116, Name: __index
            -- upvalues: u19 (copy)
            if p25 == "resetAnim" then
                return u19.prevAnimState;
            end;

            return nil;
        end
    });
end;

function u1.LoadIcon(p26: table, p27: any, p28: string?, p29: string?) -- Line: 122
    -- upvalues: Icons (copy), u9 (copy)
    if not p27 then
        return;
    end;

    local v30 = typeof(p27) == "Instance" and p27 and p27 or nil;

    if type(p27) == "string" then
        local v31;

        if p28 then
            if typeof(p28) == "Instance" and p28 then
                v31 = p28;
            else
                v31 = type(p28) == "string" and Icons:FindFirstChild(p28) or Icons;
            end;
        else
            v31 = Icons;
        end;

        v30 = v31:FindFirstChild(p27);

        if not v30 then
            return warn("No folder for", p27, p28);
        end;
    end;

    if v30 then
        local Metadata = v30:FindFirstChild("Metadata");

        if not pcall(function() -- Line: 143
            -- upvalues: Metadata (ref)
            Metadata = require(Metadata);
        end) then
            if Metadata then
                return warn("[Icons] Metadata was not valid for icon " .. v30.Name);
            end;

            warn("[Icons] Missing metadata for icon " .. v30.Name);

            return;
        end;

        p26.curIcon = v30.Name;
        p26.iconColor = Metadata.Color or Color3.new(1, 1, 1);
        p26.iconSide = Metadata.Facing or "R";

        if p26.iconSide == "Left" or p26.iconSide == "L" then
            p26.iconSide = "L";
        else
            p26.iconSide = "R";
        end;

        p26.offsets.set("Scale", "iconScaleOffset", tonumber(Metadata.Scale) or nil);
        p26.offsets.set("alpha", "iconAlphaOffset", tonumber(Metadata.Transparency) or nil);
        local Antialiasing = Metadata.Antialiasing;
        p26.antialiasing = Antialiasing == nil and true or Antialiasing;
        local FlipAutomatically = Metadata.FlipAutomatically;
        p26.autoFlip = FlipAutomatically == nil and true or FlipAutomatically;
        p26.iconSize = Metadata.Size or Vector2.new(150, 150);
        p26.iconCount = Metadata.IconCount or 3;
        p26.animatedIcon = Metadata.Animated or false;
        p26.iconOffset = Metadata.Offset and (typeof(Metadata.Offset) == "UDim2" and Vector2.new(Metadata.Offset.X.Scale, Metadata.Offset.Y.Scale) or Vector2.new(Metadata.Offset.X or 0, Metadata.Offset.Y or 0)) or Vector2.zero;
        p26.metadata = Metadata or {};

        if p26.animatedIcon then
            p26.iconCount = Metadata.Animations and #Metadata.Animations or 0;
            p26.XMLFile = v30:FindFirstChild("XML") or nil;
            p26.XMLPath = v30:FindFirstChild("Animations") or nil;
        end;
    else
        p26.curIcon = "Custom";
        p26.iconColor = p27.Color or Color3.new(1, 1, 1);
        p26.iconSide = p27.Facing or "R";

        if p26.iconSide == "Left" or p26.iconSide == "L" then
            p26.iconSide = "L";
        else
            p26.iconSide = "R";
        end;

        p26.offsets.set("Scale", "iconScaleOffset", tonumber(p27.Scale) or nil);
        p26.offsets.set("alpha", "iconAlphaOffset", tonumber(p27.Transparency) or nil);
        local Antialiasing = p27.Antialiasing;
        p26.antialiasing = Antialiasing == nil and true or Antialiasing;
        local FlipAutomatically = p27.FlipAutomatically;
        p26.autoFlip = FlipAutomatically == nil and true or FlipAutomatically;
        p26.iconSize = p27.Size or Vector2.new(150, 150);
        p26.iconCount = p27.IconCount or 2;
        p26.animatedIcon = false;
        p26.iconOffset = p27.Offset and (typeof(p27.Offset) == "UDim2" and Vector2.new(p27.Offset.X.Scale, p27.Offset.Y.Scale) or Vector2.new(p27.Offset.X or 0, p27.Offset.Y or 0)) or Vector2.zero;
        p26.metadata = p27;
        p26.XMLFile = nil;
        p26.XMLPath = nil;
    end;

    local v32 = p26.animatedIcon and 1.4 or (math.min(150 / p26.iconSize.Y, 150 / p26.iconSize.X) or 1.4);
    p26.offsets.set("Scale", "weirdImplementationMeThinksThanks", v32);

    if p26.side == p26.iconSide and p26.autoFlip then
        p26.offsets.set("Scale", "iconFlip", Vector2.new(-1, 1));
    else
        p26.offsets.set("Scale", "iconFlip", nil);
    end;

    local v33 = p26.iconOffset * p26.iconSize / (p26.offsets.get("Scale", "iconScaleOffset") or 1);
    p26.appliedOffset = v33;
    table.clear(p26.Animations);

    if p26.animatedIcon and (p29 == nil and true or p29) then
        local metadata = p26.metadata;

        if metadata and metadata.Animations then
            for i, v in metadata.Animations do
                local v34 = p26.XMLPath and p26.XMLPath:FindFirstChild(i) or p26.XMLFile;

                if v34 == nil then
                    warn("[Icons] NO XML FOUND");
                else
                    local v35 = metadata.Assets and metadata.Assets[i] or (metadata.Asset or v34:GetAttribute("Image"));
                    local v36 = v34:GetAttribute("Factor") or 1;
                    local v37;

                    if metadata.LoopData then
                        v37 = metadata.LoopData[i] or nil;
                    else
                        v37 = nil;
                    end;

                    if v37 == nil then
                        v37 = not i:find("Trans_");
                    end;

                    local AnimFramesXml = p26:GetAnimFramesXml(v34, v, v36, 1);

                    if AnimFramesXml and #AnimFramesXml > 0 then
                        for _, v2 in AnimFramesXml do
                            if v2.FrameOffset then
                                v2.FrameOffset = v2.FrameOffset + v33;
                            else
                                v2.FrameOffset = v33;
                            end;

                            v2._fixed = false;
                        end;

                        p26:AddAnimation(i, AnimFramesXml, 24, v37, v35);
                    end;
                end;
            end;
        end;
    else
        local v38 = u9[p26.iconCount] or u9[2];
        local v39 = {};

        for i = 1, p26.iconCount do
            v39[v38[i % (#v38 + 1)]] = {
                Size = p26.iconSize,
                Offset = Vector2.new(p26.iconSize.X * (i - 1), 0),
                FrameSize = p26.iconSize,
                FrameOffset = v33
            };
            local _ = i;
        end;

        for i, v in v39 do
            p26:AddAnimation(i, { v }, 0, true, p26.metadata.Asset);
        end;
    end;

    return p26:ChangeState(p26.iconState, true);
end;

function u1.setBop(p40: table, p41: string) -- Line: 284
    -- upvalues: IconBopsV2 (copy)
    if not IconBopsV2[p41] then
        local _ = IconBopsV2.Default;
    end;
end;

function u1.GetAnimationFrames(p42: table, p43: any, p44: string?, p45: string?, p46: string?) -- Line: 289
end;

function u1.exportToDatastore(p47, p48) -- Line: 293
    local v49 = typeof(p48.Color) == "Color3" and p48.Color or Color3.new(1, 1, 1);

    return {
        Name = p48.Name or "Unknown Icon",
        Color = { v49.R, v49.G, v49.B },
        SizeX = p48.Size and (p48.Size.X or 150) or 150,
        SizeY = p48.Size and (p48.Size.Y or 150) or 150,
        OffsetX = p48.Offset and (p48.Offset.X or 0) or 0,
        OffsetY = p48.Offset and (p48.Offset.Y or 0) or 0,
        Asset = p48.Asset,
        Transparency = p48.Transparency,
        IconCount = p48.IconCount,
        Scale = p48.Scale,
        Facing = p48.Facing,
        Antialiasing = p48.Antialiasing,
        FlipAutomatically = p48.FlipAutomatically
    };
end;

function u1.parseFromDatastore(p50, p51) -- Line: 313
    return {
        Name = p51.Name or "Unknown Icon",
        Color = p51.Color and type(p51.Color) == "table" and Color3.new(table.unpack(p51.Color, 1, 3)) or Color3.new(1, 1, 1),
        Size = Vector2.new(p51.SizeX or 150, p51.SizeY or 150),
        Offset = Vector2.new(p51.OffsetX, p51.OffsetY),
        Asset = p51.Asset,
        Transparency = p51.Transparency,
        IconCount = p51.IconCount,
        Scale = p51.Scale,
        Facing = p51.Facing,
        Antialiasing = p51.Antialiasing,
        FlipAutomatically = p51.FlipAutomatically
    };
end;

function u1.convertLegacySettingsToNew(p52, p53, p54) -- Line: 329
    return {
        Name = p54 or "Unknown Icon",
        Color = p53.IconColor and type(p53.IconColor) == "table" and Color3.new(table.unpack(p53.IconColor, 1, 3)) or Color3.new(1, 1, 1),
        Size = Vector2.new(p53.IconBaseSize or 150, p53.IconBaseSize or 150),
        Offset = Vector2.new(p53.OffsetX, p53.OffsetY),
        Asset = `rbxassetid://{p53.IconID}`,
        Transparency = p53.IconAlpha,
        IconCount = p53.IconAmount,
        Scale = p53.IconScale,
        Facing = p53.IconFacing,
        Antialiasing = p53.IconAntialiasing,
        FlipAutomatically = p53.FlipAutomatically
    };
end;

function merge(p55: table, p56: table, p57: boolean)
    if p57 then
        for i, v in p56 do
            rawset(p55, i, v);
        end;

        return;
    end;

    for i, v in p56 do
        p55[i] = v;
    end;
end;

function u1.__call(...) -- Line: 358
    -- upvalues: u1 (copy)
    return u1.new(...);
end;

v3();

return u1;