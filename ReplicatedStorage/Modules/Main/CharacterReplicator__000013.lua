-- Decompiled with Potassium's decompiler.

if game:GetService("RunService"):IsClient() then
    repeat
        task.wait();
    until game:IsLoaded();
end;

local u1 = {
    ReplicationEnabled = true,
    SupportEmotes = true
};

if workspace:GetAttribute("_DebugSetReplicator") ~= nil and game:GetService("RunService"):IsStudio() then
    u1.ReplicationEnabled = workspace:GetAttribute("_DebugSetReplicator");
end;

if game:GetService("RunService"):IsServer() then
    workspace:SetAttribute("ReplicationEnabled", u1.ReplicationEnabled);
end;

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Assets = ReplicatedStorage:WaitForChild("Assets");
local Events = ReplicatedStorage:WaitForChild("Events");
local Character = require(Modules.Main.Character);
local u2 = u1.SupportEmotes and require(script.EmoteSupport) or nil;
local CharacterReplication = Events.CharacterReplication;
local StageAnimReplication = Events.StageAnimReplication;
local Emotes = Assets:WaitForChild("Emotes");
local Animations = Assets:WaitForChild("Animations");
local Logger = require(Modules.Other.Logger);
local u3 = {
    ManualPlay = true
};
local u9 = {
    ManualPlay = function(p4, p5, p6, p7, p8) -- Line: 42
        -- upvalues: StageAnimReplication (copy)
        if p6.isStage then
            StageAnimReplication:FireClient(p5, p4.owner, p7, p8);

            return;
        end;

        p6.remote:FireClient(p5, "Play", p7, p8, false);
    end
};
local u10 = {
    loadCharacters = true,
    loadExtCharacters = true,
    loadExtHugeRigs = false,
    loadStageCharacters = true,
    hugeAnimReplacement = Animations:WaitForChild("BF")
};

function getAnimInstanceFromString(p11, p12)
    -- upvalues: Emotes (copy), Animations (copy)
    return (p12 and Emotes or Animations):FindFirstChild(p11);
end;

function cleanAnimForReplication(p13, p14)
    for _, child in p13:GetChildren() do
        if child.Name:sub(1, #p14) ~= p14 and child.Name ~= "Assets" then
            child:Destroy();
        end;
    end;

    return p13;
end;

function writePropsAndStuffFromAnim(p15, p16)
    local propData = p15.propData;
    local v17 = p16:FindFirstChild(propData.animSide or propData.side);
    local Attributes = p16:GetAttributes();

    if v17 then
        for i, v in v17:GetAttributes() do
            Attributes[i] = v;
        end;
    end;

    p15.sideAttributes = Attributes;
end;

if game:GetService("RunService"):IsServer() then
    local u18 = {};
    local u19 = {};
    local u20 = {};
    local u21 = {};

    function replicateToClient(p22: userdata, p23: any)
        -- upvalues: ReplicatedStorage (copy)
        if p23:IsDescendantOf(ReplicatedStorage.Assets) then
            p23 = p23:Clone();
        end;

        p23.Parent = p22.PlayerGui:FindFirstChild("__CharacterReplication");
    end;

    function safeDestroyInvoke(u24, u25)
        local coroutine_running_ret = coroutine.running();
        local u26 = false;
        local u27 = nil;
        u27 = task.delay(20, function() -- Line: 113
            -- upvalues: u26 (ref), u27 (ref), coroutine_running_ret (copy)
            if not u26 then
                u27 = nil;
                task.spawn(coroutine_running_ret, false);
            end;
        end);
        task.spawn(function() -- Line: 120
            -- upvalues: u24 (copy), u25 (copy), u26 (ref), u27 (ref), coroutine_running_ret (copy)
            u24:InvokeClient(u25);
            u26 = true;

            if u27 then
                task.cancel(u27);
                u27 = nil;
            end;

            task.spawn(coroutine_running_ret, true);
        end);

        return u26 and true or coroutine.yield();
    end;

    function removePlayerFromData(p28, p29)
        if p29.destRemote then
            safeDestroyInvoke(p29.destRemote, p28);
            p29.destRemote:Destroy();
        end;

        if p29.model then
            p29.model:Destroy();
        end;

        if p29.remote then
            p29.remote:Destroy();
        end;

        if p29.extraAssets then
            for _, v in p29.extraAssets do
                pcall(function() -- Line: 143
                    -- upvalues: v (copy)
                    v:Destroy();
                end);
            end;
        end;
    end;

    local newWithProps = Character.newWithProps;

    function Character.newWithProps(u30) -- Line: 150
        -- upvalues: u1 (copy), Logger (copy), newWithProps (copy), u19 (copy), u20 (copy), u21 (copy), u10 (copy), CharacterReplication (copy), u3 (copy), u9 (copy), u18 (copy)
        if u30.serverReplication or not u1.ReplicationEnabled then
            Logger.log("Not doing replication!");

            return newWithProps(u30);
        end;

        local u31 = u30.charModel or u30.model;
        local u32, u33;

        if u31:IsA("Player") then
            u32 = u31;
            u33 = u31.Character;

            if not u33 then
                return;
            end;

            u33.Archivable = true;

            for _, descendant in u33:GetDescendants() do
                if descendant:IsA("Script") then
                    descendant.Archivable = false;
                else
                    descendant.Archivable = true;
                end;
            end;

            u31 = u33:Clone();
        else
            u33 = u31;
            u32 = "";
        end;

        local v34 = u30.remote or u30.replicationRemote;
        u30.charModel = nil;
        u30.model = nil;
        u30.replicationRemote = nil;
        u30.remote = nil;
        u30.async = true;
        u30.position = u30.position or u33:GetPivot();
        local u35 = u30.animSide or (u30.side or "L");
        local u36 = nil;
        local v37 = u30.anim or u30.startingAnim;

        if type(v37) == "string" then
            v37 = getAnimInstanceFromString(v37, u30.isEmote or (u30.emote or false));
        end;

        if typeof(v37) == "Instance" then
            v37 = cleanAnimForReplication(v37:Clone(), u35);
        end;

        local u38 = {
            alive = true,
            stagePlayers = u30.stagePlrs or u30.stagePlayers,
            isStage = (u30.stagePlrs or u30.stagePlayers) and true or false,
            isEmote = u30.isEmote or (u30.emote or false),
            preloadedAnims = {},
            sideAttributes = {},
            currentAnim = v37,
            players = {},
            playersData = {}
        };

        if u32 == "" then
            u32 = false;
        end;

        u38.owner = u32;
        u38.propData = u30;

        function u38.Destroy(p39) -- Line: 221
            -- upvalues: u19 (ref), u20 (ref), u32 (ref), u36 (ref)
            local table_find_ret = table.find(u19, p39);

            if table_find_ret then
                table.remove(u19, table_find_ret);
            end;

            u20[u32] = nil;

            if u36 then
                u36:Disconnect();
                u36 = nil;
            end;

            for i, v in p39.playersData do
                task.spawn(removePlayerFromData, i, v);
            end;
        end;

        function u38.CanAddPlayer(p40, p41) -- Line: 236
            -- upvalues: u21 (ref)
            local v42 = u21[p41];

            if not v42 then
                return false;
            end;

            if not v42[1] then
                return false;
            end;

            local v43 = p40.isStage and table.find(p40.stagePlayers, p41);

            return v43 and v42[3] and true or (not v43 and v42[2] and true or false);
        end;

        function u38.RemovePlayer(p44, p45) -- Line: 251
            if not p44.players[p45] then
                return;
            end;

            p44.players[p45] = nil;
            local v46 = p44.playersData[p45];
            p44.playersData[p45] = nil;
            task.spawn(removePlayerFromData, p45, v46);
        end;

        function u38.AddPlayer(p47, p48) -- Line: 259
            -- upvalues: u31 (ref), u35 (copy), u21 (ref), u10 (ref), u30 (copy), CharacterReplication (ref), u33 (ref)
            if p47.players[p48] or p48 == p47.owner and p47.isStage then
                return;
            end;

            p47.players[p48] = true;
            local v49 = p47.isStage and table.find(p47.stagePlayers, p48);

            if v49 then
                p47.playersData[p48] = {
                    isStage = true
                };

                return;
            end;

            local v50 = u31:Clone();
            local RemoteFunction = Instance.new("RemoteFunction");
            local RemoteEvent = Instance.new("RemoteEvent");
            RemoteEvent.Name = "CharRepl";
            local v51;

            if p47.currentAnim then
                v51 = p47.currentAnim:Clone() or nil;
            else
                v51 = nil;
            end;

            if v51 and (v51:GetAttribute("HugeAnim") or v51:FindFirstChild(u35) and v51[u35]:GetAttribute("HugeAnim")) and (u21[p48] and not u21[p48][4]) then
                v51 = u10.hugeAnimReplacement:Clone();
            end;

            replicateToClient(p48, v50);
            replicateToClient(p48, RemoteFunction);
            replicateToClient(p48, RemoteEvent);
            local v52 = {};

            if v51 then
                replicateToClient(p48, v51);
                v52[p47.currentAnim] = v51;
            end;

            u30.anim = v51;
            p47.playersData[p48] = {
                remote = RemoteEvent,
                destRemote = RemoteFunction,
                model = v50,
                extraAssets = v52
            };
            CharacterReplication:FireClient(p48, v50, u30, RemoteEvent, RemoteFunction, u33, p47.owner);
        end;

        writePropsAndStuffFromAnim(u38, v37);

        if v34 then
            u36 = v34.OnServerEvent:Connect(function(p53, p54, ...) -- Line: 311
                -- upvalues: u32 (ref), u3 (ref), u9 (ref), u38 (copy)
                if p53 ~= u32 then
                    p53:Kick("Banned. #real");

                    return;
                end;

                if not u3[p54 or ""] then
                    return;
                end;

                local v55 = u9[p54];

                if v55 then
                    for i, v in u38.playersData do
                        v55(u38, i, v, ...);
                    end;

                    return;
                end;

                for i, v in u38.playersData do
                    v.remote:FireClient(i, p54, ...);
                end;
            end);
        end;

        for i, _ in u18 do
            if u38:CanAddPlayer(i) then
                u38:AddPlayer(i);
            end;
        end;

        table.insert(u19, u38);
        u20[u32] = u38;

        return u38;
    end;

    game:GetService("Players").PlayerRemoving:Connect(function(p56) -- Line: 341
        -- upvalues: u18 (copy), u21 (copy), u19 (copy)
        u18[p56] = nil;
        u21[p56] = nil;

        for _, v in u19 do
            if v.players[p56] then
                v:RemovePlayer(p56);
            end;
        end;
    end);
    CharacterReplication.OnServerEvent:Connect(function(p57, p58, ...) -- Line: 352
        -- upvalues: u19 (copy), u21 (copy), u18 (copy)
        local v59 = { ... };

        if p58 == "Sync" then
            for _, v in u19 do
                if v:CanAddPlayer(p57) then
                    v:AddPlayer(p57);
                elseif v.players[p57] then
                    v:RemovePlayer(p57);
                end;
            end;

            return;
        end;

        if p58 == "UpdPreferences" then
            u21[p57] = v59[1];
            u18[p57] = v59[1][1] or nil;
        end;
    end);
    Logger.log("Server replicator initialized!");
    ReplicatedStorage:SetAttribute("InitializedReplication", true);

    return u1;
end;

repeat
    task.wait();
until ReplicatedStorage:GetAttribute("InitializedReplication") == true;

u1.ReplicationEnabled = workspace:GetAttribute("ReplicationEnabled") or u1.ReplicationEnabled;

if u2 then
    u2.init();
end;

local DataManager = require(ReplicatedStorage.Modules.Data.DataManager);
local LocalPlayer = Players.LocalPlayer;
local u60 = {};
local u61 = {};

function u1.LinkPlayer(p62, p63, p64) -- Line: 381
    -- upvalues: u60 (copy)
    u60[p63] = p64;
end;

function u1.UnlinkPlayer(p65, p66) -- Line: 385
    -- upvalues: u60 (copy)
    u60[p66] = nil;
end;

function u1.UnlinkAll(p67) -- Line: 389
    -- upvalues: u60 (copy)
    table.clear(u60);
end;

function u1.GetCharFromPlr(p68, p69) -- Line: 393
    -- upvalues: u61 (copy)
    return u61[p69];
end;

function u1.SendCharSettingsUpdate(p70) -- Line: 397
    -- upvalues: CharacterReplication (copy), u10 (copy)
    if not p70.ReplicationEnabled then
        return;
    end;

    CharacterReplication:FireServer("UpdPreferences", {
        u10.loadCharacters,
        u10.loadExtCharacters,
        u10.loadStageCharacters,
        u10.loadExtHugeRigs
    });
end;

function u1.SetSettings(p71, p72) -- Line: 407
    -- upvalues: u10 (copy)
    local v73 = {};

    for i, v in p72 do
        if v ~= u10[i] then
            v73[i] = true;
        end;

        u10[i] = v;
    end;

    if v73.loadCharacters or (v73.loadExtCharacters or v73.loadStageCharacters) then
        p71:SendCharSettingsUpdate();
        p71:SyncWithServer();
    end;
end;

function u1.SyncWithServer(p74) -- Line: 422
    -- upvalues: CharacterReplication (copy)
    if not p74.ReplicationEnabled then
        return;
    end;

    CharacterReplication:FireServer("Sync");
end;

StageAnimReplication.OnClientEvent:Connect(function(p75: userdata, p76: string?, p77: number?) -- Line: 427
    -- upvalues: u60 (copy)
    if not u60[p75] then
        return;
    end;

    u60[p75]:Play(p76, "", p77, false);
end);
CharacterReplication.OnClientEvent:Connect(function(u78: any, u79: any, p80: userdata, u81: userdata, u82: any, u83: any) -- Line: 433
    -- upvalues: LocalPlayer (copy), Character (copy), u61 (copy), u2 (copy), Players (copy)
    local u84 = u83 == LocalPlayer;
    local u85 = u79.isEmote or u79.emote;
    local u86 = nil;
    u79.charModel = u78;
    u78.Parent = Character:GetRigStorage();
    local u87 = Character.newWithProps(u79);
    u87.destroyChar = true;

    if u83 then
        u61[u83] = u87;
    end;

    local function doParentStuff() -- Line: 448
        -- upvalues: u87 (copy), u82 (copy), u78 (copy), Character (ref), u84 (copy), u2 (ref), u85 (copy), u79 (copy)
        if not u87.alive then
            return;
        end;

        if u82 then
            u78.Parent = u82.Parent == Character:GetRigStorage() and workspace or u82.Parent;

            if u84 then
                local PrimaryPart = u82.PrimaryPart;

                for _, descendant in u82:GetDescendants() do
                    if (descendant:IsA("BasePart") or descendant:IsA("FaceInstance")) and (descendant ~= PrimaryPart and descendant.Name ~= "HumanoidRootPart") then
                        descendant.Transparency = 1;
                    elseif descendant:IsA("LayerCollector") or (descendant:IsA("Beam") or descendant:IsA("ParticleEmitter")) then
                        descendant.Enabled = false;
                    end;
                end;
            else
                u82.Parent = nil;
            end;
        else
            u78.Parent = workspace;
        end;

        if u84 and (u2 and u85) then
            u2.localCharCreated(u87);
        end;

        if u2 and u85 then
            u2.charCreated(u87, u79.stage);
        end;
    end;

    if u84 then
        u87:postAsyncAnimLoad(doParentStuff);
    else
        doParentStuff();
    end;

    if u85 then
        u87:postAsyncAnimLoad(function() -- Line: 487
            -- upvalues: u87 (copy)
            u87:Dance();
            u87:Play("Intro");
        end);
    end;

    local u89 = p80.OnClientEvent:Connect(function(p88, ...) -- Line: 493
        -- upvalues: u87 (copy)
        u87[p88](u87, ...);
    end);

    function u81.OnClientInvoke() -- Line: 497
        -- upvalues: u81 (copy), u84 (copy), u2 (ref), u85 (copy), u87 (copy), u89 (copy), u86 (ref), u82 (copy), u83 (copy), Players (ref)
        function u81.OnClientInvoke() -- Line: 498
        end;

        task.spawn(function() -- Line: 501
            -- upvalues: u84 (ref), u2 (ref), u85 (ref), u87 (ref), u89 (ref), u86 (ref), u82 (ref), u83 (ref), Players (ref)
            if u84 and (u2 and u85) then
                u2.localDestroyed(u87);
            end;

            u89:Disconnect();
            u87:Destroy();

            if u86 then
                u86:Disconnect();
                u86 = nil;
            end;

            if u84 then
                local PrimaryPart = u82.PrimaryPart;

                for _, descendant in u82:GetDescendants() do
                    if (descendant:IsA("BasePart") or descendant:IsA("FaceInstance")) and (descendant ~= PrimaryPart and descendant.Name ~= "HumanoidRootPart") then
                        descendant.Transparency = 0;
                    elseif descendant:IsA("LayerCollector") or (descendant:IsA("Beam") or descendant:IsA("ParticleEmitter")) then
                        descendant.Enabled = true;
                    end;
                end;

                return;
            end;

            if u82 and (u83 and (u83.Character == u82 and Players:IsAncestorOf(u83))) then
                u82.Parent = workspace;

                return;
            end;

            pcall(function() -- Line: 521
                -- upvalues: u82 (ref)
                u82:Destroy();
            end);
        end);
    end;
end);
DataManager:GetData();
u10.loadCharacters = true;
u10.loadExtCharacters = true;
u10.loadStageCharacters = true;
u1:SendCharSettingsUpdate();

if u10.loadCharacters and u10.loadExtCharacters then
    u1:SyncWithServer();
end;

Logger.log("Client initialized,", "Enabled?:", u1.ReplicationEnabled, "Emote replication support?:", u1.SupportEmotes);

return u1;