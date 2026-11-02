-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local BadgeService = game:GetService("BadgeService");
local ServerStorage = game:GetService("ServerStorage");
local HttpService = game:GetService("HttpService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Events = ReplicatedStorage:WaitForChild("Events");
local Assets = ReplicatedStorage:WaitForChild("Assets");
local getRatingLetter = require(Modules.Main.Ratings).getRatingLetter;
local Logger = require(Modules.Other.Logger);

if RunService:IsClient() then
    warn("HELP HELP HELP HELP HELP HELP HELP YOU SHOULDN\'T REQUIRE THIS IN CLIENT");
end;

local u1 = {};
require(Modules.Main.AssetReplicator);
local DataManager = require(Modules.Data.DataManager);
local AssetIcons = require(Modules.UI.AssetIcons);
local Random_new_ret = Random.new();
local OnUnlock = Events:WaitForChild("Engine"):WaitForChild("OnUnlock");
local ServerRequest = Events.ServerRequests.ServerRequest;
local v2 = {
    Unknown = {},
    None = {},
    Quest = {},
    Badge = {},
    Match = {}
};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
u1.BadgeUnlocks = u3;
u1.UnlocksBy = v2;
u1.UnlocksByItem = u6;
u1.SortedMatchUnlocks = u4;
u1.AssetUnlocks = u5;
local u7 = {
    Animations = Assets:WaitForChild("Animations"),
    Banners = ServerStorage.ReplicableAssets.Banners,
    Emotes = Assets:WaitForChild("Emotes"),
    Holdsplashes = ServerStorage.ReplicableAssets.Holdsplashes,
    Icons = Assets:WaitForChild("Icons"),
    Noteskins = Assets:WaitForChild("Noteskins"),
    Notesplashes = Assets:WaitForChild("Notesplashes"),
    Tags = ServerStorage.ReplicableAssets.Tags
};

local function isAny(p8) -- Line: 184
    -- upvalues: isAny (copy)
    local v9 = not p8;

    if not v9 then
        if p8 == true or (p8 == "any" or (p8 == "Any" or p8 == "__any")) then
            v9 = true;
        elseif type(p8) == "table" then
            v9 = isAny(p8[1]);
        else
            v9 = false;
        end;
    end;

    return v9;
end;

local function getBadgeData(p10: number) -- Line: 113
    -- upvalues: HttpService (copy)
    local GetAsync = HttpService.GetAsync;
    local v11 = `https://badges.roproxy.com/v1/badges/{p10}`;
    local success, result = pcall(GetAsync, HttpService, v11);

    if success then
        local success2, result2 = pcall(HttpService.JSONDecode, HttpService, result);

        if success2 and result2 then
            return {
                Name = result2.name,
                UniverseInfo = {
                    Name = result2.awardingUniverse.name,
                    Id = result2.awardingUniverse.rootPlaceId
                },
                Image = `rbxassetid://{result2.displayIconImageId}`
            };
        end;
    end;
end;

local function getItem(p12: string, p13: string?, p14: string?) -- Line: 141
    -- upvalues: u7 (copy)
    if p13 == "" then
        p13 = nil;
    end;

    if p14 == "" then
        p14 = nil;
    end;

    local v15 = u7[p12];

    if not v15 then
        return nil;
    end;

    local v16 = v15:FindFirstChild(p14 or (p13 or ""));

    if v16 then
        if not ((not p14 or v16:GetAttribute("Pack")) and (p14 or not v16:GetAttribute("Pack"))) then
            return nil;
        end;

        if p14 and p13 then
            return v16:FindFirstChild(p13);
        end;

        return v16;
    end;
end;

local u17 = {
    Animations = "OwnedAnimations",
    Banners = "OwnedBanners",
    Emotes = "OwnedEmotes",
    Holdsplashes = "OwnedHoldsplashes",
    Icons = "OwnedIconPacks",
    Noteskins = "OwnedNoteskins",
    Notesplashes = "OwnedNotesplashes",
    Tags = "OwnedTags"
};
local u18 = {
    Animations = "PrevLockedAnimations",
    Banners = "PrevLockedBanners",
    Emotes = "PrevLockedEmotes",
    Holdsplashes = "PrevLockedHoldsplashes",
    Icons = "PrevLockedIconPacks",
    Noteskins = "PrevLockedNoteskins",
    Notesplashes = "PrevLockedNotesplashes",
    Tags = "PrevLockedTags"
};

for i, v in u7 do
    local v19 = {};
    u5[i] = v19;
    local v20 = i;

    for _, child in v:GetChildren() do
        local Metadata = child:FindFirstChild("Metadata");

        if Metadata then
            local success, result = pcall(function() -- Line: 196
                -- upvalues: Metadata (ref)
                Metadata = require(Metadata);
            end);

            if success then
                local Attribute = child:GetAttribute("Pack");
                local v21 = "Unknown";
                local UnlockCondition = Metadata.UnlockCondition;
                local v22 = {};

                if UnlockCondition == "DailyQuest" then
                    v21 = "Quest";
                elseif UnlockCondition == "Badge" or type(UnlockCondition) == "table" and UnlockCondition.BadgeId then
                    v21 = "Badge";
                    v22 = {
                        BadgeId = type(UnlockCondition) == "table" and UnlockCondition.BadgeId or (Metadata.BadgeId or nil)
                    };

                    if type(v22.BadgeId) ~= "number" then
                        v22.BadgeId = -1;
                    end;
                elseif type(UnlockCondition) == "table" and UnlockCondition.Mod ~= nil then
                    v21 = "Match";

                    if UnlockCondition.Accuracy == nil then
                        UnlockCondition.Accuracy = v20 == "Tags" and 80 or 70;
                    end;

                    if Metadata.Chance and not UnlockCondition.Chance then
                        UnlockCondition.Chance = Metadata.Chance;
                    end;

                    if UnlockCondition.Chance and type(UnlockCondition.Chance) ~= "number" then
                        UnlockCondition.Chance = nil;
                        v22 = UnlockCondition;
                    else
                        v22 = UnlockCondition;
                    end;
                elseif type(UnlockCondition) == "boolean" then
                    v21 = "None";
                end;

                if v21 or type(UnlockCondition) == "string" then
                    local v23 = {
                        Type = v20,
                        Name = child.Name,
                        IsPack = Attribute,
                        UnlockType = v21,
                        UnlockMeta = v22,
                        Chance = Metadata.Chance or nil
                    };

                    if Metadata.Tag then
                        v23.DisplayName = Metadata.Tag;
                    end;

                    table.insert(v19, v23);
                    table.insert(v2[v21], v23);
                    u6[child] = v23;

                    if v21 == "Match" then
                        local Mod = UnlockCondition.Mod;
                        local v24 = not Mod;

                        if not v24 then
                            if Mod == true or (Mod == "any" or (Mod == "Any" or Mod == "__any")) then
                                v24 = true;
                            elseif type(Mod) == "table" then
                                v24 = isAny(Mod[1]);
                            else
                                v24 = false;
                            end;
                        end;

                        local v25 = v24 and "__any" or UnlockCondition.Mod;

                        if type(v25) == "string" then
                            UnlockCondition.Mod = v25;
                            v25 = { v25 };
                        end;

                        for _, v3 in v25 do
                            local v26 = u4[v3] or {};
                            u4[v3] = v26;
                            local Song = UnlockCondition.Song;
                            local v27 = not Song;

                            if not v27 then
                                if Song == true or (Song == "any" or (Song == "Any" or Song == "__any")) then
                                    v27 = true;
                                elseif type(Song) == "table" then
                                    v27 = isAny(Song[1]);
                                else
                                    v27 = false;
                                end;
                            end;

                            local v28 = v27 and "__any" or UnlockCondition.Song;

                            if type(v28) == "string" then
                                UnlockCondition.Song = v28;
                                v28 = { v28 };
                            end;

                            for _, v4 in v28 do
                                local v29 = v26[v4] or {};
                                v26[v4] = v29;
                                local Difficulty = UnlockCondition.Difficulty;
                                local v30 = not Difficulty;

                                if not v30 then
                                    if Difficulty == true or (Difficulty == "any" or (Difficulty == "Any" or Difficulty == "__any")) then
                                        v30 = true;
                                    elseif type(Difficulty) == "table" then
                                        v30 = isAny(Difficulty[1]);
                                    else
                                        v30 = false;
                                    end;
                                end;

                                local v31 = v30 and "__any" or UnlockCondition.Difficulty;

                                if type(v31) == "string" then
                                    UnlockCondition.Difficulty = v31;
                                    v31 = { v31 };
                                end;

                                for _, v5 in v31 do
                                    local v32 = v29[v5] or {};
                                    v29[v5] = v32;
                                    table.insert(v32, v23);
                                end;
                            end;
                        end;
                    elseif v21 == "Badge" and v22.BadgeId > -1 then
                        v22.BadgeInfo = getBadgeData(v22.BadgeId);
                        local v33 = u3[v22.BadgeId] or {};
                        u3[v22.BadgeId] = v33;
                        table.insert(v33, v23);
                    elseif v21 == "None" then
                        v23.Silent = true;
                    end;
                else
                    warn((`[UnlocksManager] Unknown unlock type for {v20}/{child.Name}: {UnlockCondition}`));
                end;
            else
                warn(result, Metadata);
            end;
        end;
    end;
end;

function u1.getMatchUnlocks(p34: table, p35: string, p36: string, p37: string) -- Line: 316
    -- upvalues: u4 (copy)
    local v38 = (p36 == "__any" or not p36) and "" or p36;
    local v39 = (p37 == "__any" or not p37) and "" or p37;
    local v40 = {};

    for _, v in { u4[(p35 == "__any" or not p35) and "" or p35], u4.__any } do
        for _, v3 in { v[v38], v.__any } do
            for _, v4 in { v3[v39], v3.__any } do
                table.move(v4, 1, #v4, #v40 + 1, v40);
            end;
        end;
    end;

    return v40;
end;

function u1.getMissingUnlocks(p41: table, p42: userdata, p43: userdata) -- Line: 334
end;

function u1.onMatchFinish(p44: table, p45: table, p46: table) -- Line: 338
    -- upvalues: u1 (copy), getRatingLetter (copy), Random_new_ret (copy)
    if not (p45.GimmicksEnabled and (p45.ModchartsEnabled and p45.Rate >= 1)) then
        return;
    end;

    local MatchUnlocks = p44:getMatchUnlocks(p45.Mod, p45.Song, p45.Difficulty);
    local v47 = u1:seperateStatsFromSides(p46);

    for _, v in p46 do
        local v48 = v[1];
        local v49 = v[2];

        if v48 and (v49 and not v49.Failed) then
            local v50 = {};

            for _, v3 in u1:getQuestsForPlayer(v48) do
                if v3.Type == 1 then
                    if v3.Data.Mod == p45.Mod and v3.Data.Song == p45.Song then
                        u1:onQuestComplete(v48, v3, v50);
                    end;
                elseif v3.Type == 3 then
                    if #v47.L >= 1 and #v47.R >= 1 then
                        u1:onQuestComplete(v48, v3, v50);
                    end;
                elseif v3.Type == 2 then
                    if #v47.L >= 2 and #v47.R >= 2 then
                        u1:onQuestComplete(v48, v3, v50);
                    end;
                elseif v3.Type == 4 then
                    local Mod = v3.Data.Mod;
                    local Song = v3.Data.Song;

                    if table.find({ "C", "B", "A", "S", "P" }, getRatingLetter(v49.Accuracy)) and (Mod == p45.Mod and Song == p45.Song) then
                        u1:onQuestComplete(v48, v3, v50);
                    end;
                elseif v3.Type == 5 and v3.Data.Mod == p45.Mod then
                    u1:onQuestComplete(v48, v3, v50);
                end;
            end;

            for _, v3 in MatchUnlocks do
                local Chance = v3.Chance;

                if (not Chance or Random_new_ret:NextNumber(1, Chance) == 1) and (v3.UnlockMeta.Accuracy or 70) <= v49.Accuracy then
                    table.insert(v50, v3);
                end;
            end;

            p44:bulkUnlock(v50, v48);
        end;
    end;
end;

function u1.bulkUnlock(p51: table, p52: table, p53: userdata) -- Line: 414
    -- upvalues: DataManager (copy), u17 (copy), AssetIcons (copy), OnUnlock (copy)
    if not (p52 and next(p52)) then
        return;
    end;

    local Profile = DataManager:GetProfile(p53);

    if not (Profile and Profile.Data) then
        return;
    end;

    local v54 = {};

    for _, v in p52 do
        local v55 = Profile.Data[u17[v.Type] or "Owned" .. v.Type];

        if v55 and not table.find(v55, v.Name) then
            table.insert(v55, v.Name);
            local v56;

            if v.Silent then
                v56 = v;
            else
                local v57 = AssetIcons:format(v.Type, v.IsPack and {
                    pack = v.Name
                } or {
                    name = v.Name
                });

                if v57 then
                    v56 = table.clone(v);
                    v56.Icon = v57;
                else
                    v56 = v;
                end;
            end;

            table.insert(v54, v56);
        end;
    end;

    if next(v54) then
        OnUnlock:FireClient(p53, v54);
    end;
end;

function u1.doUnlock(p58: table, p59: table, p60: userdata?) -- Line: 442
    p58:bulkUnlock({ p59 }, p60);
end;

function u1.doTestUnlock(p61, u62) -- Line: 447
    -- upvalues: u5 (copy), AssetIcons (copy), OnUnlock (copy)
    local v63 = u5.Animations[1];
    local v64 = v63 and AssetIcons:format(v63.Type, {
        name = v63.Name
    });

    if v64 then
        local table_clone_ret = table.clone(v63);
        table_clone_ret.Icon = v64;
        OnUnlock:FireClient(u62, { table_clone_ret });
    end;

    task.delay(4, function() -- Line: 459
        -- upvalues: u5 (ref), AssetIcons (ref), OnUnlock (ref), u62 (copy)
        local v65 = u5.Banners[1];
        local v66 = v65 and AssetIcons:format(v65.Type, {
            name = v65.Name
        });

        if v66 then
            local table_clone_ret = table.clone(v65);
            table_clone_ret.Icon = v66;
            OnUnlock:FireClient(u62, { table_clone_ret });
        end;
    end);
end;

function u1.seperateStatsFromSides(p67: table, p68: table) -- Line: 473
    local v69 = {
        L = {},
        R = {}
    };

    for _, v in p68 do
        local v70 = v[2];

        if v[1] and v70 then
            if v70.Side == "L" then
                table.insert(v69.L, v);
            else
                table.insert(v69.R, v);
            end;
        end;
    end;

    return v69;
end;

function u1.getQuestsForPlayer(p71: table, p72: userdata) -- Line: 497
    -- upvalues: DataManager (copy)
    local Data = DataManager:GetProfile(p72).Data;

    if not Data then
        return {};
    end;

    local DailyQuestData = Data.DailyQuestData;

    return #DailyQuestData.Quests == 0 and {} or tableFilter(table.clone(DailyQuestData.Quests), function(p73, p74) -- Line: 504
        return p73.Completed == false;
    end);
end;

function tableFilter(p75, p76)
    local v77 = {};

    for i, v in ipairs(p75) do
        if p76(v, i) then
            table.insert(v77, v);
        end;
    end;

    return v77;
end;

function calculateTotalCompleted(p78)
    return #p78.Quests == 0 and 0 or #tableFilter(table.clone(p78.Quests), function(p79, p80) -- Line: 521
        return p79.Completed == true;
    end);
end;

function u1.onQuestComplete(p81: table, p82: userdata, p83: table, p84: table) -- Line: 524
    -- upvalues: DataManager (copy)
    local Data = DataManager:GetProfile(p82).Data;

    if not Data then
        return;
    end;

    local DailyQuestData = Data.DailyQuestData;
    DailyQuestData.Quests[p83.ID].Completed = true;
    p83.Completed = true;
    DailyQuestData.TotalQuests = calculateTotalCompleted(DailyQuestData);
    DataManager:SetData(p82, "DailyQuestData", DailyQuestData);

    if p83.Reward and p84 then
        table.insert(p84, p83.Reward);
    end;
end;

function u1.onPlrJoined(u85: table, u86: userdata) -- Line: 540
    -- upvalues: DataManager (copy), u18 (copy), u17 (copy), getItem (copy), u6 (copy), Logger (copy)
    local Profile = DataManager:GetProfile(u86);

    if Profile and Profile.Data then
        for i, v in u18 do
            local v87 = u17[i] or "Owned" .. i;
            local v88 = Profile.Data[v];
            local v89 = Profile.Data[v87];

            if v88 and v89 then
                local v90 = v;
                local v91 = i;
                local v92 = false;

                for i2 = #v88, 1, -1 do
                    local v93 = v88[i2];
                    local v94 = getItem(v91, nil, v93);
                    local v95 = u6[v94 or -1];
                    local v96;

                    if v95 and v95.UnlockType ~= "None" then
                        Logger.log("THIS SHOULD BE RELOCKED:", v94.Name);
                        table.remove(v88, i2);
                        local table_find_ret = table.find(v89, v93);

                        if table_find_ret then
                            table.remove(v89, table_find_ret);
                        end;

                        v96 = i2;
                        v92 = true;
                    else
                        v96 = i2;
                    end;
                end;

                if v92 then
                    DataManager:SetData(u86, v90, v88);
                    DataManager:SetData(u86, v87, v89);
                end;
            end;
        end;
    end;

    task.delay(5, function() -- Line: 578
        -- upvalues: u85 (copy), u86 (copy)
        u85:checkForBadges(u86);
    end);
end;

function u1.checkForBadges(p97: table, u98: userdata?) -- Line: 583
    -- upvalues: BadgeService (copy), u3 (copy)
    local u99 = {};
    local u100 = {};

    local function doRequest() -- Line: 587
        -- upvalues: BadgeService (ref), u98 (copy), u100 (copy), u99 (copy)
        local success, result = pcall(function() -- Line: 588
            -- upvalues: BadgeService (ref), u98 (ref), u100 (ref)
            return BadgeService:CheckUserBadgesAsync(u98.UserId, u100);
        end);

        if success then
            if #result > 0 then
                table.move(result, 1, #result, #u99 + 1, u99);
            end;

            return;
        end;

        warn("Error while checking if player", u98.Name, "has badges:", result);
    end;

    for i, _ in u3 do
        if #u100 == 10 then
            doRequest();
            table.clear(u100);
        end;

        table.insert(u100, i);
    end;

    doRequest();
    local v101 = {};

    for _, v in u99 do
        for _, v3 in u3[v] do
            table.insert(v101, v3);
        end;
    end;

    p97:bulkUnlock(v101, u98);
end;

function u1.onBadgeAwarded(p102: table, p103: number, p104: userdata) -- Line: 624
    -- upvalues: u3 (copy)
    if not (p103 and (p104 and u3[p103])) then
        return;
    end;

    local v105 = {};

    for _, v in u3[p103] do
        table.insert(v105, v);
    end;

    p102:bulkUnlock(v105, p104);
end;

function u1.checkOwned(p106, p107) -- Line: 636
    -- upvalues: Logger (copy), DataManager (copy)
    local v108 = { "OwnedAnimations", "OwnedEmotes", "OwnedNoteskins", "OwnedIconPacks" };
    local v109 = { "BF", "GF", "Friday Night Funkin\'", "BF" };
    local v110 = { nil, nil, nil, "Friday Night Funkin\'" };

    for i, v in { "Animation", "Emote", "Noteskin", "Icon" } do
        local v111 = p107[v];
        local v112 = p107[v108[i]];

        if not ((v ~= "Icon" or table.find(v112, p107[v .. "Pack"])) and table.find(v112, v111) or (v ~= "Icon" or table.find(v112, p107[v .. "Pack"]))) then
            Logger.log("Player does not own", v, v111 .. ", resetting to default.");
            p107[v] = v109[i];
            p107[v .. "Pack"] = v110[i];
            DataManager:SetData(v, v109[i]);
            DataManager:SetData(v .. "Pack", v110[i]);
        end;
    end;
end;

OnUnlock.OnServerEvent:Connect(function(p113: userdata, p114: string, p115: table) -- Line: 660
    -- upvalues: getItem (copy), DataManager (copy), u6 (copy), u17 (copy), u18 (copy), u1 (copy)
    if type(p114) ~= "string" or type(p115) ~= "table" then
        return;
    end;

    local v116 = getItem(p114, p115.name, p115.pack);

    if not v116 then
        return;
    end;

    local Profile = DataManager:GetProfile(p113);

    if not (Profile and Profile.Data) then
        return;
    end;

    local v117 = u6[v116];

    if v117 and v117.UnlockType == "None" then
        local v118 = Profile.Data[u17[v117.Type] or "Owned" .. v117.Type];

        if not v118 or table.find(v118, v117.Name) then
            return;
        end;

        table.insert(v118, v117.Name);
        local v119 = Profile.Data[u18[v117.Type] or "PrevLocked" .. v117.Type];

        if v119 then
            table.insert(v119, v117.Name);
        end;

        u1:doUnlock(v117, p113);
    end;
end);
local PlayerRanks = require(Modules.Other.PlayerRanks);
ServerRequest.OnServerEvent:Connect(function(p120: userdata, p121: string, ...) -- Line: 689
    -- upvalues: PlayerRanks (copy), u1 (copy)
    local v122 = { ... };
    local v123 = PlayerRanks:isDev(p120);

    if p121 == "GimmeUnlockVro" then
        if not v123 then
            p120:Kick("Anticheat: 403\nUnauthorized");
        end;

        local v124 = v122[1];
        local v125 = v122[2];
        u1:doUnlock({
            Silent = false,
            ForcedUnlock = true,
            UnlockType = v124.type,
            UnlockMeta = v124.meta,
            Type = v125.Type,
            Name = v125.Name,
            IsPack = v125.IsPack
        }, p120);
    end;
end);

return u1;