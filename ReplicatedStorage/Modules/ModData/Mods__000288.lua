-- Decompiled with Potassium's decompiler.

if not game:GetService("RunService"):IsRunning() then
    return error("This module is not meant to run on studio outside of playtest");
end;

local u1 = nil;
local u2 = nil;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local ServerStorage = game:GetService("ServerStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
game:GetService("HttpService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Difficulties = require(Modules.ModData.Difficulties);
local PlayerRanks = require(Modules.Other.PlayerRanks);
local Logger = require(Modules.Other.Logger);
RunService:IsStudio();
local v3 = RunService:IsClient();
local _ = game.PlaceId == 13042469490;
local u4 = not v3 and ServerStorage.ServerConfig:GetAttribute("ClosedIndev");
local u5 = not v3 and ServerStorage.ServerConfig:GetAttribute("PublicIndev");
local DifficultyOrder = Difficulties.DifficultyOrder;
local Scale = Difficulties.Scale;
local DifficultyData = Difficulties.DifficultyData;
local Effects = Difficulties.Effects;
local table_insert = table.insert;
local table_sort = table.sort;
local table_find = table.find;

for _, v in CollectionService:GetTagged("InstanceReference") do
    if v:IsA("ObjectValue") and v.Value then
        local v6 = v.Value:Clone();
        v6.Name = v.Name;
        v6.Parent = v.Parent;
        v:Destroy();
    end;
end;

function canUserUseMod(p7: userdata?, p8: userdata)
    -- upvalues: PlayerRanks (copy), u5 (copy), u4 (copy)
    if not p8 then
        return false;
    end;

    local v9 = p7 and (PlayerRanks:GetRank(p7) or 0) or 0;
    local Attribute = p8:GetAttribute("Indev");
    local Attribute2 = p8:GetAttribute("New");
    local Attribute3 = p8:GetAttribute("Dev");
    local Attribute4 = p8:GetAttribute("Contributor");
    local Attribute5 = p8:GetAttribute("Tester");
    local v10;

    if Attribute or u5 and Attribute2 then
        if v9 >= 252 then
            v10 = true;
        else
            v10 = not (u4 or u5);

            if v10 then
                if game.PlaceId == 13042469490 then
                    v10 = v9 >= 190;
                else
                    v10 = false;
                end;
            end;
        end;
    elseif Attribute3 then
        v10 = v9 >= 252;
    elseif Attribute4 then
        v10 = v9 >= 200;
    else
        v10 = not Attribute5 and true or v9 >= 190;
    end;

    if p8:GetAttribute("Hidden") then
        v10 = false;
    end;

    if p7 then
        local Attribute6 = p8:GetAttribute("AllowedIds");

        if Attribute6 and not v10 then
            local v11 = Attribute6:split(",");
            v10 = table.find(v11, (tostring(p7.UserId))) and true or false;
        end;
    end;

    return v10;
end;

local u12 = nil;

function getUserAllowedMods(p13: userdata?)
    -- upvalues: u12 (ref), u2 (ref), u1 (ref), table_insert (copy)
    if p13 == nil and u12 then
        return u12;
    end;

    local v14 = {};

    for _, v in u2 do
        if canUserUseMod(p13, u1[v].ModFile) then
            table_insert(v14, v);
        end;
    end;

    if p13 == nil and not u12 then
        u12 = v14;
    end;

    return v14;
end;

local u15 = {
    New = {
        Text = "NEW",
        OnlyOnMods = false,
        Color = Color3.new(0.133333, 1, 0)
    },
    Updated = {
        Text = "UPDATED",
        OnlyOnMods = false,
        Color = Color3.new(1, 0.933333, 0)
    },
    Indev = {
        Text = "INDEV",
        OnlyOnMods = true,
        Color = Color3.new(0, 0.65098, 1)
    },
    Collab = {
        Text = "COLLAB",
        OnlyOnMods = false,
        Color = Color3.new(0.501961, 0.203922, 0.921569)
    },
    Dev = {
        Text = "DEV",
        OnlyOnMods = true,
        Color = Color3.new(1, 0, 0)
    },
    Improved = {
        Text = "IMPROV",
        OnlyOnMods = false,
        Color = Color3.new(1, 0.701961, 0)
    }
};
local u16 = { "Dev", "Indev", "Collab", "Improved", "New", "Updated" };

function applyPrefix(p17, p18)
    -- upvalues: u16 (copy), u15 (copy)
    local v19 = "";

    for _, v in u16 do
        local v20 = u15[v];

        if v20 ~= nil and (not v20.OnlyOnMods or p18) and p17[v] then
            v19 = v19 .. `<font color="#{v20.Color:ToHex()}">{v20.Text}</font>`;
        end;
    end;

    return v19;
end;

local u21 = { "Stream", "Jumpstream", "Handstream", "Stamina", "Jack", "Chordjack", "Technical", "LN Coordination", "LN Density", "LN Release" };

local function decodeSkillsets(p22: string?) -- Line: 166
    -- upvalues: u21 (copy)
    local v23 = {};

    if not p22 or p22 == "" then
        return v23;
    end;

    local v24 = p22:split(",");

    for i, v in u21 do
        v23[v] = tonumber(v24[i]) or 0;
    end;

    return v23;
end;

function decodeCachedDifficulty(p25: string?)
    -- upvalues: decodeSkillsets (copy)
    if not p25 or p25 == "" then
        return {
            L = {},
            R = {}
        };
    end;

    local table_unpack_ret, v26 = table.unpack(p25:split(";"));

    return {
        L = decodeSkillsets(table_unpack_ret),
        R = decodeSkillsets(v26)
    };
end;

local v63, v64 = (function() -- Line: 187
    -- upvalues: ServerStorage (copy), DifficultyOrder (copy), table_insert (copy), table_sort (copy), table_find (copy), Logger (copy)
    local Children = ServerStorage.Assets:WaitForChild("Mods"):GetChildren();
    local v27 = tick();
    local v28 = {};
    local v29 = {
        Dev = {},
        Mods = {},
        Collab = {}
    };
    local v30 = {};

    for _, v in Children do
        local Songs = v:FindFirstChild("Songs");

        if Songs then
            local Attributes = v:GetAttributes();
            local v31 = Attributes.ShowOrder and (Attributes.ShowOrder or -1) or -1;
            local v32 = {};
            local v33 = {};
            local v34 = {
                Prefix = "",
                Aliases = Attributes.Nickname or Attributes.Alias or (Attributes.Nicknames or Attributes.Aliases),
                ModFile = v,
                SongData = {}
            };
            local u35;

            if v34.Aliases then
                local string_split_ret = string.split(v34.Aliases, ",");
                u35 = v;

                for i, v2 in string_split_ret do
                    string_split_ret[i] = v2:match("^%s*(.-)%s*$") or "";
                end;

                v34.Aliases = table.concat(string_split_ret, "|");
            else
                u35 = v;
            end;

            local Events = u35:FindFirstChild("Events");
            local Modchart = u35:FindFirstChild("Modchart");
            local NoteGroup = u35:FindFirstChild("NoteGroup");

            for _, child in Songs:GetChildren() do
                if child:IsA("Folder") then
                    local v36 = {};
                    local Name = child.Name;
                    local Attributes2 = child:GetAttributes();
                    local v37 = applyPrefix(Attributes2, false);
                    local v38 = Attributes2.DisplayName or Name;
                    local Difficulties2 = child:FindFirstChild("Difficulties");

                    if Difficulties2 then
                        local isCopyrighted = Attributes2.isCopyrighted;
                        local v39 = Events or child:FindFirstChild("Events");
                        local v40 = Modchart or child:FindFirstChild("Modchart");
                        local v41 = NoteGroup or child:FindFirstChild("NoteGroup");

                        for _, child2 in Difficulties2:GetChildren() do
                            if child2:IsA("ModuleScript") or child2:IsA("NumberValue") then
                                local Attributes3 = child2:GetAttributes();
                                local v42 = v39 and true or (child2:FindFirstChild("Events") and true or false);
                                local v43 = v40 and true or (child2:FindFirstChild("Modchart") and true or false);
                                local v44 = v41 and true or (child2:FindFirstChild("NoteGroup") and true or false);
                                local v45 = Attributes3._VSliceDiffs and true or false;

                                if v45 then
                                    child2:SetAttribute("_OGName", child2.Name);
                                end;

                                local v46 = child2;

                                for _, v2 in v45 and string.split(Attributes3._VSliceDiffs, "|") or { child2.Name } do
                                    if table.find(DifficultyOrder, v2) then
                                        if v45 then
                                            local v47 = v46:Clone();
                                            v47.Name = v2;
                                            v47.Parent = Difficulties2;
                                        end;

                                        local v48 = {};
                                        local v49 = v2:gsub(" ", "_");
                                        local v50 = Attributes3[`_CachedInfo_{v49}`] or Attributes3._CachedInfo;
                                        local v51 = Attributes3[`_CachedDifficulty_{v49}`] or Attributes3._CachedDifficulty;
                                        local v52 = Attributes3[`_CachedAudio_{v49}`] or Attributes3._CachedAudio;

                                        if v50 then
                                            local string_split_ret = string.split(v50, "|");
                                            v48.Keycount = tonumber(string_split_ret[1]) or 4;
                                            v48.BPM = tonumber(string_split_ret[2]) or 0;
                                            v48.Rating = {
                                                L = tonumber(string_split_ret[3]) or 0,
                                                R = tonumber(string_split_ret[4]) or 0
                                            };
                                            v48.HasEvents = v42 or tonumber(string_split_ret[5]) == 1;
                                            v48.AudioLength = v52 and (tonumber(v52) > 0 and tonumber(v52)) or nil;
                                        else
                                            v48.Keycount = 4;
                                            v48.BPM = 0;
                                            v48.Rating = {
                                                L = 0,
                                                R = 0
                                            };
                                            v48.HasEvents = v42;
                                            v48.AudioLength = nil;
                                            v48.IsNotCached = true;
                                        end;

                                        v48.Skillsets = decodeCachedDifficulty(v51);
                                        v48.HasGimmicks = v44;
                                        v48.HasModchart = v43;
                                        v48.Original = Attributes3.Original;
                                        v48.HideMultiplayer = Attributes3.HideMultiplayer;
                                        v48.HideSingleplayer = Attributes3.HideSingleplayer;
                                        local isCopyrighted2 = Attributes3.isCopyrighted;

                                        if isCopyrighted2 == nil then
                                            v48.HasCopyright = isCopyrighted;
                                        else
                                            v48.HasCopyright = isCopyrighted2;
                                        end;

                                        v36[v2] = v48;
                                    end;
                                end;

                                if v45 then
                                    v46:Destroy();
                                end;

                                v34.SongData[Name] = {
                                    DiffData = v36,
                                    Prefix = v37,
                                    DisplayName = v38
                                };
                                table_insert(v33, Name);
                            end;
                        end;
                    else
                        warn("[Mods] Song", child.Name, "from", u35.Name, "does not have difficulties! Skipping...");
                    end;
                end;
            end;

            local u53 = nil;
            pcall(function() -- Line: 350
                -- upvalues: u53 (ref), u35 (copy)
                u53 = u35:FindFirstChild("Metadata") and require(u35.Metadata) or nil;
            end);
            table_sort(v33, function(p54, p55) -- Line: 362
                return p54:lower() < p55:lower();
            end);

            if u53 then
                for i, v2 in u53 do
                    if v34[i] then
                        warn("CONFLICT OF INDEXES!", u35.Name, i);
                    else
                        v34[i] = v2;
                    end;
                end;

                if u53.Weeks then
                    for i = 1, #u53.Weeks do
                        local v56 = u53.Weeks[i];
                        local v57;

                        if v56 and v56.Songs then
                            v57 = i;

                            for _, v2 in v56.Songs do
                                table_insert(v32, v2);
                            end;
                        else
                            v57 = i;
                        end;
                    end;

                    for _, v2 in v33 do
                        if not table_find(v32, v2) then
                            table_insert(v32, v2);
                        end;
                    end;
                else
                    v32 = v33;
                end;
            end;

            v34.SongOrder = v32;
            local v58 = false;
            v34.Prefix = v34.Prefix .. applyPrefix(Attributes, true);

            if v31 == -1 then
                if Attributes.Collab then
                    table_insert(v29.Collab, u35.Name);
                    v58 = true;
                end;

                if Attributes.Dev then
                    table_insert(v29.Dev, u35.Name);
                    v58 = true;
                end;
            else
                table_insert(v28, u35.Name);
                v58 = true;
            end;

            v30[u35.Name] = v34;

            if not v58 then
                table_insert(v29.Mods, u35.Name);
            end;
        end;
    end;

    for _, v in v29 do
        table.sort(v, function(p59, p60) -- Line: 424
            return p59:lower() < p60:lower();
        end);
    end;

    local v61 = {};

    for _, v in {
        v28,
        v29.Dev,
        v29.Collab,
        v29.Mods
    } do
        table.move(v, 1, #v, #v61 + 1, v61);
    end;

    local log = Logger.log;
    local v62 = tick() - v27;
    log((`Took {math.abs(v62)} seconds to load mods.`));

    return v30, v61;
end)();
u1 = v63;
u2 = v64;

return {
    ModData = u1,
    ModOrder = u2,
    DifficultyScale = Scale,
    DifficultyData = DifficultyData,
    DifficultyOrder = DifficultyOrder,
    DifficultyEffects = Effects,
    canUserUseMod = canUserUseMod,
    getUserAllowedMods = getUserAllowedMods
};