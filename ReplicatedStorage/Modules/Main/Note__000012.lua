-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local RGBSprite = require(Modules.Main.RGBSprite);
local Sprite = require(Modules.Main.Sprite);
local Adapters = require(Modules.Other.Adapters);
local AssetReplicator = require(Modules.Main.AssetReplicator);
local LocalSignals = require(Modules.Signals.LocalSignals);
local u1, u2, v3 = RGBSprite:Extend();
local u4 = nil;
local u5 = {
    data = require(Modules.Engine.VSRG.ManiaData),
    dirs = require(Modules.Engine.VSRG.ManiaData.Dirs)
};
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Vector2_new_ret = Vector2.new(0.5, 0.5);
local Vector2_new_ret2 = Vector2.new(0.5, 0);
local table_find = table.find;
local table_remove = table.remove;
local u6 = {};

local function getObjFromPool() -- Line: 28
    -- upvalues: u6 (copy)
    local table_remove_ret = table.remove(u6);

    if table_remove_ret then
        return table_remove_ret;
    end;

    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.BorderSizePixel = 0;

    return ImageLabel;
end;

local ImageLabel = Instance.new("ImageLabel");
u1.allowedNilCases.hitSound = true;
u1.allowedNilCases.texture = true;
u1.allowedNilCases.textureFallback = true;
u1.allowedNilCases.noteSplashTexture = true;
u1.allowedNilCases.altType = true;
u1.allowedNilCases.endPixel = true;
u1.allowedNilCases.prevTime = true;
u1.allowedNilCases.forcedAnim = true;
u1.allowedNilCases.hitSustain = true;
u1.allowedNilCases.sustainTimes = true;
u1.allowedNilCases.sustainComplete = true;

function u1.new(p7, p8, p9, p10, p11) -- Line: 59
    -- upvalues: u2 (copy), ImageLabel (copy), Color3_fromRGB_ret (copy), Vector2_new_ret (copy), Vector2_new_ret2 (copy)
    local v12 = p10 or false;
    local v13 = u2(ImageLabel, nil, false, nil, true);
    merge(v13, {
        imageColor = Color3_fromRGB_ret,
        strumLine = p11,
        y = 2000,
        x = 100,
        distance = 2000,
        angle = 0,
        quantCol = 0,
        quantDir = "",
        quantAngle = 0,
        visible = true,
        alpha = 1,
        multAlpha = 1,
        zindex = v12 and 4 or 5,
        bgAlpha = 0,
        anchor = Vector2_new_ret,
        strumTime = p7,
        initialPos = p7,
        texture = nil,
        textureFallback = nil,
        noteSplashTexture = nil,
        noAnimation = false,
        noMissAnimation = false,
        hitCausesMiss = false,
        noteSplash = true,
        ignoreNote = false,
        shouldBeHitted = true,
        className = "Note",
        mustPress = false,
        side = "",
        charSide = "",
        noteData = p8,
        prevNote = p9,
        sustainNote = v12,
        isSustain = v12,
        gfNote = false,
        multSpeed = 1,
        hitbox = 1,
        rawData = {},
        dType = { 0 },
        dir = "",
        column = 0,
        section = {},
        tablesStored = {},
        simpleSus = false,
        susEndTime = p7,
        endPos = p7,
        posOffset = {
            x = 0,
            y = 0
        },
        scoreMult = 1,
        sustainScrollSpeed = -1,
        isEnd = false,
        susHit = 0,
        susAmmo = 1,
        sustains = {},
        sustainTimes = false,
        spawnTimeMult = 1,
        ignoreAccuracy = false,
        shareAlpha = true,
        shareScale = true,
        shareAngle = true,
        playAnim = true,
        forcedAnim = nil,
        hitHealth = 0.035,
        missHealth = 0.07,
        killOnHit = false,
        hitSound = nil,
        missSound = nil,
        players = nil,
        hitSoundVolume = 1,
        missSoundVolume = 1,
        rating = {},
        missed = false,
        hit = false,
        wasHit = false,
        hitNextSus = false,
        cancelMovement = false,
        cancelUpdate = false,
        cancelSpawn = false,
        angleAnchor = Vector2_new_ret2
    }, true);
    v13:SetObj(nil);
    v13:changeNoteData(p8);

    return v13;
end;

function u1.getNoteSkinTypeFrames(p14: any, p15: string) -- Line: 164
    -- upvalues: Adapters (copy), u5 (copy), Sprite (copy)
    local v16 = {};
    local Attribute = p14:GetAttribute("Antialiasing");
    local v17 = tonumber(p14:GetAttribute("Framerate")) or 24;
    local v18 = tonumber(p14:GetAttribute("SizeMult")) or 1;
    local v19 = tonumber(p14:GetAttribute("Factor")) or 1;
    local v20 = tonumber(p15:gsub("%D", ""));
    p15:gsub("%A", "");
    Adapters.numberToText(v20);
    local string_lower_ret = string.lower(u5.data.dirXmlColor[p15]);
    local u21 = {};
    local u22 = {};
    local u23 = {};
    (function(p24) -- Line: 183, Name: searchByName
        -- upvalues: u21 (copy), string_lower_ret (copy), u22 (copy), u23 (copy)
        tonumber(p24:gsub("%D", ""));
        p24:gsub("%A", "");
        local string_lower_ret2 = string.lower(p24);
        u21[#u21 + 1] = string_lower_ret .. "0";
        u21[#u21 + 1] = string_lower_ret .. " alone0";
        u21[#u21 + 1] = string_lower_ret2 .. "0";
        u21[#u21 + 1] = string_lower_ret2 .. " alone0";
        u22[#u22 + 1] = string_lower_ret .. " hold piece0";
        u22[#u22 + 1] = string_lower_ret .. " hold0";
        u22[#u22 + 1] = string_lower_ret2 .. " hold piece0";
        u22[#u22 + 1] = string_lower_ret2 .. " hold0";
        u23[#u23 + 1] = string_lower_ret .. " hold end0";
        u23[#u23 + 1] = string_lower_ret .. " end hold0";
        u23[#u23 + 1] = string_lower_ret .. " tail0";
        u23[#u23 + 1] = string_lower_ret2 .. " hold end0";
        u23[#u23 + 1] = string_lower_ret2 .. " end hold";
        u23[#u23 + 1] = string_lower_ret2 .. " tail0";

        if string_lower_ret == "purple" then
            u21[#u21 + 1] = "pruple0";
            u21[#u21 + 1] = "pruple alone0";
            u22[#u22 + 1] = "pruple hold0";
            u22[#u22 + 1] = "pruple hold piece0";
            u23[#u23 + 1] = "pruple hold end0";
            u23[#u23 + 1] = "pruple end hold0";
            u23[#u23 + 1] = "pruple tail0";
        end;
    end)(p15);
    v16.note = Sprite:GetAnimFramesByResults(p14, u21, v19, v18);
    v16.hold = Sprite:GetAnimFramesByResults(p14, u22, v19, v18);
    v16.holdend = Sprite:GetAnimFramesByResults(p14, u23, v19, v18);
    v16._id = p14:GetAttribute("Image");
    v16._antialiasing = Attribute == nil and true or Attribute;
    v16._framerate = v17;
    v16._folder = p15;
    v16._name = p14.Name;

    return v16;
end;

function u1.changeNoteData(p25, p26, p27) -- Line: 231
    p25:changeTargetStrum(p26);
    p25:reloadSkin();
end;

function u1.changeTargetStrum(p28, p29) -- Line: 237
    -- upvalues: u5 (copy)
    local v30 = p28.strumLine and (p28.strumLine.KeyCount or 4) or 4;
    p28.noteData = p29;
    p28.column = p29;
    p28.dir = u5.dirs[tonumber(v30)][p29 + 1];
    local v31 = p28.strumLine and p28.strumLine.Strums[p29];

    if v31 then
        p28.offsets.set("x", "anchorOffset", v31.offsets.get("x", "anchorOffset"));
        p28.offsets.set("y", "anchorOffset", v31.offsets.get("y", "anchorOffset"));
        p28.offsets.set("y", "strumLineOffset", v31.offsets.get("y", "strumLineOffset"));
        p28.offsets.set("x", "strumGapOffset", v31.offsets.get("x", "strumGapOffset"));
        p28.strum = v31;
    end;
end;

function u1.changeStrumline(p32, p33, p34) -- Line: 254
    -- upvalues: u4 (ref)
    if not p33 then
        return;
    end;

    local strumLine = p32.strumLine;
    p32.strumLine = p33;

    if strumLine and (p33 ~= strumLine and p33.KeyCount ~= strumLine) or p34 then
        p32:changeNoteData(p34 and p34 % p33.KeyCount or p32.noteData % p33.KeyCount);
    end;

    local v35 = p33.Index % 2 == 0 and "L" or "R";
    p32.mustPress = u4.Side == v35;
    p32.side = v35;
    p32.charSide = v35;
end;

function u1.getSkinData(p36: table, p37: userdata) -- Line: 271
    local Attribute = p37:GetAttribute("Antialiasing");
    local v38 = tonumber(p37:GetAttribute("Framerate")) or 24;
    local v39 = tonumber(p37:GetAttribute("SizeMult")) or 1;
    local v40 = tonumber(p37:GetAttribute("Factor")) or 1;

    return {
        animations = {
            static = p36:GetAnimFramesByResults(p37, { "receptor0", "receptor static0" }, v40, v39),
            confirm = p36:GetAnimFramesByResults(p37, { "receptor confirm0" }, v40, v39),
            press = p36:GetAnimFramesByResults(p37, { "receptor press0", "receptor pressed0" }, v40, v39),
            note = p36:GetAnimFramesByResults(p37, { "note0", "note alone0" }, v40, v39),
            hold = p36:GetAnimFramesByResults(p37, { "note hold piece0", "note hold0" }, v40, v39),
            holdend = p36:GetAnimFramesByResults(p37, { "note hold end0", "note holdend0", "note tail0" }, v40, v39)
        },
        id = p37:GetAttribute("Image"),
        framerate = v38,
        antialiasing = Attribute == nil and true or Attribute
    };
end;

function getSetBelow(p41, p42)
    if p41 and type(p42) == "string" then
        local v43 = p41:FindFirstChild(p42);

        if v43 then
            return v43;
        end;

        if p42 == "Plus" then
            p42 = "rDown2";
            v43 = p41:FindFirstChild(p42);
        end;

        if p42 == "Square" and not v43 then
            p42 = "rUp2";
            v43 = p41:FindFirstChild(p42);
        end;

        local v44 = v43 or p41:FindFirstChild((string.gsub(p42, "%A", "")));

        if string.sub(p42, 1, 1) == "r" then
            local string_sub_ret = string.sub(p42, 2);
            v44 = v44 or p41:FindFirstChild(string_sub_ret) or p41:FindFirstChild((string.gsub(string_sub_ret, "%A", "")));
        end;

        return v44;
    end;
end;

function getDirBelow(p45, p46)
    if type(p45) == "string" then
        if p45 == "Plus" then
            return "rDown2";
        end;

        if p45 == "Square" then
            return "rUp2";
        end;

        local string_gsub_ret, v47 = string.gsub(p45, "%A", "");

        if v47 > 0 then
            return string_gsub_ret;
        end;

        if string.sub(p45, 1, 1) ~= "r" then
            return p45, true;
        end;

        local v48 = p45 .. (string.match(p46 or "", "%A") or "");

        return string.sub(v48, 2);
    end;
end;

function u1.getNoteTypeData(p49: table, p50: any, p51: number?, p52: table?) -- Line: 357
    -- upvalues: AssetReplicator (copy), u5 (copy), Sprite (copy)
    if type(p50) == "string" then
        p50 = AssetReplicator.getAsset("NoteTypes", p50);
    end;

    if not p50 then
        return warn("No texture!");
    end;

    local v53 = {};
    local v54 = u5.dirs[p51 or 4];

    if p52 then
        v54 = table.clone(v54);

        for _, v in p52 do
            if not table.find(v54, v) then
                table.insert(v54, v);
            end;
        end;
    end;

    local Attribute = p50:GetAttribute("Antialiasing");
    local v55 = Attribute == nil and true or Attribute;
    local v56 = tonumber(p50:GetAttribute("Framerate")) or 24;
    local v57 = tonumber(p50:GetAttribute("SizeMult")) or 1;
    local v58 = tonumber(p50:GetAttribute("Factor")) or 1;

    for _, v in v54 do
        local v59 = getSetBelow(p50, v);

        if v59 then
            local Attribute2 = v59:GetAttribute("Antialiasing");
            local v60 = tonumber(v59:GetAttribute("Framerate")) or 24;
            local v61 = tonumber(v59:GetAttribute("SizeMult")) or 1;
            local v62 = tonumber(v59:GetAttribute("Factor")) or 1;
            v53[v] = {
                animations = {
                    note = p49:GetAnimFramesByResults(v59, { "note0", "note alone0" }, v62, v61),
                    hold = p49:GetAnimFramesByResults(v59, { "note hold piece0", "note hold0" }, v62, v61),
                    holdend = p49:GetAnimFramesByResults(v59, { "note hold end0", "note holdend0", "note tail0" }, v62, v61)
                },
                id = v59:GetAttribute("Image") or p50:GetAttribute("Image"),
                framerate = v60,
                antialiasing = Attribute2 == nil and true or Attribute2
            };
        else
            local u63 = {};
            local u64 = {};
            local u65 = {};

            local function searchByName(p66) -- Line: 414
                -- upvalues: u5 (ref), u63 (ref), u64 (ref), u65 (ref)
                local string_lower_ret = string.lower(u5.data.dirXmlColor[p66]);
                local string_lower_ret2 = string.lower(p66);
                local v67 = string_lower_ret == "purple";
                u63 = {
                    string_lower_ret .. "0",
                    string_lower_ret .. " alone0",
                    string_lower_ret2 .. "0",
                    string_lower_ret2 .. " alone0",
                    v67 and "pruple0" or nil,
                    v67 and "pruple alone0" or nil
                };
                u64 = {
                    string_lower_ret .. " hold piece0",
                    string_lower_ret .. " hold0",
                    string_lower_ret2 .. " hold piece0",
                    string_lower_ret2 .. " hold0",
                    v67 and "pruple hold0" or nil,
                    v67 and "pruple hold piece0" or nil
                };
                u65 = {
                    string_lower_ret .. " hold end0",
                    string_lower_ret .. " end hold0",
                    string_lower_ret .. " tail0",
                    string_lower_ret2 .. " hold end0",
                    string_lower_ret2 .. " end hold",
                    string_lower_ret2 .. " tail0",
                    v67 and "pruple hold end0" or nil,
                    v67 and "pruple end hold0" or nil,
                    v67 and "pruple hold end0" or nil
                };
            end;

            local v68 = v;
            local v69 = nil;
            local v70 = false;
            local v71;

            repeat
                if true then
                    if v69 then
                        v69, v70 = getDirBelow(v69, v68);
                    else
                        v69 = v68;
                    end;
                end;

                searchByName(v69);
                v71 = Sprite:GetAnimFramesByResults(p50, u63, v58, v57);
            until v71 or v70;

            v53[v68] = {
                animations = {
                    note = v71,
                    hold = Sprite:GetAnimFramesByResults(p50, u64, v58, v57),
                    holdend = Sprite:GetAnimFramesByResults(p50, u65, v58, v57)
                },
                id = p50:GetAttribute("Image"),
                framerate = v56,
                antialiasing = v55
            };
        end;
    end;

    return v53;
end;

function u1.reloadSkin(p72) -- Line: 484
    -- upvalues: u4 (ref)
    if not (p72.loadTextures and p72._active) then
        return;
    end;

    if p72.useQuants then
        u4.applyQuantsToNote(p72);

        return;
    end;

    u4.loadNoteset(p72, p72.dir, false);
end;

function u1.makeObj(p73) -- Line: 494
    -- upvalues: u6 (copy)
    local table_remove_ret = table.remove(u6);

    if not table_remove_ret then
        table_remove_ret = Instance.new("ImageLabel");
        table_remove_ret.BackgroundTransparency = 1;
        table_remove_ret.BorderSizePixel = 0;
    end;

    p73:SetObj(table_remove_ret);
    p73.objectIsPool = true;
end;

function u1.SetRating(p74: table, p75: table) -- Line: 499
    p74.rating = p75;
end;

function u1.GetRating(p76) -- Line: 503
    return p76.rating;
end;

function u1.getCacheSize() -- Line: 508
    -- upvalues: u6 (copy)
    return #u6;
end;

function u1.clearCache() -- Line: 512
    -- upvalues: u6 (copy)
    for _, v in u6 do
        v:Destroy();
    end;

    table.clear(u6);
end;

function u1.Copy(p77, p78, p79, p80, ...) -- Line: 521
    -- upvalues: u6 (copy)
    local super = p77.super;
    local v81 = p79 or table.remove(u6);

    if not v81 then
        v81 = Instance.new("ImageLabel");
        v81.BackgroundTransparency = 1;
        v81.BorderSizePixel = 0;
    end;

    return super:Copy(p78, v81, merge({
        objectIsPool = true,
        tablesStored = {}
    }, p80 or {}, true), ...);
end;

function u1.Clone(p82, p83, p84, ...) -- Line: 533
    -- upvalues: u6 (copy)
    local super = p82.super;
    local v85 = p83 or table.remove(u6);

    if not v85 then
        v85 = Instance.new("ImageLabel");
        v85.BackgroundTransparency = 1;
        v85.BorderSizePixel = 0;
    end;

    return super:Clone(v85, merge({
        objectIsPool = true,
        tablesStored = {}
    }, p84 or {}, true), ...);
end;

function u1.Destroy(p86: table, p87: boolean) -- Line: 564
    -- upvalues: u6 (copy), table_find (copy), table_remove (copy)
    p86.prevNote = nil;
    local Obj = p86.Obj;

    if Obj then
        Obj.Parent = nil;
        table.insert(u6, Obj);
        p86.Obj = nil;
    end;

    local tablesStored = p86.tablesStored;

    for i = 1, #tablesStored do
        local v88 = tablesStored[i];
        local v89 = table_find(v88, p86);
        local v90;

        if v89 then
            table_remove(v88, v89);
            v90 = i;
        else
            v90 = i;
        end;
    end;

    p86.super:Destroy();
end;

function merge(p91: table, p92: table, p93: boolean?)
    if p93 then
        for i, v in p92 do
            rawset(p91, i, v);
        end;

        return p91;
    end;

    for i, v in p92 do
        p91[i] = v;
    end;

    return p91;
end;

LocalSignals.APILoaded:Once(function(p94) -- Line: 604
    -- upvalues: u4 (ref)
    u4 = p94;
end);

function u1.__tostring(p95) -- Line: 608
    local v96 = {};

    for i, v in p95 do
        if i == "strumLine" or i == "tablesStored" then
            v96[i] = "*** HELL NO JIGSAW IM NOT PRINTING THIS ***";
        else
            v96[i] = v;
        end;
    end;

    print(v96);

    return "";
end;

function u1.__call(p97, ...) -- Line: 624
    -- upvalues: u1 (copy)
    return u1.new(...);
end;

v3();

return u1;