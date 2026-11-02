-- Decompiled with Potassium's decompiler.

local v1 = {};
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EngineVersion = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Engine"):WaitForChild("EngineVersion"));
local Logger = require(ReplicatedStorage.Modules.Other.Logger);
local LocalPlayer = Players.LocalPlayer;
local u2 = {};

function v1.GetRank(p3: table, p4: userdata?, p5: number?, p6: boolean?) -- Line: 15
    -- upvalues: LocalPlayer (copy), u2 (copy), Logger (copy), RunService (copy)
    local u7 = p4 or LocalPlayer;
    local u8 = p5 or 17371285;

    if u2[u7] and (u2[u7][u8] and not p6) then
        Logger.log("Returning cached rank for " .. u7.Name .. " in group " .. u8);

        return u2[u7][u8];
    end;

    local u9 = nil;
    Logger.log("Fetching rank for " .. u7.Name .. " in group " .. u8 .. "...");
    pcall(function() -- Line: 27
        -- upvalues: u9 (ref), u7 (ref), u8 (ref)
        u9 = u7:GetRankInGroupAsync(u8);
    end);
    u9 = u9 or (RunService:IsStudio() and 255 or 0);

    if u2[u7] then
        u2[u7][u8] = u9;
    else
        u2[u7] = {
            [u8] = u9
        };
    end;

    Logger.log("Rank for " .. u7.Name .. " set to: " .. tostring(u9));

    return u9;
end;

v1.isIndev = EngineVersion.IsIndev();
v1.isStudio = EngineVersion.IsStudio();

if RunService:IsClient() and LocalPlayer then
    local Rank = v1:GetRank(LocalPlayer);
    v1.isADev = Rank >= 252;
    v1.isAContrib = Rank >= 200;
    v1.isACC = Rank == 150;
    Logger.log("Client initialized. Dev: " .. tostring(v1.isADev) .. " | Contrib: " .. tostring(v1.isAContrib));
end;

function v1.isDev(p10: table, p11: userdata?) -- Line: 89
    -- upvalues: LocalPlayer (copy), Logger (copy)
    local v12 = p11 or LocalPlayer;
    local v13 = p10:GetRank(v12) >= 252;
    Logger.log("isDev check for " .. (v12 and v12.Name or "Unknown") .. ": " .. tostring(v13));

    return v13;
end;

function v1.isContrib(p14: table, p15: userdata?) -- Line: 96
    -- upvalues: LocalPlayer (copy), Logger (copy)
    local v16 = p15 or LocalPlayer;
    local v17 = p14:GetRank(v16) >= 200;
    Logger.log("isContrib check for " .. (v16 and v16.Name or "Unknown") .. ": " .. tostring(v17));

    return v17;
end;

function v1.isCC(p18: table, p19: userdata?) -- Line: 103
    -- upvalues: LocalPlayer (copy), Logger (copy)
    local v20 = p19 or LocalPlayer;
    local v21 = p18:GetRank(v20) == 150;
    Logger.log("isCC check for " .. (v20 and v20.Name or "Unknown") .. ": " .. tostring(v21));

    return v21;
end;

function v1.isTester(p22: table, p23: userdata) -- Line: 110
    -- upvalues: LocalPlayer (copy), Logger (copy)
    local v24 = p23 or LocalPlayer;
    local v25 = p22:GetRank(v24) >= 190;
    Logger.log("isTester check for " .. (v24 and v24.Name or "Unknown") .. ": " .. tostring(v25));

    return v25;
end;

Players.PlayerRemoving:Connect(function(p26) -- Line: 117
    -- upvalues: u2 (copy), Logger (copy)
    if u2[p26] then
        Logger.log("Cleaning up cache for leaving player: " .. p26.Name);
        u2[p26] = nil;
    end;
end);

return v1;