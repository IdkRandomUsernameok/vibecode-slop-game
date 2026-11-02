-- Decompiled with Potassium's decompiler.

local u1 = { "MeshPart", "SpecialMesh" };
local u2 = {
    ImageLabel = {
        Property = "ImageContent"
    },
    ImageButton = {
        Property = "ImageContent"
    },
    Texture = {
        Property = "ImageContent"
    },
    Decal = {
        Property = "ImageContent"
    },
    Beam = {
        Property = "ImageContent"
    },
    Sky = {
        Properties = { "MoonTextureContent", "SunTextureContent", "SkyboxBkContent", "SkyboxFtContent", "SkyboxDnContent", "SkyboxLfContent", "SkyboxRtContent", "SkyboxUpContent" }
    },
    ParticleEmitter = {
        Property = "ImageContent"
    },
    MeshPart = {
        Property = "TextureContent"
    },
    SpecialMesh = {
        Property = "TextureContent"
    }
};
local u3 = {
    __maid = nil,
    Initialized = false,
    CurrentMap = nil,
    Stage = nil,
    Maps = {},
    ExtraCameras = {},
    Cameras = {
        BF = nil,
        Dad = nil,
        Camera = nil
    },
    Lighting = {
        Objects = {},
        Properties = {}
    },
    Instances = {},
    StageData = {
        BFCam = nil,
        DadCam = nil,
        MainCam = nil,
        GF = nil,
        Speaker = nil,
        RatingPosition = nil
    },
    Signals = {},
    ExemptPlayers = {}
};
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local v4 = RunService:IsServer() and game:GetService("ServerStorage") or nil;
local Players = game:GetService("Players");
local u5 = v4 and v4.Assets or nil;
local Modules = ReplicatedStorage:FindFirstChild("Modules");
local Character = require(Modules.Main.Character);
local CacheService = require(Modules.Main.CacheService);
local TerrainWriter = require(script:WaitForChild("TerrainWriter"));
local u6;

if RunService:IsClient() then
    u6 = Players.LocalPlayer or nil;
else
    u6 = nil;
end;

local RigStorage = Character:GetRigStorage();
local __Background = ReplicatedStorage.Temp:FindFirstChild("__Background");
local workspace_Terrain = workspace.Terrain;
local Clouds = workspace_Terrain:FindFirstChild("Clouds");
local Water = workspace:WaitForChild("Map"):WaitForChild("Terrain"):WaitForChild("Water");
local CurrentLobby = require(script.Lighting.CurrentLobby);
local DefaultMap = require(script.Lighting.DefaultMap);
local NotScriptable = require(script.Lighting.NotScriptable);
local u7 = {};

for _, v in require(script.Lighting.APIDump) do
    if CurrentLobby[v] == nil then
        CurrentLobby[v] = Lighting[v];
    end;

    if DefaultMap[v] == nil then
        DefaultMap[v] = Lighting[v];
    end;
end;

u3.Lighting.Properties = table.clone(CurrentLobby);

local function FireEngine(p8: string, ...) -- Line: 124
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Events.EngineControl:FireServer(p8, ...);
end;

function u3.Setup(p9: table, p10: table) -- Line: 137
    -- upvalues: u7 (ref), RunService (copy), u6 (copy)
    if not p10 then
        warn("[MapService V2] API is not present! Can\'t initalize MapService.");

        return;
    end;

    u7 = p10;

    if RunService:IsServer() then
        return;
    end;

    if RunService:IsClient() then
        if not RunService:IsStudio() then
            local _ = u6.Name == "aaronrtwo";
        end;

        Instance.new("Model", workspace).Name = "Background";
        p9.Signals.MapAdded = u7.Dependencies.Signal.new();
        p9.Signals.MapSwitched = u7.Dependencies.Signal.new();
    end;
end;

function u3.GetPath(p11: table, p12: table) -- Line: 162
    -- upvalues: RunService (copy), u5 (copy)
    if not (RunService:IsServer() or p12) then
        warn("[Map] Either not running on server or malformed path.");
    end;

    local Maps = u5:FindFirstChild("Maps");

    for _, v in p12 do
        if Maps then
            Maps = Maps:FindFirstChild(v);
        end;

        if not Maps then
            return nil;
        end;
    end;

    return Maps;
end;

function u3.GetBackgroundFolder(p13: table, p14: table) -- Line: 179
    -- upvalues: __Background (copy)
    return __Background;
end;

function u3.CacheLighting(p15) -- Line: 187
    -- upvalues: Lighting (copy), __Background (copy), RunService (copy)
    if #p15.Lighting.Objects > 0 then
        table.clear(p15.Lighting.Objects);
    end;

    for _, child in Lighting:GetChildren() do
        table.insert(p15.Lighting.Objects, child);
        child.Parent = __Background.CachedLighting;
    end;

    if RunService:IsStudio() then
        print("[MapService V2] Fully cached Lighting!", p15.Lighting.Objects, p15.Lighting.Properties);
    end;
end;

function u3.RestoreTerrainWater(p16) -- Line: 204
    -- upvalues: workspace_Terrain (copy), Water (copy), RunService (copy)
    if not workspace_Terrain then
        return;
    end;

    for _, child in Water:GetChildren() do
        if child:IsA("BasePart") then
            workspace_Terrain:FillBlock(child.CFrame, child.Size, Enum.Material.Water);
        end;
    end;

    if RunService:IsStudio() then
        print("[MapService V2] Restored lobby terrain water!");
    end;
end;

function u3.CreateBackground(p17: table, p18: any, p19: table) -- Line: 225
    -- upvalues: RunService (copy)
    if not (RunService:IsServer() and (p18 and p19)) then
        warn("[MapService V2] Either not running on server or malformed Instance.");
    end;

    if p18 then
        p18.Archivable = true;
    end;

    if p18 then
        p18 = p18:Clone();
    end;

    local v20 = {
        SerializedInstance = nil,
        TerrainBounds = nil,
        TerrainVoxels = nil,
        MapPath = {},
        Lighting = {
            Objects = {},
            Properties = {}
        },
        Characters = {
            L = {},
            R = {}
        },
        Attributes = {}
    };

    if p18:FindFirstChild("Lighting") then
        v20.Lighting.Objects = p18.Lighting:FindFirstChild("Objects") and (p18.Lighting.Objects:GetChildren() or {}) or {};
        v20.Lighting.Properties = p18.Lighting:FindFirstChild("Properties") and (require(p18.Lighting.Properties) or {}) or {};
    else
        v20.Lighting.Objects = {};
        v20.Lighting.Properties = {};
    end;

    v20.Attributes = p18:GetAttributes();
    v20.SerializedInstance = p18;
    v20.Modchart = p18:FindFirstChild("Modchart");
    v20.MapPath = p19;
    v20.TerrainBounds = p18:FindFirstChild("TerrainBounds");

    return v20;
end;

function u3.CreateStage(u21: table, p22: table, p23: userdata, p24: table, p25: any) -- Line: 278
    -- upvalues: Players (copy), RigStorage (copy), u7 (ref), u6 (copy)
    local v26 = { "Map", "Shop" };
    u21.Stage = p23;
    local v27 = u21:Add(p22);
    u21:CacheLighting();
    local u28 = {};
    local v29 = {};
    local v30 = {};

    for i = 1, #v26 do
        local v31 = v26[i];
        u21.Instances[v31] = workspace:FindFirstChild(v31);
        local v32;

        if workspace:FindFirstChild(v31) then
            workspace:FindFirstChild(v31).Parent = nil;
            v32 = i;
        else
            v32 = i;
        end;
    end;

    local v33 = { "Dummy_BOT", "Dummy_GF" };

    for _, v in p24 do
        for _, v2 in v do
            table.insert(v33, v2.Name);
        end;
    end;

    for i in u21.ExemptPlayers do
        table.insert(v33, i);
    end;

    for _, child in workspace:GetChildren() do
        if child:FindFirstChild("Humanoid") and (table.find(v33, child.Name) == nil and Players:GetPlayerFromCharacter(child)) then
            table.insert(u28, child);
            child.Parent = RigStorage;
        end;
    end;

    u21.Instances.Players = u28;

    for _, child in workspace:FindFirstChild("Stages"):GetChildren() do
        if child ~= p23 then
            table.insert(v29, child);
            child.Parent = nil;
        end;
    end;

    u21.Instances.Stages = v29;
    u21.Instances.OtherInstances = v30;
    u21.NoPosChars = p25 or {
        L = {},
        R = {}
    };
    u21.__maid = u7.Dependencies.Maid.new();

    local function __playerCharacterController(u34: userdata) -- Line: 333
        -- upvalues: u21 (copy), u28 (copy), RigStorage (ref)
        u21.__maid:GiveTask(u34.CharacterAdded:Connect(function(p35: userdata) -- Line: 334
            -- upvalues: u28 (ref), u21 (ref), u34 (copy), RigStorage (ref)
            if table.find(u28, p35) then
                return;
            end;

            if u21.ExemptPlayers[u34.Name] then
                return;
            end;

            table.insert(u28, p35);
            task.wait();

            if not u21.Initialized then
                return;
            end;

            p35.Parent = RigStorage;
        end));
        u21.__maid:GiveTask(u34.CharacterRemoving:Connect(function(p36: userdata) -- Line: 345
            -- upvalues: u28 (ref)
            if not table.find(u28, p36) then
                return;
            end;

            table.remove(u28, table.find(u28, p36));
        end));
    end;

    for _, v in Players:GetPlayers() do
        __playerCharacterController(v);
    end;

    Players.PlayerAdded:Connect(__playerCharacterController);
    u21.Cameras.BF = p23.Cameras:WaitForChild("BF");
    u21.Cameras.Dad = p23.Cameras:WaitForChild("Dad");
    u21.Cameras.Camera = p23.Cameras:WaitForChild("Camera");
    u21.StageData.BFCam = u21.Cameras.BF.CFrame;
    u21.StageData.DadCam = u21.Cameras.Dad.CFrame;
    u21.StageData.MainCam = u21.Cameras.Camera.CFrame;
    u21.StageData.RatingPosition = p23.RatingPosition.CFrame;
    u21.StageData.Speaker = p23.Internals:GetPivot();
    u21.StageData.GF = p23.Internals:FindFirstChild("GF").CFrame or nil;
    u21.Initialized = true;
    u21.__maid:GiveTask(function() -- Line: 381
        -- upvalues: u6 (ref), u21 (copy)
        u6.ReplicationFocus = nil;
        u21.StageData.DadCam = nil;
        u21.StageData.BFCam = nil;
        u21.StageData.MainCam = nil;
        u21.StageData.GF = nil;
        u21.NoPosChars = nil;
        u21.Stage:SetAttribute("UseRatingPosition", nil);
        u21.StageData.Speaker = nil;
        u21.StageData.RatingPosition = nil;
        u21.Instances.Lobby = nil;
        u21.Instances.Shop = nil;
        u21.Instances.Stages = {};
        u21.Instances.Players = {};
        table.clear(u21.ExtraCameras);
        table.clear(u21.Lighting.Properties);
        table.clear(u21.Cameras);
        table.clear(u21.Maps);
        u21.CurrentMap = nil;
        u21.Stage = nil;
    end);

    if v27 then
        u21:Switch(p22.SerializedInstance.Name);
    end;
end;

function u3.Property(p37: table, p38: any, p39: boolean, p40: any) -- Line: 423
    local string_split_ret = string.split(p38, "/");

    for i = 1, #string_split_ret do
        p37 = p37[string_split_ret[i]];
        local _ = i;
    end;

    if p39 then
        p37 = p40 or p37;
    end;

    return p37;
end;

function u3.ReturnProperty(p41: string) -- Line: 439
    -- upvalues: RunService (copy), u3 (copy)
    if RunService:IsStudio() then
        warn("[MapService V2] This is a deprecated function! Use :Property instead!");
    end;

    return u3:Property(p41, false);
end;

function u3.SetProperty(p42: string, p43: any) -- Line: 445
    -- upvalues: RunService (copy), u3 (copy)
    if RunService:IsStudio() then
        warn("[MapService V2] This is a deprecated function! Use :Property instead!");
    end;

    return u3:Property(p42, true, p43);
end;

function u3.Add(p44: table, u45: table) -- Line: 459
    -- upvalues: u1 (copy), CacheService (copy), u2 (copy)
    if not (u45 and u45.SerializedInstance) then
        return false;
    end;

    if p44.Maps[u45.SerializedInstance.Name] then
        if p44.Maps[u45.SerializedInstance.Name] == u45 then
            return true;
        end;

        warn("[MapService V2] Do not try and create duplicate maps.");
        u45.SerializedInstance:Destroy();

        return false;
    end;

    task.spawn(function() -- Line: 474
        -- upvalues: u45 (copy), u1 (ref), CacheService (ref), u2 (ref)
        for _, descendant in u45.SerializedInstance:GetDescendants() do
            if u1[descendant.ClassName] then
                CacheService.cacheMesh(descendant);
            end;

            if u2[descendant.ClassName] then
                CacheService.cacheImage(descendant);
            end;
        end;

        CacheService.cacheImage(u45.SerializedInstance);
        CacheService.cacheMesh(u45.SerializedInstance);
    end);
    p44.Maps[u45.SerializedInstance.Name] = u45;
    p44.Signals.MapAdded:Fire(u45.SerializedInstance.Name);

    return true;
end;

function u3.Switch(p46: table, p47: string) -- Line: 499
    -- upvalues: Lighting (copy), __Background (copy), workspace_Terrain (copy), TerrainWriter (copy), u6 (copy), Clouds (copy), DefaultMap (copy), CurrentLobby (copy), NotScriptable (copy)
    if not p46.Maps[p47 or ""] then
        warn((`[MapService V2] {p47} does not exist.`));

        return;
    end;

    local u48 = p46.Maps[p47];

    if p46.CurrentMap then
        if p46.CurrentMap == p47 then
            return;
        end;

        local v49 = p46.Maps[p46.CurrentMap];

        if v49.SerializedInstance.Lighting:FindFirstChild("Objects") then
            for _, child in Lighting:GetChildren() do
                if not child:GetAttribute("DoNotOverwrite") then
                    child.Parent = v49.SerializedInstance.Lighting.Objects;
                end;
            end;
        end;

        v49.SerializedInstance.Parent = __Background:FindFirstChild("CachedMaps");
    end;

    if workspace_Terrain then
        workspace_Terrain:Clear();
    end;

    local Stage = u48.SerializedInstance:FindFirstChild("Stage");

    for _, v in __Background:FindFirstChild("Stages"):GetChildren() or {} do
        if v:GetAttribute("Map") == u48.MapPath[#u48.MapPath] then
            v.Parent = u48.SerializedInstance;
            Stage = v;
        end;
    end;

    u48.SerializedInstance.Parent = workspace:FindFirstChild("Background");

    if workspace_Terrain and u48.TerrainBounds then
        local TerrainBounds = u48.TerrainBounds;
        local Attribute = TerrainBounds:GetAttribute("TerrainVoxels");
        local Attribute2 = TerrainBounds:GetAttribute("TerrainSize");
        local Attribute3 = TerrainBounds:GetAttribute("PrecisionLevel");

        if Attribute and Attribute2 then
            local v50 = Region3.new(TerrainBounds.Position - TerrainBounds.Size / 2, TerrainBounds.Position + TerrainBounds.Size / 2):ExpandToGrid(4);
            local v51, v52 = TerrainWriter:load(Attribute, Attribute2, Attribute3 or 1);
            workspace_Terrain:WriteVoxels(v50, 4, v51, v52);
        else
            warn("[MapService] Malformed terrain data");
        end;
    end;

    if Stage then
        u6.ReplicationFocus = Stage.PrimaryPart;
        p46.Cameras.Dad.CFrame = Stage.Cameras.Dad.CFrame;
        p46.Cameras.BF.CFrame = Stage.Cameras.BF.CFrame;
        p46.Cameras.Camera.CFrame = Stage.Cameras.Camera.CFrame;
        local v53 = {};

        for _, child in Stage.Cameras:GetChildren() do
            v53[child.Name] = true;
            local v54 = p46.Cameras[child.Name] or p46.ExtraCameras[child.Name];

            if v54 then
                v54.CFrame = child.CFrame;
            else
                local v55 = p46.Cameras.Camera:Clone();
                v55.Name = child.Name;
                v55.CFrame = child.CFrame;
                v55.Parent = p46.Stage.Cameras;
                p46.ExtraCameras[child.Name] = v55;
            end;
        end;

        for i, v in p46.ExtraCameras do
            if not v53[i] then
                p46.ExtraCameras[i] = nil;
                pcall(function() -- Line: 581
                    -- upvalues: v (copy)
                    v:Destroy();
                end);
            end;
        end;

        for i, v in u48.Characters do
            local v56 = v;

            for _, child in Stage:FindFirstChild(i):GetChildren() do
                v56[child.Name:gsub("Outline", "")] = child:GetPivot();
            end;
        end;

        if Stage:FindFirstChild("Stage") then
            if Stage.Stage:FindFirstChild("Speaker") then
                local Speaker = Stage.Stage.Speaker;
                p46.Stage.Internals:PivotTo(Speaker.CFrame * CFrame.new(0, Speaker.Size.Y / 2 - 0.55, 0));
            end;

            if Stage.Stage:FindFirstChild("RatingPosition") then
                p46.Stage:SetAttribute("UseRatingPosition", true);
                p46.Stage.RatingPosition.CFrame = Stage.Stage.RatingPosition.CFrame;
            end;
        end;

        if not Stage:GetAttribute("Map") then
            Stage:SetAttribute("Map", u48.MapPath[#u48.MapPath]);
        end;

        Stage.Parent = __Background:FindFirstChild("Stages");
    end;

    if Clouds then
        Clouds.Parent = nil;
    end;

    for i = 1, #u48.Lighting.Objects do
        u48.Lighting.Objects[i].Parent = u48.Lighting.Objects[i].ClassName == "Clouds" and workspace.Terrain or Lighting;
        local _ = i;
    end;

    for i, v in DefaultMap do
        if u48.Lighting.Properties[i] == nil then
            u48.Lighting.Properties[i] = v;
        end;
    end;

    if u48.Lighting.Properties.GlobalShadows then
        u48.Lighting.Properties.GlobalShadows = CurrentLobby.GlobalShadows;
    end;

    for i, v in u48.Lighting.Properties do
        if NotScriptable[i] then
            warn("Map.Lighting contains \'NotScriptable\'", i, p47);
        else
            Lighting[i] = v;
        end;
    end;

    for _, child in p46.Stage.Internals.Hologram:GetChildren() do
        pcall(function() -- Line: 639
            -- upvalues: child (copy), u48 (copy)
            child.Enabled = u48.Attributes.HideHologram and not u48.Attributes.HideHologram or false;
        end);
    end;

    p46.CurrentMap = p47;
    p46.Signals.MapSwitched:Fire(u48);
end;

function u3.HideSpeaker(p57: table, p58: boolean) -- Line: 654
    if p57.Stage == nil then
        return;
    end;

    for _, v in { "Bolts", "Speaker", "Speaker_Outline" } do
        p57.Stage.Internals[v].Transparency = p58 and 1 or 0;
        p57.Stage.Internals[v].CanCollide = p58 == false;
    end;
end;

function u3.SetPlayerExempt(p59: table, p60: userdata, p61: boolean) -- Line: 671
    if not p60 then
        return;
    end;

    p59.ExemptPlayers[p60.Name] = p61 or nil;
end;

function u3.Reposition(p62: table, p63: table, p64: any, p65: boolean, p66: boolean) -- Line: 681
    if not p62.CurrentMap then
        return;
    end;

    local v67 = p62.Maps[p62.CurrentMap];

    if v67 == nil then
        return;
    end;

    if p63 then
        for i, v in p63 do
            local v68 = i;

            for i2, v2 in v do
                local v69 = v67.Characters[v68];

                if v69 and v69[tostring(i2)] ~= nil then
                    v2:SetPosition(v69[tostring(i2)], true);
                elseif i2 >= 0 and not p62.NoPosChars[v68][i2] then
                    local v70 = v68 == "L" and 1 or -1;

                    if v69["0"] ~= nil then
                        v2:SetPosition(v69["0"] * CFrame.new(v70 * 1.5 * i2, 0, i2 * 2.75), true);
                    end;
                end;
            end;
        end;
    end;

    if p64 ~= nil then
        if p64.SetPosition then
            p64:SetPosition(p62.Stage.Internals.GF.CFrame);

            return;
        end;

        p64:PivotTo(p62.Stage.Internals.GF.CFrame);
    end;
end;

function u3.Destroy(u71: table, p72: function) -- Line: 726
    -- upvalues: workspace_Terrain (copy), Clouds (copy), __Background (copy), Players (copy), Lighting (copy), CurrentLobby (copy), NotScriptable (copy)
    if not u71.Initialized then
        if p72 then
            p72();
        end;

        return;
    end;

    pcall(function() -- Line: 732
        -- upvalues: u71 (copy)
        u71.Cameras.BF.CFrame = u71.StageData.BFCam;
        u71.Cameras.Dad.CFrame = u71.StageData.DadCam;
        u71.Cameras.Camera.CFrame = u71.StageData.MainCam;
    end);

    if u71.StageData.RatingPosition then
        u71.Stage:SetAttribute("UseRatingPosition", nil);
        u71.Stage.RatingPosition.CFrame = u71.StageData.RatingPosition;
    end;

    for _, v in u71.ExtraCameras do
        v:Destroy();
    end;

    if u71.StageData.Speaker then
        u71.Stage.Internals:PivotTo(u71.StageData.Speaker);
    end;

    if u71.Stage then
        for _, child in u71.Stage.Internals.Hologram:GetChildren() do
            child.Enabled = true;
        end;
    end;

    if workspace_Terrain then
        workspace_Terrain:Clear();
        u71:RestoreTerrainWater();
    end;

    if Clouds then
        Clouds.Parent = workspace_Terrain;
    end;

    for _, v in { "Map", "Shop" } do
        if u71.Instances[v] then
            u71.Instances[v].Parent = workspace;
        end;
    end;

    for i = 1, u71.Instances.Stages and #u71.Instances.Stages or #{} do
        u71.Instances.Stages[i].Parent = workspace.Stages;
        local _ = i;
    end;

    u71.Initialized = false;
    u71.ExemptPlayers = {};

    for _, child in __Background.Stages:GetChildren() do
        child:Destroy();
    end;

    for i = 1, u71.Instances.Players and (#u71.Instances.Players or 0) or 0 do
        local v73 = u71.Instances.Players[i];
        local v74;

        if Players:GetPlayerFromCharacter(v73) then
            v73.Parent = workspace;
            v74 = i;
        else
            v74 = i;
        end;
    end;

    for i = 1, #u71.Instances.OtherInstances do
        if not u71.Instances.OtherInstances[i] then
            return;
        end;

        u71.Instances.OtherInstances[i].Parent = workspace;
        local _ = i;
    end;

    for _, v in u71.Maps do
        pcall(function() -- Line: 799
            -- upvalues: v (copy)
            v.SerializedInstance:Destroy();
        end);
        v.Lighting.Properties = {};
        local v75 = v;

        for i = 1, #v.Lighting.Objects do
            v75.Lighting.Objects[i]:Destroy();
            local _ = i;
        end;
    end;

    for i = 1, #u71.Lighting.Objects do
        u71.Lighting.Objects[i].Parent = Lighting;
        local _ = i;
    end;

    for i, v in CurrentLobby do
        if NotScriptable[i] then
            warn("Lighting default contains \'NotScriptable\'", i);
        else
            Lighting[i] = v;
        end;
    end;

    if u71.__maid then
        u71.__maid:DoCleaning();
    end;

    if p72 then
        p72();
    end;
end;

return u3;