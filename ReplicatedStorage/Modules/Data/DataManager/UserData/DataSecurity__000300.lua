-- Decompiled with Potassium's decompiler.

local u5 = {
    __add = function(p1, p2) -- Line: 18, Name: __add
        local v3 = {};

        for i, v in p1 do
            v3[i] = v;
        end;

        for i, v in p2 do
            v3[i] = v;
        end;

        local v4 = getmetatable(p1);

        return setmetatable(v3, v4);
    end
};

local function _(p6: table) -- Line: 30
    -- upvalues: u5 (copy)
    return setmetatable(p6, u5);
end;

local v7 = setmetatable({
    string = true
}, u5);
local v8 = setmetatable({
    ["nil"] = true
}, u5);
local v9 = setmetatable({
    number = true
}, u5);
local v10 = setmetatable({
    table = true
}, u5);
local v11 = setmetatable({}, u5);
local v12 = v7 + v8;
local v13 = v7 + v9;
local _ = v10 + v7;

local function isArray(p14) -- Line: 44
    local v15 = 0;
    local v16 = 0;

    for i, _ in p14 do
        if type(i) == "number" and i > 0 then
            v16 = v16 + 1;
        end;

        v15 = v15 + 1;
    end;

    return v15 == v16 == (#p14 == v16);
end;

local function _(u17: number) -- Line: 58
    -- upvalues: isArray (copy), u5 (copy)
    return setmetatable({
        table = function(p18) -- Line: 58
            -- upvalues: isArray (ref), u17 (copy)
            local v19 = isArray(p18) and #p18 <= u17;

            return v19;
        end
    }, u5);
end;

local function _(u20: number) -- Line: 59
    -- upvalues: isArray (copy), u5 (copy)
    return setmetatable({
        table = function(p21) -- Line: 59
            -- upvalues: isArray (ref), u20 (copy)
            local v22 = isArray(p21) and u20 <= #p21;

            return v22;
        end
    }, u5);
end;

local function _(u23: number, u24: number) -- Line: 60
    -- upvalues: isArray (copy), u5 (copy)
    return setmetatable({
        table = function(p25) -- Line: 60
            -- upvalues: isArray (ref), u23 (copy), u24 (copy)
            local v26 = isArray(p25);

            if v26 then
                if u23 <= #p25 then
                    v26 = #p25 <= u24;
                else
                    v26 = false;
                end;
            end;

            return v26;
        end
    }, u5);
end;

local v27 = {};
local u28 = 2;

function v27.table(p29) -- Line: 58
    -- upvalues: isArray (copy), u28 (copy)
    local v30 = isArray(p29) and #p29 <= u28;

    return v30;
end;

local v31 = setmetatable(v27, u5) + v7;
local u32 = {};

for _, v in { "CustomIcon", "OpponentCustomIcon", "NoteskinPack", "OpponentNoteskinPack", "NotesplashPack", "OpponentNotesplashPack", "AnimationPack", "OpponentAnimationPack", "IconPack", "OpponentIconPack", "BannerPack", "OpponentBannerPack", "TagPack", "EmotePack", "HoldsplashPack", "OpponentHoldsplashPack", "CustomBannerImage" } do
    u32[v] = v12;
end;

u32["CustomIconSets/*"] = v11;

for _, v in { "EmoteUserID", "DuoEmoteUserID", "TrioEmoteUserID", "BotUserID", "DuoUserID", "TrioUserID", "ExtraBotIDs/*" } do
    u32[v] = v13;
end;

local function setType(p33, p34) -- Line: 101
    -- upvalues: u32 (copy)
    u32["Keybinds" .. p33] = p34;
    u32["ConsoleKeybinds" .. p33] = p34;
end;

u32.Keybinds = v11;
u32.ConsoleKeybinds = v11;
u32["Keybinds/*!"] = v11;
u32["ConsoleKeybinds/*!"] = v11;

for i = 1, 18 do
    local v35 = `/{i}`;
    u32["Keybinds" .. v35] = v11;
    u32["ConsoleKeybinds" .. v35] = v11;
    local v36 = `/{i}/*`;
    u32["Keybinds" .. v36] = v11;
    u32["ConsoleKeybinds" .. v36] = v11;
    local v37 = `/{i}/*+`;
    u32["Keybinds" .. v37] = v31;
    u32["ConsoleKeybinds" .. v37] = v31;
    local _ = i;
end;

u32["Keybinds/Extra/Dodge"] = v31;
u32["ConsoleKeybinds/Extra/Dodge"] = v31;
u32["Keybinds/Extra/Attack"] = v31;
u32["ConsoleKeybinds/Extra/Attack"] = v31;
u32["Keybinds/Extra/*!"] = v11;
u32["ConsoleKeybinds/Extra/*!"] = v11;
u32["Keybinds/Miscellaneous/LeaderboardKeybind"] = v12;
u32["ConsoleKeybinds/Miscellaneous/LeaderboardKeybind"] = v12;
u32["Keybinds/Miscellaneous/AdminKeybind"] = v12;
u32["ConsoleKeybinds/Miscellaneous/AdminKeybind"] = v12;
u32.NoteskinCustomization = v11;
local v38 = require(Modules:WaitForChild("Engine").VSRG.ManiaData.Dirs)[18];
local v39 = { "Global" };

for i = 4, 18 do
    v39[i - 2] = tostring(i);
    local _ = i;
end;

for _, v in v38 do
    ValueTypes["NoteskinCustomization/" .. v] = {
        table = true,
        ["nil"] = true
    };
    local v40 = v;

    for _, v2 in v39 do
        ValueTypes["NoteskinCustomization/" .. v40 .. "/" .. v2] = {
            table = true,
            ["nil"] = true
        };
        ValueTypes["NoteskinCustomization/" .. v40 .. "/" .. v2 .. "/NoteskinColor"] = {
            table = true,
            ["nil"] = true
        };
        ValueTypes["NoteskinCustomization/" .. v40 .. "/" .. v2 .. "/NotesplashColor"] = {
            table = true,
            ["nil"] = true
        };
        ValueTypes["NoteskinCustomization/" .. v40 .. "/" .. v2 .. "/HoldsplashColor"] = {
            table = true,
            ["nil"] = true
        };
    end;
end;

return table.freeze({
    {
        Server = { "UnlockedIcons", "UniqueFCData", "HoneypotWave", "OwnedBanners", "OwnedTags", "OwnedEmotes", "OwnedIconPacks", "OwnedNoteskins", "OwnedAnimations", "OwnedNotesplashes", "OwnedHoldsplashes", "PrevLockedBanners", "PrevLockedTags", "PrevLockedEmotes", "PrevLockedIconPacks", "PrevLockedNoteskins", "PrevLockedAnimations", "PrevLockedNotesplashes", "PrevLockedHoldsplashes", "DailyQuestData", "Version" },
        Developer = { "CustomSongSelectMusic", "CustomShopMusic", "CustomShopMusicBPM", "ShowBloxstrapDebug", "PrintIncomingSignals", "PrintOutgoingSignals", "DebugPrint", "FunnyMode", "ShowBotplay", "CustomDevRankTag", "AutomaticBotplay", "UseOttoBotplay", "ShowcaseMode", "DisguisedName", "DisguisedVerified", "DisguisedDisplayName" },
        Staff = { "ShowNametagColors", "ShowCustomDevTag", "CustomTagData", "CustomBannerImage", "CustomBannerStyle", "ReplaceBannerByCustom" },
        Contributor = { "UseCustomAnimations", "CustomAnimationData", "CustomAnimData" },
        ContentCreator = { "StreamerMode" }
    }
});