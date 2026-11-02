-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Data = require(Modules.Data.DataManager):GetData();
local LocalSignals = require(Modules.Signals.LocalSignals);
local Logger = require(Modules.Other.Logger);
local u1 = {
    ModulesFolder = ReplicatedStorage:WaitForChild("Events"),
    stageRemote = nil,
    remoteListen = {},
    batchQueues = {},
    batchScheduled = {}
};

local function u3(p2) -- Line: 16
    -- upvalues: LocalSignals (copy), Logger (copy)
    LocalSignals.SendNotification:Fire({
        header = "[AFTERNIGHT NETWORKING ERROR]",
        contentHiddenByDefault = true,
        timeout = 10,
        content = p2,
        color = Color3.new(0.490196, 0.254902, 1)
    });
    Logger.warn(p2);
end;

local function handleRemote(p4, p5, ...) -- Line: 28
    -- upvalues: u1 (copy), u3 (copy), Data (copy)
    local v6 = u1.remoteListen[p5];

    if v6 then
        xpcall(v6, u3, ...);

        if Data.PrintIncomingSignals then
            print("RemoteHandler:", p4, p5, ...);
        end;
    end;
end;

ReplicatedStorage.Events.EngineControl.OnClientEvent:Connect(function(...) -- Line: 41
    -- upvalues: handleRemote (copy)
    handleRemote("EngineControl", ...);
end);
ReplicatedStorage.Events.InputControl.OnClientEvent:Connect(function(...) -- Line: 44
    -- upvalues: handleRemote (copy)
    handleRemote("InputControl", ...);
end);
ReplicatedStorage.Events.DataControl.OnClientEvent:Connect(function(...) -- Line: 47
    -- upvalues: handleRemote (copy)
    handleRemote("DataControl", ...);
end);
ReplicatedStorage.Events.ShowMessageOnChannel.OnClientEvent:Connect(function(p7: userdata, p8: string) -- Line: 50
    p7:DisplaySystemMessage(p8);
end);

function u1.readyServer(p9, ...) -- Line: 55
    -- upvalues: ReplicatedStorage (copy), Data (copy)
    ReplicatedStorage.Events.DataControl:FireServer(p9, ...);

    if Data.PrintOutgoingSignals then
        print("Ready Server:", p9, ...);
    end;
end;

function u1.listenTo(p10, p11) -- Line: 62
    -- upvalues: u1 (copy)
    u1.remoteListen[p10] = p11;
end;

function u1.fireServer(p12, ...) -- Line: 66
    -- upvalues: ReplicatedStorage (copy), Data (copy)
    ReplicatedStorage.Events.EngineControl:FireServer(p12, ...);

    if Data.PrintOutgoingSignals then
        print("Fired Server:", p12, ...);
    end;
end;

function u1.fireStageRemote(p13, ...) -- Line: 73
    -- upvalues: u1 (copy), Data (copy)
    if u1.stageRemote == nil then
        return;
    end;

    u1.stageRemote:FireServer(p13, ...);

    if Data.PrintOutgoingSignals then
        print("Fired Server [Stage Remote]:", p13, ...);
    end;
end;

function u1.fireStageRemoteBatched(u14, ...) -- Line: 84
    -- upvalues: u1 (copy)
    if u1.stageRemote == nil then
        return;
    end;

    local batchQueues = u1.batchQueues;
    local batchScheduled = u1.batchScheduled;
    batchQueues[u14] = batchQueues[u14] or {};
    table.insert(batchQueues[u14], { ... });

    if not batchScheduled[u14] then
        batchScheduled[u14] = true;
        task.defer(function() -- Line: 96
            -- upvalues: batchQueues (copy), u14 (copy), batchScheduled (copy), u1 (ref)
            local v15 = batchQueues[u14];
            batchQueues[u14] = nil;
            batchScheduled[u14] = nil;
            u1.fireStageRemote(u14 .. "Batch", v15);
        end);
    end;
end;

return u1;