-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local Modules = ReplicatedStorage:WaitForChild("Modules");
local u1 = {
    DataManager = require(Modules.Data.DataManager),
    StageZoneHandler = require(Modules.Other.StageZones),
    NetworkFunctions = require(Modules.Engine.NetworkFunctions),
    LocalSignals = require(Modules.Signals.LocalSignals)
};
local Data = u1.DataManager:GetData();

for _, v in {
    {
        require("@self/Modules/WorldOptimization"),
        multiThreaded = true,
        args = { Modules, Data }
    }
} do
    local function load() -- Line: 20
        -- upvalues: v (copy)
        xpcall(function() -- Line: 21
            -- upvalues: v (ref)
            v[1](unpack(v.args));
        end, function(p2) -- Line: 23
            warn((`[World Module Error]: {p2}\n{debug.traceback()}`));
        end);
    end;

    if v.multiThreaded then
        task.spawn(load);
    else
        xpcall(function() -- Line: 21
            -- upvalues: v (copy)
            v[1](unpack(v.args));
        end, function(p3) -- Line: 23
            warn((`[World Module Error]: {p3}\n{debug.traceback()}`));
        end);
    end;
end;

local u4 = {};

function getStageByID(p5: string)
    -- upvalues: u4 (copy)
    if u4[p5] then
        return u4[p5];
    end;

    for _, child in workspace.Stages:GetChildren() do
        if child:IsA("Model") and child:GetAttribute("ID") == p5 then
            return child;
        end;
    end;

    return nil;
end;

u1.LocalSignals.ClientLoaded:Once(function() -- Line: 51
    -- upvalues: u1 (copy), u4 (copy)
    u1.NetworkFunctions.readyServer("ClientLoaded");

    for _, child in workspace.Stages:GetChildren() do
        if child:IsA("Model") then
            u4[child:GetAttribute("ID")] = child;
        end;
    end;
end);
u1.NetworkFunctions.listenTo("StageSetSongInfo", function(p6: string, p7: string, p8: boolean) -- Line: 61
    -- upvalues: u1 (copy)
    if not p7 then
        return;
    end;

    if not p6 then
        return;
    end;

    local v9 = getStageByID(p6);

    if not v9 then
        return;
    end;

    v9.Internals.Hologram.Front.Background.Stats.Song.Text = p7;
    local StageData = u1.StageZoneHandler:getStageData(v9);

    if not StageData then
        return;
    end;

    local Gameplay = StageData.soundPart:WaitForChild("StageAudio"):WaitForChild("Gameplay");

    if not p8 then
        for _, descendant in Gameplay:GetDescendants() do
            if descendant:IsA("Sound") then
                descendant.SoundId = "rbxassetid://0";
            elseif descendant:IsA("AudioPlayer") then
                descendant.AudioContent = Content.none;
            end;
        end;
    end;
end);
local Stages = workspace:WaitForChild("Stages");

local function processStage(p10) -- Line: 88
    -- upvalues: u1 (copy)
    if p10:IsA("Model") or p10:GetAttribute("Stage") then
        u1.StageZoneHandler:addStage(p10);
    end;
end;

for _, child in Stages:GetChildren() do
    if child:IsA("Model") or child:GetAttribute("Stage") then
        u1.StageZoneHandler:addStage(child);
    end;
end;

Stages.ChildAdded:Connect(processStage);
u1.StageZoneHandler:setUpdateState(true);