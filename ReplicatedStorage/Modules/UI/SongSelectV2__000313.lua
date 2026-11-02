-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local MarketplaceService = game:GetService("MarketplaceService");
game:GetService("TeleportService");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("ConfigService");
local GuiService2 = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local u2 = RunService:IsStudio();
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Signal = require(Modules.Lib.Signal);
local Scroll = require(Modules.Lib.Scroll);
local DataManager = require(Modules.Data.DataManager);
local Difficulties = require(Modules.ModData.Difficulties);
local Songs = require(Modules.ModData.Songs);
local Translator = require(Modules.Main.Translator);
local VirtualCursorManager = require(Modules.Other.VirtualCursorManager);
local SongPlayer = require(Modules.Audio.SongPlayer);
local SoundLib = require(Modules.Audio.SoundLib);
local Visualizer = require(Modules.Audio.Visualizer);
local Logger = require(Modules.Other.Logger);
local u3 = {
    type = "GradientBars",
    barSpacing = 0.011,
    barCount = 14,
    barPosition = "Down",
    transparency = 0.3,
    color = Color3.fromRGB(85, 85, 85)
};
local u4 = VirtualCursorManager.new();
local SongSelect = Translator.new("SongSelect", { "SongSelect", "Difficulties", "Judgements", "Modifiers", "CreditsReplacements" });
local Data = DataManager:GetData();
local SongStats = DataManager:GetSongStats();
local LocalPlayer = Players.LocalPlayer;
local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
local TeleportAd = ReplicatedStorage:WaitForChild("Events"):WaitForChild("TeleportAd");
local GameplayModifiers = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Engine"):WaitForChild("VSRG"):WaitForChild("GameplayModifiers");
SoundLib:Pool({ { "SongSelect/Hover5", 2 }, { "SongSelect/Hover4", 2 }, { "SongSelect/Hover3", 2 }, { "SongSelect/Hover2", 2 }, { "SongSelect/Hover1", 2 } });
SoundLib:Pool("Selected", 2);
local u5 = {
    Played = Content.fromUri("rbxassetid://106524539212164"),
    FC = Content.fromUri("rbxassetid://118001435927301"),
    GFC = Content.fromUri("rbxassetid://91146395241452"),
    PFC = Content.fromUri("rbxassetid://77907460974923"),
    MFC = Content.fromUri("rbxassetid://96241033738365")
};
local u6 = {
    Played = 0,
    FC = 1,
    GFC = 2,
    PFC = 3,
    MFC = 4
};
local u7 = { "Stream", "Jumpstream", "Handstream", "Stamina", "Jack", "Chordjack", "Technical", "LN Coordination", "LN Density", "LN Release" };

local function decodeSkillsets(p8: string?) -- Line: 281
    -- upvalues: u7 (copy)
    local v9 = {};

    if not p8 or p8 == "" then
        return v9;
    end;

    local v10 = p8:split(",");

    for i, v in ipairs(u7) do
        local v11 = {
            name = v,
            value = tonumber(v10[i]) or 0
        };
        table.insert(v9, v11);
    end;

    return v9;
end;

function decodeCachedDifficulty(p12: string?)
    -- upvalues: decodeSkillsets (copy)
    if not p12 or p12 == "" then
        return {
            L = {},
            R = {}
        };
    end;

    local table_unpack_ret, v13 = table.unpack(p12:split(";"));

    return {
        L = decodeSkillsets(table_unpack_ret),
        R = decodeSkillsets(v13)
    };
end;

local function getSongFCState(p14: table) -- Line: 305
    -- upvalues: Data (ref), SongStats (ref)
    local v15 = table.find(Data.UniqueFCData, p14.category.name .. "/" .. p14.name) and "FC" or nil;
    local v16 = SongStats[p14.category.name] and SongStats[p14.category.name][p14.name];

    if v16 then
        local v17 = v16.__AFNHFCData or v15;
        v15 = not v17 and next(v16) and "Played" or v17;
    end;

    return v15;
end;

local function getWorstFCState(p18: string?, p19: string?) -- Line: 324
    -- upvalues: u6 (copy)
    if not (p18 and p19) then
        return nil;
    end;

    if u6[p19] < u6[p18] then
        p18 = p19 or p18;
    end;

    return p18;
end;

local u20 = {};
local u21 = {};
local u22 = {
    uiRatio = 2.058,
    weekHeaderYSize = 19,
    songNoWeekYSize = 30,
    songWWeekYSize = 45,
    modSizeY = 36,
    scrollBarInset = 6,
    basexSize = 0.99,
    baseDiffSize = 42,
    defTransDiff = 0.925,
    songTemplateValues = {
        nameXPos = 0.025,
        songNameYOffset = 5,
        weekNameYOffset = 28,
        songNameYSize = 19,
        weekNameYSize = 12,
        nameXSize = 0.842,
        iconSize = 34
    }
};
local u23 = {
    RATE_ROUND = 2,
    MAX_JUDGE = 9,
    MIN_JUDGE = 1,
    JUDGE_ROUND = 0,
    MAX_RATE = u2 and 4 or 2,
    MIN_RATE = u2 and 0.1 or 0.25
};
local u24 = {};

local function getCategoryFCState(p25: table, p26: table) -- Line: 329
    -- upvalues: getSongFCState (copy), u6 (copy)
    local v27 = p25.loadAllSongs and p26 and p26 or p25.songs;

    if #v27 == 0 then
        return nil;
    end;

    local v28 = true;
    local v29 = nil;

    for _, v in v27 do
        local v30 = getSongFCState(v);

        if not v30 then
            return nil;
        end;

        if v28 then
            v29 = v30;
            v28 = false;
        elseif v29 and v30 then
            if u6[v30] < u6[v29] and v30 then
                v29 = v30;
            end;
        else
            v29 = nil;
        end;
    end;

    return v29;
end;

for _, child in script.Songs:GetChildren() do
    if child:IsA("Sound") then
        table.insert(u20, Content.fromUri(child.SoundId));
    end;
end;

script.Songs:Destroy();
local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Exponential);
local UIMusic = script.Audio.UIMusic;
local SongPreview = script.Audio.SongPreview;
local u31 = SongPlayer.new(SongPreview);
u31.isStatic = true;
u31:setPitched(true);

local function randomizeMusic() -- Line: 372
    -- upvalues: UIMusic (copy), u20 (copy)
    UIMusic.AudioContent = u20[math.random(1, #u20)];
end;

local u32 = nil;
local u33 = nil;

local function setSongPreview(p34) -- Line: 378
    -- upvalues: u33 (ref), u32 (ref), TweenService (copy), SongPreview (copy), u31 (copy), TweenInfo_new_ret2 (copy)
    if p34 == u33 then
        return;
    end;

    u33 = p34;

    if not p34 then
        TweenService:Create(SongPreview, TweenInfo_new_ret2, {
            Volume = 0
        }):Play();
        u32 = task.delay(0.5, function() -- Line: 394
            -- upvalues: u32 (ref), u31 (ref)
            u32 = nil;
            u31:unload();
        end);

        return;
    end;

    if u32 then
        task.cancel(u32);
        u32 = nil;
    end;

    TweenService:Create(SongPreview, TweenInfo.new(0), {
        Volume = 0
    }):Play();
    u31:load(p34);
    TweenService:Create(SongPreview, TweenInfo_new_ret2, {
        Volume = 1
    }):Play();
    u31:Play();
end;

local u35 = nil;

local function setMusicVolume(p36, p37) -- Line: 402
    -- upvalues: u35 (ref), Data (ref), UIMusic (copy), TweenInfo_new_ret2 (copy), TweenService (copy)
    if u35 then
        task.cancel(u35);
        u35 = nil;
    end;

    local v38 = not Data.SongSelectMusic and 0 or p36;

    if p37 then
        if v38 > 0 then
            UIMusic:Play();
        else
            u35 = task.delay(TweenInfo_new_ret2.Time, function() -- Line: 413
                -- upvalues: UIMusic (ref)
                UIMusic:Stop();
            end);
        end;
    end;

    TweenService:Create(UIMusic, TweenInfo_new_ret2, {
        Volume = v38
    }):Play();
end;

u31.ended:Connect(function() -- Line: 421
    -- upvalues: u33 (ref), TweenService (copy), SongPreview (copy), u31 (copy), TweenInfo_new_ret2 (copy)
    local u39 = u33;
    TweenService:Create(SongPreview, TweenInfo.new(0), {
        Volume = 0
    }):Play();
    task.delay(1, function() -- Line: 425
        -- upvalues: u31 (ref), u33 (ref), u39 (copy), TweenService (ref), SongPreview (ref), TweenInfo_new_ret2 (ref)
        if u31.paused or u33 ~= u39 then
            return;
        end;

        u31:setPosition(0);
        TweenService:Create(SongPreview, TweenInfo_new_ret2, {
            Volume = 1
        }):Play();
    end);
end);
UIMusic.Ended:Connect(function() -- Line: 433
    -- upvalues: TweenService (copy), UIMusic (copy), u21 (copy), u20 (copy), SongPreview (copy), TweenInfo_new_ret2 (copy)
    TweenService:Create(UIMusic, TweenInfo.new(0), {
        Volume = 0
    }):Play();
    task.delay(1, function() -- Line: 435
        -- upvalues: u21 (ref), UIMusic (ref), u20 (ref), TweenService (ref), SongPreview (ref), TweenInfo_new_ret2 (ref)
        if not next(u21) then
            return;
        end;

        UIMusic.AudioContent = u20[math.random(1, #u20)];
        UIMusic.TimePosition = 0;
        UIMusic:Play();
        TweenService:Create(SongPreview, TweenInfo_new_ret2, {
            Volume = 1
        }):Play();
    end);
end);

function translateCredits(p40: string)
    -- upvalues: SongSelect (copy)
    for i, v in SongSelect.Default.CreditsReplacements do
        p40 = p40:gsub(v, SongSelect.Get("CreditsReplacements_" .. i));
    end;

    return p40;
end;

function translatePrefixes(p41: string)
    -- upvalues: SongSelect (copy)
    if p41 == "" then
        return p41;
    end;

    for i, v in SongSelect.Default.SongSelect.PrefixReplacements do
        p41 = p41:gsub(v, SongSelect.Get("SongSelect_PrefixReplacements_" .. i));
    end;

    return p41;
end;

function parseContent(p42)
    if not p42 then
        return Content.none;
    end;

    if typeof(p42) == "Content" then
        return p42;
    end;

    if type(p42) == "string" then
        return Content.fromUri(p42);
    end;

    return Content.fromAssetId(p42);
end;

function parseColorSequence(p43)
    if p43 then
        if typeof(p43) == "Color3" then
            return ColorSequence.new(p43);
        end;

        return p43;
    end;
end;

local function toMMSS(p44: number) -- Line: 482
    local v45 = p44 % 60;
    local v46 = (p44 - v45) / 60;

    if v45 < 10 then
        v45 = "0" .. v45 or v45;
    end;

    return v46 .. ":" .. v45;
end;

function vectorToRatio(p47, p48: number)
    local X = p47.X;
    local Y = p47.Y;
    local math_round_ret = math.round(Y * p48);

    if X <= math_round_ret then
        return Vector2.new(X, (math.round(X / p48)));
    end;

    return Vector2.new(math_round_ret, Y);
end;

function round(p49, p50)
    local v51 = 10 ^ (p50 or 0);

    return math.floor(p49 * v51 + 0.5) / v51;
end;

u22.baseUiX = vectorToRatio(Vector2.new(1280, 720), u22.uiRatio).X;
u22.baseUiY = vectorToRatio(Vector2.new(1280, 720), u22.uiRatio).Y;

function finalEscape(p52)
    return p52:gsub("[%-%.%+%[%]%(%)%$%^%%%?%*]", "%%%1");
end;

local function trimText(p53: string) -- Line: 514
    return p53:gsub("^%s+", ""):gsub("%s+$", "");
end;

local function normalizeSearchText(p54: string) -- Line: 518
    return p54:lower():gsub("%-", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "");
end;

local function nameMatches(p55: any, p56: string) -- Line: 523
    local v57 = p56:lower():gsub("%-", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "");

    if v57 == "" then
        return true;
    end;

    if p55.name and string.find(p55.name:lower():gsub("%-", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""), v57, 1, true) then
        return true;
    end;

    if p55.displayName and string.find(p55.displayName:lower():gsub("%-", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""), v57, 1, true) then
        return true;
    end;

    if p55.aliases then
        for i in string.gmatch(p55.aliases, "[^|]+") do
            if string.find(i:lower():gsub("%-", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""), v57, 1, true) then
                return true;
            end;
        end;
    end;

    return false;
end;

local u70 = {
    [">"] = function(p58, p59) -- Line: 591
        return p59 < p58;
    end,

    [">="] = function(p60, p61) -- Line: 594
        return p61 <= p60;
    end,

    ["<"] = function(p62, p63) -- Line: 597
        return p62 < p63;
    end,

    ["<="] = function(p64, p65) -- Line: 600
        return p64 <= p65;
    end,

    ["="] = function(p66, p67) -- Line: 605
        return p66 == p67;
    end,

    ["!="] = function(p68, p69) -- Line: 608
        return p68 ~= p69;
    end
};
local u140 = {
    rating = function(p71: table, p72: any, p73: any, p74: any, p75: any) -- Line: 614, Name: rating
        -- upvalues: u70 (copy)
        local v76 = tonumber(p72);

        if not (p71.isSong and v76) then
            return p74;
        end;

        local v77 = false;

        for _, v in p71.diffs do
            if v.Rating[p75.curSide] then
                v77 = v77 or u70[p73](v.Rating[p75.curSide], v76);
            end;
        end;

        return v77;
    end,

    keycount = function(p78: table, p79: any, p80: any, p81: any) -- Line: 627, Name: keycount
        -- upvalues: u70 (copy)
        local v82 = tonumber(p79);

        if not (p78.isSong and v82) then
            return p81;
        end;

        local v83 = false;

        for _, v in p78.diffs do
            if v.Keycount then
                v83 = v83 or u70[p80](v.Keycount, v82);
            end;
        end;

        return v83;
    end,

    bpm = function(p84: table, p85: any, p86: any, p87: any) -- Line: 640, Name: bpm
        -- upvalues: u70 (copy)
        local v88 = tonumber(p85);

        if not (p84.isSong and v88) then
            return p87;
        end;

        local v89 = false;

        for _, v in p84.diffs do
            if v.BPM then
                v89 = v89 or u70[p86](v.BPM, v88);
            end;
        end;

        return v89;
    end,

    name = function(p90: table, p91: any, p92: any, p93: any) -- Line: 654, Name: name
        -- upvalues: nameMatches (copy)
        local v94 = nameMatches(p90, p91 or "");

        if p92 == "!=" then
            v94 = not v94;
        end;

        return v94;
    end,

    credits = function(p95: table, p96: any, p97: any) -- Line: 660, Name: credits
        local v98 = finalEscape(p96 or ""):lower();
        local v99 = p95.isSong and { p95 } or p95.songs;

        if p95.isSong then
            p95 = p95.category or p95;
        end;

        local string_find_ret = string.find((p95.credits or ""):lower(), v98);

        for _, v in v99 do
            if string_find_ret then
                break;
            end;

            string_find_ret = string_find_ret or (string.find((v.credits or ""):lower(), v98) or string.find((v.extraCredits or ""):lower(), v98));

            for _, v2 in v.diffs do
                if string_find_ret then
                    break;
                end;

                string_find_ret = string_find_ret or (string.find((v2.credits or ""):lower(), v98) or string.find((v2.extraCredits or ""):lower(), v98));
            end;
        end;

        if p97 == "!=" then
            string_find_ret = not string_find_ret;
        end;

        return string_find_ret;
    end,

    week = function(p100, p101, p102, p103) -- Line: 683, Name: week
        if not p100.isSong then
            return p103;
        end;

        local v104 = string.find((p100.week and p100.week.name or ""):lower(), finalEscape(p101 or ""):lower()) and true;

        if p102 == "!=" then
            v104 = not v104;
        end;

        return v104;
    end,

    status = function(p105: table, p106: any, p107: any) -- Line: 692, Name: status
        if (p106 or ""):lower() ~= "none" then
            local v108;

            if p105.isSong then
                v108 = string.find((p105.prefix or ""):lower(), finalEscape(p106 or ""):lower()) or string.find((p105.category.prefix or ""):lower(), finalEscape(p106 or ""):lower());
            else
                v108 = string.find((p105.prefix or ""):lower(), finalEscape(p106 or ""):lower());
            end;

            if p107 == "!=" then
                v108 = not v108;
            end;

            return v108 and true or false;
        end;

        local v109 = (p105.prefix or "") ~= "";

        if p105.isSong and not v109 then
            v109 = (p105.category.prefix or "") ~= "";
        end;

        if p107 == "!=" then
            return v109;
        end;

        return not v109;
    end,

    new = function(p110: table, p111: any, p112: any) -- Line: 719, Name: new
        local string_find_ret = string.find((p110.prefix or ""):lower(), "new");

        if p111 == "false" and true or p111 == "f" then
            string_find_ret = not string_find_ret;
        end;

        if p112 == "!=" then
            string_find_ret = not string_find_ret;
        end;

        return string_find_ret and true or false;
    end,

    updated = function(p113: table, p114: any, p115: any) -- Line: 728, Name: updated
        local string_find_ret = string.find((p113.prefix or ""):lower(), "updated");

        if p114 == "false" and true or p114 == "f" then
            string_find_ret = not string_find_ret;
        end;

        if p115 == "!=" then
            string_find_ret = not string_find_ret;
        end;

        return string_find_ret and true or false;
    end,

    improved = function(p116: table, p117: any, p118: any) -- Line: 737, Name: improved
        local string_find_ret = string.find((p116.prefix or ""):lower(), "improv");

        if p117 == "false" and true or p117 == "f" then
            string_find_ret = not string_find_ret;
        end;

        if p118 == "!=" then
            string_find_ret = not string_find_ret;
        end;

        return string_find_ret and true or false;
    end,

    indev = function(p119: table, p120: any, p121: any) -- Line: 746, Name: indev
        local string_find_ret = string.find((p119.prefix or ""):lower(), "indev");

        if p120 == "false" and true or p120 == "f" then
            string_find_ret = not string_find_ret;
        end;

        if p121 == "!=" then
            string_find_ret = not string_find_ret;
        end;

        return string_find_ret and true or false;
    end,

    modchart = function(p122: table, p123: any, p124: any, p125: any) -- Line: 755, Name: modchart
        if not p122.isSong then
            return p125;
        end;

        local v126 = p123 ~= "false" and p123 ~= "f";

        if p124 == "!=" then
            v126 = not v126;
        end;

        local v127 = false;

        for _, v in p122.diffs do
            v127 = v127 or v.HasModchart == true == v126;
        end;

        return v127;
    end,

    gimmick = function(p128: table, p129: any, p130: any, p131: any) -- Line: 769, Name: gimmick
        if not p128.isSong then
            return p131;
        end;

        local v132 = p129 ~= "false" and p129 ~= "f";

        if p130 == "!=" then
            v132 = not v132;
        end;

        local v133 = false;

        for _, v in p128.diffs do
            v133 = v133 or v.HasGimmicks == true == v132;
        end;

        return v133;
    end,

    map = function(p134: table, p135: any, p136: any, p137: any) -- Line: 783, Name: map
        if not p134.isSong then
            return p137;
        end;

        local v138 = p135 ~= "false" and p135 ~= "f";

        if p136 == "!=" then
            v138 = not v138;
        end;

        local v139 = false;

        for _, v in p134.diffs do
            v139 = v139 or v.HasMap == true == v138;
        end;

        return v139;
    end
};
local u141 = {
    ["=="] = "=",
    ["~="] = "!="
};

for i, v in {
    diff = "rating",
    difficulty = "rating",
    keys = "keycount",
    mania = "keycount",
    keyammo = "keycount",
    credit = "credits",
    hasmap = "map",
    bg = "map",
    hasbg = "map",
    hasbackground = "map",
    background = "map",
    hasmodchart = "modchart",
    hasmodcharts = "modchart",
    hasgimmick = "gimmick",
    hasgimmicks = "gimmick",
    specialnotes = "gimmick",
    hasspecialnotes = "gimmick",
    prefix = "status",
    state = "status",
    update = "updated",
    added = "new",
    improv = "improved"
} do
    u140[i] = u140[v];
end;

for i, v in u141 do
    u70[i] = u70[v];
end;

local function parseFilterSegment(p142: string) -- Line: 809
    -- upvalues: u141 (copy), u70 (copy), u140 (copy)
    local v143, v144, v145 = p142:match("^%s*([%a_][%w_]*)%s*([<>!~=]+)(.*)$");

    if not v143 then
        return nil;
    end;

    local v146 = u141[v144] or v144;

    if not u70[v146] then
        return nil;
    end;

    local v147 = u140[v143:lower()];

    return v147 and { v147, v145:gsub("^%s+", ""):gsub("%s+$", ""), v146 } or nil;
end;

function getCasesFromSearch(p148)
    -- upvalues: parseFilterSegment (copy), u140 (copy)
    if not p148 or p148:gsub("^%s+", ""):gsub("%s+$", "") == "" then
        return {};
    end;

    local v149 = {};

    for i in (p148 .. "&"):gmatch("(.-)&") do
        if i:gsub("^%s+", ""):gsub("%s+$", "") ~= "" then
            table.insert(v149, i);
        end;
    end;

    local v150 = {};
    local v151 = false;

    for _, v in v149 do
        local v152 = parseFilterSegment(v) ~= nil;

        if #v150 == 0 or (v152 or v151) then
            table.insert(v150, v);
        else
            v150[#v150] = v150[#v150] .. "&" .. v;
        end;

        v151 = v152;
    end;

    local v153 = {};

    for _, v in v150 do
        local v154 = parseFilterSegment(v);

        if v154 then
            table.insert(v153, v154);
        else
            local v155 = { u140.name, v:gsub("^%s+", ""):gsub("%s+$", ""), "=" };
            table.insert(v153, v155);
        end;
    end;

    return v153;
end;

function u1.new(p156: any, p157: table?) -- Line: 858
    -- upvalues: u1 (copy), GuiService (copy), SongSelect (copy), Data (ref), Signal (copy), Visualizer (copy), SongPreview (copy), u22 (copy), u21 (copy), TweenService (copy), Scroll (copy), getCategoryFCState (copy), u5 (copy), SoundLib (copy), getSongFCState (copy), u31 (copy), u23 (copy), GameplayModifiers (copy), Logger (copy), TeleportAd (copy)
    if not p156 then
        return error("[SongSelect] No ui passed!");
    end;

    local v158 = p157 or {};
    local v159 = p156;
    local Modifiers = p156:FindFirstChild("Modifiers");

    if not Modifiers then
        v158.blockModifiers = true;
    end;

    local u160 = p156:FindFirstChild("Main") or p156;
    u1.baseUI = u1.baseUI or v159:Clone();
    u160.BackgroundTransparency = 0.25 * GuiService.PreferredTransparency;
    GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- Line: 873
        -- upvalues: u160 (ref), GuiService (ref)
        u160.BackgroundTransparency = 0.25 * GuiService.PreferredTransparency;
    end);

    if Modifiers and Modifiers.Content then
        Modifiers.Content.Size = UDim2.new(0.343, 0, 1, -GuiService.TopbarInset.Height);
        GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 880
            -- upvalues: Modifiers (copy), GuiService (ref)
            if Modifiers and Modifiers.Content then
                Modifiers.Content.Size = UDim2.new(0.343, 0, 1, -GuiService.TopbarInset.Height);
            end;
        end);
    end;

    u160.Size = UDim2.new(0.925, 0, 0.8, -GuiService.TopbarInset.Height / 2);
    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 887
        -- upvalues: u160 (ref), GuiService (ref)
        u160.Size = UDim2.new(0.925, 0, 0.8, -GuiService.TopbarInset.Height / 2);
    end);
    v159.RootLocalizationTable = SongSelect.localizationTable;
    local v161 = {
        gui = v159,
        ui = u160,
        modifiersUi = Modifiers,
        mods = {},
        songs = {},
        folders = {},
        categories = {},
        difficulties = {},
        features = v158,
        scrolls = {},
        voteData = {
            mod = nil,
            song = nil,
            diff = nil
        },
        generalOffset = 0,
        isInitialized = false,
        timerId = 0,
        scalingSizeMult = 1,
        upscaleAmmo = Data.SongSelectUpscale or 1,
        modifiers = {},
        useRates = false,
        rate = 1,
        pitchSong = true,
        modchartsEnabled = true,
        gimmicksEnabled = true,
        judgement = 4,
        curSide = "L",
        showCopyright = true,
        isSingleplayer = false,
        players = {
            L = {},
            R = {}
        },
        favoriteAdded = Signal.new(),
        favoriteRemoved = Signal.new(),
        recentPlay = Signal.new(),
        makeFolder = Signal.new(),
        deleteFolder = Signal.new(),
        addToFolder = Signal.new(),
        removeFromFolder = Signal.new(),
        play = Signal.new(),
        picked = Signal.new(),
        isDirty = true,
        Visualizer = Visualizer.new(u160.UpperPanel.SongInfo.SelectedSong.Visualizer, {})
    };
    local u162 = setmetatable(v161, {
        __index = u1
    });
    u162.Visualizer:setAudio(SongPreview);
    local UpperPanel = u160.UpperPanel;
    local u163 = vectorToRatio(workspace.CurrentCamera.ViewportSize, u22.uiRatio);
    local u164 = (math.max(u163.Y / u22.baseUiY, 1) - 1) * u162.upscaleAmmo + 1;
    u162.scalingSizeMult = u164;
    local u165 = {};

    local function updateSize() -- Line: 964
        -- upvalues: u21 (ref), u162 (copy), u163 (ref), u22 (ref), u164 (ref), u165 (copy)
        if not u21[u162] then
            u162.isDirty = true;

            return;
        end;

        u163 = vectorToRatio(workspace.CurrentCamera.ViewportSize, u22.uiRatio);
        u164 = (math.max(u163.Y / u22.baseUiY, 1) - 1) * u162.upscaleAmmo + 1;
        u162.scalingSizeMult = u164;

        for _, v in u165 do
            v();
        end;
    end;

    u162.updateLayoutSize = updateSize;
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateSize);
    local v166 = { u160.UpperPanel.SongMods.SongMods, u160.UpperPanel.SongMods.SongVotes, u160.UpperPanel.SongMods.Rates };
    local v167 = {
        u160.UpperPanel.SongInfo.SongCredits,
        u160.UpperPanel.SongInfo.SongStats,
        u160.UpperPanel.SongInfo.SelectedSong,
        u160.UpperPanel.SongInfo.Difficulties,
        u160.UpperPanel.SongInfo.Credits
    };
    local v168 = {
        u160.UpperPanel.Mods,
        u160.UpperPanel.SongInfo,
        u160.UpperPanel.SongMods,
        u160.UpperPanel.Songs
    };
    local v169 = {
        [u160.UpperPanel.SongMods] = v166,
        [u160.UpperPanel.SongInfo] = v167
    };

    for i = 1, #v168 do
        local u170 = v168[i];
        local u171 = v169[u170];
        u170.MouseEnter:Connect(function() -- Line: 1000
            -- upvalues: u171 (copy), TweenService (ref), u170 (copy)
            if u171 then
                for i2 = 1, #u171 do
                    TweenService:Create(u171[i2].UIStroke, TweenInfo.new(0.5), {
                        Transparency = 0.7
                    }):Play();
                    local _ = i2;
                end;

                return;
            end;

            TweenService:Create(u170.UIStroke, TweenInfo.new(0.5), {
                Transparency = 0.7
            }):Play();
        end);
        u170.MouseLeave:Connect(function() -- Line: 1010
            -- upvalues: u171 (copy), TweenService (ref), u170 (copy)
            if u171 then
                for i2 = 1, #u171 do
                    TweenService:Create(u171[i2].UIStroke, TweenInfo.new(0.5), {
                        Transparency = 0.9
                    }):Play();
                    local _ = i2;
                end;

                return;
            end;

            TweenService:Create(u170.UIStroke, TweenInfo.new(0.5), {
                Transparency = 0.9
            }):Play();
        end);
        local _ = i;
    end;

    local ScrollingFrame = UpperPanel.Mods.ScrollingFrame;
    local u172 = Scroll.new(ScrollingFrame, nil, "Pooled");
    u172:setLayout({
        isList = true,
        fillDirection = Enum.FillDirection.Vertical,
        padding = ScrollingFrame.UIListLayout.Padding
    });
    ScrollingFrame.UIListLayout.Parent = nil;
    u172:setTypes({
        Mod = {
            OnLoaded = function(u173: table, u174: userdata, p175: table) -- Line: 1038, Name: OnLoaded
                -- upvalues: u162 (copy), getCategoryFCState (ref), u5 (ref), SoundLib (ref)
                p175.clickedConnection = u174.MouseButton1Click:Connect(function() -- Line: 1039
                    -- upvalues: u162 (ref), u173 (copy)
                    u162:selectCategory(u173);
                end);
                u174.ModName.Text = u173.displayName;
                u174.ModIcon.ImageContent = u173.icon or Content.none;
                u174.BG.UIGradient.Color = u173.color;
                u174.PrefixDisplay.Text = translatePrefixes(u173.prefix or "");
                local v176;

                if u173.prefix == nil then
                    v176 = false;
                else
                    v176 = u173.prefix ~= "";
                end;

                u174.PrefixDisplay.Visible = v176;
                local v177 = getCategoryFCState(u173, u162.songs);
                u174.Icons.FCIcon.ImageContent = u173.showFCIcon and v177 and u5[v177] or Content.none;
                u174.ModName.Size = UDim2.fromScale(u173.showFCIcon and v177 and 0.71 or 0.825, 0.53);
                u174.ModName.Position = UDim2.fromScale(0.15, 0.5);
                SoundLib:Attach(u174, {
                    MouseButton1Click = "Selected",
                    MouseLeave = "",
                    MouseEnter = { "SongSelect/Hover1", "SongSelect/Hover2", "SongSelect/Hover3", "SongSelect/Hover4", "SongSelect/Hover5" }
                }, function(p178) -- Line: 1060
                    -- upvalues: u174 (copy)
                    if p178 == "MouseEnter" then
                        u174.UIStroke.Transparency = 0.6;

                        return;
                    end;

                    if p178 == "MouseLeave" then
                        u174.UIStroke.Transparency = 0.8;
                    end;
                end);
            end,

            OnUnloaded = function(p179: any, p180: any, p181: table) -- Line: 1070, Name: OnUnloaded
                if p181.clickedConnection then
                    p181.clickedConnection:Disconnect();
                    p181.clickedConnection = nil;
                end;
            end,

            Template = ScrollingFrame.Template,
            Size = UDim2.new(u22.basexSize, -u22.scrollBarInset, 0, u22.modSizeY * u164)
        }
    });
    u172:setVisible(false);
    table.insert(u165, function() -- Line: 1081
        -- upvalues: u172 (copy), ScrollingFrame (copy), u22 (ref), u164 (ref)
        u172.cachedFrameSize = ScrollingFrame.AbsoluteSize;
        u172.types.Mod.Size = UDim2.new(u22.basexSize, -u22.scrollBarInset, 0, u22.modSizeY * u164);
        u172:setTypes(u172.types);
    end);
    ScrollingFrame.Template.Parent = nil;
    table.insert(u162.scrolls, u172);
    u162.modScroll = u172;
    UpperPanel.Mods.ModSearch.TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 1093
        -- upvalues: u162 (copy)
        u162:renderMods();
    end);
    local ScrollingFrame2 = UpperPanel.Songs.ScrollingFrame;
    local u182 = Scroll.new(ScrollingFrame2, nil, "Pooled");
    u182:setLayout({
        isList = true,
        fillDirection = Enum.FillDirection.Vertical,
        padding = ScrollingFrame2.UIListLayout.Padding
    });
    ScrollingFrame2.UIListLayout.Parent = nil;
    ScrollingFrame2.SongTemplate.PrefixDisplay.Text = "";
    ScrollingFrame2.SongTemplate.WeekName.Text = "";
    u182:setTypes({
        Week = {
            OnLoaded = function(p183: table, p184: any) -- Line: 1115, Name: OnLoaded
                p184.Week.Text = p183.name or "Week name goes here";
                p184.BG.UIGradient.Color = p183.color;
            end,

            Template = ScrollingFrame2.WeekTemplate,
            Size = UDim2.new(u22.basexSize, -u22.scrollBarInset, 0, u22.weekHeaderYSize * u164)
        },
        Song = {
            OnLoaded = function(u185: table, u186: any, p187: table) -- Line: 1123, Name: OnLoaded
                -- upvalues: u162 (copy), getSongFCState (ref), u5 (ref), SoundLib (ref)
                p187.clickedConnection = u186.MouseButton1Click:Connect(function() -- Line: 1124
                    -- upvalues: u162 (ref), u185 (copy)
                    u162:selectSong(u185);
                end);
                local v188 = getSongFCState(u185);
                u186.Icons.FCIcon.ImageContent = v188 and u5[v188] or Content.none;
                u186.BG.UIGradient.Color = u185.color;
                u186.SongName.Text = u185.displayName or u185.name;
                u186.Icons.Favorite.Sprite.ImageColor3 = u185.favorited and Color3.fromRGB(255, 255, 255) or Color3.new(0, 0, 0);
                u186.PrefixDisplay.Text = translatePrefixes(u185.prefix or "");
                local v189;

                if u185.prefix == nil then
                    v189 = false;
                else
                    v189 = u185.prefix ~= "";
                end;

                u186.PrefixDisplay.Visible = v189;
                u186.Icons.Favorite.Visible = not u162.features.noFavorites;
                SoundLib:Attach(u186, {
                    MouseButton1Click = "Selected",
                    MouseLeave = "",
                    MouseEnter = { "SongSelect/Hover1", "SongSelect/Hover2", "SongSelect/Hover3", "SongSelect/Hover4", "SongSelect/Hover5" }
                }, function(p190) -- Line: 1144
                    -- upvalues: u186 (copy)
                    if p190 == "MouseEnter" then
                        u186.StateStroke.Transparency = 0.2;

                        return;
                    end;

                    if p190 == "MouseLeave" then
                        u186.StateStroke.Transparency = 0.6;
                    end;
                end);

                if not (u162.features.lockFavorites and u162.features.noFavorites) then
                    p187.favClicked = u186.Icons.Favorite.MouseButton1Click:Connect(function() -- Line: 1153
                        -- upvalues: u185 (copy), u186 (copy), u162 (ref)
                        u185.favorited = not u185.favorited;
                        u186.Icons.Favorite.Sprite.ImageColor3 = u185.favorited and Color3.fromRGB(255, 255, 255) or Color3.new(0, 0, 0);

                        if u185.favorited then
                            u162.favoriteAdded:Fire(u185.category.name, u185.name);
                        else
                            u162.favoriteRemoved:Fire(u185.category.name, u185.name);
                        end;

                        u162:renderMods();

                        if u162.favoritesCat then
                            if u185.favorited then
                                table.insert(u162.favoritesCat.songs, u185);

                                return;
                            end;

                            local table_find_ret = table.find(u162.favoritesCat.songs, u185);

                            if table_find_ret then
                                table.remove(u162.favoritesCat.songs, table_find_ret);
                            end;

                            if u162.curCat == u162.favoritesCat then
                                u162:renderSongs();
                            end;
                        end;
                    end);
                end;

                u186.UnavailableDisplay.Visible = u185.isUnavailable;

                if u185.isUnavailable then
                    if p187.clickedConnection then
                        p187.clickedConnection:Disconnect();
                        p187.clickedConnection = nil;
                    end;

                    if p187.favClicked then
                        p187.favClicked:Disconnect();
                        p187.favClicked = nil;
                    end;
                end;
            end,

            OnUnloaded = function(p191: table, p192: any, p193: table) -- Line: 1183, Name: OnUnloaded
                if p193.clickedConnection then
                    p193.clickedConnection:Disconnect();
                    p193.clickedConnection = nil;
                end;

                if p193.favClicked then
                    p193.favClicked:Disconnect();
                    p193.favClicked = nil;
                end;
            end,

            Template = ScrollingFrame2.SongTemplate,
            Size = UDim2.new(u22.basexSize, -u22.scrollBarInset, 0, u22.songNoWeekYSize * u164)
        },
        SongWithWeek = {
            OnLoaded = function(p194: table, p195: any, p196: table) -- Line: 1191, Name: OnLoaded
                -- upvalues: u182 (copy)
                u182.types.Song.OnLoaded(p194, p195, p196);
                p195.WeekName.Text = p194.week and p194.week.name or "";
            end,

            OnUnloaded = function(p197: table, p198: any, p199: any) -- Line: 1197, Name: OnUnloaded
                -- upvalues: u182 (copy)
                u182.types.Song.OnUnloaded(p197, p198, p199);
                p198.WeekName.Text = "";
            end,

            Template = ScrollingFrame2.SongTemplate,
            Size = UDim2.new(u22.basexSize, -u22.scrollBarInset, 0, u22.songWWeekYSize * u164)
        }
    });

    local function updateSongTemplate() -- Line: 1207
        -- upvalues: u182 (copy), u22 (ref), u164 (ref)
        local Template = u182.types.Song.Template;
        Template.SongName.Position = UDim2.new(u22.songTemplateValues.nameXPos, 0, 0, u22.songTemplateValues.songNameYOffset * u164);
        Template.WeekName.Position = UDim2.new(u22.songTemplateValues.nameXPos, 0, 0, u22.songTemplateValues.weekNameYOffset * u164);
        Template.SongName.Size = UDim2.new(u22.songTemplateValues.nameXSize, 0, 0, u22.songTemplateValues.songNameYSize * u164);
        Template.WeekName.Size = UDim2.new(u22.songTemplateValues.nameXSize, 0, 0, u22.songTemplateValues.weekNameYSize * u164);
    end;

    updateSongTemplate();
    table.insert(u165, function() -- Line: 1219
        -- upvalues: u182 (copy), ScrollingFrame2 (copy), u22 (ref), u164 (ref), updateSongTemplate (copy)
        u182.cachedFrameSize = ScrollingFrame2.AbsoluteSize;
        u182.types.Week.Size = UDim2.new(u22.basexSize, -u22.scrollBarInset, 0, u22.weekHeaderYSize * u164);
        u182.types.Song.Size = UDim2.new(u22.basexSize, -u22.scrollBarInset, 0, u22.songNoWeekYSize * u164);
        u182.types.SongWithWeek.Size = UDim2.new(u22.basexSize, -u22.scrollBarInset, 0, u22.songWWeekYSize * u164);
        updateSongTemplate();
        u182:setTypes(u182.types);
    end);
    ScrollingFrame2.WeekTemplate.Parent = nil;
    ScrollingFrame2.SongTemplate.Parent = nil;
    table.insert(u162.scrolls, u182);
    u182:setVisible(false);
    u162.songScroll = u182;
    UpperPanel.Songs.SongSearch.TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 1238
        -- upvalues: u162 (copy)
        u162:renderSongs();
    end);
    UpperPanel.SongInfo.Difficulties.DifficultyList.Template.Visible = false;
    local DifficultyList = UpperPanel.SongInfo.Difficulties.DifficultyList;
    local v200 = Scroll.new(DifficultyList, nil, "Pooled");
    v200:setLayout({
        isList = true,
        fillDirection = DifficultyList.UIListLayout.FillDirection,
        padding = DifficultyList.UIListLayout.Padding,
        horizontalAlignment = DifficultyList.UIListLayout.HorizontalAlignment,
        verticalAlignment = DifficultyList.UIListLayout.VerticalAlignment
    });
    DifficultyList.UIListLayout.Parent = nil;
    v200:setVisible(false);
    local Template = DifficultyList.Template;
    Template.Parent = nil;
    table.insert(u162.scrolls, v200);
    u162.diffScroll = v200;
    u162.diffTemplate = Template;
    u162.difficultyItems = {};
    table.insert(u165, function() -- Line: 1271
        -- upvalues: u162 (copy), u22 (ref), u164 (ref)
        local types = u162.diffScroll.types;
        local v201 = false;

        for i, v in u162.difficulties do
            if types[i] then
                types[i].Size = UDim2.new(0.92 * v.scale.X, 0, 0, u22.baseDiffSize * v.scale.Y * u164);
                v201 = true;
            end;
        end;

        if v201 then
            u162.diffScroll:setTypes(types);
        end;
    end);

    if not u162.features.noAll then
        u162:addCategory({
            name = "All",
            credits = "All the songs!",
            loadAllSongs = true,
            isFolder = true,
            showFCIcon = true,
            lockedFolder = true,
            displayWeeks = false,
            alwaysVisible = false,
            alphabeticalSort = true,
            songs = {},
            color = Color3.fromRGB(255, 255, 255),
            icon = Content.fromAssetId(78916262503791)
        });
        u162.generalOffset = u162.generalOffset + 1;
    end;

    if not u162.features.noFavorites then
        u162.favoritesCat = u162:addCategory({
            name = "Favorites",
            credits = "All your favorite songs!",
            isFolder = true,
            showFCIcon = true,
            lockedFolder = true,
            displayWeeks = false,
            alwaysVisible = false,
            alphabeticalSort = true,
            songs = {},
            color = Color3.fromRGB(255, 170, 0),
            icon = Content.fromAssetId(137378185425509)
        });
        u162.generalOffset = u162.generalOffset + 1;
    end;

    if not u162.features.noRecents then
        u162.recentCat = u162:addCategory({
            name = "Recently Played",
            credits = "All your recently played songs!",
            isFolder = true,
            showFCIcon = true,
            lockedFolder = true,
            displayWeeks = false,
            alwaysVisible = false,
            alphabeticalSort = false,
            songs = {},
            color = Color3.fromRGB(160, 157, 255),
            icon = Content.fromAssetId(138225302983887)
        });
    end;

    local v202 = {};
    local v203 = {};
    local v204 = {};

    if u162.features.blockRates then
        UpperPanel.SongMods.Rates.Visible = false;
    else
        local function fixUpRates() -- Line: 1374
            -- upvalues: u31 (ref), u162 (copy), UpperPanel (copy)
            u31:setPitched(u162.pitchSong);
            setPreviewRate(u162, u162.useRates and tonumber(UpperPanel.SongMods.Rates.CurrentSpeed.Input.Label.Text) or 1);
        end;

        table.insert(v202, {
            property = "useRates",
            button = UpperPanel.SongMods.Rates.Toggle.Toggle,
            onChange = fixUpRates
        });
        table.insert(v203, {
            property = "rate",
            max = u23.MAX_RATE,
            min = u23.MIN_RATE,
            round = u23.RATE_ROUND,
            textbox = UpperPanel.SongMods.Rates.CurrentSpeed.Input.Label
        });
        table.insert(v202, {
            property = "pitchSong",
            button = UpperPanel.SongMods.Rates.Pitch.Toggle,
            onChange = fixUpRates
        });
        UpperPanel.SongMods.Rates.CurrentSpeed.Input.Label.FocusLost:Connect(fixUpRates);
    end;

    if u162.features.blockModifiers then
        UpperPanel.SongMods.SongMods.Visible = false;
    else
        table.insert(v202, {
            property = "modchartsEnabled",
            button = UpperPanel.SongMods.SongMods.Modcharts.Toggle
        });
        table.insert(v202, {
            property = "gimmicksEnabled",
            button = UpperPanel.SongMods.SongMods.SpecialNotes.Toggle
        });
        table.insert(v203, {
            property = "judgement",
            max = u23.MAX_JUDGE,
            min = u23.MIN_JUDGE,
            round = u23.JUDGE_ROUND,
            textbox = UpperPanel.SongMods.SongMods.Judgement.Input.Label
        });
    end;

    if u162.features.noVotes then
        UpperPanel.SongMods.SongVotes.Visible = false;
    end;

    local Header = UpperPanel.SongInfo.Credits.Header;
    local ScrollingFrame3 = UpperPanel.SongInfo.Credits.ScrollingFrame;
    local v205 = {
        controller = ScrollingFrame3.PageController,
        labelPages = {
            {
                ignoreIfEmpty = false,
                obj = ScrollingFrame3.ModCredits,
                pageName = SongSelect.SongSelect_CreditsHeader
            },
            {
                ignoreIfEmpty = true,
                obj = ScrollingFrame3.AFNCredits,
                pageName = SongSelect.SongSelect_CreditsHeader
            }
        },
        back = Header.Backy,
        next = Header.Advancy,
        header = Header,
        scroll = ScrollingFrame3
    };
    u162.creditsPage = v205;
    table.insert(v204, v205);
    local Header2 = UpperPanel.SongInfo.SongStats.Header;
    local PagesContent = UpperPanel.SongInfo.SongStats.PagesContent;
    local v206 = {
        controller = PagesContent.PageController,
        labelPages = {
            {
                ignoreIfEmpty = false,
                obj = PagesContent.SongInfo,
                pageName = SongSelect.SongSelect_SongStatsHeader
            },
            {
                pageName = "Difficulty",
                ignoreIfEmpty = true,
                obj = PagesContent.SongDifficulty
            },
            {
                ignoreIfEmpty = true,
                obj = PagesContent.SongBest,
                pageName = SongSelect.SongSelect_HighscoreHeader
            }
        },
        back = Header2.Backy,
        next = Header2.Advancy,
        header = Header2,
        scroll = PagesContent
    };
    u162.statsPage = v206;
    table.insert(v204, v206);

    if not v158.blockModifiers and Modifiers then
        UpperPanel.SongMods.SongMods.Modifiers.Toggle.MouseButton1Click:Connect(function() -- Line: 1491
            -- upvalues: u162 (copy)
            u162:openModifiers();
        end);
        Modifiers.Content.ButtonContainers.IgnoreLayout.Close.MouseButton1Click:Connect(function() -- Line: 1495
            -- upvalues: u162 (copy)
            u162:closeModifiers();
        end);
        Modifiers.Content.ButtonContainers.Apply.MouseButton1Click:Connect(function() -- Line: 1499
            -- upvalues: u162 (copy)
            u162:closeModifiers();
        end);
        Modifiers.Content.ButtonContainers.Reset.MouseButton1Click:Connect(function() -- Line: 1503
            -- upvalues: u162 (copy), u160 (ref), Modifiers (copy)
            table.clear(u162.modifiers);

            for _, child in u160.ModifiersDisplay:GetChildren() do
                if child:IsA("Frame") then
                    child.Visible = false;
                end;
            end;

            for _, child in Modifiers.Content.ScrollingFrame:GetChildren() do
                if child:IsA("TextButton") then
                    child.IconContainer.EnabledStroke.Enabled = false;
                end;
            end;
        end);
        local Template2 = Modifiers.Content.ScrollingFrame.Template;
        Template2.Parent = nil;
        local ModifierTemplate = u160.ModifiersDisplay.ModifierTemplate;
        ModifierTemplate.Parent = nil;

        for _, child in GameplayModifiers:GetChildren() do
            if child:GetAttribute("CanBeUsed") and child:IsA("ModuleScript") then
                local u207 = Template2:Clone();
                local u208 = ModifierTemplate:Clone();
                local Name = child.Name;
                local v209 = child:GetAttribute("Name") or SongSelect.SongSelect_UnknownModifier;
                local v210 = parseContent(child:GetAttribute("Icon"));
                local v211 = child:GetAttribute("Description") or SongSelect.SongSelect_ModifierNoDesc;
                u207.Name = Name;
                u207.TextContainer.Header.Text = v209;
                u207.TextContainer.Desc.Text = v211;
                u207.IconContainer.Icon.ImageContent = v210;
                u207.IconContainer.EnabledStroke.Enabled = false;
                u207.SettingsButton.Visible = u207:FindFirstChild("Configs");
                u207.Parent = Modifiers.Content.ScrollingFrame;
                u208.Icon.ImageContent = v210;
                u208.Parent = u160.ModifiersDisplay;
                u207.MouseButton1Click:Connect(function() -- Line: 1550
                    -- upvalues: u162 (copy), Name (copy), u207 (copy), u208 (copy)
                    local table_find_ret = table.find(u162.modifiers, Name);
                    u207.IconContainer.EnabledStroke.Enabled = not table_find_ret;
                    u208.Visible = not table_find_ret;

                    if table_find_ret then
                        table.remove(u162.modifiers, table_find_ret);

                        return;
                    end;

                    table.insert(u162.modifiers, Name);
                    u208.LayoutOrder = #u162.modifiers;
                end);
            end;
        end;
    end;

    for _, v in v202 do
        local v212 = v.label or v.button and (v.button:FindFirstChild("Label") or v.button);
        v.label = v212;

        if v.label and v.button then
            local function updateLabelAndValue() -- Line: 1571
                -- upvalues: u162 (copy), v (copy), SongSelect (ref)
                local v213 = u162[v.property];

                if typeof(v213) ~= "boolean" or v213 == nil then
                    v213 = false;
                end;

                if v.isInverted then
                    v213 = not v213;
                end;

                if v.onChange then
                    v.onChange();
                end;

                v.label.Text = v213 and SongSelect.Toggles_On or SongSelect.Toggles_Off;
                v.label.TextColor3 = v213 and Color3.fromRGB(12, 255, 109) or Color3.fromRGB(255, 70, 70);
            end;

            updateLabelAndValue();
            v.button.MouseButton1Click:Connect(function() -- Line: 1586
                -- upvalues: u162 (copy), v (copy), updateLabelAndValue (copy)
                u162[v.property] = not u162[v.property];
                updateLabelAndValue();
            end);
        else
            Logger.warn("PROPERTY DOESNT HAVE AN ASSIGNED VALUE", v.property);
        end;
    end;

    for _, v in v203 do
        if v.textbox then
            v.max = v.max or 1;
            v.min = v.min or 0;
            v.round = v.round or 0;
            v.textbox.Text = u162[v.property];
            v.textbox.FocusLost:Connect(function() -- Line: 1603
                -- upvalues: v (copy), u162 (copy)
                local string_gsub_ret = string.gsub(v.textbox.Text, "[^%d.-]", "");
                local v214 = tonumber(string_gsub_ret) or u162[v.property];
                local v215 = round(v214, v.round);
                local math_clamp_ret = math.clamp(v215, v.min, v.max);
                u162[v.property] = math_clamp_ret;
                v.textbox.Text = math_clamp_ret;
            end);
        else
            Logger.warn("PROPERTY DOESNT HAVE AN ASSIGNED VALUE", v.property);
        end;
    end;

    for _, v in v204 do
        local u216 = {};
        local u217 = {};
        local u218 = {};

        local function updatePages() -- Line: 1618
            -- upvalues: u216 (copy), v (copy), u217 (copy), u218 (copy)
            table.clear(u216);

            for _, v2 in v.labelPages do
                if u217[v2.obj] then
                    v2.obj.Visible = false;
                else
                    v2.obj.Visible = true;
                    table.insert(u216, v2.obj);
                end;
            end;

            local CurrentPage = v.controller.CurrentPage;

            if CurrentPage and u217[CurrentPage] then
                v.controller:JumpTo(u216[1]);
            end;

            local CurrentPage2 = v.controller.CurrentPage;

            if not CurrentPage2 then
                return;
            end;

            v.header.Text = u218[CurrentPage2].pageName or "";
            v.back.Visible = CurrentPage2.LayoutOrder ~= 1;
            v.next.Visible = CurrentPage2.LayoutOrder ~= #u216;

            if v.scroll then
                v.scroll.CanvasSize = UDim2.fromOffset(0, CurrentPage2.AbsoluteSize.Y);
                game:GetService("TweenService"):Create(v.scroll, TweenInfo.new(0.25, Enum.EasingStyle.Exponential), {
                    CanvasPosition = Vector2.zero
                }):Play();
            end;
        end;

        v.next.MouseButton1Click:Connect(function() -- Line: 1647
            -- upvalues: v (copy), updatePages (copy)
            v.controller:Next();
            updatePages();
        end);
        v.back.MouseButton1Click:Connect(function() -- Line: 1652
            -- upvalues: v (copy), updatePages (copy)
            v.controller:Previous();
            updatePages();
        end);
        local u219 = v;
        local v220 = nil;

        for i, v2 in v.labelPages do
            u218[v2.obj] = v2;
            v2.obj.LayoutOrder = i;

            if v2.ignoreIfEmpty then
                v2.obj:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 1664
                    -- upvalues: u217 (copy), v2 (copy), updatePages (copy)
                    u217[v2.obj] = v2.obj.Text == "" and true or nil;
                    updatePages();
                end);
                u217[v2.obj] = v2.obj.Text == "" and true or nil;

                if not u217[v2.obj] then
                    v220 = v220 or v2.obj;
                end;
            else
                v220 = v220 or v2.obj;
            end;
        end;

        if v220 then
            u219.controller:JumpTo(v220);
        end;

        updatePages();

        function u219.jumpTo(p221) -- Line: 1682
            -- upvalues: u219 (copy), u217 (copy), updatePages (copy)
            if p221 == u219.controller.CurrentPage then
                return;
            end;

            if u217[p221] then
                return updatePages();
            end;

            u219.controller:JumpTo(p221);
            updatePages();
        end;

        u219.updatePages = updatePages;
    end;

    u160.CheckOutPanel.Play.MouseButton1Click:Connect(function() -- Line: 1696
        -- upvalues: u162 (copy), TeleportAd (ref)
        if u162.curGame then
            TeleportAd:FireServer(u162.curGame);
        end;
    end);
    u160.StatsPanel.Play.MouseButton1Click:Connect(function() -- Line: 1703
        -- upvalues: u162 (copy)
        if not (u162.voteData and u162.voteData.diff) then
            return;
        end;

        u162.play:Fire(u162.voteData.mod.name, u162.voteData.song.name, u162.voteData.diff.name);
        u162:deselectSong();
    end);
    u160.StatsPanel.Skip.MouseButton1Click:Connect(function() -- Line: 1711
        -- upvalues: u162 (copy)
        u162.play:Fire("", "", "");
        u162:deselectSong();
    end);
    u160.StatsPanel.Play.Visible = false;
    local SongInfo = UpperPanel.SongInfo;
    SongInfo.ListSkip.SelectWarning.Visible = true;
    SongInfo.SelectedSong.Visible = false;
    SongInfo.Credits.Visible = false;
    SongInfo.SongStats.Visible = false;
    SongInfo.Difficulties.Visible = false;

    if Modifiers then
        Modifiers.Position = UDim2.fromScale(1, 0);
    end;

    return u162;
end;

function u1.renderMods(p222) -- Line: 1733
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), SongSelect (copy)
    local Text = p222.ui.UpperPanel.Mods.ModSearch.TextBox.Text;
    local v223 = Text == nil and "" or Text;
    local v224 = getCasesFromSearch(v223);
    local v225 = p222.unavailableSongList or {};
    local v226 = 0;
    local v227 = {};

    for _, v in ipairs(p222.categories) do
        local v228 = not table.find(v225, v.name .. "/*");
        local v229;

        if v228 and not v.alwaysVisible then
            v229 = v;

            for _, v2 in v224 do
                if not v228 then
                    break;
                end;

                v228 = v2[1](v229, v2[2], v2[3], v228, p222);
            end;
        elseif v.alwaysVisible then
            v226 = v226 + 1;
            v229 = v;
        else
            v229 = v;
        end;

        if v228 then
            table.insert(v227, {
                type = "Mod",
                item = v229
            });
        end;
    end;

    local v230 = #v227 - v226;
    TweenService:Create(p222.ui.UpperPanel.Mods.SearchResults, TweenInfo_new_ret, {
        AnchorPoint = Vector2.new(0.5, v223 == "" and 0 or 1)
    }):Play();

    if v223 ~= "" then
        p222.ui.UpperPanel.Mods.SearchResults.Label.Text = v230 == 0 and SongSelect.SongSelect.NoResultsFound or SongSelect.RawFormat("SongSelect.XResultsFound", {
            resultAmmo = v230
        });
    end;

    p222.modScroll:setItems(v227);
end;

function u1.renderSongs(p231) -- Line: 1777
    -- upvalues: Data (ref), TweenService (copy), TweenInfo_new_ret (copy), SongSelect (copy)
    if not p231.curCat then
        return;
    end;

    local Text = p231.ui.UpperPanel.Songs.SongSearch.TextBox.Text;
    local v232 = Text == nil and "" or Text;
    local v233 = getCasesFromSearch(v232);
    local curCat = p231.curCat;
    local v234 = {};
    local v235 = Data.SortByWeek and curCat.displayWeeks;
    local v236 = 0;
    local v237 = nil;
    local v238 = nil;

    for _, v in ipairs(curCat.loadAllSongs and p231.songs or curCat.songs) do
        local v239 = not v.isUnavailable;

        if v.fullyCopyrighted and not p231.showCopyright then
            v239 = false;
        end;

        local v240;

        if v239 then
            v240 = v;

            for _, v2 in v233 do
                if not v239 then
                    break;
                end;

                v239 = v2[1](v240, v2[2], v2[3], v239, p231);
            end;
        else
            v240 = v;
        end;

        if v235 and v240.week ~= v238 then
            v238 = v240.week;
            v237 = v240.week;
        end;

        if v239 then
            if v235 and v237 ~= nil then
                table.insert(v234, {
                    type = "Week",
                    item = v237
                });
                v236 = v236 + 1;
                v237 = nil;
            end;

            table.insert(v234, {
                item = v240,
                type = v235 and "Song" or "SongWithWeek"
            });
        end;
    end;

    if curCat.alphabeticalSort or not Data.SortByWeek then
        table.sort(v234, function(p241, p242) -- Line: 1829
            return p241.item.name:lower() < p242.item.name:lower();
        end);
    end;

    TweenService:Create(p231.ui.UpperPanel.Songs.SearchResults, TweenInfo_new_ret, {
        AnchorPoint = Vector2.new(0.5, v232 == "" and 0 or 1)
    }):Play();

    if v232 ~= "" then
        local v243 = #v234 - v236;
        p231.ui.UpperPanel.Songs.SearchResults.Label.Text = v243 == 0 and SongSelect.SongSelect.NoResultsFound or SongSelect.RawFormat("SongSelect.XResultsFound", {
            resultAmmo = v243
        });
    end;

    curCat.renderedWithWeeks = v235;
    p231.songScroll:setItems(v234);
end;

function u1.renderDiffs(p244) -- Line: 1846
    -- upvalues: Logger (copy)
    if not p244.curSong then
        p244.difficultyItems = {};
        p244.diffScroll:setItems({});

        return;
    end;

    local v245 = {};
    local v246 = {};

    for i, v in p244.curSong.diffs do
        if not (v.HideMultiplayer and not p244.isSingleplayer or (v.HideSingleplayer and p244.isSingleplayer or v.HasCopyright and not p244.showCopyright)) then
            local v247 = p244.difficulties[i];

            if v247 then
                local v248 = {
                    item = v247,
                    type = i
                };
                v245[i] = v248;
                table.insert(v246, v248);
            else
                Logger.warn("Difficulty", i, "isn\'t defined!");
            end;
        end;
    end;

    table.sort(v246, function(p249, p250) -- Line: 1873
        return (p249.item.order or (1 / 0)) < (p250.item.order or (1 / 0));
    end);
    p244.difficultyItems = v245;
    p244.diffScroll:setItems(v246);
end;

function u1.renderPlayers(p251) -- Line: 1881
    -- upvalues: LocalPlayer (copy), Players (copy), SongSelect (copy)
    local v252 = p251.renderedPlayers or {};

    for _, v in v252 do
        pcall(function() -- Line: 1885
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    table.clear(v252);
    local ScrollingFrame = p251.ui.UpperPanel.SongMods.SongVotes.ScrollingFrame;
    local Template = ScrollingFrame.Template;
    Template.Visible = false;
    local v253 = p251.players[p251.curSide] or {};
    local v254 = p251.players[p251.curSide == "R" and "L" or "R"] or {};

    if #v253 > 1 then
        ScrollingFrame.YourTeam.Visible = true;
        ScrollingFrame.YourSeparator.Visible = true;

        for i, v in v253 do
            if v ~= LocalPlayer then
                local u255 = Template:Clone();
                u255.Visible = true;
                u255.LayoutOrder = i + 1;
                u255.StrokeThingy.Username.Text = v.DisplayName;
                u255.StrokeThingy.Vote.Text = "None\n";
                task.spawn(function() -- Line: 1909
                    -- upvalues: Players (ref), v (copy), u255 (copy)
                    pcall(function() -- Line: 1910
                        -- upvalues: Players (ref), v (ref), u255 (ref)
                        local UserThumbnailAsync = Players:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180);
                        u255.StrokeThingy.UserPFP.ImageContent = Content.fromUri(UserThumbnailAsync);
                    end);
                end);
                u255.Parent = ScrollingFrame;
                v252[v.Name] = u255;
            end;
        end;
    else
        ScrollingFrame.YourTeam.Visible = false;
        ScrollingFrame.YourSeparator.Visible = false;
    end;

    if #v254 > 0 then
        ScrollingFrame.Opponent.Visible = true;
        ScrollingFrame.OppoSeparator.Visible = true;

        for i, v in v254 do
            local u256 = Template:Clone();
            u256.Visible = true;
            u256.LayoutOrder = i + 101;
            u256.StrokeThingy.Username.Text = v.DisplayName;
            u256.StrokeThingy.Vote.Text = SongSelect.RawGet("SongSelect.OtherVotesNone") .. "\n";
            task.spawn(function() -- Line: 1935
                -- upvalues: Players (ref), v (copy), u256 (copy)
                pcall(function() -- Line: 1936
                    -- upvalues: Players (ref), v (ref), u256 (ref)
                    local UserThumbnailAsync = Players:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180);
                    u256.StrokeThingy.UserPFP.ImageContent = Content.fromUri(UserThumbnailAsync);
                end);
            end);
            u256.Parent = ScrollingFrame;
            v252[v.Name] = u256;
        end;
    else
        ScrollingFrame.Opponent.Visible = false;
        ScrollingFrame.OppoSeparator.Visible = false;
    end;

    p251.renderedPlayers = v252;
end;

function u1.allowRender(p257) -- Line: 1953
    p257.isInitialized = true;
    p257:renderMods();
    p257:goTo(p257.favoritesCat and next(p257.favoritesCat.songs) and (p257.generalOffset or 1) or 1);
end;

function u1.selectCategory(p258: table, p259: table) -- Line: 1962
    if p258.curCat == p259 or not p259 then
        return;
    end;

    p258.curCat = p259;
    task.spawn(p258.setGame, p258, p259.gameId);
    p258.songScroll.linkedScroll.CanvasPosition = Vector2.zero;
    p258:renderSongs();
end;

function u1.selectSong(p260: table, p261: table) -- Line: 1972
    -- upvalues: SongSelect (copy)
    local SongInfo = p260.ui.UpperPanel.SongInfo;

    if p260.creditsPage then
        p260.creditsPage.jumpTo(SongInfo.Credits.ScrollingFrame.ModCredits);
    end;

    if p260.curSong == p261 then
        return;
    end;

    p260.curSong = p261;
    SongInfo.ListSkip.SelectWarning.Visible = false;
    p260.ui.StatsPanel.Play.Visible = true;
    SongInfo.SelectedSong.Visible = true;
    SongInfo.SelectedSong.DataContainer.SongName.Text = p261.name;
    SongInfo.SelectedSong.DataContainer.ModName.Text = p261.category.displayName;
    SongInfo.SelectedSong.WeekName.Text = p261.week and (p261.week.name or "") or "";
    SongInfo.SelectedSong.Icon.ImageContent = p261.icon;
    SongInfo.SelectedSong.SongTweaks.NoWins.Visible = not p261.canWin;
    SongInfo.Credits.Visible = true;
    SongInfo.Credits.ScrollingFrame.ModCredits.Text = SongSelect.RawFormat("SongSelect.CreditsBy", {
        creatorName = p261.credits
    });
    SongInfo.Credits.ScrollingFrame.AFNCredits.Text = translateCredits(p261.extraCredits or "");
    SongInfo.SongStats.Visible = true;
    SongInfo.SongStats.PagesContent.SongInfo.Text = `{SongSelect.Get("SongSelect.SongStatsNoSelect")}\n\n\n\n\n\n`;
    SongInfo.SongStats.PagesContent.SongBest.Text = `{SongSelect.Get("SongSelect.SongStatsNoSelect")}\n\n\n`;
    SongInfo.SongStats.PagesContent.SongBest.Text = "?\n\n\n\n\n\n\n\n\n\n\n";
    p260:selectDiff(nil);
    SongInfo.Difficulties.Visible = true;
    p260.diffScroll:setVisible(true);
    p260:renderDiffs();
end;

function u1.deselectSong(p262) -- Line: 2015
    if not p262.curSong then
        return;
    end;

    p262.curSong = nil;
    local SongInfo = p262.ui.UpperPanel.SongInfo;
    SongInfo.ListSkip.SelectWarning.Visible = true;
    SongInfo.SelectedSong.Visible = false;
    SongInfo.Credits.Visible = false;
    SongInfo.SongStats.Visible = false;
    SongInfo.Difficulties.Visible = false;
    p262.diffScroll:setVisible(false);
    p262.ui.StatsPanel.Play.Visible = false;
    p262.voteData = {};
end;

function setPreviewRate(p263, p264)
    -- upvalues: u31 (copy)
    u31:setSpeed(p264);
end;

function previewSong(p265: any, p266: table, p267: table)
    -- upvalues: setSongPreview (copy)
    local category = p266.category;
    setSongPreview((category.dataPath and (category.dataPath.Songs[p266.name .. "-" .. p267.name] or (category.dataPath.Songs[p266.name] or category.dataPath)) or p266.dataPath).Audio);
end;

function u1.selectDiff(u268: table, u269: table) -- Line: 2043
    -- upvalues: Data (ref), u35 (ref), TweenService (copy), UIMusic (copy), TweenInfo_new_ret2 (copy), u22 (copy), SongSelect (copy), u31 (copy), u7 (copy), SongStats (ref)
    local curDiff = u268.curDiff;
    local curSong = u268.curSong;

    if not curSong then
        return;
    end;

    if not u269 then
        u268.voteData = {};

        return;
    end;

    local u270 = curSong.diffs[u269.name];

    if not u270 then
        return;
    end;

    u268.curDiff = u269;
    local v271 = {
        mod = u268.voteData.mod,
        song = u268.voteData.song,
        diff = u268.voteData.diff
    };
    u268.voteData = {
        mod = curSong.category,
        song = curSong,
        diff = u270
    };

    if u268.voteData.mod == v271.mod and u268.voteData.song == v271.song and u268.voteData.diff == v271.diff then
        return;
    end;

    if Data.SongSelectPreviewMusic then
        previewSong(u268, curSong, u270);

        if u35 then
            task.cancel(u35);
            u35 = nil;
        end;

        TweenService:Create(UIMusic, TweenInfo_new_ret2, {
            Volume = not Data.SongSelectMusic and 0 or 0
        }):Play();
    end;

    u268.picked:Fire(curSong.category.name, curSong.name, u269.name);

    if curDiff and curDiff.obj then
        curDiff.obj.ColorBG.Enabled = false;
        curDiff.obj.BaseGradient.Enabled = true;
        curDiff.obj.BackgroundTransparency = u22.defTransDiff;
    end;

    if u269.obj then
        u269.obj.ColorBG.Enabled = true;
        u269.obj.BaseGradient.Enabled = false;
        u269.obj.BackgroundTransparency = 0;
    end;

    local SongInfo = u268.ui.UpperPanel.SongInfo;
    SongInfo.SelectedSong.Icon.ImageContent = u270.icon or curSong.icon;

    local function updateSongInfoData() -- Line: 2099
        -- upvalues: SongInfo (copy), SongSelect (ref), u270 (copy), u268 (copy), u31 (ref)
        local SongInfo2 = SongInfo.SongStats.PagesContent.SongInfo;
        local table_concat = table.concat;
        local v272 = {};
        local v273 = "· " .. SongSelect.Format("SongSelect.SongInfo.BPM", {
            bpm = tostring(u270.BPM or "?")
        });
        local v274 = SongSelect.Format("SongSelect.SongInfo.Keycount", {
            keycount = tostring(u270.Keycount or "4")
        });
        local v275 = SongSelect.Format("SongSelect.SongInfo.Difficulty", {
            rating = u270.Rating and u270.Rating[u268.curSide] or "N/A"
        });
        local Format = SongSelect.Format;
        local v276 = {};
        local v277, v278, v279, v280, v281;

        if u31.timeLength <= 0 and u270.AudioLength then
            local v282 = math.round(u270.AudioLength) or "-:--";
            local v283 = v282 % 60;
            local v284 = (v282 - v283) / 60;

            if v283 < 10 then
                v283 = "0" .. v283 or v283;
            end;

            v277 = v284 .. ":" .. v283;

            if not v277 then
                v278 = math.round(u31.timeLength);
                v279 = v278 % 60;
                v280 = (v278 - v279) / 60;
                v281 = ":";

                if v279 < 10 then
                    v279 = "0" .. v279 or v279;
                end;

                v277 = v280 .. v281 .. v279;
            end;
        else
            v278 = math.round(u31.timeLength);
            v279 = v278 % 60;
            v280 = (v278 - v279) / 60;
            v281 = ":";

            if v279 < 10 then
                v279 = "0" .. v279 or v279;
            end;

            v277 = v280 .. v281 .. v279;
        end;

        v276.timeLength = v277;
        v272[1], v272[2], v272[3], v272[4], v272[5], v272[6], v272[7], v272[8] = v273, v274, v275, Format("SongSelect.SongInfo.Length", v276), SongSelect.Format("SongSelect.SongInfo.Events", {
    hasEvents = u270.HasEvents and "✅" or "❌"
}), SongSelect.Format("SongSelect.SongInfo.Gimmicks", {
    hasGimmicks = u270.HasGimmicks and "✅" or "❌"
}), SongSelect.Format("SongSelect.SongInfo.Modchart", {
    hasModchart = u270.HasModchart and "✅" or "❌"
}), SongSelect.Format("SongSelect.SongInfo.Map", {
    hasMap = u270.HasMap and "✅" or "❌"
});
        SongInfo2.Text = table_concat(v272, "\n· ");
    end;

    updateSongInfoData();
    (function() -- Line: 2115, Name: updateSongDifficultyData
        -- upvalues: u270 (copy), u268 (copy), SongInfo (copy), u7 (ref)
        local v285 = u270.Skillsets and u270.Skillsets[u268.curSide] or {};

        if not next(v285) then
            SongInfo.SongStats.PagesContent.SongDifficulty.Text = "Stream: 0\nJumpstream: 0\nHandstream: 0\nStamina: 0 \nJack: 0\nChordjack: 0\nTechnical: 0\nLN Coordination: 0\nLN Density: 0\nLN Release: 0\nLN Anchor: 0";

            return;
        end;

        local v286 = {};

        for _, v in ipairs(u7) do
            table.insert(v286, ("· %s: %.2f"):format(v, v285[v] or 0));
        end;

        SongInfo.SongStats.PagesContent.SongDifficulty.Text = table.concat(v286, "\n");
    end)();

    if u31.timeLength <= 0 then
        u31.timeLengthChanged:Once(function() -- Line: 2135
            -- upvalues: u269 (copy), u268 (copy), updateSongInfoData (copy)
            if u269 ~= u268.curDiff then
                return;
            end;

            updateSongInfoData();
        end);
    end;

    SongInfo.Credits.ScrollingFrame.ModCredits.Text = SongSelect.RawFormat("SongSelect.CreditsBy", {
        creatorName = u270.credits or ""
    });
    SongInfo.Credits.ScrollingFrame.AFNCredits.Text = translateCredits(u270.extraCredits or "");

    if u270.extraCredits and u268.creditsPage then
        u268.creditsPage.jumpTo(SongInfo.Credits.ScrollingFrame.AFNCredits);
    end;

    local v287 = SongStats[curSong.category.name] and SongStats[curSong.category.name][curSong.name];
    local v288 = v287 and next(v287) and true or false;

    if v287 then
        v287 = v287[u269.name];
    end;

    if v287 then
        SongInfo.SongStats.PagesContent.SongBest.Text = table.concat({
            `[{SongSelect["Judgements_" .. (v287.FCData or "CLEAR")]}]`,
            SongSelect.Format("SongSelect.HighscoreScore", {
                score = v287.Score
            }),
            SongSelect.Format("SongSelect.HighscoreAccuracy", {
                acc = v287.Accuracy
            }),
            SongSelect.Format("SongSelect.HighscoreMisses", {
                misses = v287.Misses
            })
        }, "\n· ");

        return;
    end;

    if v288 or not table.find(Data.UniqueFCData, curSong.category.name .. "/" .. curSong.name) then
        SongInfo.SongStats.PagesContent.SongBest.Text = `[{SongSelect.SongSelect_HighscoreNotPlayed}]\n\n\n`;

        return;
    end;

    SongInfo.SongStats.PagesContent.SongBest.Text = table.concat({ `[{SongSelect.Judgements_FC}]`, SongSelect.SongSelect_OldHighscoreStat }, "\n");
end;

function u1.addSong(p289: table, p290: table, p291: table) -- Line: 2173
    -- upvalues: u2 (copy), Logger (copy)
    p290.category = p291;
    p290.icon = parseContent(p290.icon or p291.icon);
    p290.credits = p290.credits or p291.credits;
    p290.color = p290.color or p291.color;
    p290.isSong = true;
    p290.diffs = p290.diffs or {};

    if u2 and not (next(p290.diffs) or string.find(p290.category.prefix, "INDEV")) then
        Logger.warn((`{p290.name} does not have ANY difficulties!!! SAVAGE TIGERSLAYER'S PERFECTED FLURRY OF BLADES [????????]`));
    end;

    p290.dataPath = p290.dataPath or p291.dataPath and p291.dataPath.Songs[p290.name];
    local v292 = false;
    local v293 = true;

    for _, v in p290.diffs do
        if p290.dataPath then
            v.dataPath = v.dataPath or (p291.dataPath and p291.dataPath.Songs[p290.name .. "-" .. v.name] or p290.dataPath);
        end;

        v292 = v292 or v.HasCopyright;

        if not v.HasCopyright then
            v293 = false;
        end;

        v.HasMap = (p291.metadata and p291.metadata.Background or v.dataPath and v.dataPath.Background) and true or false;
        v.icon = parseContent(v.icon or p290.icon);
    end;

    if p290.dataPath and p290.dataPath.CanWin ~= nil then
        p290.canWin = p290.dataPath.CanWin;
    else
        p290.canWin = true;
    end;

    p290.canBeCopyrighted = v292;
    p290.fullyCopyrighted = v292 and v293 and v293 or false;
    table.insert(p289.songs, p290);
end;

function u1.addCategory(p294: table, p295: table) -- Line: 2216
    -- upvalues: SongSelect (copy), Songs (copy)
    local v296 = (p294.isFolder and #p294.folders or #p294.mods) + 1;
    p295.displayName = p295.displayName or p295.name;
    p295.weeks = p295.weeks or {};
    p295.songs = p295.songs or {};
    p295.icon = parseContent(p295.icon);
    p295.showFCIcon = p295.showFCIcon == nil and true or p295.showFCIcon;
    p295.credits = p295.credits or SongSelect.SongSelect_CreditsFallback;
    p295.color = parseColorSequence(p295.color) or ColorSequence.new(Color3.new(1, 1, 1));
    p295.displayWeeks = p295.displayWeeks == nil and true or (p295.displayWeeks or false);
    p295.dataPath = p295.dataPath or Songs[p295.name];
    p295.metadata = p295.metadata or p295.dataPath and p295.dataPath.Metadata;

    for _, v in p295.songs do
        p294:addSong(v, p295);
    end;

    table.insert(p294.categories, v296, p295);
    table.insert(p294.isFolder and p294.folders or p294.mods, p295);

    if p294.isInitialized then
        p294:renderMods();
    end;

    return p295;
end;

function u1._onDiffLoaded(u297: table, u298: table, u299: userdata, p300: table) -- Line: 2244
    -- upvalues: u22 (copy), SoundLib (copy), Difficulties (copy)
    u298.obj = u299;
    u299.Name = u298.name;
    u299.ColorBG.Color = u298.color;
    u299.Border.UIStroke.UIGradient.Color = u298.color;
    u299.Border.Difficulty.Text = u298.name;
    local v301;

    if u297.voteData.song == u297.curSong then
        v301 = u297.curDiff and u297.curDiff.name == u298.name;
    else
        v301 = false;
    end;

    u299.BackgroundTransparency = v301 and 0 or u22.defTransDiff;
    u299.ColorBG.Enabled = v301;
    u299.BaseGradient.Enabled = not v301;
    p300.clickedConnection = u299.MouseButton1Click:Connect(function() -- Line: 2257
        -- upvalues: u297 (copy), u298 (copy)
        u297:selectDiff(u298);
    end);
    SoundLib:Attach(u299, {
        MouseButton1Click = "Selected",
        MouseLeave = "",
        MouseEnter = { "SongSelect/Hover1", "SongSelect/Hover2", "SongSelect/Hover3", "SongSelect/Hover4", "SongSelect/Hover5" }
    });
    local u302 = Difficulties.Effects[u298.name];

    if u302 then
        p300.effectThread = task.spawn(function() -- Line: 2270
            -- upvalues: u299 (copy), u302 (copy)
            while task.wait(1) do
                u299.Border.Difficulty.Text = u302[math.random(1, #u302)];
            end;
        end);
    end;
end;

function u1._onDiffUnloaded(p303: table, p304: table, p305: userdata, p306: table) -- Line: 2278
    if p306.clickedConnection then
        p306.clickedConnection:Disconnect();
        p306.clickedConnection = nil;
    end;

    if p306.effectThread then
        task.cancel(p306.effectThread);
        p306.effectThread = nil;
    end;

    if p304.obj == p305 then
        p304.obj = nil;
    end;
end;

function u1.addDifficulty(u307: table, p308: table) -- Line: 2285
    p308.color = parseColorSequence(p308.color) or ColorSequence.new(Color3.new(1, 1, 1));
    p308.scale = p308.scale or Vector2.one;
    u307.difficulties[p308.name] = p308;
    u307.pendingDiffTypes = u307.pendingDiffTypes or {};
    u307.pendingDiffTypes[p308.name] = true;

    if not u307._diffFlushScheduled then
        u307._diffFlushScheduled = true;
        task.defer(function() -- Line: 2296
            -- upvalues: u307 (copy)
            u307._diffFlushScheduled = false;
            u307:_flushDifficultyTypes();
        end);
    end;
end;

function u1._flushDifficultyTypes(u309) -- Line: 2303
    -- upvalues: u22 (copy)
    local pendingDiffTypes = u309.pendingDiffTypes;

    if not (pendingDiffTypes and next(pendingDiffTypes)) then
        return;
    end;

    u309.pendingDiffTypes = {};
    local types = u309.diffScroll.types;

    for i in pendingDiffTypes do
        local v310 = u309.difficulties[i];

        if v310 then
            types[i] = {
                OnLoaded = function(p311, p312, p313) -- Line: 2315, Name: OnLoaded
                    -- upvalues: u309 (copy)
                    u309:_onDiffLoaded(p311, p312, p313);
                end,

                OnUnloaded = function(p314, p315, p316) -- Line: 2318, Name: OnUnloaded
                    -- upvalues: u309 (copy)
                    u309:_onDiffUnloaded(p314, p315, p316);
                end,

                Template = u309.diffTemplate,
                Size = UDim2.new(0.92 * v310.scale.X, 0, 0, u22.baseDiffSize * v310.scale.Y * u309.scalingSizeMult)
            };
        end;
    end;

    u309.diffScroll:setTypes(types);

    if u309.curSong then
        u309:renderDiffs();
    end;
end;

function u1.setGame(p317: table, u318: number) -- Line: 2331
    -- upvalues: u24 (copy), MarketplaceService (copy), SongSelect (copy)
    if p317.curGame == u318 then
        return;
    end;

    p317.curGame = u318;
    p317.ui.CheckOutPanel.Visible = u318 and true or false;

    if u318 then
        p317.ui.CheckOutPanel.Background.ImageContent = Content.fromUri((`https://www.roblox.com/asset-thumbnail/image?assetId={u318}&width=1280&height=720&format=png`));
        local u319 = u24[u318];

        if not u319 then
            pcall(function() -- Line: 2342
                -- upvalues: u319 (ref), MarketplaceService (ref), u318 (copy)
                u319 = MarketplaceService:GetProductInfo(u318);
            end);
            u24[u318] = u319;

            if p317.curGame ~= u318 then
                return;
            end;

            if not u319 then
                p317.ui.CheckOutPanel.GameData.Creator.Text = SongSelect.SongSelect_FailedCreator;
                p317.ui.CheckOutPanel.GameData.Title.Text = SongSelect.SongSelect_FailedName;

                return;
            end;
        end;

        p317.ui.CheckOutPanel.GameData.Creator.Text = SongSelect.RawFormat("SongSelect.MadeBy", {
            creatorName = u319.Creator.Name
        });
        p317.ui.CheckOutPanel.GameData.Title.Text = u319.Name;
    end;
end;

function u1.goTo(p320, p321) -- Line: 2359
    if type(p321) == "number" then
        p321 = p320.categories[p321] or p321;
    end;

    p320:selectCategory(p321);
end;

function u1.setFavorites(p322: table, p323: table) -- Line: 2363
    if not p322.favoritesCat then
        return;
    end;

    local v324 = {};

    for _, v in p322.songs do
        local table_find_ret = table.find(p323, v.category.name .. "/" .. v.name);

        if v.favorited then
            if table_find_ret then
                table.insert(v324, v);
            else
                v.favorited = false;
            end;
        elseif table_find_ret then
            v.favorited = true;
            table.insert(v324, v);
        end;
    end;

    p322.favoritesCat.songs = v324;

    if p322.curCat == p322.favoritesCat then
        p322:renderSongs();
    end;
end;

function u1.setRecents(p325: table, p326: table) -- Line: 2388
    if not p325.recentCat then
        return;
    end;

    local v327 = {};

    for _, v in p326 do
        local string_find_ret = string.find(v, "/");

        if string_find_ret then
            local string_sub_ret = string.sub(v, 1, string_find_ret - 1);
            local string_sub_ret2 = string.sub(v, string_find_ret + 1);

            for _, v2 in p325.songs do
                if v2.category.name == string_sub_ret and v2.name == string_sub_ret2 then
                    table.insert(v327, v2);
                    break;
                end;
            end;

            if #v327 >= 25 then
                break;
            end;
        end;
    end;

    p325.recentCat.songs = v327;

    if p325.curCat == p325.recentCat then
        p325:renderSongs();
    end;
end;

function u1.addRecent(p328: table, p329: string, p330: string) -- Line: 2416
    if not p328.recentCat then
        return;
    end;

    local v331 = nil;

    for _, v in p328.songs do
        if v.category.name == p329 and v.name == p330 then
            v331 = v;
            break;
        end;
    end;

    if not v331 then
        return;
    end;

    local table_find_ret = table.find(p328.recentCat.songs, v331);

    if table_find_ret then
        table.remove(p328.recentCat.songs, table_find_ret);
    end;

    table.insert(p328.recentCat.songs, 1, v331);

    if #p328.recentCat.songs > 25 then
        table.remove(p328.recentCat.songs, #p328.recentCat.songs);
    end;

    if p328.curCat == p328.recentCat then
        p328:renderSongs();
    end;
end;

function u1.setUnavailableSongs(p332: table, p333: table) -- Line: 2442
    p332.unavailableSongList = p333;
    local u334 = false;
    local curCat = p332.curCat;

    local function markAsChanged(p335) -- Line: 2448
        -- upvalues: curCat (copy), u334 (ref)
        if not curCat then
            return;
        end;

        if p335.category == curCat then
            u334 = true;

            return;
        end;

        if table.find(curCat.songs, p335) then
            u334 = true;
        end;
    end;

    local v336 = false;

    for _, v in p332.songs do
        local v337 = table.find(p333, v.category.name .. "/" .. v.name) or table.find(p333, v.category.name .. "/*");

        if v.isUnavailable then
            if not v337 then
                v.isUnavailable = false;

                if curCat then
                    if v.category == curCat then
                        u334 = true;
                    elseif table.find(curCat.songs, v) then
                        u334 = true;
                    end;
                end;
            end;
        elseif v337 then
            v.isUnavailable = true;

            if curCat then
                if v.category == curCat then
                    u334 = true;
                elseif table.find(curCat.songs, v) then
                    u334 = true;
                end;
            end;
        end;
    end;

    for _, v in p332.categories do
        if table.find(p333, v.name .. "/*") then
            v336 = true;
            break;
        end;
    end;

    if v336 then
        p332:renderMods();
    end;

    if u334 then
        p332:renderSongs();
    end;
end;

function u1.setTimeLeft(u338, p339) -- Line: 2492
    -- upvalues: SongSelect (copy)
    u338.ui.SelectionPanel.VotingCountdown.Text = SongSelect.RawFormat("SongSelect.TimeLeft", {
        timeLeft = p339
    });
    u338.timerId = u338.timerId + 1;

    if p339 == 0 then
        return;
    end;

    local u340 = tick() + p339;
    local timerId = u338.timerId;
    task.spawn(function() -- Line: 2501
        -- upvalues: timerId (copy), u338 (copy), u340 (copy), SongSelect (ref)
        while task.wait(0.9) and (timerId == u338.timerId and u340 - tick() > 0) do
            local VotingCountdown = u338.ui.SelectionPanel.VotingCountdown;
            local RawFormat = SongSelect.RawFormat;
            local v341 = {};
            local v342 = u340 - tick();
            local math_floor_ret = math.floor(v342);
            v341.timeLeft = math.max(math_floor_ret, 0);
            VotingCountdown.Text = RawFormat("SongSelect.TimeLeft", v341);
        end;
    end);
end;

function u1.setVote(p343, p344, p345) -- Line: 2508
    -- upvalues: SongSelect (copy)
    if not p343.renderedPlayers then
        return;
    end;

    local v346 = p343.renderedPlayers[p344 and p344.Name or ""];

    if not v346 then
        return;
    end;

    local v347 = `{p345.Mod} - {p345.Song} [{SongSelect.GetOr(p345.Diff and ("Difficulties_" .. p345.Diff or "") or "", p345.Diff)}] {p345.Rate == 1 and "" or (`[{p345.Rate .. "x"}]` or "")}`;

    if p345.Mod == "" then
        v347 = SongSelect.SongSelect_VoteSkipped .. "\n";
    end;

    v346.StrokeThingy.UserPFP.UIStroke.Color = p345.isFinal and Color3.fromRGB(0, 255, 4) or Color3.fromRGB(255, 0, 4);
    v346.StrokeThingy.Vote.Text = v347;
end;

function u1.openModifiers(p348) -- Line: 2521
    -- upvalues: TweenService (copy)
    TweenService:Create(p348.modifiersUi, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0)
    }):Play();
end;

function u1.closeModifiers(p349) -- Line: 2525
    -- upvalues: TweenService (copy)
    TweenService:Create(p349.modifiersUi, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(1, 0)
    }):Play();
end;

function u1.updateSongFlags(p350: table, p351: table) -- Line: 2529
    for i, v in p351 do
        p350[i] = v;
    end;

    p350.ui.UpperPanel.SongMods.SongMods.Judgement.SoloOnly.Visible = not p350.isSingleplayer;
    local curSong = p350.curSong;
    p350:renderMods();
    p350:renderSongs();
    p350:renderPlayers();
    p350:selectDiff(nil);
    p350.voteData = {};

    if curSong then
        if curSong.fullyCopyrighted and not p350.showCopyright then
            p350:deselectSong();
        end;
    end;
end;

function u1.copyContentFrom(p352, p353) -- Line: 2551
    if not p353 then
        return;
    end;

    for _, v in { "mods", "songs", "folders", "categories" } do
        p352[v] = p353[v];
    end;

    for _, v in p353.difficulties do
        local table_clone_ret = table.clone(v);
        table_clone_ret.obj = nil;
        p352:addDifficulty(table_clone_ret);
    end;
end;

function u1.show(u354) -- Line: 2569
    -- upvalues: u21 (copy), u3 (copy), Data (ref), SongStats (ref), DataManager (copy), SongSelect (copy), UIMusic (copy), u20 (copy), u33 (ref), TweenService (copy), SongPreview (copy), TweenInfo_new_ret2 (copy), u32 (ref), u31 (copy), setMusicVolume (copy), RunService (copy), UserInputService (copy), GuiService2 (copy), u4 (copy)
    local v355 = next(u21) and true or false;
    u21[u354] = true;
    u354.Visualizer:setSettings(u3);
    u354:setTimeLeft(0);
    local Data2 = DataManager:GetData();
    local SongStats2 = DataManager:GetSongStats();
    Data = Data2;
    SongStats = SongStats2;
    u354:renderMods();
    local Stats = u354.ui.StatsPanel.Stats;
    Stats.FC.Text = SongSelect.RawFormat("SongSelect.Stats.FCs", {
        count = Data.Stats.FCs + Data.Stats.GFCs,
        uniqueCount = #Data.UniqueFCData
    });
    Stats.PFC.Text = SongSelect.RawFormat("SongSelect.Stats.PFCs", {
        count = Data.Stats.PFCs
    });
    Stats.MFC.Text = SongSelect.RawFormat("SongSelect.Stats.MFCs", {
        count = Data.Stats.MFCs
    });
    Stats.Wins.Text = SongSelect.RawFormat("SongSelect.Stats.Wins", {
        count = Data.Stats.Wins
    });
    Stats.Losses.Text = SongSelect.RawFormat("SongSelect.Stats.Losses", {
        count = Data.Stats.Losses
    });
    Stats.TotalPlayed.Text = SongSelect.RawFormat("SongSelect.Stats.TotalPlayed", {
        count = Data.Stats.SongsPlayed
    });
    u354.gui.Visible = true;
    u354.upscaleAmmo = Data.SongSelectUpscale;
    u354.updateLayoutSize(true);
    u354.songScroll:setVisible(true);
    u354.modScroll:setVisible(true);

    if not v355 then
        UIMusic.AudioContent = u20[math.random(1, #u20)];

        if u33 ~= nil then
            u33 = nil;
            TweenService:Create(SongPreview, TweenInfo_new_ret2, {
                Volume = 0
            }):Play();
            u32 = task.delay(0.5, function() -- Line: 394
                -- upvalues: u32 (ref), u31 (ref)
                u32 = nil;
                u31:unload();
            end);
        end;

        setMusicVolume(1, true);
    end;

    u354.onUpdateConnection = RunService.RenderStepped:Connect(function(p356) -- Line: 2608
        -- upvalues: u354 (copy), u31 (ref)
        u354.Visualizer:update(p356);
        u31:update();
    end);

    if UserInputService.TouchEnabled then
        GuiService2.TouchControlsEnabled = false;
    end;

    u4:Enable();
end;

function u1.hide(u357) -- Line: 2619
    -- upvalues: u21 (copy), u33 (ref), TweenService (copy), SongPreview (copy), TweenInfo_new_ret2 (copy), u32 (ref), u31 (copy), setMusicVolume (copy), UserInputService (copy), GuiService2 (copy), u4 (copy)
    u21[u357] = nil;
    u357.Visualizer:setSettings({});
    u357.gui.Visible = false;
    u357.songScroll:setVisible(false);
    u357.modScroll:setVisible(false);
    task.delay(0.5, function() -- Line: 2627
        -- upvalues: u357 (copy)
        if u357.onUpdateConnection then
            u357.onUpdateConnection:Disconnect();
        end;
    end);

    if next(u21) then
        return;
    end;

    if u33 ~= nil then
        u33 = nil;
        TweenService:Create(SongPreview, TweenInfo_new_ret2, {
            Volume = 0
        }):Play();
        u32 = task.delay(0.5, function() -- Line: 394
            -- upvalues: u32 (ref), u31 (ref)
            u32 = nil;
            u31:unload();
        end);
    end;

    setMusicVolume(0, true);
    u357:deselectSong();

    if UserInputService.TouchEnabled then
        GuiService2.TouchControlsEnabled = true;
    end;

    u4:Disable();
end;

function u1.legacyParse(p358, p359, p360) -- Line: 2648
    -- upvalues: SongSelect (copy)
    local v361 = {
        name = p360,
        displayName = p359.OverrideName or p360,
        credits = p359.Credits or SongSelect.SongSelect_CreditsFallbackAlt,
        icon = p359.Icon,
        color = parseColorSequence(p359.Color) or ColorSequence.new(Color3.new(1, 1, 1))
    };
    local v362;

    if p359.GameIds then
        v362 = p359.GameIds.Default or nil;
    else
        v362 = nil;
    end;

    v361.gameId = v362;
    v361.prefix = p359.Prefix or nil;
    v361.weeks = {};
    v361.songs = {};
    v361.displayWeeks = true;
    v361.aliases = p359.Aliases;
    local v363 = {};

    if p359.Weeks then
        for i, v in ipairs(p359.Weeks) do
            if v.Songs then
                local v364 = {
                    name = v.Name,
                    songs = v.Songs
                };
                local v365;

                if p359.WeekColors then
                    v365 = p359.WeekColors[i] or nil;
                else
                    v365 = nil;
                end;

                v364.color = parseColorSequence(v365);
                v364.isDefaultColor = not (p359.WeekColors and p359.WeekColors[i]);

                for _, v2 in v.Songs do
                    v363[v2] = v364;
                end;

                table.insert(v361.weeks, v364);
            end;
        end;
    end;

    for _, v in p359.SongOrder do
        local v366 = {
            name = v
        };
        local v367;

        if p359.SongData[v] then
            v367 = p359.SongData[v].DisplayName or v;
        else
            v367 = v;
        end;

        v366.displayName = v367;
        v366.diffs = p359.SongData[v] and (p359.SongData[v].DiffData or {}) or {};
        v366.prefix = p359.SongData[v] and (p359.SongData[v].Prefix or "") or "";
        v366.week = v363[v] or nil;
        local v368 = v361.credits or SongSelect.SongSelect_CreditsFallbackAnotherAlt;
        local v369 = p359.ExtraCredits and p359.ExtraCredits[v];
        v366.credits = v368;

        if v369 and v369.Credits then
            if typeof(v369.Credits) == "table" then
                warn((`The song "{v}" from tab "{p360}" has a extra credits field of type table. Please fix!!!`));
            elseif string.sub(v369.Credits, 1, 1) == "+" then
                v366.credits = v368 .. v369.Credits:sub(2);
            else
                v366.credits = v369.Credits;
            end;
        end;

        local credits = v366.credits;

        if v366.credits:find("//") then
            local v370, v371 = v366.credits:match("^(.-)//(.-)$");
            v366.credits = v370:match("^%s*(.-)%s*$");
            v366.extraCredits = v371:match("^%s*(.-)%s*$");
        end;

        local v372 = p359.SongIcons and p359.SongIcons[v366.name];

        if type(v372) == "table" then
            v366.icon = v372.Difficulties._Default;
        else
            v366.icon = v372;
        end;

        v366.color = parseColorSequence(p359.Colors and p359.Colors[v] or (v366.week and not v366.week.isDefaultColor and v366.week.color or v361.color));

        if v366.week and not v366.week.color then
            v366.week.color = v366.color;
        end;

        local v373 = v;

        for i, v2 in v366.diffs do
            v2.name = i;
            v2.credits = credits;

            if v369 and v369.Difficulties then
                if v369.Difficulties[i] then
                    local v374 = v369.Difficulties[i];

                    if string.sub(v374, 1, 1) == "+" then
                        v2.credits = credits .. v374:sub(2);
                    else
                        v2.credits = v374;
                    end;
                elseif v369.Difficulties._Default then
                    local _Default = v369.Difficulties._Default;

                    if string.sub(_Default, 1, 1) == "+" then
                        v2.credits = credits .. _Default:sub(2);
                    else
                        v2.credits = _Default;
                    end;
                end;
            end;

            if v2.credits:find("//") then
                local v375, v376 = v2.credits:match("^(.-)//(.-)$");
                v2.credits = v375:match("^%s*(.-)%s*$");
                v2.extraCredits = v376:match("^%s*(.-)%s*$");
            end;

            if type(v372) == "table" then
                v2.icon = v372.Difficulties and (v372.Difficulties[i] or v372.Difficulties._Default);
            end;
        end;

        v366.gameId = p359.GameIds and p359.GameIds[v373] or v361.gameId;
        local v377;

        if p359.Achievements then
            v377 = p359.Achievements[v373] or nil;
        else
            v377 = nil;
        end;

        v366.requiresAchievement = v377;
        table.insert(v361.songs, v366);
    end;

    return v361;
end;

return u1;