-- Decompiled with Potassium's decompiler.

repeat
    task.wait();
until game:IsLoaded();

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("TextChatService");
local LocalPlayer = Players.LocalPlayer;
local Modules = ReplicatedStorage:WaitForChild("Modules");
local v1 = {
    DataManager = require(Modules.Data.DataManager),
    LocalSignals = require(Modules.Signals.LocalSignals),
    PlayerRanks = require(Modules.Other.PlayerRanks)
};
local Data = v1.DataManager:GetData();

for _, v in {
    {
        require("@self/Modules/Sprinting"),
        multiThreaded = true,
        args = {
            LocalPlayer,
            Modules,
            v1,
            Data
        }
    },
    {
        require("@self/Modules/ChatHandler"),
        multiThreaded = false,
        args = { Modules, Data }
    },
    {
        require("@self/Modules/RobloxEvents"),
        multiThreaded = true,
        args = {}
    }
} do
    local function load() -- Line: 25
        -- upvalues: v (copy)
        xpcall(function() -- Line: 26
            -- upvalues: v (ref)
            v[1](unpack(v.args));
        end, function(p2) -- Line: 28
            warn((`[Player Module Error]: {p2}\n{debug.traceback()}`));
        end);
    end;

    if v.multiThreaded then
        task.spawn(load);
    else
        xpcall(function() -- Line: 26
            -- upvalues: v (copy)
            v[1](unpack(v.args));
        end, function(p3) -- Line: 28
            warn((`[Player Module Error]: {p3}\n{debug.traceback()}`));
        end);
    end;
end;