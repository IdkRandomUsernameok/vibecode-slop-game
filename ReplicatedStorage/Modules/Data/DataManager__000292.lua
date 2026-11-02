-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
local DataStoreService = game:GetService("DataStoreService");
local Players = game:GetService("Players");
local HttpService = game:GetService("HttpService");
local script_LeaderstatHandler = require(script.LeaderstatHandler);
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Events = ReplicatedStorage:WaitForChild("Events");
local Logger = require(Modules.Other.Logger);
local DataTemplate = require(script.UserData.DataTemplate);
local script_MovedSongs = require(script.MovedSongs);
local u1 = {};
local u2 = { "UseCustomAnimations", "CustomAnimationData", "CustomAnimData" };
local u3 = { "CustomSongSelectMusic", "CustomShopMusic", "CustomShopMusicBPM", "ShowBloxstrapDebug", "PrintIncomingSignals", "PrintOutgoingSignals", "DebugPrint", "FunnyMode", "ShowBotplay", "CustomDevRankTag", "AutomaticBotplay", "UseOttoBotplay", "ShowcaseMode", "DisguisedName", "DisguisedVerified", "DisguisedDisplayName" };
local u4 = { "StreamerMode" };
local u5 = {};
local u6 = { "ShowNametagColors", "ShowCustomDevTag", "CustomTagData", "CustomBannerImage", "CustomBannerStyle", "ReplaceBannerByCustom" };
local u7 = { "UnlockedIcons", "UniqueFCData", "HoneypotWave", "OwnedBanners", "OwnedTags", "OwnedEmotes", "OwnedIconPacks", "OwnedNoteskins", "OwnedAnimations", "OwnedNotesplashes", "OwnedHoldsplashes", "PrevLockedBanners", "PrevLockedTags", "PrevLockedEmotes", "PrevLockedIconPacks", "PrevLockedNoteskins", "PrevLockedAnimations", "PrevLockedNotesplashes", "PrevLockedHoldsplashes", "DailyQuestData", "Version" };
local u8 = {};

for _, v in { "CustomIcon", "OpponentCustomIcon", "NoteskinPack", "OpponentNoteskinPack", "NotesplashPack", "OpponentNotesplashPack", "AnimationPack", "OpponentAnimationPack", "IconPack", "OpponentIconPack", "BannerPack", "OpponentBannerPack", "TagPack", "EmotePack", "HoldsplashPack", "OpponentHoldsplashPack", "CustomBannerImage" } do
    u1[v] = {
        string = true,
        ["nil"] = true
    };
end;

u1["CustomIconSets/*"] = {};

for _, v in { "EmoteUserID", "DuoEmoteUserID", "TrioEmoteUserID", "BotUserID", "DuoUserID", "TrioUserID" } do
    u1[v] = {
        number = true,
        string = true
    };
end;

u1["ExtraBotIDs/*"] = {
    number = true,
    string = true
};
u1.Keybinds = {};

for i = 1, 18 do
    local v9;

    if DataTemplate.Keybinds[tostring(i)] then
        u1["Keybinds/" .. i] = {};
        u1["Keybinds/" .. i .. "/*"] = {};
        u1["ConsoleKeybinds/" .. i] = {};
        u1["ConsoleKeybinds/" .. i .. "/*"] = {};
        v9 = i;

        for i2, _ in DataTemplate.Keybinds[tostring(i)] do
            u1["Keybinds/" .. v9 .. "/" .. i2] = {
                table = true,
                string = true
            };
            u1["ConsoleKeybinds/" .. v9 .. "/" .. i2] = {
                table = true,
                string = true
            };
        end;
    else
        v9 = i;
    end;
end;

u1["Keybinds/Extra/Dodge"] = {
    table = true,
    string = true
};
u1["Keybinds/Extra/Attack"] = {
    table = true,
    string = true
};
u1["Keybinds/Extra/*!"] = {};
u1["ConsoleKeybinds/Extra/Dodge"] = {
    table = true,
    string = true
};
u1["ConsoleKeybinds/Extra/Attack"] = {
    table = true,
    string = true
};
u1["ConsoleKeybinds/Extra/*!"] = {};
u1["Keybinds/Miscellaneous/AdminKeybind"] = {
    string = true,
    ["nil"] = true
};
u1["Keybinds/Miscellaneous/LeaderboardKeybind"] = {
    string = true,
    ["nil"] = true
};
u1["ConsoleKeybinds/Miscellaneous/AdminKeybind"] = {
    string = true,
    ["nil"] = true
};
u1["ConsoleKeybinds/Miscellaneous/LeaderboardKeybind"] = {
    string = true,
    ["nil"] = true
};
u1.NoteskinCustomization = {};
local v10 = require(Modules:WaitForChild("Engine").VSRG.ManiaData.Dirs)[18];
local v11 = { "Global" };

for i = 4, 18 do
    v11[i - 2] = tostring(i);
    local _ = i;
end;

for _, v in v10 do
    u1["NoteskinCustomization/" .. v] = {
        table = true,
        ["nil"] = true
    };
    local v12 = v;

    for _, v2 in v11 do
        u1["NoteskinCustomization/" .. v12 .. "/" .. v2] = {
            table = true,
            ["nil"] = true
        };
        u1["NoteskinCustomization/" .. v12 .. "/" .. v2 .. "/NoteskinColor"] = {
            table = true,
            ["nil"] = true
        };
        u1["NoteskinCustomization/" .. v12 .. "/" .. v2 .. "/NotesplashColor"] = {
            table = true,
            ["nil"] = true
        };
        u1["NoteskinCustomization/" .. v12 .. "/" .. v2 .. "/HoldsplashColor"] = {
            table = true,
            ["nil"] = true
        };
    end;
end;

local u13 = {
    Name = true,
    IconCount = true,
    Asset = true,
    OffsetX = true,
    OffsetY = true,
    SizeX = true,
    SizeY = true,
    Scale = true,
    Transparency = true,
    Color = true,
    Facing = true,
    Antialiasing = true,
    FlipAutomatically = true
};
local u21 = {
    CustomIconSets = function(p14: any, p15: any, p16: userdata, p17: boolean) -- Line: 253
        -- upvalues: RunService (copy), u13 (copy)
        if RunService:IsClient() then
            return p14;
        end;

        if not p16 then
            return p15;
        end;

        local v18 = {};

        for _, v in p15 do
            v18[v.Name or ""] = true;
        end;

        for i, v in p14 do
            if not (tonumber(i) and (tonumber(i) <= 25 and (tonumber(i) >= 1 and tonumber(i) == tonumber(i) // 1))) then
                return p15;
            end;

            if type(v.Name) ~= "string" or (type(v.Asset) ~= "string" or (type(v.IconCount) ~= "number" or (type(v.OffsetX) ~= "number" or (type(v.OffsetY) ~= "number" or (type(v.SizeX) ~= "number" or (type(v.SizeY) ~= "number" or (type(v.Scale) ~= "number" or (type(v.Transparency) ~= "number" or (type(v.Color) ~= "table" or (type(v.Facing) ~= "string" or (type(v.Antialiasing) ~= "boolean" or type(v.FlipAutomatically) ~= "boolean"))))))))))) then
                return p15;
            end;

            if #v.Color ~= 3 then
                return p15;
            end;

            local v19 = v;

            for _, v2 in v.Color do
                if type(v2) ~= "number" then
                    return p15;
                end;
            end;

            if not v19.Asset:find("^rbxassetid://") then
                return p15;
            end;

            for i2, _ in v19 do
                if not u13[i2] then
                    return p15;
                end;
            end;

            if not v18[v19.Name or ""] then
                local v20 = doBaseFilter(p16.UserId, v19.Name or "");

                if v20 then
                    v19.Name = v20:GetNonChatStringForUserAsync(p16.UserId) or "Icon Name Moderated";
                    v18[v19.Name] = true;
                end;
            end;
        end;

        return p14;
    end
};
local u22 = nil;
local u23 = nil;
local u24 = {};
local u25 = {};
local u26 = {};
Events:WaitForChild("GetData");
Events:WaitForChild("SetData");
Events:WaitForChild("GetSessionPage");
local u27 = RunService:IsServer() and "Client" or "Server";
local u28 = RunService:IsServer() and "Server" or "Client";

function fireEvent(p29, ...)
    -- upvalues: Events (copy), u27 (copy)
    local v30 = Events:FindFirstChild(p29);

    if v30 then
        if v30:IsA("RemoteEvent") then
            return v30["Fire" .. u27](v30, ...);
        end;

        return v30["Invoke" .. u27](v30, ...);
    end;
end;

function onEvent(p31, p32)
    -- upvalues: Events (copy), u28 (copy)
    local v33 = Events:FindFirstChild(p31);

    if not v33 then
        return;
    end;

    if v33:IsA("RemoteEvent") then
        v33["On" .. u28 .. "Event"]:Connect(p32);

        return;
    end;

    v33["On" .. u28 .. "Invoke"] = p32;
end;

function getDatastoreKey(p34: number)
    -- upvalues: RunService (copy), u5 (copy)
    if RunService:IsStudio() and u5[p34] then
        return "Player_" .. u5[p34];
    end;

    return "Player_" .. p34;
end;

function createLeaderstats(p35, p36, p37)
    -- upvalues: script_LeaderstatHandler (copy)
    return script_LeaderstatHandler.Create(p35, p36, p37);
end;

function u8.UpdateLeaderstats(p38, p39) -- Line: 420
    -- upvalues: script_LeaderstatHandler (copy)
    for _, v in script_LeaderstatHandler.GetLeaderstat(p39, "ALL") do
        v:Update();
    end;
end;

function u8.SetLeaderstat(p40, p41, p42, p43) -- Line: 440
    -- upvalues: u8 (copy)
    local Profile = u8:GetProfile(p41);

    if not Profile then
        return;
    end;

    Profile.Data.Stats[p42] = p43;
    u8:UpdateLeaderstats(p41);
end;

function u8.IncreaseLeaderstat(p44, p45, p46, p47) -- Line: 449
    -- upvalues: u8 (copy)
    local Profile = u8:GetProfile(p45);

    if not Profile then
        return;
    end;

    local Stats = Profile.Data.Stats;
    Stats[p46] = Stats[p46] + p47;
    u8:UpdateLeaderstats(p45);
end;

function u8.GetLeaderstat(p48, p49, p50) -- Line: 458
    -- upvalues: u8 (copy)
    local Profile = u8:GetProfile(p49);

    if Profile then
        return Profile.Data.Stats[p50];
    end;
end;

local u51 = {};

function getRank(u52)
    -- upvalues: u51 (copy), RunService (copy)
    if u51[u52] then
        return u51[u52];
    end;

    local success, result = pcall(function() -- Line: 472
        -- upvalues: u52 (copy)
        return u52:GetRankInGroup(17371285);
    end);
    u51[u52] = success and result and result or nil;

    if not (success and result) then
        if RunService:IsStudio() then
            return 255;
        end;

        result = 0;
    end;

    return result;
end;

if RunService:IsClient() then
    getRank(game.Players.LocalPlayer);
end;

local script_SongStats = require(script.SongStats);
local DataStoreOptions = Instance.new("DataStoreOptions");
DataStoreOptions:SetExperimentalFeatures({
    v2 = true
});
local u53;

if RunService:IsServer() then
    u53 = DataStoreService:GetDataStore("_SongStats", nil, DataStoreOptions) or nil;
else
    u53 = nil;
end;

function u8.GetSongStats(p54, p55) -- Line: 493
    -- upvalues: u25 (copy), RunService (copy), u23 (ref)
    if u25[p55] then
        return u25[p55];
    end;

    if not RunService:IsServer() then
        return u23;
    end;
end;

local u56 = {};

function addToFailed(p57)
    -- upvalues: u56 (copy)
    u56[p57] = true;
end;

function loadSongStats(p58: userdata, p59: any)
    -- upvalues: u53 (copy), u25 (copy), script_SongStats (copy), u56 (copy)
    local v60 = p59 or getDatastoreKey(p58.UserId);
    local v61 = nil;
    local v62 = nil;

    for i = 1, 5 do
        v61, v62 = pcall(u53.GetAsync, u53, v60);

        if v61 then
            break;
        end;

        task.wait(1);
        local _ = i;
    end;

    if v61 then
        u25[p58] = v62 and script_SongStats.decrypt(v62) or {};

        return;
    end;

    u56[p58] = true;
end;

function saveSongStats(p63: userdata)
    -- upvalues: u25 (copy), u56 (copy), script_SongStats (copy), u53 (copy)
    local v64 = u25[p63];

    if not v64 or u56[p63] then
        u56[p63] = false;

        return;
    end;

    u25[p63] = nil;
    local v65 = getDatastoreKey(p63.UserId);
    local v66 = script_SongStats.encript(v64);
    local v67 = { p63.UserId };
    local v68 = nil;

    for i = 1, 5 do
        v68 = pcall(u53.SetAsync, u53, v65, v66, v67);

        if v68 then
            break;
        end;

        task.wait(1);
        local _ = i;
    end;

    if not v68 then
        warn("[DataManager] Couldn\'t save song stats for: ", v65);
    end;
end;

function u8.UpdateSongStats(p69: table, p70: any, p71: any, p72: any, p73: any, p74: table) -- Line: 546
    -- upvalues: u8 (copy), script_SongStats (copy)
    if typeof(p70) == "Instance" and p70:IsA("Player") then
        u8:TrackSessionRun(p70, p71, p72, p73, p74);
        fireEvent("SetStatData", p70, p71, p72, p73, p74);
        p70 = p69:GetSongStats(p70) or {};
    end;

    script_SongStats.songStatChange(p70, p71, p72, p73, p74);
end;

local encryptSession = script_SongStats.encryptSession;
local decryptSession = script_SongStats.decryptSession;
local u75 = {};
local u76 = {};
local u77;

if RunService:IsServer() then
    u77 = DataStoreService:GetDataStore("_SessionDirectory") or nil;
else
    u77 = nil;
end;

function addFailedSession(p78)
    -- upvalues: u76 (copy)
    u76[p78] = true;
end;

local function getSessionStore(p79: number) -- Line: 582
    -- upvalues: u75 (copy), DataStoreService (copy)
    local v80 = "_PlayerSessions_" .. p79;

    if not u75[v80] then
        u75[v80] = DataStoreService:GetDataStore(v80);
    end;

    return u75[v80];
end;

local function getSessionKey(p81: userdata, p82: number) -- Line: 591
    return "Player_" .. p81.UserId .. "_S" .. p82;
end;

local function getDirectoryKey(p83: userdata) -- Line: 595
    return "Player_" .. p83.UserId;
end;

local function tryAsync(p84, ...) -- Line: 599
    local v85 = { ... };
    local v86 = nil;
    local v87 = nil;

    for i = 1, 5 do
        v86, v87 = pcall(p84, table.unpack(v85));

        if v86 then
            return v86, v87;
        end;

        task.wait(1);
        local _ = i;
    end;

    return v86, v87;
end;

local function estimateSize(p88) -- Line: 610
    return #game:GetService("HttpService"):JSONEncode(p88);
end;

function loadSessionData(p89: userdata, p90: any)
    -- upvalues: RunService (copy), tryAsync (copy), u77 (copy), u76 (copy), u26 (copy), u75 (copy), DataStoreService (copy), decryptSession (copy), encryptSession (copy)
    if not RunService:IsServer() then
        return;
    end;

    local v91, v92 = tryAsync(u77.GetAsync, u77, "Player_" .. p89.UserId);

    if not v91 then
        u76[p89] = true;
        u26[p89] = {
            current = nil,
            storeIndex = 1,
            sessionCount = 0
        };
        warn(p89.UserId .. ": failed to load session directory");

        return;
    end;

    local v93 = v92 or {
        storeIndex = 1,
        sessionCount = 0,
        lastLeaveTime = nil,
        lastSessionStoreIndex = nil,
        lastSessionIndex = nil
    };
    u26[p89] = {
        current = nil,
        storeIndex = v93.storeIndex,
        sessionCount = v93.sessionCount
    };
    local os_time_ret = os.time();
    local lastLeaveTime = v93.lastLeaveTime;

    if lastLeaveTime then
        if os_time_ret - v93.lastLeaveTime <= 3600 then
            lastLeaveTime = v93.lastSessionStoreIndex and v93.lastSessionIndex;
        else
            lastLeaveTime = false;
        end;
    end;

    if lastLeaveTime then
        local v94 = "_PlayerSessions_" .. v93.lastSessionStoreIndex;

        if not u75[v94] then
            u75[v94] = DataStoreService:GetDataStore(v94);
        end;

        local v95 = u75[v94];
        local v96, v97 = tryAsync(v95.GetAsync, v95, "Player_" .. p89.UserId .. "_S" .. v93.lastSessionIndex);
        local v98 = v96 and v97 and decryptSession(v97);

        if v98 then
            v98.EndTime = nil;
            u26[p89].current = {
                data = v98,
                storeIndex = v93.lastSessionStoreIndex,
                sessionIndex = v93.lastSessionIndex
            };

            return;
        end;
    end;

    if v93.lastSessionStoreIndex and v93.lastSessionIndex then
        local v99 = "_PlayerSessions_" .. v93.lastSessionStoreIndex;

        if not u75[v99] then
            u75[v99] = DataStoreService:GetDataStore(v99);
        end;

        local v100 = u75[v99];
        local v101 = "Player_" .. p89.UserId .. "_S" .. v93.lastSessionIndex;
        local v102, v103 = tryAsync(v100.GetAsync, v100, v101);

        if v102 and v103 then
            local v104 = decryptSession(v103);

            if v104 and not v104.EndTime then
                local v105 = v104.StartTime or 0;

                for _, v in v104.Runs do
                    if v.Timestamp and v105 < v.Timestamp then
                        v105 = v.Timestamp;
                    end;
                end;

                v104.EndTime = v105;
                tryAsync(v100.SetAsync, v100, v101, encryptSession(v104), { p89.UserId });
            end;
        end;
    end;
end;

function startSession(u106: userdata)
    -- upvalues: RunService (copy), u26 (copy), u75 (copy), DataStoreService (copy), tryAsync (copy), encryptSession (copy)
    if not RunService:IsServer() then
        return;
    end;

    local u107 = u26[u106];

    if not u107 or u107.current then
        return;
    end;

    u107.sessionCount = u107.sessionCount + 1;
    local u108 = {
        EndTime = nil,
        StartTime = os.time(),
        Runs = {}
    };
    u107.current = {
        data = u108,
        storeIndex = u107.storeIndex,
        sessionIndex = u107.sessionCount
    };
    task.spawn(function() -- Line: 695
        -- upvalues: u107 (copy), u75 (ref), DataStoreService (ref), u106 (copy), tryAsync (ref), encryptSession (ref), u108 (copy)
        local v109 = "_PlayerSessions_" .. u107.storeIndex;

        if not u75[v109] then
            u75[v109] = DataStoreService:GetDataStore(v109);
        end;

        local v110 = u75[v109];
        local v111, v112 = tryAsync(v110.SetAsync, v110, "Player_" .. u106.UserId .. "_S" .. u107.sessionCount, encryptSession(u108), { u106.UserId });

        if not v111 then
            warn("couldnt do initial session save for " .. u106.UserId .. ": " .. tostring(v112));
        end;
    end);
end;

function saveCurrentSession(p113: userdata, p114: boolean)
    -- upvalues: RunService (copy), u26 (copy), u76 (copy), encryptSession (copy), u75 (copy), DataStoreService (copy), tryAsync (copy), u77 (copy)
    if not RunService:IsServer() then
        return;
    end;

    local v115 = u26[p113];

    if not (v115 and (v115.current and not u76[p113])) then
        return;
    end;

    local current = v115.current;
    local data = current.data;

    if p114 then
        data.EndTime = os.time();
    end;

    local v116 = encryptSession(data);
    local v117 = "_PlayerSessions_" .. current.storeIndex;

    if not u75[v117] then
        u75[v117] = DataStoreService:GetDataStore(v117);
    end;

    local v118 = u75[v117];
    local v119 = "Player_" .. p113.UserId .. "_S" .. current.sessionIndex;
    local v120, v121 = tryAsync(v118.SetAsync, v118, v119, v116, { p113.UserId });

    if not v120 then
        warn("session store " .. current.storeIndex .. " failed for " .. p113.UserId .. ", rolling over !! error: " .. tostring(v121));
        v115.storeIndex = v115.storeIndex + 1;
        current.storeIndex = v115.storeIndex;
        local v122 = "_PlayerSessions_" .. v115.storeIndex;

        if not u75[v122] then
            u75[v122] = DataStoreService:GetDataStore(v122);
        end;

        local v123 = u75[v122];

        if not tryAsync(v123.SetAsync, v123, v119, v116, { p113.UserId }) then
            warn("couldnt save session for " .. p113.UserId .. " even after rollover..");

            return;
        end;
    end;

    if not tryAsync(u77.SetAsync, u77, "Player_" .. p113.UserId, {
        storeIndex = v115.storeIndex,
        sessionCount = v115.sessionCount,
        lastLeaveTime = p114 and os.time() or nil,
        lastSessionStoreIndex = current.storeIndex,
        lastSessionIndex = current.sessionIndex
    }, { p113.UserId }) then
        warn("couldnt save directory for " .. p113.UserId);
    end;
end;

function endSession(p124: userdata)
    -- upvalues: RunService (copy), u26 (copy)
    if not RunService:IsServer() then
        return;
    end;

    local v125 = u26[p124];

    if v125 and (v125.current and #v125.current.data.Runs == 0) then
        u26[p124] = nil;

        return;
    end;

    saveCurrentSession(p124, true);
    u26[p124] = nil;
end;

function u8.TrackSessionRun(p126: table, p127: userdata, p128: any, p129: any, p130: any, p131: table) -- Line: 760
    -- upvalues: RunService (copy), u26 (copy)
    if not RunService:IsServer() then
        return;
    end;

    local v132 = u26[p127];

    if not (v132 and v132.current) then
        return;
    end;

    local Runs = v132.current.data.Runs;
    local v133 = {
        Mod = p128,
        Song = p129,
        Diff = p130,
        FCData = p131.FCData,
        Score = math.round(p131.Score),
        Accuracy = p131.Accuracy,
        Misses = p131.Misses,
        Timestamp = os.time()
    };
    table.insert(Runs, v133);

    if #v132.current.data.Runs % 10 == 0 then
        task.spawn(saveCurrentSession, p127, false);
    end;
end;

function u8.GetCurrentSession(p134: table, p135: userdata) -- Line: 781
    -- upvalues: u26 (copy)
    local v136 = u26[p135];

    return v136 and (v136.current and v136.current.data) or nil;
end;

function u8.GetSessionInfo(p137: table, p138: userdata) -- Line: 786
    -- upvalues: u26 (copy)
    local v139 = u26[p138];

    return v139 and {
        storeIndex = v139.storeIndex,
        sessionCount = v139.sessionCount
    } or nil;
end;

function u8.GetSessions(p140: table, p141: userdata, p142: number?, p143: number?) -- Line: 792
    -- upvalues: RunService (copy), tryAsync (copy), u77 (copy), u75 (copy), DataStoreService (copy), decryptSession (copy)
    local v144 = p143 or 20;

    if not RunService:IsServer() then
        return nil;
    end;

    local v145, v146 = tryAsync(u77.GetAsync, u77, "Player_" .. p141.UserId);

    if not (v145 and v146) then
        warn("couldnt get directory for " .. p141.UserId);

        return nil;
    end;

    local sessionCount = v146.sessionCount;
    local math_ceil_ret = math.ceil(sessionCount / v144);
    local v147, v148;

    if p142 == nil then
        v147 = sessionCount;
        v148 = 1;
    else
        v147 = sessionCount - (p142 - 1) * v144;
        v148 = math.max(v147 - v144 + 1, 1);
    end;

    local v149 = {};

    for i = v147, v148, -1 do
        local v150 = "Player_" .. p141.UserId .. "_S" .. i;
        local v151 = i;
        local v152 = nil;

        for i2 = 1, v146.storeIndex do
            local v153 = "_PlayerSessions_" .. i2;

            if not u75[v153] then
                u75[v153] = DataStoreService:GetDataStore(v153);
            end;

            local v154 = u75[v153];
            local v155, v156 = tryAsync(v154.GetAsync, v154, v150);

            if v155 and v156 then
                v152 = v156;
                break;
            end;

            local _ = i2;
        end;

        if v152 then
            local v157 = decryptSession(v152);

            if v157 then
                v157.SessionIndex = v151;
                table.insert(v149, v157);
            end;
        end;
    end;

    local v158 = {
        Sessions = v149,
        Page = p142 or "all"
    };
    local v159;

    if p142 then
        v159 = v144 or sessionCount;
    else
        v159 = sessionCount;
    end;

    v158.PageSize = v159;
    v158.Total = sessionCount;
    v158.TotalPages = math_ceil_ret;
    v158.HasMore = p142 and p142 < math_ceil_ret and true or false;

    return v158;
end;

function u8.GetSessionsAsync(p160: table, p161: number?, p162: number?) -- Line: 850
    -- upvalues: RunService (copy)
    if not RunService:IsServer() then
        return fireEvent("GetSessionPage", p161, p162);
    end;
end;

function onProfileLoaded(p163: any, u164: table)
    if u164.Data.Stats.Wins < workspace:GetAttribute("MinimumWins") then
        p163:Kick("Your wins count does not meet the minimum wins required by the server owner.");
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "Leaderstats";
    createLeaderstats("Wins", p163, u164.Data.Stats.Wins).Self.Parent = Folder;
    createLeaderstats("UFCs", p163, function(p165) -- Line: 868
        -- upvalues: u164 (copy)
        return #u164.Data.UniqueFCData;
    end).Self.Parent = Folder;
    Folder.Parent = p163;
end;

local AssetReplicator = require(Modules:WaitForChild("Main"):WaitForChild("AssetReplicator"));
local Assets = ReplicatedStorage:WaitForChild("Assets");
local u166 = {
    Animations = Assets:WaitForChild("Animations"),
    Notesplashes = Assets:WaitForChild("Notesplashes"),
    Noteskins = Assets:WaitForChild("Noteskins")
};
local v167;

if RunService:IsServer() then
    v167 = ServerStorage.ReplicableAssets.Holdsplashes;
else
    v167 = AssetReplicator.getAsset("Holdsplashes");
end;

u166.Holdsplashes = v167;
u166.Emotes = Assets:WaitForChild("Emotes");
u166.Icons = Assets:WaitForChild("Icons");
local v168;

if RunService:IsServer() then
    v168 = ServerStorage.ReplicableAssets.Tags;
else
    v168 = AssetReplicator.getAsset("Tags");
end;

u166.Tags = v168;
local v169;

if RunService:IsServer() then
    v169 = ServerStorage.ReplicableAssets.Banners;
else
    v169 = AssetReplicator.getAsset("Banners");
end;

u166.Banners = v169;

function isPackValid(p170, p171, p172)
    if p171 == "" then
        p171 = nil;
    end;

    if p172 == "" then
        p172 = nil;
    end;

    if p171 and p172 then
        local v173 = p170:FindFirstChild(p171);

        return v173 and (v173:GetAttribute("Pack") and v173:FindFirstChild(p172)) and true or false;
    end;

    if not p171 and p172 then
        local v174 = p170:FindFirstChild(p172);

        if v174 and not v174:GetAttribute("Pack") then
            return true;
        end;
    end;

    return false;
end;

function checkAssetFailsafes(p175)
    -- upvalues: u166 (copy), DataTemplate (copy)
    if not isPackValid(u166.Noteskins, p175.NoteskinPack, p175.Noteskin) then
        p175.NoteskinPack = DataTemplate.NoteskinPack;
        p175.Noteskin = DataTemplate.Noteskin;
    end;

    if not isPackValid(u166.Noteskins, p175.OpponentNoteskinPack, p175.OpponentNoteskin) then
        p175.OpponentNoteskinPack = DataTemplate.OpponentNoteskinPack;
        p175.OpponentNoteskin = DataTemplate.OpponentNoteskin;
    end;

    if not isPackValid(u166.Animations, p175.AnimationPack, p175.Animation) then
        p175.AnimationPack = DataTemplate.AnimationPack;
        p175.Animation = DataTemplate.Animation;
    end;

    if not isPackValid(u166.Animations, p175.OpponentAnimationPack, p175.OpponentAnimation) then
        p175.OpponentAnimationPack = DataTemplate.OpponentAnimationPack;
        p175.OpponentAnimation = DataTemplate.OpponentAnimation;
    end;

    if not isPackValid(u166.Icons, p175.IconPack, p175.Icon) then
        p175.IconPack = DataTemplate.IconPack;
        p175.Icon = DataTemplate.Icon;
    end;

    if not isPackValid(u166.Icons, p175.OpponentIconPack, p175.OpponentIcon) then
        p175.OpponentIconPack = DataTemplate.OpponentIconPack;
        p175.OpponentIcon = DataTemplate.OpponentIcon;
    end;

    if not isPackValid(u166.Emotes, p175.EmotePack, p175.Emote) then
        p175.EmotePack = DataTemplate.EmotePack;
        p175.Emote = DataTemplate.Emote;
    end;

    if not isPackValid(u166.Tags, p175.TagPack, p175.Tag) then
        p175.TagPack = DataTemplate.TagPack;
        p175.Tag = DataTemplate.Tag;
    end;

    if not isPackValid(u166.Banners, p175.BannerPack, p175.Banner) then
        p175.BannerPack = DataTemplate.BannerPack;
        p175.Banner = DataTemplate.Banner;
    end;

    if not isPackValid(u166.Banners, p175.OpponentBannerPack, p175.OpponentBanner) then
        p175.OpponentBannerPack = DataTemplate.OpponentBannerPack;
        p175.OpponentBanner = DataTemplate.OpponentBanner;
    end;

    if not isPackValid(u166.Notesplashes, p175.NotesplashPack, p175.Notesplash) then
        p175.NotesplashPack = DataTemplate.NotesplashPack;
        p175.Notesplash = DataTemplate.Notesplash;
    end;

    if not isPackValid(u166.Notesplashes, p175.OpponentNotesplashPack, p175.OpponentNotesplash) then
        p175.OpponentNotesplashPack = DataTemplate.OpponentNotesplashPack;
        p175.OpponentNotesplash = DataTemplate.OpponentNotesplash;
    end;

    if not isPackValid(u166.Holdsplashes, p175.HoldsplashPack, p175.Holdsplash) then
        p175.HoldsplashPack = DataTemplate.HoldsplashPack;
        p175.Holdsplash = DataTemplate.Holdsplash;
    end;

    if not isPackValid(u166.Holdsplashes, p175.OpponentHoldsplashPack, p175.OpponentHoldsplash) then
        p175.OpponentHoldsplashPack = DataTemplate.OpponentHoldsplashPack;
        p175.OpponentHoldsplash = DataTemplate.OpponentHoldsplash;
    end;
end;

local IconV2 = require(Modules.Main.IconV2);

function convertOldCustomIcons(p176)
    -- upvalues: IconV2 (copy)
    local CustomIconSets = p176.CustomIconSets;

    if next(CustomIconSets) then
        return;
    end;

    if p176.PlayerIconData and p176.PlayerIconData.IconID ~= 0 then
        table.insert(CustomIconSets, IconV2:exportToDatastore(IconV2:convertLegacySettingsToNew(p176.PlayerIconData, "Player Icon")));
        p176.PlayerIconData = nil;
    end;

    if p176.BotIconData and p176.BotIconData.IconID ~= 0 then
        table.insert(CustomIconSets, IconV2:exportToDatastore(IconV2:convertLegacySettingsToNew(p176.BotIconData, "Bot Icon")));
        p176.BotIconData = nil;
    end;
end;

function redirectSongs(p177: any, p178: userdata)
    -- upvalues: script_MovedSongs (copy), u25 (copy)
    for i, v in script_MovedSongs do
        if i.mod and v.mod then
            local id = i.id;
            local id2 = v.id;
            local table_find_ret = table.find(p177.Favorites, id);

            if table_find_ret and not table.find(p177.Favorites, id2) then
                p177.Favorites[table_find_ret] = id2;
            end;

            local table_find_ret2 = table.find(p177.UniqueFCData, id);

            if table_find_ret2 and not table.find(p177.UniqueFCData, id2) then
                p177.UniqueFCData[table_find_ret2] = id2;
            end;

            local v179;

            if p178 then
                v179 = u25[p178] or nil;
            else
                v179 = nil;
            end;

            if v179 then
                if i.mod == v.mod and i.song == v.song then
                    warn("what the pomni bro why are you redirecting to yourself bruhhhh");
                elseif i.mod and not (i.song or (not v.mod or v.song)) then
                    local v180 = v179[i.mod];

                    if v180 then
                        local v181 = v179[v.mod] or {};
                        v179[v.mod] = v181;

                        for i2, v2 in v180 do
                            if not v181[i2] then
                                v181[i2] = v2;
                            end;
                        end;

                        v179[i.mod] = nil;
                    end;
                elseif i.mod and (i.song and (v.mod and v.song)) then
                    local v182 = v179[i.mod];

                    if v182 then
                        local v183 = v182[i.song];

                        if v183 then
                            local v184 = v179[v.mod] or {};
                            v179[v.mod] = v184;
                            v184[v.song] = v183;
                            v182[i.song] = nil;
                        end;
                    end;
                else
                    warn("UNSUPPORTED REDIRECTION DATA, FROM:", i, "TO:", v);
                end;
            end;
        else
            warn("INVALID REDIRECTION DATA");
        end;
    end;
end;

function filterUserData(p185, p186)
    -- upvalues: DataTemplate (copy), u3 (copy), u6 (copy), u2 (copy), u4 (copy)
    for i, v in { p185.Keybinds, p185.ConsoleKeybinds } do
        local v187 = i == 1 and DataTemplate.Keybinds or DataTemplate.ConsoleKeybinds;
        local v188 = i;

        for i2, v2 in v do
            local v189 = v187[i2];
            local v190 = v2;

            for i3, v3 in v2 do
                if tonumber(i3) or type(v3) == "string" and (v3:find("DPag") or v188 == 2 and v3:find("MouseButton")) then
                    local v191;

                    if v189 then
                        v191 = v189[i3] or nil;
                    else
                        v191 = nil;
                    end;

                    v190[i3] = v191;
                end;
            end;
        end;
    end;

    if p185.NoteskinCustomization[4] then
        p185.NoteskinCustomization = {};
    end;

    if p185.NoteskinColorData then
        if not next(p185.NoteskinCustomization) then
            for i, v in p185.NoteskinColorData do
                if type(v.Color) == "table" then
                    p185.NoteskinCustomization[i] = {
                        Global = {
                            NoteskinColor = {
                                Type = "Hue",
                                Animations = { "note", "hold", "holdend", "press", "confirm" },
                                Color = v.Color
                            }
                        }
                    };
                end;
            end;
        end;

        p185.NoteskinColorData = nil;
    end;

    if p185.PlayerIconData or p185.BotIconData then
        convertOldCustomIcons(p185);
    end;

    local v192 = getRank(p186);

    if v192 < 252 then
        for _, v in u3 do
            p185[v] = DataTemplate[v];
        end;
    end;

    if v192 < 248 then
        for _, v in u6 do
            p185[v] = DataTemplate[v];
        end;
    end;

    if v192 < 200 then
        for _, v in u2 do
            p185[v] = DataTemplate[v];
        end;
    end;

    if v192 < 150 then
        for _, v in u4 do
            p185[v] = DataTemplate[v];
        end;
    end;

    if p185.Version < 1.1 then
        p185.PrevLockedBanners = {};
        p185.PrevLockedTags = {};
        p185.PrevLockedEmotes = {};
        p185.PrevLockedIconPacks = {};
        p185.PrevLockedNoteskins = {};
        p185.PrevLockedAnimations = {};
        p185.PrevLockedNotesplashes = {};
        p185.PrevLockedHoldsplashes = {};
    end;

    checkAssetFailsafes(p185);
    redirectSongs(p185, p186);
    p185.Version = DataTemplate.Version;
end;

function u8.GetLocalData(p193: table, p194: boolean?) -- Line: 1144
    -- upvalues: RunService (copy), u22 (ref)
    if not RunService:IsServer() then
        if not u22 or p194 then
            u22 = fireEvent("GetData");
        end;

        return u22;
    end;
end;

if RunService:IsServer() then
    function u8.GetData(p195: table, p196: userdata?) -- Line: 1153
        local Profile = p195:GetProfile(p196);

        if Profile then
            return Profile;
        end;
    end;

    function u8.GetProfile(p197: table, p198: userdata?) -- Line: 1160
        -- upvalues: Players (copy), u24 (copy)
        if p198 and Players:IsAncestorOf(p198) then
            if u24[p198] == nil then
                repeat
                    task.wait();
                until u24[p198] or not Players:IsAncestorOf(p198);
            end;

            return u24[p198];
        end;
    end;
else
    function u8.GetData(p199) -- Line: 1167
        -- upvalues: u8 (copy)
        return u8:GetLocalData();
    end;

    function u8.GetProfile(p200: table, p201: userdata?) -- Line: 1171
        -- upvalues: u8 (copy)
        return {
            Data = u8:GetLocalData()
        };
    end;
end;

local u202 = {};

if RunService:IsServer() then
    local ProfileStore = require(script.ProfileService).GetProfileStore("_Settings2", DataTemplate);

    local function PlayerAdded(u203: userdata) -- Line: 1184
        -- upvalues: u202 (copy), RunService (copy), u25 (copy), u26 (copy), ProfileStore (copy), DataTemplate (copy), u24 (copy), Players (copy)
        local v204 = u202[u203.Name];
        local v205 = v204 and RunService:IsStudio() and getDatastoreKey(v204) or getDatastoreKey(u203.UserId);
        local success, result = pcall(loadSongStats, u203, v205);

        if not success then
            addToFailed(u203);
            u25[u203] = {};
            warn(u203.UserId .. " SONG STATS ERRORED WITH:", result);
        end;

        local success2, result2 = pcall(loadSessionData, u203, v205);

        if not success2 then
            addFailedSession(u203);
            u26[u203] = {
                current = nil,
                storeIndex = 1,
                sessionCount = 0
            };
            warn(u203.UserId .. " SESSION DATA ERRORED WITH: " .. tostring(result2));
        end;

        local v206;

        if v204 and RunService:IsStudio() then
            addToFailed(u203);
            v206 = ProfileStore:ViewProfileAsync(v205);
        else
            v206 = ProfileStore:LoadProfileAsync(v205);

            if game.PlaceId == 13042469490 and v206 then
                local v207 = ProfileStore:ProfileVersionQuery(v205, Enum.SortDirection.Descending, nil, DateTime.fromUniversalTime(2026, 1, 2)):NextAsync();

                if v207 then
                    for _, v in { "PrevLockedBanners", "PrevLockedTags", "PrevLockedEmotes", "PrevLockedIconPacks", "PrevLockedNoteskins", "PrevLockedAnimations", "PrevLockedNotesplashes", "PrevLockedHoldsplashes" } do
                        local v208 = v206.Data[v:gsub("PrevLocked", "Owned")];

                        if v208 then
                            for _, v2 in v207.Data[v] or {} do
                                if not table.find(v208, v2) then
                                    table.insert(v208, v2);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        if v206 == nil then
            u203:Kick("Data couldn\'t be loaded!");
        else
            v206:AddUserId(u203.UserId);
            v206.Data.Version = v206.Data.Version or 0;
            v206:Reconcile();
            local u209 = DataTemplate.Version >= v206.Data.Version and true or game.PlaceId == 13042469490;
            v206:ListenToRelease(function() -- Line: 1248
                -- upvalues: u24 (ref), u203 (copy), u209 (copy)
                u24[u203] = nil;
                saveSongStats(u203);
                endSession(u203);
                u203:Kick(u209 and "Profile lock has been released (Correctly saved data)" or "Your save file has a higher data version than this server! (Outdated server)");
            end);

            if u203:IsDescendantOf(Players) and u209 then
                filterUserData(v206.Data, u203);
                u24[u203] = v206;
                startSession(u203);
                onProfileLoaded(u203, v206);
            else
                v206:Release();
            end;
        end;
    end;

    for _, v in Players:GetPlayers() do
        task.spawn(PlayerAdded, v);
    end;

    Players.PlayerAdded:Connect(PlayerAdded);
    Players.PlayerRemoving:Connect(function(p210) -- Line: 1280
        -- upvalues: u24 (copy)
        local v211 = u24[p210];

        if v211 ~= nil then
            v211:Release();
        end;
    end);
    onEvent("GetData", function(p212) -- Line: 1287
        -- upvalues: u8 (copy)
        repeat
            task.wait();
        until u8:GetProfile(p212);

        return u8:GetProfile(p212).Data, u8:GetSongStats(p212);
    end);
    onEvent("SetData", function(p213, p214, p215) -- Line: 1292
        -- upvalues: u24 (copy), u8 (copy)
        if u24[p213] then
            u8:SetData(p213, p214, p215, true);
        end;
    end);
    onEvent("GetSessionPage", function(p216, p217, p218) -- Line: 1298
        -- upvalues: u8 (copy)
        local Sessions = u8:GetSessions(p216, p217, p218);
        local CurrentSession = u8:GetCurrentSession(p216);

        if CurrentSession and Sessions then
            local v219 = false;

            for _, v in Sessions.Sessions do
                if v.StartTime == CurrentSession.StartTime then
                    v.Runs = CurrentSession.Runs;
                    v.SessionIndex = "current";
                    v219 = true;
                    break;
                end;
            end;

            if not v219 then
                table.insert(Sessions.Sessions, 1, {
                    SessionIndex = "current",
                    StartTime = CurrentSession.StartTime,
                    EndTime = CurrentSession.EndTime,
                    Runs = CurrentSession.Runs
                });
                Sessions.Total = Sessions.Total + 1;
            end;
        end;

        return Sessions;
    end);
else
    local v220, v221 = fireEvent("GetData");
    u22 = v220;
    u23 = v221;
    onEvent("SetData", function(p222, p223) -- Line: 1331
        -- upvalues: u22 (ref), u8 (copy)
        local v224 = getByPath(u22, p222) ~= p223;
        setByPath(u8:GetLocalData(), p222, p223);

        if v224 and u8.triggerChange then
            u8.triggerChange(p222, p223, false);
        end;
    end);
    onEvent("SetStatData", function(...) -- Line: 1339
        -- upvalues: u8 (copy), u23 (ref)
        u8:UpdateSongStats(u23, ...);
    end);
    Logger.log("Successfully got the data!");
end;

function setByPath(p225, p226, p227)
    local string_split_ret = string.split(p226, "/");

    for i = 1, #string_split_ret do
        local v228;

        if i == #string_split_ret then
            p225[p225[string_split_ret[i]] and string_split_ret[i] or (tonumber(string_split_ret[i]) or string_split_ret[i])] = p227;
            v228 = i;
        else
            p225 = p225[string_split_ret[i]] or p225[tonumber(string_split_ret[i])];
            v228 = i;
        end;
    end;
end;

function getByPath(p229, p230)
    if not p230 then
        return nil;
    end;

    local string_split_ret = string.split(p230, "/");

    for i = 1, #string_split_ret do
        if p229 == nil then
            return nil;
        end;

        if i == #string_split_ret then
            if p229[string_split_ret[i]] == nil then
                return p229[tonumber(string_split_ret[i])];
            end;

            return p229[string_split_ret[i]];
        end;

        p229 = p229[string_split_ret[i]] or p229[tonumber(string_split_ret[i])];
        local _ = i;
    end;
end;

function getValue(p231, p232, p233)
    local string_split_ret = string.split(p232, "/");

    for i = 1, #string_split_ret do
        local v234;

        if i == #string_split_ret then
            p231[p231[string_split_ret[i]] and string_split_ret[i] or (tonumber(string_split_ret[i]) or string_split_ret[i])] = p233;
            v234 = i;
        else
            p231 = p231[string_split_ret[i]] or p231[tonumber(string_split_ret[i])];
            v234 = i;
        end;
    end;
end;

function setValue(p235, p236)
    -- upvalues: Logger (copy)
    if not p236 then
        return nil;
    end;

    local string_split_ret = string.split(p236, "/");

    for i = 1, #string_split_ret do
        if p235 == nil then
            Logger.log("Path", p236, "doesn\'t exist!");

            return nil;
        end;

        if i == #string_split_ret then
            if p235[string_split_ret[i]] == nil then
                return p235[tonumber(string_split_ret[i])];
            end;

            return p235[string_split_ret[i]];
        end;

        p235 = p235[string_split_ret[i]] or p235[tonumber(string_split_ret[i])];
        local _ = i;
    end;
end;

u8.setByPath = setByPath;
u8.getByPath = getByPath;
u8.getValue = getValue;
u8.setValue = setValue;

function makeLastWildcard(p237)
    return p237:gsub("([^/]+)$", "*");
end;

function hasWriteAccess(p238, p239, p240)
    -- upvalues: RunService (copy), u7 (copy), u3 (copy), u6 (copy), u2 (copy), u4 (copy)
    local v241 = RunService:IsServer() and p240;

    if table.find(u7, p238) and v241 then
        warn("Only server can write to \'" .. p238 .. "\'!");

        return;
    end;

    if not p239 and RunService:IsServer() then
        return true;
    end;

    local v242 = getRank(p239);

    if table.find(u3, p238) and v242 < 252 then
        return;
    end;

    if table.find(u6, p238) and v242 < 248 then
        return;
    end;

    if table.find(u2, p238) and v242 < 200 then
        return;
    end;

    if not table.find(u4, p238) or v242 >= 150 then
        return true;
    end;
end;

function canSetData(p243, p244, p245, p246)
    -- upvalues: u1 (copy), DataTemplate (copy)
    local string_split_ret = string.split(p243, "/");

    if #string_split_ret > 1 then
        for i = 1, #string_split_ret - 1 do
            if not hasWriteAccess(table.concat(string_split_ret, "/", 1, i), p245, p246) then
                warn((`[DATA] Couldn't set '{p243}', parent tree is not allowed to be written to {table.concat(string_split_ret, "/", 1, i)}`));

                return;
            end;

            local _ = i;
        end;
    end;

    if not hasWriteAccess(p243, p245, p246) then
        warn("[DATA] Don\'t have write access to " .. p243);

        return;
    end;

    local v247 = u1[p243];

    if not v247 then
        local v248;

        if getByPath(DataTemplate, p243) == nil then
            v248 = u1[makeLastWildcard(p243) .. "!"];
        else
            v248 = u1[makeLastWildcard(p243) .. "+"];
        end;

        v247 = v248 or u1[makeLastWildcard(p243)];
    end;

    local v249 = type(v247) == "table" and v247["nil"] or v247 == "nil";

    if p244 ~= nil or v249 then
        local v250 = getByPath(DataTemplate, p243);
        local v251 = v247 or typeof(v250);
        local v252;

        if v251 == "any" then
            v252 = true;
        elseif type(v251) == "table" then
            v252 = v251.any;
        else
            v252 = false;
        end;

        local v253 = typeof(p244);

        if v252 or (v251 == v253 or type(v251) == "table" and v251[v253]) then
            return true;
        end;

        local v254 = {};

        if type(v251) == "table" then
            for i, _ in v251 do
                table.insert(v254, i);
            end;
        else
            v254 = { v251 };
        end;

        return warn((`[DATA] Tried to save index '{p243}' with type '{v253}'! (Valid types: {table.concat(v254, ", ")})`));
    end;

    warn("[DATA] Index \'" .. p243 .. "\' is not allowed to be nil!");
end;

local function is_valid_utf8(p255) -- Line: 1505
    local v256 = 1;

    while v256 <= #p255 do
        local string_byte_ret = string.byte(p255, v256);

        if string_byte_ret < 0 or string_byte_ret > 127 then
            if string_byte_ret >= 194 and string_byte_ret <= 223 then
                local string_byte_ret2 = string.byte(p255, v256 + 1);

                if not (string_byte_ret2 and (string_byte_ret2 >= 128 and string_byte_ret2 <= 191)) then
                    return false;
                end;

                v256 = v256 + 1;
            elseif string_byte_ret == 224 then
                local string_byte_ret2 = string.byte(p255, v256 + 1);
                local string_byte_ret3 = string.byte(p255, v256 + 2);

                if not (string_byte_ret2 and (string_byte_ret3 and (string_byte_ret2 >= 160 and (string_byte_ret2 <= 191 and (string_byte_ret3 >= 128 and string_byte_ret3 <= 191))))) then
                    return false;
                end;

                v256 = v256 + 2;
            elseif string_byte_ret >= 225 and string_byte_ret <= 236 then
                local string_byte_ret2 = string.byte(p255, v256 + 1);
                local string_byte_ret3 = string.byte(p255, v256 + 2);

                if not (string_byte_ret2 and (string_byte_ret3 and (string_byte_ret2 >= 128 and (string_byte_ret2 <= 191 and (string_byte_ret3 >= 128 and string_byte_ret3 <= 191))))) then
                    return false;
                end;

                v256 = v256 + 2;
            elseif string_byte_ret == 237 then
                local string_byte_ret2 = string.byte(p255, v256 + 1);
                local string_byte_ret3 = string.byte(p255, v256 + 2);

                if not (string_byte_ret2 and (string_byte_ret3 and (string_byte_ret2 >= 128 and (string_byte_ret2 <= 159 and (string_byte_ret3 >= 128 and string_byte_ret3 <= 191))))) then
                    return false;
                end;

                v256 = v256 + 2;
            elseif string_byte_ret >= 238 and string_byte_ret <= 239 then
                local string_byte_ret2 = string.byte(p255, v256 + 1);
                local string_byte_ret3 = string.byte(p255, v256 + 2);

                if not (string_byte_ret2 and (string_byte_ret3 and (string_byte_ret2 >= 128 and (string_byte_ret2 <= 191 and (string_byte_ret3 >= 128 and string_byte_ret3 <= 191))))) then
                    return false;
                end;

                v256 = v256 + 2;
            elseif string_byte_ret == 240 then
                local string_byte_ret2 = string.byte(p255, v256 + 1);
                local string_byte_ret3 = string.byte(p255, v256 + 2);
                local string_byte_ret4 = string.byte(p255, v256 + 3);

                if not (string_byte_ret2 and (string_byte_ret3 and (string_byte_ret4 and (string_byte_ret2 >= 144 and (string_byte_ret2 <= 191 and (string_byte_ret3 >= 128 and (string_byte_ret3 <= 191 and (string_byte_ret4 >= 128 and string_byte_ret4 <= 191)))))))) then
                    return false;
                end;

                v256 = v256 + 3;
            elseif string_byte_ret >= 241 and string_byte_ret <= 243 then
                local string_byte_ret2 = string.byte(p255, v256 + 1);
                local string_byte_ret3 = string.byte(p255, v256 + 2);
                local string_byte_ret4 = string.byte(p255, v256 + 3);

                if not (string_byte_ret2 and (string_byte_ret3 and (string_byte_ret4 and (string_byte_ret2 >= 128 and (string_byte_ret2 <= 191 and (string_byte_ret3 >= 128 and (string_byte_ret3 <= 191 and (string_byte_ret4 >= 128 and string_byte_ret4 <= 191)))))))) then
                    return false;
                end;

                v256 = v256 + 3;
            else
                if string_byte_ret ~= 244 then
                    return false;
                end;

                local string_byte_ret2 = string.byte(p255, v256 + 1);
                local string_byte_ret3 = string.byte(p255, v256 + 2);
                local string_byte_ret4 = string.byte(p255, v256 + 3);

                if not (string_byte_ret2 and (string_byte_ret3 and (string_byte_ret4 and (string_byte_ret2 >= 128 and (string_byte_ret2 <= 143 and (string_byte_ret3 >= 128 and (string_byte_ret3 <= 191 and (string_byte_ret4 >= 128 and string_byte_ret4 <= 191)))))))) then
                    return false;
                end;

                v256 = v256 + 3;
            end;
        end;

        v256 = v256 + 1;
    end;

    return true;
end;

local u257 = {
    Enum = true,
    Enums = true,
    OverlapParams = true,
    RotationCurveKey = true,
    userdata = true,
    number = true,
    string = true,
    table = true,
    boolean = true,
    ["nil"] = true
};

local function isSaveable(p258) -- Line: 1627
    -- upvalues: u257 (copy), isSaveable (copy), is_valid_utf8 (copy)
    if type(p258) == "table" then
        for i, v in p258 do
            if not u257[typeof(i)] then
                return false;
            end;

            if not isSaveable(v) then
                return false;
            end;
        end;

        return true;
    end;

    if type(p258) == "string" then
        return is_valid_utf8(p258);
    end;

    return u257[typeof(p258)];
end;

function u8.isValid(p259, p260) -- Line: 1644
    -- upvalues: isSaveable (copy)
    return isSaveable(p260);
end;

local TextService = game:GetService("TextService");

function doBaseFilter(u261, u262)
    -- upvalues: TextService (copy)
    local success, result = pcall(function() -- Line: 1652
        -- upvalues: TextService (ref), u262 (copy), u261 (copy)
        return TextService:FilterStringAsync(u262, u261);
    end);

    return success and result and result or nil;
end;

local NormalFilter = Events.TextFilter.NormalFilter;

function u8.filterString(p263, p264) -- Line: 1659
    -- upvalues: isSaveable (copy), NormalFilter (copy)
    if p264 and isSaveable(p264) then
        return NormalFilter:InvokeServer(p264);
    end;
end;

if RunService:IsServer() then
    function u8.SetData(p265, p266, p267, p268, p269) -- Line: 1666
        -- upvalues: isSaveable (copy), u21 (copy)
        if not (p266 and p267) then
            return;
        end;

        local v270 = deepcopy(p268);

        if not isSaveable(v270) then
            warn(`[DataManager] Tried to save bad value in datastore ({p267})`, v270);

            return;
        end;

        local Data = p265:GetProfile(p266).Data;

        if not Data then
            return;
        end;

        if not canSetData(p267, v270, p266, p269) then
            return;
        end;

        local v271 = u21[p267] or u21[makeLastWildcard(p267)];

        if v271 then
            v270 = v271(v270, getByPath(Data, p267), p266, p269);
        end;

        setByPath(Data, p267, v270);

        if not p269 then
            fireEvent("SetData", p266, p267, v270);
        end;
    end;
else
    local u272 = require(Modules.Lib.Signal).new();

    function u8.triggerChange(p273, p274, p275) -- Line: 1698
        -- upvalues: u272 (copy)
        u272:Fire(p273, p274, p275);
    end;

    u8.DataChanged = u272;

    function u8.SetData(p276, p277, p278, p279) -- Line: 1704
        -- upvalues: isSaveable (copy), u8 (copy), Players (copy), u21 (copy), u272 (copy)
        if not p277 then
            return;
        end;

        local v280 = deepcopy(p278);

        if not isSaveable(v280) then
            warn(`[DataManager] Tried to save bad value in datastore ({p277})`, v280);

            return;
        end;

        local LocalData = u8:GetLocalData();

        if not LocalData then
            return;
        end;

        if not canSetData(p277, v280, Players.LocalPlayer) then
            return;
        end;

        local v281 = u21[p277] or u21[makeLastWildcard(p277)];

        if v281 then
            v280 = v281(v280, getByPath(LocalData, p277), Players.LocalPlayer, false);
        end;

        local v282 = getByPath(LocalData, p277) ~= v280;
        setByPath(LocalData, p277, v280);

        if not p279 then
            fireEvent("SetData", p277, v280);
        end;

        if v282 then
            u272:Fire(p277, v280, p279);
        end;
    end;
end;

function deepcopy(p283, p284)
    local v285 = p284 or {};

    if type(p283) ~= "table" then
        return p283;
    end;

    if v285[p283] then
        return v285[p283];
    end;

    local v286 = {};
    v285[p283] = v286;

    for i, v in next, p283 do
        v286[deepcopy(i, v285)] = deepcopy(v, v285);
    end;

    local l_deepcopy = deepcopy;
    local v287 = getmetatable(p283);
    setmetatable(v286, l_deepcopy(v287, v285));

    return v286;
end;

function u8.Export(p288, p289) -- Line: 1757
    -- upvalues: u8 (copy), u7 (copy), u3 (copy), u6 (copy), u2 (copy), u4 (copy), HttpService (copy)
    local v290 = deepcopy(u8:GetLocalData());
    v290.SaveData = nil;
    v290.Favorites = nil;
    v290.PlayerELO = nil;
    local v291 = p289 or {
        exportKeybinds = false,
        exportBots = false,
        exportJudgementImages = false,
        exportAnim = false
    };

    for _, v in { "Noteskin", "NoteskinPack", "NoteskinOverrides", "OpponentNoteskin", "OpponentNoteskinPack", "Notesplash", "NotesplashPack", "NotesplashOverrides", "OpponentNotesplash", "OpponentNotesplashPack", "Animation", "AnimationPack", "OpponentAnimation", "OpponentAnimationPack", "Holdsplash", "HoldsplashPack", "HoldsplashOverrides", "OpponentHoldsplash", "OpponentHoldsplashPack", "Emote", "EmotePack", "Tag", "TagPack", "Banner", "BannerPack", "OpponentBanner", "OpponentBannerPack", "Icon", "IconPack", "OpponentIcon", "OpponentIconPack", "OwnedTags", "OwnedBanners", "OwnedEmotes", "OwnedIconPacks", "OwnedNoteskins", "OwnedAnimations", "OwnedNotesplashes", "OwnedHoldsplashes" } do
        v290[v] = nil;
    end;

    for _, v in u7 do
        v290[v] = nil;
    end;

    for _, v in u3 do
        v290[v] = nil;
    end;

    for _, v in u6 do
        v290[v] = nil;
    end;

    for _, v in u2 do
        v290[v] = nil;
    end;

    for _, v in u4 do
        v290[v] = nil;
    end;

    if not v291.exportKeybinds then
        v290.Keybinds = nil;
        v290.ConsoleKeybinds = nil;
    end;

    if not v291.exportJudgementImages then
        v290.JudgementImages = nil;
    end;

    if not v291.exportAnim then
        v290.UseProps = nil;
        v290.UseFaces = nil;
        v290.UseReqFaces = nil;
    end;

    if not v291.exportBots then
        v290.EmoteUserID = nil;
        v290.DuoEmoteUserID = nil;
        v290.TrioEmoteUserID = nil;
        v290.BotUserID = nil;
        v290.DuoUserID = nil;
        v290.TrioUserID = nil;
        v290.ExtraBotIDs = nil;
        v290.ExtraBotTypes = nil;
    end;

    HttpService:JSONEncode(v290);
end;

u8.DataTemplate = DataTemplate;
script_LeaderstatHandler.GiveDataManager(u8);

return u8;