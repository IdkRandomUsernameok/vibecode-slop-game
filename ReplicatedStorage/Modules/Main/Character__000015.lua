-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
local ContentProvider = game:GetService("ContentProvider");
local TweenService = game:GetService("TweenService");
game["Run Service"]:IsServer();
game:GetService("AnimationClipProvider");
local u1 = nil;
local Signal = require(ReplicatedStorage.Modules.Lib.Signal);
local VarTweener = require(ReplicatedStorage.Modules.Main.VarTweener);
local CacheService = require(ReplicatedStorage.Modules.Main.CacheService);
local AppearanceManager = require(ReplicatedStorage.Modules.Other.AppearanceManager);
local DataManager = require(ReplicatedStorage.Modules.Data.DataManager);
local RigAssets = require(ReplicatedStorage.Modules.Main.RigAssets);
local Logger = require(ReplicatedStorage.Modules.Other.Logger);
require(script.RewriteStuff.RigInfo);
local u2 = false;
local getDescription = AppearanceManager.getDescription;
local u3 = {
    __minz = true
};

function u3.__index(p4, p5) -- Line: 49
    -- upvalues: u3 (copy)
    if p5 ~= "Parent" then
        return u3[p5];
    end;

    if p4.charModel then
        return p4.charModel.Parent;
    end;
end;

function u3.__newindex(p6, p7, p8) -- Line: 56
    if p7 ~= "Parent" then
        return rawset(p6, p7, p8);
    end;

    if p6.charModel then
        p6.charModel.Parent = p8;
    end;
end;

local u9 = RunService:IsServer();
local u10 = RunService:IsStudio();
local _ = game.PlaceId == 13042469490;
local LocalData = DataManager:GetLocalData();
local Characters = ReplicatedStorage.Characters;
local Emotes = ReplicatedStorage.Assets.Emotes;
local Animations = ReplicatedStorage.Assets.Animations;
local l_game = game;
local u11 = l_game:FindFirstChild("RigStorage") or Instance.new("Folder");
u11.Name = "RigStorage";
u11.Parent = l_game;
u3.RigStorage = l_game;

if CacheService.AnimationDummy then
    CacheService.AnimationDummy.Parent = u11;
end;

local u12 = {
    R6 = Characters:FindFirstChild("DefaultR6"),
    R15 = Characters:FindFirstChild("DefaultR15"),
    D15 = Characters:FindFirstChild("DefaultD15")
};
local u13 = {
    [Enum.AccessoryType.Face] = true,
    [Enum.AccessoryType.Eyebrow] = true,
    [Enum.AccessoryType.Eyelash] = true
};
local v14 = {};
local u15 = {
    useFaces = true,
    useProps = true,
    useReqProps = true,
    extraIds = {}
};
local u16 = {
    Left = "Left",
    Down = "Down",
    Up = "Up",
    Right = "Right"
};

for i, v in {
    Left = { "Left", "rLeft", "rLeft2", "Left2" },
    Down = { "Down", "rDown", "rDown2", "Down2" },
    Up = { "Up", "rUp", "rUp2", "Up2", "Square", "Plus" },
    Right = { "Right", "rRight", "rRight2", "Right2" }
} do
    local v17 = i;

    for _, v2 in v do
        v14[v2] = v17;
    end;
end;

local u18 = { "", "ALT", "MISS", "DODGE", "SHOOT" };
local u19 = { "", "ALT" };
local u20 = {
    R15 = { "Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot", "HumanoidRootPart" },
    R6 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "HumanoidRootPart" }
};

function getAnimations(p21: userdata, p22: string?)
    -- upvalues: u10 (copy), Logger (copy)
    if not p21 then
        return {};
    end;

    if typeof(p21) == "Instance" then
        p21 = p21:FindFirstChild(p22 or "") or p21;
    end;

    local v23 = {};

    for _, v in p21:QueryDescendants(">Animation") do
        v23[v.Name] = {
            Id = v.AnimationId,
            Speed = tonumber(v:GetAttribute("Speed")) or 1,
            Priority = v:GetAttribute("Priority"),
            Looped = v:GetAttribute("Looped")
        };
    end;

    if u10 then
        for _, v in p21:QueryDescendants(">AnimationClip") do
            local v24 = v;

            for _, v2 in v:QueryDescendants("Pose") do
                if v2.EasingStyle == Enum.PoseEasingStyle.Constant and v2.EasingDirection ~= Enum.PoseEasingDirection.Out then
                    Logger.warn("AnimationClip has wrongly exported constant ease dir, changing to out for intended preview (Fix this before publishing!)");
                    v2.EasingDirection = Enum.PoseEasingDirection.Out;
                end;
            end;

            v23[v24.Name] = {
                Id = game:GetService("AnimationClipProvider"):RegisterAnimationClip(v24),
                Speed = tonumber(v24:GetAttribute("Speed")) or 1,
                Priority = v24:GetAttribute("Priority"),
                Looped = v24:GetAttribute("Looped")
            };
        end;
    end;

    return v23;
end;

u3.IdlePrefixes = u19;
u3.GetAnimations = getAnimations;
u3.AnimationPrefixes = u18;

function getId(p25)
    if tonumber(p25) then
        p25 = "rbxassetid://" .. p25 or p25;
    end;

    return p25;
end;

function hasProperty(u26, u27)
    local success, _ = pcall(function() -- Line: 208
        -- upvalues: u26 (copy), u27 (copy)
        u26[u27] = u26[u27];
    end);

    return success;
end;

function getInstance(p28, p29)
    if p29 == nil then
        return;
    end;

    for i = 1, #p29 do
        local v30 = p29[i];

        if not p28:FindFirstChild(v30) then
            break;
        end;

        p28 = p28:FindFirstChild(v30);
        local _ = i;
    end;

    return p28;
end;

function getRealName(p31, p32)
    if p32 == nil or p32.Parent == nil then
        return nil;
    end;

    local v33 = {};
    table.insert(v33, 1, p32.Name);
    local Parent = p32.Parent;

    if Parent ~= p31 then
        table.insert(v33, 1, Parent.Name);

        repeat
            if Parent.Parent ~= p31 then
                Parent = Parent.Parent;
                table.insert(v33, 1, Parent.Name);
            end;
        until Parent.Parent == p31;
    end;

    return v33;
end;

function reverseTable(p34)
    local table_clone_ret = table.clone(p34);

    for i = 1, math.floor(#table_clone_ret / 2) do
        local v35 = #table_clone_ret - i + 1;
        local v36 = table_clone_ret[i];
        table_clone_ret[i] = table_clone_ret[v35];
        table_clone_ret[v35] = v36;
        local _ = i;
    end;

    return table_clone_ret;
end;

function getFullPath(p37)
    local v38 = {};

    if p37.Name and p37 then
        repeat
            if p37.Name and p37 then
                table.insert(v38, p37.Name);
                p37 = p37.Parent;
            end;
        until p37.Name == "PreloadedRig";
    end;

    return v38;
end;

function findObject(p39, p40)
    if #p40 <= 0 then
        return p39;
    end;

    local v41 = reverseTable(p40);
    local v42 = 1;

    repeat
        p39 = p39:FindFirstChild(v41[v42]);
        v42 = v42 + 1;
    until p39 == nil or v42 == #v41 + 1;

    return p39;
end;

local GetImageID = ReplicatedStorage:WaitForChild("Events"):WaitForChild("GetImageID");
game:GetService("MarketplaceService");
game:GetService("InsertService");
local u43 = u9 and (task.wait(2) and shared.getImageId) or function() -- Line: 291
    return "rbxassetid://0";
end;

function getDecalFromFaceId(p44)
    -- upvalues: u9 (copy), u43 (copy), GetImageID (copy)
    return p44 == 0 and "rbxasset://textures/face.png" or (u9 and u43(p44) or GetImageID:InvokeServer(p44) or "rbxassetid://" .. p44);
end;

function findFaceInHead(p45: userdata)
    return p45:FindFirstChildOfClass("Decal");
end;

function getFaceFromCharacter(p46)
    if p46:FindFirstChild("Head") then
        return findFaceInHead(p46.Head);
    end;
end;

function loadDescription(p47: userdata, p48: userdata?, u49: userdata?, p50: table?, p51: table?)
    -- upvalues: Logger (copy), u20 (copy), LocalData (copy), Characters (copy)
    if not p48 then
        if p47 then
            p48 = p47:FindFirstChild("Humanoid");
        else
            p48 = p47;
        end;
    end;

    local v52;

    if p47 then
        v52 = p47:FindFirstChild("AnimationController") or nil;
    else
        v52 = nil;
    end;

    if v52 ~= nil then
        return Logger.log("Character is a mesh rig, continuing...");
    end;

    if not p47 then
        return Logger.log("No character found!");
    end;

    if not p48 then
        return Logger.log("No humanoid found!");
    end;

    if not u49 then
        return Logger.log("No description found!");
    end;

    local u53 = p50 or {};
    local v54 = p51 or {};
    local u55 = v54.suffix or "";
    local v56 = tick();
    local v57 = {};
    local v58 = {};
    local v59 = {};
    local v60 = u20[p48.RigType.Name] or {};
    local u61 = getFaceFromCharacter(p47);

    if u61 and (u61.Texture == "rbxassetid://0" or (u61.Texture == "" or u61.Transparency == 1)) then
        u61 = nil;
    end;

    local v62 = #p47:QueryDescendants("[$Face]") > 0;
    local v63 = {};
    local v64 = {};
    local v65 = {};

    if LocalData and not LocalData.CameraFlash then
        table.insert(v65, "[$Flashing]");
    end;

    if not u53.useFaces then
        table.insert(v65, "[$Face]");
    end;

    if not u53.useProps then
        table.insert(v65, "[$Prop]");
    end;

    if not u53.useReqProps then
        table.insert(v65, "[$RequiredProp]");
    end;

    for _, v in p47:QueryDescendants(table.concat(v65, ",")) do
        if v:IsDescendantOf(p47) then
            pcall(function() -- Line: 369
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;
    end;

    for _, v in p47:QueryDescendants("BasePart") do
        v.CanCollide = false;
        v.CanQuery = false;
        v.CanTouch = false;

        if table.find(v60, v.Name) and v.Parent == p47 then
            v58[v.Name] = {
                Transparency = v.Transparency
            };
        end;
    end;

    for _, v in p47:QueryDescendants("Accessory") do
        if v.AccessoryType == Enum.AccessoryType.Face or (v.AccessoryType == Enum.AccessoryType.Eyebrow or v.AccessoryType == Enum.AccessoryType.Eyelash) then
            v64[#v64 + 1] = v;
        end;
    end;

    task.wait();

    if not (u53.useFaces or (u61 or not v62)) then
        u61 = Instance.new("Decal");
        u61.Transparency = 0;
        u61.Texture = getDecalFromFaceId(p48:GetAppliedDescription().Face);
        u61.Parent = p47:FindFirstChild("Head");
    end;

    local v66 = not (u53["Head_Part" .. u55] or u61) and p47:FindFirstChild("Head");

    if v66 then
        u49.Face = 0;
        u49.Head = 0;
    end;

    require(script.RewriteStuff.NormalizeRig)(p47);
    require(script.RewriteStuff.ApplyDescription)(p47, u49);

    for i, v in v57 do
        if v.Part0 then
            i.Part0 = p47:FindFirstChild(v.Part0);
        end;

        if v.Part1 then
            i.Part1 = p47:FindFirstChild(v.Part1);
        end;

        if i.Part0 and i.Part0 ~= p47.PrimaryPart then
            i.Part0.Anchored = false;
        end;

        if i.Part1 and i.Part1 ~= p47.PrimaryPart then
            i.Part1.Anchored = false;
        end;
    end;

    for i, v in v58 do
        local v67 = p47:FindFirstChild(i);

        if v67 and (i ~= "Head" or not v67:FindFirstChildOfClass("FaceControls")) then
            for i2, v2 in v do
                v67[i2] = v2;
            end;
        end;
    end;

    for i, v in v59 do
        if i and (i.Parent and (v and v.Parent)) then
            i.Parent = v;
        end;
    end;

    if not (u53["Head_Part" .. u55] or (u61 or not p47:FindFirstChild("Head"))) then
        local Head = p47.Head;

        if Head.Transparency < 1 then
            local v68 = Characters.DefaultHead:Clone();
            v68.Size = v68.Size * (v54.headScale or 1);
            v68.Color = Head.Color;
            v68.Transparency = Head.Transparency;
            v68.CFrame = Head.CFrame;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = Head;
            WeldConstraint.Part1 = v68;
            WeldConstraint.Parent = Head;
            v68.Parent = Head;

            for _, v in v64 do
                if v:IsDescendantOf(p47) then
                    pcall(function() -- Line: 543
                        -- upvalues: v (copy)
                        v:Destroy();
                    end);
                end;
            end;

            Head.Transparency = 1;
        end;
    end;

    table.clear(v58);
    table.clear(v59);
    table.clear(v57);

    for i, v in u53 do
        local u69, v70 = i:gsub("_Part" .. u55, "");
        local v71 = i == "ReplaceRoot" .. u55;

        if v70 >= 1 then
            local v72 = p47:FindFirstChild(u69 or "");
            local v73;

            if v72 and v72.ClassName == "MeshPart" then
                v73 = v;

                for _, child in v72:GetChildren() do
                    if child:IsA("LayerCollector") then
                        child.Enabled = false;
                    elseif child:IsA("FaceInstance") then
                        child.Transparency = 1;
                    end;
                end;

                v72.Transparency = 1;
            else
                v73 = v;
            end;

            local function resolvePath(p74: userdata, p75: table) -- Line: 576
                local v76 = { p74 };

                for _, v2 in p75 do
                    if v2 ~= "" then
                        local v77 = v2;
                        v76 = {};

                        for _, v3 in v76 do
                            if v77 == "*" then
                                for _, child in v3:GetChildren() do
                                    table.insert(v76, child);
                                end;
                            else
                                local v78 = v3:FindFirstChild(v77);

                                if v78 then
                                    table.insert(v76, v78);
                                end;
                            end;
                        end;

                        if #v76 == 0 then
                            break;
                        end;
                    end;
                end;

                return v76;
            end;

            local string_split_ret = string.split(v73, ",");

            if #string_split_ret >= 1 then
                for _, v2 in string_split_ret do
                    local v79 = string.match(v2, "^%s*(.-)%s*$") or v2;
                    local string_split_ret2 = string.split(v79, "/");
                    local _Props = p47:FindFirstChild("_Props");
                    local v80 = not _Props and {} or resolvePath(_Props, string_split_ret2);

                    if #v80 == 0 then
                        v80 = resolvePath(p47, string_split_ret2);
                    end;

                    if #v80 == 0 then
                        Logger.log("No", v79, "found!");
                    else
                        local u81 = {};

                        local function collectPartsAndMeshes(p82: userdata) -- Line: 627
                            -- upvalues: u81 (copy), collectPartsAndMeshes (copy)
                            if p82:IsA("BasePart") or p82:IsA("SpecialMesh") then
                                table.insert(u81, p82);

                                return;
                            end;

                            if p82:IsA("Model") or p82:IsA("Folder") then
                                for _, child in p82:GetChildren() do
                                    collectPartsAndMeshes(child);
                                end;
                            end;
                        end;

                        for _, v3 in v80 do
                            collectPartsAndMeshes(v3);
                        end;

                        for _, v3 in u81 do
                            local success, result = pcall(function() -- Line: 643
                                -- upvalues: u49 (copy), u69 (copy), v3 (copy)
                                local v83 = u49 ~= nil and u49[u69 .. "Color"] or Color3.new();

                                if v3:IsA("BasePart") then
                                    v3.Color = v83;

                                    return;
                                end;

                                if v3:IsA("SpecialMesh") then
                                    v3.VertexColor = Vector3.new(v83.R, v83.G, v83.B);
                                end;
                            end);

                            if not success then
                                Logger.log((`Applying Color failed, response: {result}`));
                            end;

                            if u69 == "Head" then
                                local u84 = nil;

                                if v3:IsA("BasePart") then
                                    u84 = findFaceInHead(v3);
                                elseif v3:IsA("SpecialMesh") and (v3.Parent and v3.Parent:IsA("BasePart")) then
                                    u84 = findFaceInHead(v3.Parent);
                                end;

                                if u84 then
                                    task.spawn(function() -- Line: 666
                                        -- upvalues: u61 (ref), u84 (ref), u49 (copy)
                                        if u61 then
                                            u84.Texture = u61.Texture;

                                            return;
                                        end;

                                        u84.Texture = getDecalFromFaceId(u49.Face);
                                    end);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        elseif v71 and v == true then
            local v85 = p47:FindFirstChild(p48.RigType.Name == "R6" and "Torso" or "LowerTorso");

            if v85 then
                local Root = v85:FindFirstChild("Root");

                if Root then
                    task.delay(0, function() -- Line: 688
                        -- upvalues: Root (copy)
                        task.wait();
                        Root.Enabled = false;
                    end);
                end;
            end;
        end;
    end;

    if u53["Color_Offset_Target" .. u55] and u53["Color_Offset" .. u55] then
        local string_split_ret = string.split(u53["Color_Offset_Target" .. u55], ",");

        if #string_split_ret >= 1 then
            for _, v in string_split_ret do
                local string_split_ret2 = string.split(v, "/");
                local v86;

                if #string_split_ret2 > 1 then
                    v86 = p47;

                    for _, v2 in string_split_ret2 do
                        if p47 == nil then
                            break;
                        end;

                        p47 = p47:FindFirstChild(v2);
                    end;
                else
                    local v87 = p47:FindFirstChild(v, true);
                    v86 = p47;
                    p47 = v87;
                end;

                if p47 then
                    for _, v2 in p47.ClassName == "Model" and (p47:GetChildren() or { p47 }) or { p47 } do
                        local success, result = pcall(function() -- Line: 724
                            -- upvalues: v2 (copy), u53 (ref), u55 (copy)
                            v2.Color = Color3.new(math.clamp(v2.Color.R + u53["Color_Offset" .. u55].X, 0, 1), math.clamp(v2.Color.G + u53.Color_Offset.Y, 0, 1), (math.clamp(v2.Color.B + u53.Color_Offset.Z, 0, 1)));
                        end);

                        if not success then
                            Logger.warn((`Applying Color failed, response: {result}`));
                        end;
                    end;

                    p47 = v86;
                else
                    p47 = v86;
                end;
            end;
        end;
    end;

    Logger.log((`Took {tick() - v56} seconds to load appearance!`));

    return {
        rootWelds = v63
    };
end;

function mergeTracks(u88)
    if #u88 ~= 0 then
        return setmetatable({
            tracks = u88
        }, {
            __index = function(p89, u90) -- Line: 751, Name: __index
                -- upvalues: u88 (copy)
                local v91 = u88[1][u90];

                if type(v91) == "function" then
                    return setmetatable({}, {
                        __call = function(...) -- Line: 754, Name: __call
                            -- upvalues: u88 (ref), u90 (copy)
                            for _, v in u88 do
                                v[u90](v, unpack({ ... }, 3, select("#", ...)));
                            end;
                        end
                    });
                end;

                return v91;
            end,

            __newindex = function(p92, p93, p94) -- Line: 763, Name: __newindex
                -- upvalues: u88 (copy)
                for _, v in u88 do
                    v[p93] = p94;
                end;
            end
        });
    end;
end;

function u3.LoadAnimationsOnAnimator(p95, p96, p97) -- Line: 771
    -- upvalues: u16 (copy), u19 (copy)
    local v98 = {};
    local v99 = {};

    for i, v in u16 do
        local v100 = v;
        local v101 = i;

        for _, v2 in p95.prefixes do
            local v102 = p95.optionalPrefixes[v2];
            local v103 = v101 .. v2;
            local v104 = v100 .. v2;
            local v105 = p96[v104] or p96[v100];

            if v105 then
                local v106 = v105 == p96[v104] and v103 and v103 or v101;

                if v106 ~= v101 or not v102 then
                    v99[v103] = v99[v106] or p95:AddAnimation(v103, v105.Id, v105.Speed, false, Enum.AnimationPriority.Movement, p97);
                    table.insert(v98, v106);
                end;
            end;
        end;
    end;

    for _, v in (p96.IdleLeft or p96.IdleRight) and { "IdleLeft", "IdleRight" } or { p95.idleName } do
        local v107 = v;

        for _, v2 in u19 do
            local v108 = v107 .. v2;
            local v109 = p96[v108] or p96[v107];

            if v109 then
                local v110 = v109 == p96[v108] and v108 and v108 or v107;
                v99[v108] = v99[v110] or p95:AddAnimation(v108, v109.Id, v109.Speed, true, Enum.AnimationPriority.Idle, p97);
                table.insert(v98, v110);
            end;
        end;
    end;

    for i, v in p96 do
        if not table.find(v98, i) then
            v99[i] = p95:AddAnimation(i, v.Id, v.Speed, v.Looped or false, Enum.AnimationPriority[v.Priority or "Action"], p97);
        end;
    end;

    return v99;
end;

function getHumanoid(p111: userdata)
    local Humanoid = p111:FindFirstChild("Humanoid");

    if Humanoid then
        return Humanoid;
    end;

    local AnimationController = p111:FindFirstChild("AnimationController");

    if AnimationController then
        return AnimationController;
    end;

    local Humanoid2 = Instance.new("Humanoid");
    Humanoid2.Parent = p111;
    Humanoid2.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    Instance.new("Animator").Parent = Humanoid2;

    return Humanoid2;
end;

function getAnimator(p112: userdata)
    local v113 = getHumanoid(p112);
    local Animator = v113:FindFirstChild("Animator");

    if Animator then
        return Animator;
    end;

    local Animator2 = Instance.new("Animator");
    Animator2.Parent = v113;

    return Animator2;
end;

local u114 = { "Play", "ManualPlay", "LoadAnim", "PreloadAnim", "AddPrefix", "SetAnimationSpeed", "SetAnimTrackSpeed" };

function u3.Replicate(p115, ...) -- Line: 857
    -- upvalues: u9 (copy)
    local remote = p115.remote;

    if not remote or u9 then
        return;
    end;

    remote:FireServer(...);
end;

function u3.AddPrefix(p116, p117, p118) -- Line: 864
    -- upvalues: u16 (copy)
    p116:Replicate("AddPrefix", p117, p118);
    table.insert(p116.prefixes, p117);
    p116.optionalPrefixes[p117] = p118;

    for _, v in p116.preloadedAnims or {} do
        local animations = v.animations;

        for i, _ in u16 do
            local v119 = i .. p117;
            local v120 = animations[i];

            if animations[v119] or (p118 or not v120) then
                if animations[v119] then
                    animations[v119].Priority = Enum.AnimationPriority.Movement;
                end;
            else
                animations[v119] = v120;
                v120.Priority = Enum.AnimationPriority.Movement;
            end;
        end;
    end;
end;

function u3.cloneModel(p121: userdata) -- Line: 889
    p121.Archivable = true;
    local v122 = p121:Clone();
    v122.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    local v123 = v122:FindFirstChildOfClass("ForceField");

    if v123 then
        v123:Destroy();
    end;

    for _, v in v122:QueryDescendants("LuaSourceContainer, LayerCollector") do
        v:Destroy();
    end;

    local Rig = v122:FindFirstChild("Rig");

    if Rig then
        Rig:Destroy();
    end;

    return v122;
end;

function u3.new(p124: userdata, p125: string?, p126, p127: any, p128: any, p129: userdata?, p130: boolean?, p131: table?, p132: boolean?, p133: boolean?) -- Line: 912
    -- upvalues: u3 (copy)
    return type(p124) == "table" and u3.newWithProps(p124) or u3.newWithProps({
        charModel = p124,
        animSide = p125,
        position = p126,
        anim = p127,
        humanoidDescription = p128,
        replicationRemote = p129,
        isLocked = p130,
        extraIds = p131,
        isEmote = p132,
        isAsync = p133
    });
end;

function u3.newWithProps(p134) -- Line: 927
    -- upvalues: u1 (ref), ReplicatedStorage (copy), u2 (ref), u3 (copy), u15 (copy), Logger (copy), u18 (copy), Signal (copy), getDescription (copy), u9 (copy), u114 (copy)
    if not u1 then
        u1 = require(ReplicatedStorage.Modules.Main.CharacterReplicator);
        u2 = u1.ReplicationEnabled;

        return u3.newWithProps(p134);
    end;

    local u135 = p134.charModel or p134.model;
    local v136 = p134.animSide or p134.side;
    local v137 = p134.replicationRemote or p134.remote;
    local u138 = p134.anim or p134.startingAnim;
    local v139 = p134.humanoidDescription or (p134.description or p134.desc);
    local v140 = p134.isLocked or p134.locked;
    local v141 = p134.position or p134.pos;
    local v142 = p134.isEmote or p134.emote;
    local v143 = p134.isAsync or p134.async;
    local asyncDescriptions = p134.asyncDescriptions;
    local extraIds = p134.extraIds;
    local v144 = p134.animAttributes or (p134.animAttrs or table.clone(u15));
    local offset = p134.offset;

    if extraIds then
        v144.extraIds = extraIds;
    end;

    local v145;

    if u135:IsA("Player") then
        v145 = u135;
        u135 = v145.Character;

        if not u135 then
            Logger.warn("Passed player does not have a character!");

            return nil;
        end;

        u135.Archivable = true;
    else
        v145 = nil;
    end;

    local u146 = {
        locked = v140 or false,
        characterSide = v136,
        defaultCharacterSide = v136,
        player = v145,
        hasPlayer = v145 and true or false,
        camOffset = CFrame.new(),
        serverOff = CFrame.new(),
        offsetPos = offset or CFrame.new(),
        heightOff = CFrame.new(0, v140 and 0 or getHeightDiffFromCharacter(u135), 0),
        danced = false,
        idleName = "Idle",
        zoom = 1,
        startPos = v141 or u135:GetPivot(),
        userId = 0,
        curTweenID = 0,
        charModel = u135,
        char = u135,
        destroyChar = false,
        currentAnim = "",
        animPrefix = "",
        remote = v137,
        humanoid = getHumanoid(u135),
        animator = getAnimator(u135),
        prioritizeActions = true,
        preloadedRigs = {},
        preloadedAnims = {},
        updateCon = nil,
        animAttributes = v144,
        animations = {},
        isEmote = v142 or v136 == "Emote",
        currentRig = nil,
        hidden = false,
        prefixes = table.clone(u18),
        optionalPrefixes = {},
        animOptionalPrefixes = {},
        asyncDescriptions = asyncDescriptions,
        animationPlayed = Signal.new(),
        animationLoaded = Signal.new(),
        animationStoppedLoading = Signal.new(),
        animationEnded = Signal.new(),
        connections = {},
        sideAttributes = {},
        alive = true
    };
    local _ = u146.humanoid;

    if type(v139) == "number" then
        u146.userId = v139;
        v139 = getDescription(v139);
    elseif type(v139) == "table" then
        u146.userId = v139.id;
        v139 = getDescription(v139.id, v139.type);
    end;

    setmetatable(u146, u3);

    if v137 and not u2 then
        if u9 then
            table.insert(u146.connections, v137.OnServerEvent:Connect(function(p147, p148, ...) -- Line: 1046
                -- upvalues: u146 (copy), u114 (ref)
                if p147 and u146.player ~= p147 then
                    return;
                end;

                if not table.find(u114, p148) then
                    return;
                end;

                u146[p148](u146, ...);
            end));
        else
            table.insert(u146.connections, v137.OnClientEvent:Connect(function(p149, ...) -- Line: 1053
                -- upvalues: u146 (copy)
                u146[p149](u146, ...);
            end));
        end;
    end;

    u146.spawnPos = u146.startPos;
    u146.finalPos = u146.startPos;
    u146.currentPos = u146.startPos;
    u146.rigType = u146.humanoid.ClassName == "Humanoid" and (u146.humanoid.RigType.Name or "MeshRig") or "MeshRig";
    u146.humanoidDescription = v139 or u146.humanoid:GetAppliedDescription();
    u146.defaultData = {
        humanoid = u146.humanoid,
        animator = u146.animator
    };

    if not u2 and (v145 and (not u9 and v145 ~= game.Players.LocalPlayer)) then
        local connections = u146.connections;
        local u150 = u135;

        function u146.GetActiveCharacter(p151) -- Line: 1093
            -- upvalues: u150 (ref)
            return u150;
        end;

        local function setupPosListener(u152: userdata, u153: boolean) -- Line: 1098
            -- upvalues: u150 (ref), u146 (copy), connections (copy)
            if not u152 then
                return;
            end;

            u150 = u152;

            local function updatePos() -- Line: 1104
                -- upvalues: u146 (ref), u152 (copy), u150 (ref), u153 (copy)
                task.wait();

                if not u146.alive then
                    return;
                end;

                local v154 = u152:GetAttribute("ServerPos") or u152:GetPivot();
                local v155 = u152:GetAttribute("ServerOffset") or (u146.spawnPos or CFrame.new()):Inverse() * v154;
                u150 = u152;
                u146.serverOff = v155 or CFrame.new();
                u146:SetPosition();
                task.defer(function() -- Line: 1122
                    -- upvalues: u153 (ref), u152 (ref), u146 (ref)
                    task.wait();

                    if u153 then
                        u152:PivotTo(u146.finalPos);
                    end;
                end);
            end;

            if connections[u152] then
                return updatePos();
            end;

            connections[u152] = u152:GetAttributeChangedSignal("ServerPos"):Connect(updatePos);
            local AttributeChangedSignal = u152:GetAttributeChangedSignal("ServerOffset");
            table.insert(connections, AttributeChangedSignal:Connect(updatePos));
            updatePos();
        end;

        task.spawn(setupPosListener, u135);

        if u135:FindFirstChild("Rig") then
            task.spawn(function() -- Line: 1148
                -- upvalues: setupPosListener (copy), u135 (ref)
                setupPosListener(u135.Rig:WaitForChild("PlayerRig"), true);
            end);
        end;

        connections.REPLICATION_ChildAdded = u135.ChildAdded:Connect(function(p156) -- Line: 1153
            -- upvalues: connections (copy), u135 (ref), setupPosListener (copy)
            if p156:IsA("Folder") and (p156.Name == "Rig" and not connections[p156]) then
                connections[p156] = u135.ChildAdded:Connect(function(p157) -- Line: 1156
                    -- upvalues: setupPosListener (ref)
                    if p157:IsA("Model") and p157.Name == "PlayerRig" then
                        setupPosListener(p157, true);
                    end;
                end);
                setupPosListener(p156:WaitForChild("PlayerRig"), true);
            end;
        end);
    end;

    u146:SetPosition(u146.startPos, true);

    if u138 and u138 ~= "" then
        if v143 then
            task.spawn(function() -- Line: 1173
                -- upvalues: u146 (copy), u138 (copy)
                u146:LoadAnim(u138);
            end);
        else
            u146:LoadAnim(u138);
        end;
    end;

    return u146;
end;

function u3.Destroy(u158) -- Line: 1184
    -- upvalues: Players (copy), u9 (copy)
    u158.alive = false;

    if u158.connections then
        for _, v in u158.connections do
            pcall(function() -- Line: 1189
                -- upvalues: v (copy)
                v:Disconnect();
            end);
        end;

        u158.connections = {};
    end;

    if u158.animationLoaded then
        u158.animationLoaded:DisconnectAll();
    end;

    if u158.animationEnded then
        u158.animationEnded:DisconnectAll();
    end;

    if u158.animationPlayed then
        u158.animationPlayed:DisconnectAll();
    end;

    if u158.currentTrackStop then
        u158.currentTrackStop:Disconnect();
        u158.currentTrackStop = nil;
    end;

    if u158.trackedIdleBeat then
        u158.trackedIdleBeat:Disconnect();
        u158.trackedIdleBeat = nil;
    end;

    u158:UnloadRig();
    local charModel = u158.charModel;

    if charModel then
        pcall(function() -- Line: 1215
            -- upvalues: charModel (copy)
            charModel:SetAttribute("ServerOffset", nil);
            charModel:SetAttribute("ServerPos", nil);
        end);
        pcall(function() -- Line: 1217
            -- upvalues: charModel (copy), u158 (copy)
            charModel:PivotTo(u158.spawnPos);
        end);

        if u158.destroyChar then
            pcall(function() -- Line: 1220
                -- upvalues: charModel (copy)
                charModel:Destroy();
            end);
        else
            local u159 = (not u158.hasPlayer or charModel and (u158.player ~= nil and (u158.player.Character == charModel and (u158.player.Parent ~= nil and Players:IsAncestorOf(u158.player))))) and true or false;

            if not u9 then
                pcall(function() -- Line: 1233
                    -- upvalues: charModel (copy), u159 (ref)
                    charModel.Parent = u159 and workspace or nil;
                end);

                if not u159 then
                    pcall(function() -- Line: 1235
                        -- upvalues: charModel (copy)
                        charModel:Destroy();
                    end);
                end;
            end;
        end;
    end;

    u158:UnloadAllFromMemory();
    table.clear(u158);
    u158.locked = true;
end;

function u3.AddAnimation(p160: table, p161: string, p162: any, p163: number?, p164: boolean?, p165: any, p166: userdata?) -- Line: 1250
    -- upvalues: u9 (copy), CacheService (copy)
    if p160.locked then
        return nil;
    end;

    local v167 = p166 or p160.animator;

    if not v167 then
        return nil;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = getId(p162);
    local v168 = v167:LoadAnimation(Animation);
    v168.Name = p161;
    v168:AdjustSpeed(p163 or 1);
    v168:SetAttribute("Speed", p163);

    if p165 ~= Enum.AnimationPriority.Movement and not u9 then
        CacheService.cacheAnimation(Animation);
    end;

    v168.Looped = p164 or false;
    v168.Priority = p165 or v168.Priority;

    if not (p166 and true or false) then
        p160.animations[p161] = v168;
    end;

    return v168;
end;

function u3.linkActionsToRate(p169, p170) -- Line: 1285
    for i, v in p169:GetActions() do
        p169:SetAnimationSpeed(i, (v:GetAttribute("Speed") or 1) * p170 or 1);
    end;
end;

local AfterImage = ReplicatedStorage.Modules.Assets.Templates.AfterImage;
local TweenInfo_new_ret = TweenInfo.new(0.5);
local u171 = { { -0.05, 0 }, { 0, 0.05 }, { 0, -0.05 }, { 0.05, 0 } };

function u3.CreateAfterImage(p172: table, p173: number?, p174, p175: number?, p176: userdata?) -- Line: 1301
    -- upvalues: AfterImage (copy), u171 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    if not p172.locked and p172.alive then
        local ActiveCharacter = p172:GetActiveCharacter();
        local v177 = p175 or 1;
        local u178 = AfterImage:Clone();
        u178.Parent = p176 or ActiveCharacter.PrimaryPart;
        u178.CurrentCamera = workspace.CurrentCamera;
        u178.ImageColor3 = p174 or Color3.new(1, 1, 1);
        ActiveCharacter.Archivable = true;
        ActiveCharacter:Clone().Parent = u178;
        local v179 = u171[(p173 or 0) + 1] or { 0, 0 };
        TweenService:Create(u178, TweenInfo_new_ret, {
            ImageTransparency = 1,
            Position = UDim2.new(v179[1] * v177, 0, v179[2] * v177, 0)
        }):Play();
        task.delay(0.5, function() -- Line: 1328
            -- upvalues: u178 (copy)
            u178:Destroy();
        end);

        return u178;
    end;
end;

function u3.GetFace(p180) -- Line: 1335
    local ActiveCharacter = p180:GetActiveCharacter();

    return getFaceFromCharacter(ActiveCharacter);
end;

function u3.loadDescription(p181: table, p182: userdata?, p183: table?, p184: table?) -- Line: 1340
    return loadDescription(p181:GetActiveCharacter(), nil, p182, p183, p184);
end;

function u3.HideFace(p185) -- Line: 1345
end;

function u3.ShowFace(p186) -- Line: 1349
end;

function u3.GetTrack(p187, p188) -- Line: 1353
    return p187.animations[p188];
end;

function u3.GetIdles(p189) -- Line: 1357
    local v190 = {};

    for i, v in p189.animations do
        if p189:isTrackIdle(v) then
            v190[i] = v;
        end;
    end;

    return v190;
end;

function u3.GetActions(p191) -- Line: 1369
    local v192 = {};

    for i, v in p191.animations do
        if not (p191:isTrackDirectional(v) or p191:isTrackIdle(v)) then
            v192[i] = v;
        end;
    end;

    return v192;
end;

function u3.SetAnimationSpeed(p193, p194, p195) -- Line: 1381
    -- upvalues: Logger (copy)
    local v196 = p193.animations[p194];

    if not v196 then
        return Logger.log("No animations found!");
    end;

    p193:Replicate("SetAnimationSpeed", p194, p195);
    v196:AdjustSpeed(p195 or v196:GetAttribute("Speed"));
end;

function u3.SetAnimTrackSpeed(p197, p198, p199, p200) -- Line: 1390
    local v201 = p197.preloadedAnims[p198];

    if not v201 then
        return;
    end;

    local v202 = v201.animations[p199];

    if not v202 then
        return;
    end;

    p197:Replicate("SetAnimTrackSpeed", p198, p199, p200);
    v202:AdjustSpeed(p200 or v202:GetAttribute("Speed"));
end;

function u3.GetAnimTrack(p203, p204, p205) -- Line: 1402
    local v206 = p203.preloadedAnims[p204];

    if not v206 then
        return;
    end;

    local v207 = v206.animations[p205];

    if v207 then
        return v207;
    end;
end;

local u208 = u12.R15.PrimaryPart.Size.Y / 2 + u12.R15.Humanoid.HipHeight;

function getHeightDiffFromCharacter(p209)
    -- upvalues: u208 (copy)
    local v210 = getHumanoid(p209);

    return not v210:IsA("Humanoid") and 0 or ((v210.RigType ~= Enum.HumanoidRigType.R15 or not p209.PrimaryPart) and 0 or p209.PrimaryPart.Size.Y / 2 + v210.HipHeight - u208);
end;

function u3.getHeightDiffFromCharacter(p211, p212) -- Line: 1424
    return getHeightDiffFromCharacter(p212);
end;

function parseAccesoryTable(p213)
    local string_split_ret = string.split(p213, ",");

    for i = #string_split_ret, 1, -1 do
        local v214 = string_split_ret[i]:gsub(" ", "");
        string_split_ret[i] = nil;
        local v215;

        if v214 == "%HEAD" then
            string_split_ret.Head = true;
            string_split_ret.Hat = true;
            string_split_ret.Face = true;
            string_split_ret.Hair = true;
            string_split_ret.Eyebrow = true;
            string_split_ret.Eyelash = true;
            v215 = i;
        else
            string_split_ret[v214] = true;
            v215 = i;
        end;
    end;

    return string_split_ret;
end;

local u216 = {};

for _, v in { "R6", "R15" } do
    local v217 = {};

    for _, child in u12[v]:GetChildren() do
        if child:IsA("BasePart") then
            local v218 = {
                Wraps = {},
                Attachments = {}
            };
            local Attachments = v218.Attachments;
            local Wraps = v218.Wraps;
            local v219 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("Attachment") then
                    local v220 = child2.CFrame.Position / v219.Size;
                    Attachments[child2.Name] = { v220.X, v220.Y, v220.Z };
                elseif child2:IsA("WrapTarget") then
                    local _ = child2.CageOrigin.Position / v219.Size;
                    local _ = child2.ImportOrigin.Position / v219.Size;
                    Wraps[child2.Name] = child2;
                end;
            end;

            if next(v218.Wraps) or next(v218.Attachments) then
                v217[v219.Name] = v218;
            end;
        end;
    end;

    u216[v] = v217;
end;

function addMissingAttachments(p221: any, p222: userdata)
    -- upvalues: u216 (copy)
    local v223 = u216[p221];

    if not v223 then
        return;
    end;

    for i, v in v223 do
        local v224 = p222:FindFirstChild(i);

        if v224 and v224:IsA("BasePart") then
            local Size = v224.Size;
            local v225 = v;

            for i2, v2 in v.Attachments do
                if not v224:FindFirstChild(i2) then
                    local Attachment = Instance.new("Attachment");
                    Attachment.Name = i2;
                    Attachment.Axis = Vector3.new(1, 0, 0);
                    Attachment.SecondaryAxis = Vector3.new(0, 1, 0);
                    Attachment.CFrame = CFrame.new(v2[1] * Size.X, v2[2] * Size.Y, v2[3] * Size.Z);
                    Attachment.Parent = v224;
                end;
            end;

            if v224:IsA("MeshPart") then
                for i2, v2 in v225.Wraps do
                    if not v224:FindFirstChild(i2) then
                        v2:Clone().Parent = v224;
                    end;
                end;
            end;
        end;
    end;
end;

function optimizeHumanoids(p226: userdata)
    if typeof(p226) ~= "Instance" then
        return;
    end;

    p226.EvaluateStateMachine = false;
    p226.RequiresNeck = false;
    p226.AutoRotate = false;
    p226.AutoJumpEnabled = false;
    p226.BreakJointsOnDeath = false;
    p226:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    p226:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
    p226:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false);
    p226:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
    p226:SetStateEnabled(Enum.HumanoidStateType.Landed, false);
    p226:SetStateEnabled(Enum.HumanoidStateType.Freefall, false);
    p226:SetStateEnabled(Enum.HumanoidStateType.Seated, false);
    p226:SetStateEnabled(Enum.HumanoidStateType.Swimming, false);
end;

function u3.PrepareRig(u227: table, u228: userdata, u229: userdata?, u230: string?, p231: boolean?, p232: boolean?) -- Line: 1540
    -- upvalues: RigAssets (copy), Logger (copy), u12 (copy), u11 (copy), getDescription (copy), u13 (copy), u20 (copy), Signal (copy)
    if not u228 then
        return;
    end;

    local u233 = u228:FindFirstChild(u227.characterSide) or u228;
    local u234 = u233;

    if u230 then
        u233 = u228:FindFirstChild(u227.characterSide .. u230) or u234;
    else
        u230 = "";
    end;

    local function getNumberAttribute(p235: string) -- Line: 1561
        -- upvalues: u233 (ref), u234 (copy), u230 (ref), u228 (copy)
        return u233 ~= u234 and tonumber(u233:GetAttribute(p235)) or (tonumber(u234:GetAttribute(p235 .. u230)) or tonumber(u228:GetAttribute(p235 .. u230)));
    end;

    local function getStringAttribute(p236: string) -- Line: 1566
        -- upvalues: u233 (ref), u234 (copy), u230 (ref), u228 (copy)
        if u233 ~= u234 then
            local Attribute = u233:GetAttribute(p236);

            if Attribute and Attribute ~= "" then
                return Attribute;
            end;
        end;

        local Attribute = u234:GetAttribute(p236 .. u230);

        if Attribute and Attribute ~= "" then
            return Attribute;
        end;

        local Attribute2 = u228:GetAttribute(p236 .. u230);

        if Attribute2 and Attribute2 ~= "" then
            return Attribute2;
        end;
    end;

    local function getBooleanAttribute(p237: string) -- Line: 1579
        -- upvalues: u233 (ref), u234 (copy), u230 (ref), u228 (copy)
        if u233 ~= u234 then
            local Attribute = u233:GetAttribute(p237);

            if Attribute ~= nil then
                return Attribute;
            end;
        end;

        local Attribute = u234:GetAttribute(p237 .. u230);

        if Attribute ~= nil then
            return Attribute;
        end;

        local Attribute2 = u228:GetAttribute(p237 .. u230);

        if Attribute2 ~= nil then
            return Attribute2;
        end;
    end;

    local function getAttribute(p238: string) -- Line: 1592
        -- upvalues: u233 (ref), u234 (copy), u230 (ref), u228 (copy)
        if u233 ~= u234 then
            local Attribute = u233:GetAttribute(p238);

            if Attribute ~= nil then
                return Attribute;
            end;
        end;

        local Attribute = u234:GetAttribute(p238 .. u230);

        if Attribute ~= nil then
            return Attribute;
        end;

        local Attribute2 = u228:GetAttribute(p238 .. u230);

        if Attribute2 ~= nil then
            return Attribute2;
        end;
    end;

    local v239 = RigAssets.get(u228);
    local v240;

    if u233 == u234 then
        v240 = u234:GetAttribute("RigType" .. u230);

        if not v240 or v240 == "" then
            v240 = u228:GetAttribute("RigType" .. u230);

            if not v240 or v240 == "" then
                v240 = nil;
            end;
        end;
    else
        v240 = u233:GetAttribute("RigType");

        if not v240 or v240 == "" then
            v240 = u234:GetAttribute("RigType" .. u230);

            if not v240 or v240 == "" then
                v240 = u228:GetAttribute("RigType" .. u230);

                if not v240 or v240 == "" then
                    v240 = nil;
                end;
            end;
        end;
    end;

    local v241 = v240 or u228:GetAttribute("RigType");

    if not v241 then
        local v242;

        if u233 == u234 then
            v242 = u234:GetAttribute("R6" .. u230);

            if not v242 or v242 == "" then
                v242 = u228:GetAttribute("R6" .. u230);

                if not v242 or v242 == "" then
                    v242 = nil;
                end;
            end;
        else
            v242 = u233:GetAttribute("R6");

            if not v242 or v242 == "" then
                v242 = u234:GetAttribute("R6" .. u230);

                if not v242 or v242 == "" then
                    v242 = u228:GetAttribute("R6" .. u230);

                    if not v242 or v242 == "" then
                        v242 = nil;
                    end;
                end;
            end;
        end;

        if v242 then
            v241 = "R6";
        else
            v241 = u228:GetAttribute("R6") and "R6";
        end;
    end;

    local v243;

    if u233 == u234 then
        v243 = u234:GetAttribute("Character" .. u230);

        if not v243 or v243 == "" then
            v243 = u228:GetAttribute("Character" .. u230);

            if not v243 or v243 == "" then
                v243 = nil;
            end;
        end;
    else
        v243 = u233:GetAttribute("Character");

        if not v243 or v243 == "" then
            v243 = u234:GetAttribute("Character" .. u230);

            if not v243 or v243 == "" then
                v243 = u228:GetAttribute("Character" .. u230);

                if not v243 or v243 == "" then
                    v243 = nil;
                end;
            end;
        end;
    end;

    if not v243 then
        Logger.warn((`IDK how to tell you this bro but {u228.Name} does not have a character rig..`));
    end;

    local u244 = v239 and v239:FindFirstChild(v243 or "");

    if u244 and not v241 then
        local v245 = getHumanoid(u244);

        if v245 and v245:IsA("Humanoid") then
            v241 = v245.RigType.Name;
        end;
    end;

    local u246 = v241 or "R15";

    if not (u230 == "" and u246 == u227.rigType or u244) then
        v243 = u246 .. "DefaultRig";
        u244 = u12[u246];
    end;

    if not u244 then
        return;
    end;

    local v247 = v243 .. u228.Name .. u233.Name .. u230;

    if u227.preloadedRigs and (u227.preloadedRigs[v247] and not p232) then
        return u227.preloadedRigs[v247];
    end;

    local u248 = u244:Clone();
    u248.Name = "PreloadedRig";
    u248.PrimaryPart = u248.PrimaryPart or u248:FindFirstChild("HumanoidRootPart");
    u248.Parent = u11;

    if not u227.alive then
        pcall(function() -- Line: 1646
            -- upvalues: u248 (copy)
            u248:Destroy();
        end);

        return;
    end;

    local u249 = getHumanoid(u248);
    local u250 = u233 ~= u234 and tonumber(u233:GetAttribute("Scale")) or (tonumber(u234:GetAttribute("Scale" .. u230)) or tonumber(u228:GetAttribute("Scale" .. u230))) or 1;
    local u251 = u233 ~= u234 and tonumber(u233:GetAttribute("HipHeight")) or (tonumber(u234:GetAttribute("HipHeight" .. u230)) or tonumber(u228:GetAttribute("HipHeight" .. u230)));
    local v252;

    if u233 == u234 then
        v252 = u234:GetAttribute("Offset" .. u230);

        if v252 == nil then
            v252 = u228:GetAttribute("Offset" .. u230);

            if v252 == nil then
                v252 = nil;
            end;
        end;
    else
        v252 = u233:GetAttribute("Offset");

        if v252 == nil then
            v252 = u234:GetAttribute("Offset" .. u230);

            if v252 == nil then
                v252 = u228:GetAttribute("Offset" .. u230);

                if v252 == nil then
                    v252 = nil;
                end;
            end;
        end;
    end;

    local v253 = u233 ~= u234 and tonumber(u233:GetAttribute("Rotation")) or (tonumber(u234:GetAttribute("Rotation" .. u230)) or tonumber(u228:GetAttribute("Rotation" .. u230))) or 0;
    local v254 = u233 ~= u234 and tonumber(u233:GetAttribute("Zoom")) or (tonumber(u234:GetAttribute("Zoom" .. u230)) or tonumber(u228:GetAttribute("Zoom" .. u230)));

    if u233 ~= u234 then
        v253 = v253 - (tonumber(u234:GetAttribute("Rotation")) or 0);
    end;

    local v255;

    if u233 == u234 then
        v255 = u234:GetAttribute("AnchorRoot" .. u230);

        if v255 == nil then
            v255 = u228:GetAttribute("AnchorRoot" .. u230);

            if v255 == nil then
                v255 = nil;
            end;
        end;
    else
        v255 = u233:GetAttribute("AnchorRoot");

        if v255 == nil then
            v255 = u234:GetAttribute("AnchorRoot" .. u230);

            if v255 == nil then
                v255 = u228:GetAttribute("AnchorRoot" .. u230);

                if v255 == nil then
                    v255 = nil;
                end;
            end;
        end;
    end;

    local u256 = v255 == nil and true or v255;
    local v257;

    if u233 == u234 then
        v257 = u234:GetAttribute("NoDescription" .. u230);

        if v257 == nil then
            v257 = u228:GetAttribute("NoDescription" .. u230);

            if v257 == nil then
                v257 = nil;
            end;
        end;
    else
        v257 = u233:GetAttribute("NoDescription");

        if v257 == nil then
            v257 = u234:GetAttribute("NoDescription" .. u230);

            if v257 == nil then
                v257 = u228:GetAttribute("NoDescription" .. u230);

                if v257 == nil then
                    v257 = nil;
                end;
            end;
        end;
    end;

    local v258 = not v257;
    local v259;

    if u233 == u234 then
        v259 = u234:GetAttribute("HeightFix" .. u230);

        if v259 == nil then
            v259 = u228:GetAttribute("HeightFix" .. u230);

            if v259 == nil then
                v259 = nil;
            end;
        end;
    else
        v259 = u233:GetAttribute("HeightFix");

        if v259 == nil then
            v259 = u234:GetAttribute("HeightFix" .. u230);

            if v259 == nil then
                v259 = u228:GetAttribute("HeightFix" .. u230);

                if v259 == nil then
                    v259 = nil;
                end;
            end;
        end;
    end;

    local u260 = v259 == nil and true or v259;
    local Attributes = u228:GetAttributes();

    for i, v in u234:GetAttributes() do
        Attributes[i] = v;
    end;

    for i, v in u233:GetAttributes() do
        Attributes[i] = v;
    end;

    if type(Attributes.extraIds) == "string" then
        Attributes.extraIds = string.split(Attributes.extraIds, ",");
    end;

    for i, v in u227.animAttributes do
        if Attributes[i] == nil then
            Attributes[i] = v;
        end;
    end;

    if Attributes.extraIds == nil then
        Attributes.extraIds = {};
    end;

    local u261 = {
        rawScale = 1,
        curScale = 1,
        modelScale = 1,
        hideCharacter = u248 and true or false,
        rig = u248,
        rigType = u246,
        humanoid = u249,
        zoom = v254 or 0,
        animator = getAnimator(u248),
        rotation = v253,
        offset = (v252 or CFrame.new()) * CFrame.Angles(0, math.rad(v253), 0),
        defaultPivot = u248:GetPivot(),
        heightOffset = CFrame.new(0, 0, 0),
        rigId = v247,
        descSettings = Attributes,
        subRigs = {},
        subRigsAnims = {}
    };

    local function applyHipHeight() -- Line: 1714
        -- upvalues: u251 (copy), u227 (copy), u249 (copy)
        if not (u251 and u227.alive) then
            return;
        end;

        task.defer(function() -- Line: 1717
            -- upvalues: u249 (ref), u251 (ref)
            task.wait();
            u249.HipHeight = u251;
        end);
    end;

    local function loadAppearance() -- Line: 1723
        -- upvalues: u233 (ref), u234 (copy), u230 (ref), u228 (copy), u229 (copy), getDescription (ref), u227 (copy), u248 (copy), Attributes (copy), u13 (ref), u246 (ref), u244 (ref), u249 (copy), u256 (ref), u250 (copy), u261 (copy), u251 (copy), u260 (ref), u20 (ref)
        local v262;

        if u233 == u234 then
            v262 = u234:GetAttribute("AccessoryWhitelist" .. u230);

            if v262 == nil then
                v262 = u228:GetAttribute("AccessoryWhitelist" .. u230);

                if v262 == nil then
                    v262 = nil;
                end;
            end;
        else
            v262 = u233:GetAttribute("AccessoryWhitelist");

            if v262 == nil then
                v262 = u234:GetAttribute("AccessoryWhitelist" .. u230);

                if v262 == nil then
                    v262 = u228:GetAttribute("AccessoryWhitelist" .. u230);

                    if v262 == nil then
                        v262 = nil;
                    end;
                end;
            end;
        end;

        local v263;

        if u233 == u234 then
            v263 = u234:GetAttribute("AccessoryBlacklist" .. u230);

            if v263 == nil then
                v263 = u228:GetAttribute("AccessoryBlacklist" .. u230);

                if v263 == nil then
                    v263 = nil;
                end;
            end;
        else
            v263 = u233:GetAttribute("AccessoryBlacklist");

            if v263 == nil then
                v263 = u234:GetAttribute("AccessoryBlacklist" .. u230);

                if v263 == nil then
                    v263 = u228:GetAttribute("AccessoryBlacklist" .. u230);

                    if v263 == nil then
                        v263 = nil;
                    end;
                end;
            end;
        end;

        local v264 = v262 and parseAccesoryTable(v262) or {};
        local v265 = v263 and parseAccesoryTable(v263) or {};
        local v266 = nil;

        if type(u229) == "number" then
            v266 = getDescription(u229);
        elseif type(u229) == "table" then
            v266 = getDescription(u229.id, u229.type);
        elseif typeof(u229) == "Instance" then
            v266 = u229;
        end;

        if not v266 then
            return;
        end;

        if not u227.alive then
            pcall(function() -- Line: 1743
                -- upvalues: u248 (ref)
                u248:Destroy();
            end);

            return;
        end;

        v266.Archivable = true;

        for _, descendant in v266:GetDescendants() do
            descendant.Archivable = true;
        end;

        local v267 = v266:Clone();

        if next(v264) or next(v265) then
            for _, child in v267:GetChildren() do
                if child:IsA("AccessoryDescription") then
                    local Name = child.AccessoryType.Name;

                    if not v264[Name] or v265[Name] then
                        child:Destroy();
                    end;
                end;
            end;
        end;

        if Attributes.useFaces and #u248:QueryDescendants("[$Face]") > 0 then
            for _, v in v267:QueryDescendants(">AccessoryDescription") do
                if u13[v.AccessoryType] then
                    pcall(v.Destroy, v);
                end;
            end;
        end;

        if u246 == "D15" or u246 == "S15" then
            local AppliedDescription = getHumanoid(u244):GetAppliedDescription();
            v267.Torso = AppliedDescription.Torso;
            v267.LeftLeg = AppliedDescription.LeftLeg;
            v267.RightLeg = AppliedDescription.RightLeg;
            v267.LeftArm = AppliedDescription.LeftArm;
            v267.RightArm = AppliedDescription.RightArm;
        end;

        local v268 = loadDescription(u248, u249, v267, Attributes, {
            headScale = v267.HeadScale
        });

        if not u227.alive then
            pcall(function() -- Line: 1800
                -- upvalues: u248 (ref)
                u248:Destroy();
            end);

            return;
        end;

        if u248.PrimaryPart then
            u248.PrimaryPart.Anchored = u256 or false;
        end;

        if u250 ~= 1 then
            u248:ScaleTo(1 * u250 * (u261.parentRig and u261.parentRig.rawScale or 1));
            u261.modelScale = 1 * u250;
        end;

        if u251 and u227.alive then
            task.defer(function() -- Line: 1717
                -- upvalues: u249 (ref), u251 (ref)
                task.wait();
                u249.HipHeight = u251;
            end);
        end;

        if v268 and u260 then
            local CFrame_new_ret = CFrame.new(0, getHeightDiffFromCharacter(u248), 0);
            local v269 = CFrame_new_ret:Inverse();
            local v270 = u20[u249.RigType.Name] or {};

            for _, v in v268.rootWelds or {} do
                local v271 = v.Part0 and table.find(v270, v.Part0.Name) and v.Part0.Parent == u248;
                local v272 = v.Part1 and table.find(v270, v.Part1.Name) and v.Part1.Parent == u248;

                if v271 and v.Part0.Name == "HumanoidRootPart" then
                    v.C0 = v.C0 * v269;
                end;

                if v272 and v.Part1.Name == "HumanoidRootPart" then
                    v.C1 = v.C1 * v269;
                end;
            end;

            local v273 = u261;
            v273.offset = v273.offset * CFrame_new_ret;
            u261.heightOffset = CFrame_new_ret;
        end;
    end;

    if u246 == "MeshRig" then
        v258 = false;
    end;

    if not (u249 and u249:IsA("Humanoid")) then
        v258 = false;
    end;

    local u274;

    if v258 and p231 then
        u274 = Signal.new() or nil;
    else
        u274 = nil;
    end;

    if v258 then
        if p231 then
            u274:Once(function() -- Line: 1858
                -- upvalues: u274 (ref)
                u274 = nil;
            end);
            task.spawn(function() -- Line: 1862
                -- upvalues: loadAppearance (copy), u274 (ref)
                loadAppearance();
                u274:Fire();
            end);
        else
            loadAppearance();
        end;
    elseif u251 and u227.alive then
        task.defer(function() -- Line: 1717
            -- upvalues: u249 (copy), u251 (copy)
            task.wait();
            u249.HipHeight = u251;
        end);
    end;

    if u248.PrimaryPart then
        u248.PrimaryPart.Anchored = u256 or false;
    end;

    return u261, u274;
end;

function u3.PreloadRig(u275: table, p276: userdata, p277: userdata?, p278: boolean?) -- Line: 1882
    -- upvalues: CacheService (copy), Logger (copy), AppearanceManager (copy)
    if not p276 or u275.locked then
        return;
    end;

    local u279, v280 = u275:PrepareRig(p276, p277 or u275.humanoidDescription, nil, false, p278);

    if not u279 then
        return;
    end;

    if not u275.alive then
        pcall(function() -- Line: 1889
            -- upvalues: u279 (copy)
            u279.rig:Destroy();
        end);

        for _, v in u279.subRigs do
            pcall(function() -- Line: 1894
                -- upvalues: v (copy)
                v.rig:Destroy();
            end);
        end;

        return;
    end;

    if u275.preloadedRigs and u275.preloadedRigs[u279.rigId] then
        return u275.preloadedRigs[u279.rigId];
    end;

    if v280 then
        v280:Once(function() -- Line: 1904
            -- upvalues: u275 (copy), u279 (copy), CacheService (ref)
            if u275.currentRig == u279 then
                u275:Scale();
                u275:SetPosition();
                task.spawn(function() -- Line: 1910
                    -- upvalues: u279 (ref), CacheService (ref)
                    for _, descendant in u279.rig:GetDescendants() do
                        if descendant:IsA("Decal") then
                            CacheService.cacheImage(descendant.ColorMapContent);
                        elseif descendant:IsA("MeshPart") or descendant:IsA("SpecialMesh") then
                            CacheService.cacheMesh(descendant);
                        end;
                    end;
                end);
            end;
        end);
    end;

    Logger.log("Loaded main rig for", p276.Name);
    local v281 = p276:FindFirstChild(u275.characterSide or "") or p276;

    for i = 1, tonumber(v281:GetAttribute("ExtraChars")) or (tonumber(p276:GetAttribute("ExtraChars")) or 0) do
        local v282;

        if u275.alive then
            local v283 = tostring(i + 1);
            local v284 = u279.descSettings.extraIds[i];
            local v285 = v284 == nil and {
                type = "User ID",
                id = AppearanceManager.getRandomFriend(false, u275.userId)
            } or v284;
            Logger.log("Trying to load extra rig", i);
            local u286, v287 = u275:PrepareRig(p276, v285, v283, u275.asyncDescriptions, p278);

            if u286 then
                if v287 then
                    v287:Once(function() -- Line: 1941
                        -- upvalues: u286 (copy), u279 (copy), u275 (copy)
                        local rig = u286.rig;
                        local v288 = u279 and u279.defaultPivot or nil;

                        if u275.currentRig == u279 then
                            v288 = u275.finalPos;
                        end;

                        if u279.rig and rig then
                            rig:PivotTo(v288 * u286.offset);
                        end;
                    end);
                end;

                u286.parentRig = u279;
                local rig = u286.rig;
                rig.Name = "ExtraCharacter" .. v283;
                rig:PivotTo(u279.defaultPivot * u286.offset, 0);
                rig.Parent = u279.rig;
                local subRigsAnims = u279.subRigsAnims;
                local v289 = getAnimations(p276, u275.characterSide .. v283);
                table.insert(subRigsAnims, u275:LoadAnimationsOnAnimator(v289, u286.animator));
                table.insert(u279.subRigs, u286);
                task.spawn(function() -- Line: 1971
                    -- upvalues: rig (copy), CacheService (ref)
                    for _, descendant in rig:GetDescendants() do
                        if descendant:IsA("Decal") then
                            CacheService.cacheImage(descendant.ColorMapContent);
                        elseif descendant:IsA("MeshPart") or descendant:IsA("SpecialMesh") then
                            CacheService.cacheMesh(descendant);
                        end;
                    end;
                end);
                v282 = i;
            else
                v282 = i;
            end;
        else
            v282 = i;
        end;
    end;

    if u275.alive then
        print("loaded rig", u279.rig.Parent, u279.rig);
        u275.preloadedRigs[u279.rigId] = u279;

        return u279;
    end;

    pcall(function() -- Line: 1984
        -- upvalues: u279 (copy)
        u279.rig:Destroy();
    end);

    for _, v in u279.subRigs do
        pcall(function() -- Line: 1989
            -- upvalues: v (copy)
            v.rig:Destroy();
        end);
    end;
end;

function u3.UnloadAllFromMemory(p290) -- Line: 2002
    for i, _ in p290.preloadedAnims or {} do
        p290:UnloadAnim(i);
    end;
end;

function u3.UnloadAnim(p291, p292) -- Line: 2008
    local v293 = p292 or p291.currentAnim;
    local v294 = (p291.preloadedAnims or {})[v293];

    if not v294 then
        return;
    end;

    if p291.currentAnim == v293 then
        p291:UnloadRig();
    end;

    local rig = v294.rig;

    if rig then
        p291.preloadedRigs[rig.rigId] = nil;

        if rig.rig then
            for _, v in rig.rig:QueryDescendants("Highlight") do
                if v:IsDescendantOf(rig.rig) then
                    v.Enabled = false;
                    v.Adornee = nil;
                    v.Parent = nil;
                    v:Destroy();
                end;
            end;

            for _, v in rig.rig:QueryDescendants("LayerCollector, Script, LocalScript") do
                v.Enabled = false;
            end;
        end;

        if rig.rig then
            pcall(function() -- Line: 2035
                -- upvalues: rig (copy)
                rig.rig:Destroy();
            end);
        end;

        for _, v in rig.subRigs or {} do
            if v.rig then
                pcall(function() -- Line: 2042
                    -- upvalues: v (copy)
                    v.rig:Destroy();
                end);
            end;
        end;
    end;

    for _, v in v294.animations or {} do
        v:Stop(0);
        pcall(function() -- Line: 2050
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    p291.preloadedAnims[v293] = nil;
end;

function u3.PreloadAnim(u295: table, p296: any, p297: userdata?, p298: boolean?) -- Line: 2057
    -- upvalues: Logger (copy), Emotes (copy), Animations (copy)
    if not p296 or u295.locked then
        return;
    end;

    local v299 = type(p296) == "string" and p296 and p296 or p296.Name;
    local v300 = u295.preloadedAnims[v299];

    if v300 and not p298 then
        if v300.isLoading then
            Logger.log("Preloaded animation is already loading, yielding...");

            repeat
                task.wait();
            until not u295.alive or u295.preloadedAnims[v299] ~= v300;
        end;

        return u295.alive and u295.preloadedAnims[v299];
    end;

    u295:Replicate("PreloadAnim", p296, p297);
    local v301 = u295.isEmote and Emotes or Animations;
    local v302;

    if type(p296) == "string" then
        v302 = v301:FindFirstChild(v299, true) or p296;
    else
        v302 = p296;
    end;

    if not v302 then
        return;
    end;

    if type(v302) == "string" then
        Logger.log((`{p296} IS A STRING NOT AN ANIM`));

        return;
    end;

    if v302:GetAttribute("Pack") then
        for _, child in v302:GetChildren() do
            if child.ClassName == "Folder" then
                v302 = child;
                break;
            end;
        end;
    end;

    u295.preloadedAnims[v299] = {
        isLoading = true
    };
    local v303 = getAnimations(v302, u295.characterSide);
    local v304 = v302:FindFirstChild(u295.characterSide);
    local Attributes = v302:GetAttributes();

    if v304 then
        for i, v in v304:GetAttributes() do
            Attributes[i] = v;
        end;
    end;

    local v305 = (v302:GetAttribute("OptionalPrefixes") or ""):split(",");

    if v305[1] == "%ALL" then
        v305 = setmetatable({}, {
            __index = function() -- Line: 2117, Name: __index
                return true;
            end
        });
    end;

    for i, v in v305 do
        v305[i] = nil;
        v305[v] = true;
    end;

    local v306 = {
        name = v299,
        rig = u295:PreloadRig(v302, p297, p298),
        isBeatDance = (v303.IdleLeft or v303.IdleRight) and true or false,
        folder = v302,
        optionalPrefixes = v305,
        sideAttrs = Attributes
    };

    if not u295.alive then
        return;
    end;

    u295.animOptionalPrefixes = v305;
    v306.animations = u295:LoadAnimationsOnAnimator(v303, (v306.rig or u295.defaultData).animator);
    u295.animOptionalPrefixes = {};

    if u295.alive then
        if v306.rig and #v306.rig.subRigsAnims > 0 then
            local v307 = {};

            for _, v in v306.rig.subRigsAnims do
                for i, _ in v do
                    v307[i] = true;
                end;
            end;

            for i, _ in v306.animations do
                v307[i] = true;
            end;

            local function animFromName(p308, p309) -- Line: 2166
                -- upvalues: u295 (copy)
                if p308[p309] then
                    return p308[p309];
                end;

                for _, v in u295.prefixes do
                    local v310 = p309:gsub(v, "");

                    if p308[v310] then
                        return p308[v310];
                    end;
                end;

                return nil;
            end;

            for i, _ in v307 do
                local v311 = { (animFromName(v306.animations, i)) };
                local v312 = i;

                for _, v in v306.rig.subRigsAnims do
                    local v313 = animFromName(v, v312);
                    table.insert(v311, v313);
                end;

                v306.animations[v312] = mergeTracks(v311);
            end;
        end;

        u295.preloadedAnims[v299] = v306;
        Logger.log("Preloaded anim " .. v299);

        if u295.loadingAnim or u295.animToLoad ~= v299 then
            return v306;
        end;

        Logger.log("Server caught Preload request received after same anim failed Load request");

        return u295:LoadAnim(v299, p298);
    end;
end;

function u3.BulkPreload(u314: table, p315: table) -- Line: 2200
    local u316 = #p315;
    local coroutine_running_ret = coroutine.running();

    for _, v in p315 do
        task.spawn(function() -- Line: 2207
            -- upvalues: u314 (copy), v (copy), u316 (ref), coroutine_running_ret (copy)
            u314:PreloadAnim(v);
            u316 = u316 - 1;

            if u316 == 0 then
                coroutine.resume(coroutine_running_ret);
            end;
        end);
    end;

    if u316 ~= 0 then
        return coroutine.yield();
    end;
end;

function u3.SetSide(p317: table, p318: string) -- Line: 2223
    -- upvalues: Logger (copy)
    local string_upper_ret = string.upper((tostring(p318 or p317.defaultCharacterSide)));
    Logger.log("Changed Character side to " .. string_upper_ret);
    p317.characterSide = string_upper_ret;
end;

function u3.SetIdleAnim(p319: table, p320: string?) -- Line: 2230
    -- upvalues: Logger (copy)
    p319.idleName = p320 or "Idle";
    p319:Dance();
    Logger.log("Changed Character default idle animation to " .. p319.idleName);
end;

function u3.Hide(p321: table, p322: table?, p323: table?) -- Line: 2238
    local v324;

    if p322 == nil then
        v324 = p323 == nil;
    else
        v324 = false;
    end;

    local v325 = p322 or {};
    local v326 = p323 or {};

    if v324 then
        p321.hidden = true;
    end;

    for _, v in p321.charModel:QueryDescendants("BasePart, FaceInstance") do
        if not table.find(v325, v) or table.find(v326, v) then
            v.Transparency = 1;
        end;
    end;

    for _, v in p321.charModel:QueryDescendants("LayerCollector, Beam, Fire, Sparkles, ParticleEmitter, RopeConstraint") do
        if not table.find(v325, v) or table.find(v326, v) then
            v.Enabled = false;
        end;
    end;
end;

function u3.Show(p327: table, p328: table?, p329: table?) -- Line: 2258
    local currentRig = p327.currentRig;
    local v330;

    if currentRig then
        v330 = currentRig.rig;
    else
        v330 = currentRig;
    end;

    local v331, v332, v333;

    if p328 == nil and p329 == nil then
        v331 = currentRig and (p327.charModel:GetDescendants() or {}) or {};
        v332 = currentRig and (v330:GetDescendants() or {}) or {};
        v333 = true;
    else
        v333 = false;
        v331 = p328 or {};
        v332 = p329 or {};
    end;

    if v333 then
        p327.hidden = false;
    end;

    for _, v in p327.charModel:QueryDescendants("BasePart, FaceInstance") do
        if not (v == p327.charModel.PrimaryPart or currentRig and v == v330.PrimaryPart or table.find(v331, v) and not table.find(v332, v)) then
            v.Transparency = 0;
        end;
    end;

    for _, v in p327.charModel:QueryDescendants("LayerCollector, Beam, Fire, Sparkles, ParticleEmitter, RopeConstraint") do
        if not table.find(v331, v) or table.find(v332, v) then
            v.Enabled = true;
        end;
    end;
end;

function u3.CreateClone(p334) -- Line: 2288
    return p334:GetActiveCharacter():Clone();
end;

function u3.GetActiveCharacter(p335) -- Line: 2292
    return p335.currentRig and p335.currentRig.rig or p335.charModel;
end;

function u3.LoadRig(p336: table, p337: userdata) -- Line: 2296
    -- upvalues: u9 (copy)
    if not p337 then
        return;
    end;

    if p336.currentRig then
        p336:UnloadRig();
    end;

    local v338 = p336:PreloadRig(p337);

    if v338 then
        local rig = v338.rig;
        rig.Name = "PlayerRig";

        if v338.hideCharacter then
            p336:Hide(p336.hidden and {} or rig:GetDescendants());
        end;

        local v339 = p336.charModel:FindFirstChild("Rig") or Instance.new("Folder");
        v339.Name = "Rig";

        for _, descendant in rig:GetDescendants() do
            if descendant.Name == "Highlight" and descendant.ClassName == "Folder" then
                if not u9 then
                    local Highlight = Instance.new("Highlight");
                    Highlight:AddTag("AnimationHighlight");
                    local v340 = descendant;

                    for _, child in descendant:GetChildren() do
                        if hasProperty(Highlight, child.Name) then
                            if child.Name == "DepthMode" then
                                Highlight[child.Name] = Enum.HighlightDepthMode:FromName(child.Value or "") or Enum.HighlightDepthMode.Occluded;
                            else
                                Highlight[child.Name] = child.Value;
                            end;
                        end;
                    end;

                    if Highlight.Adornee == nil then
                        Highlight.Adornee = v340.Parent;
                    end;

                    Highlight.Parent = v340.Parent;
                end;
            elseif descendant:IsA("LayerCollector") or (descendant:IsA("Script") or descendant:IsA("LocalScript")) then
                descendant.Enabled = true;
            elseif descendant:IsA("AudioEmitter") or descendant:IsA("Wire") then
                descendant:Destroy();
            end;
        end;

        p336.rigFolder = v339;
        p336.currentRig = v338;
        p336.humanoid = v338.humanoid;
        p336.animator = v338.animator;
        p336:Scale();
        p336:SetPosition();
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p336.charModel.PrimaryPart;
        WeldConstraint.Part1 = rig.PrimaryPart;
        WeldConstraint.Enabled = true;
        WeldConstraint.Name = "RigWeld";
        WeldConstraint.Parent = v339;
        rig.Parent = v339;
        v339.Parent = p336.charModel;

        return v338;
    end;
end;

function u3.Scale(p341, p342) -- Line: 2375
    local ActiveCharacter = p341:GetActiveCharacter();

    if not ActiveCharacter then
        return;
    end;

    local currentRig = p341.currentRig;
    local v343;

    if currentRig then
        local v344 = p342 or currentRig.rawScale;
        currentRig.rawScale = v344;
        v343 = v344 * currentRig.modelScale;

        if currentRig.curScale == v343 then
            return;
        end;

        currentRig.curScale = v343;
    else
        v343 = p342 or 1;
    end;

    ActiveCharacter:ScaleTo(v343);
end;

function u3.UnloadRig(p345) -- Line: 2407
    -- upvalues: u11 (copy)
    if not p345.currentRig then
        return;
    end;

    local rig = p345.currentRig.rig;
    pcall(function() -- Line: 2411
        -- upvalues: rig (copy), u11 (ref)
        rig.Parent = u11;
        rig.Name = "PreloadedRig";
    end);

    if p345.rigFolder then
        p345.rigFolder:Destroy();
        p345.rigFolder = nil;
    end;

    p345:Show(p345.hidden and (p345.charModel:GetDescendants() or {}) or {});
    p345.currentRig = nil;
    p345.humanoid = p345.defaultData.humanoid;
    p345.animator = p345.defaultData.animator;
end;

function u3.firstAnimLoad(p346, p347) -- Line: 2424
    return p346:postAsyncAnimLoad(p347);
end;

function u3.postAsyncAnimLoad(p348, p349) -- Line: 2428
    if p348.loadingAnim then
        p348.animationStoppedLoading:Wait();
    end;

    if not p348.currentAnim then
        return;
    end;

    p349();
end;

function u3.requestTrackLoad(p350, p351) -- Line: 2437
    -- upvalues: ContentProvider (copy)
    local v352 = p350.Animations[p351];

    if not v352 then
        return;
    end;

    ContentProvider:PreloadAsync({ v352.Animation });
end;

function u3.LoadAnim(u353: table, u354: any, u355: boolean?, p356: boolean?) -- Line: 2444
    -- upvalues: Logger (copy)
    if u353.locked or not u353.alive then
        return;
    end;

    if not p356 then
        u353:Replicate("LoadAnim", u354);
    end;

    if u353.loadingAnim then
        if u353.animQueue ~= u354 then
            Logger.log("Animation trying to load while another animation is loading!");
            local coroutine_running_ret = coroutine.running();
            u353.animQueue = u354;
            u353.animationStoppedLoading:Once(function() -- Line: 2460
                -- upvalues: u353 (copy), u354 (copy), coroutine_running_ret (copy), u355 (copy)
                if u353.animQueue == u354 and u353.alive then
                    return task.spawn(coroutine.resume, coroutine_running_ret, u353:LoadAnim(u354, u355, true));
                end;

                task.spawn(coroutine.resume, coroutine_running_ret);
            end);

            return coroutine.yield();
        end;

        return;
    end;

    u353.loadingAnim = true;
    local v357 = u353:PreloadAnim(u354, nil, u355);

    if not v357 then
        u353.loadingAnim = false;
        local v358;

        if u354 and (type(u354) ~= "string" or not u354) then
            v358 = u354.Name;
        else
            v358 = u354;
        end;

        u353.animToLoad = v358;

        if u353.alive then
            u353.animationStoppedLoading:Fire();

            return Logger.warn("[Character] Animation:", u354, "is not a valid animation!");
        end;

        return;
    end;

    if not u353.alive then
        u353.loadingAnim = false;

        return;
    end;

    u353.animToLoad = nil;
    Logger.log("Loading anim: " .. v357.name);
    u353.currentAnim = v357.name;
    u353.curAnimFile = u354;
    local animations = u353.animations;
    u353.isBeatDance = v357.isBeatDance;
    u353.prevIdle = nil;

    if u353.trackedIdleBeat then
        u353.trackedIdleBeat:Disconnect();
        u353.trackedIdleBeat = nil;
    end;

    u353.animations = v357.animations;
    u353.sideAttributes = v357.sideAttrs;
    u353.animationData = v357;
    u353:Dance();
    u353:LoadRig(v357.folder);

    if u353.animations ~= animations then
        for _, v in animations do
            v:Stop(0);
        end;
    end;

    if not u353.alive then
        u353:UnloadRig();
    end;

    u353.loadingAnim = false;
    u353.animationStoppedLoading:Fire();

    if not u353.alive then
        return;
    end;

    u353.animationLoaded:Fire(v357);
end;

function u3.StopDirectionalAnims(p359) -- Line: 2529
    -- upvalues: u16 (copy)
    for i, _ in u16 do
        local v360 = i;

        for _, v in p359.prefixes do
            local v361 = p359.animations[v360 .. v];

            if v361 then
                v361:Stop(0);
            end;
        end;
    end;
end;

local u362 = {
    [0] = true,
    [1] = true,
    [1000] = true
};

function u3.isActionTrackPlaying(p363) -- Line: 2547
    -- upvalues: u362 (copy)
    for _, v in p363.animator:GetPlayingAnimationTracks() do
        if not u362[v.Priority.Value] then
            return true;
        end;
    end;
end;

function u3.isTrackDirectional(p364, p365) -- Line: 2553
    return p365.Priority == Enum.AnimationPriority.Movement;
end;

function startTrackAt(p366: userdata, p367: number?, p368: number?)
    if not p367 then
        p366:Play(0, nil, p368);

        return;
    end;

    p366:Play(0, nil, p368);
    p366:AdjustSpeed(0);
    p366.TimePosition = p367;
    p366:AdjustSpeed(p368 or 1);
end;

function u3.PlayAsManual(p369, p370, p371, p372) -- Line: 2569
    p369:Play(p370, p371, p372, false);
end;

function u3.GetValidTrack(p373: table, p374: string, p375: string?) -- Line: 2573
    -- upvalues: u9 (copy), Logger (copy)
    local v376 = p375 or (p373.animPrefix or "");
    local v377 = p374 .. (v376 == " " and "" or v376);
    local v378 = p373.animations[v377];

    if v378 then
        p374 = v377;
    else
        v378 = p373.animations[p374];

        if not v378 then
            if not u9 then
                Logger.log("No animation called \'" .. p374 .. "\' found for \'" .. p373.currentAnim .. "\'!");
            end;

            return;
        end;
    end;

    return v378, p374;
end;

function u3._Play(u379: table, u380: userdata, p381: boolean?, p382: string?, u383: number?) -- Line: 2596
    -- upvalues: ContentProvider (copy), RunService (copy)
    if not u380 then
        return;
    end;

    local v384 = u379:isActionTrackPlaying();
    local u385 = p382 or (u379:isTrackDirectional(u380) and "direction" or (u379:isTrackIdle(u380) and "idle" or "action"));

    if p381 == nil then
        p381 = u379.prioritizeActions and u385 == "action" and true or not u379.prioritizeActions;
    end;

    if u385 == "direction" and (v384 and not p381) then
        return;
    end;

    if u385 == "idle" and type(u380) == "table" then
        task.spawn(function() -- Line: 2611
            -- upvalues: u380 (copy), ContentProvider (ref), u383 (copy)
            local u386 = {};

            for _, v in u380.tracks do
                pcall(function() -- Line: 2615
                    -- upvalues: u386 (copy), v (copy)
                    table.insert(u386, v.Animation);
                end);
            end;

            ContentProvider:PreloadAsync(u386);
            startTrackAt(u380, u383, u380.Speed);
        end);
    else
        if u385 ~= "idle" then
            local recentTrack = u379.recentTrack;

            if recentTrack then
                recentTrack:Stop(0);
            end;

            if u379.currentTrackStop then
                u379.currentTrackStop:Disconnect();
                u379.currentTrackStop = nil;
            end;
        end;

        startTrackAt(u380, u383, u380.Speed);
    end;

    if u385 == "idle" then
        local prevIdle = u379.prevIdle;

        if prevIdle and prevIdle ~= u380 then
            prevIdle:Stop(0);
        end;

        u379.prevIdle = u380;

        if u379.isBeatDance then
            if u379.trackedIdleBeat then
                u379.trackedIdleBeat:Disconnect();
                u379.trackedIdleBeat = nil;
            end;

            local u387 = tick();
            u379.trackedIdleBeat = RunService.PreAnimation:Connect(function() -- Line: 2644
                -- upvalues: u387 (copy), u380 (copy), u379 (copy)
                if tick() >= u387 + (u380.Length - 0.04 / u380.Speed) then
                    u379.trackedIdleBeat:Disconnect();
                    u379.trackedIdleBeat = nil;
                    u379.danced = not u379.danced;
                    u379:Dance(true);
                end;
            end);
        end;

        return;
    end;

    u379.recentTrack = u380;

    if u380.Looped then
        return;
    end;

    local function stopAnim() -- Line: 2665
        -- upvalues: u380 (copy), u379 (copy), u385 (ref)
        if not u380 then
            return;
        end;

        u379.recentTrack = nil;
        u380:Stop(0);

        if u385 == "action" then
            u379.animationEnded:Fire(u380.Name);
        end;
    end;

    local u388 = tick();
    local u389 = (u380.Length - 0.04) / u380.Speed;
    u379.currentTrackStop = RunService.PreAnimation:Connect(function(p390: number) -- Line: 2683
        -- upvalues: u388 (copy), u389 (copy), u379 (copy), u380 (copy), u385 (ref)
        if tick() >= u388 + u389 then
            u379.currentTrackStop:Disconnect();
            u379.currentTrackStop = nil;

            if not u380 then
                return;
            end;

            u379.recentTrack = nil;
            u380:Stop(0);

            if u385 == "action" then
                u379.animationEnded:Fire(u380.Name);
            end;
        end;
    end);
end;

function u3.Stop(p391) -- Line: 2692
    local recentTrack = p391.recentTrack;

    if recentTrack then
        recentTrack:Stop(0);
        p391.recentTrack = nil;
    end;

    local currentTrackStop = p391.currentTrackStop;

    if currentTrackStop then
        currentTrackStop:Disconnect();
        p391.currentTrackStop = nil;
    end;
end;

function u3.Play(p392: table, p393: string, p394: string?, p395: number?, p396: boolean?, p397: boolean) -- Line: 2702
    -- upvalues: u2 (ref)
    if p392.locked or not p393 then
        return;
    end;

    local ValidTrack, v398 = p392:GetValidTrack(p393, p394);

    if not ValidTrack then
        return;
    end;

    local v399 = p392:isTrackDirectional(ValidTrack) and "direction" or (p392:isTrackIdle(ValidTrack) and "idle" or "action");

    if p396 == nil then
        p396 = p392.prioritizeActions and v399 == "action" and true or not p392.prioritizeActions;
    end;

    if not p397 then
        if u2 then
            if not p396 then
                p392:Replicate("ManualPlay", v398, p395);
            end;
        else
            p392:Replicate("Play", v398, "", p395, p396);
        end;
    end;

    p392:_Play(ValidTrack, p396, v399, p395);
end;

function u3.isTrackIdle(p400: table, p401: userdata) -- Line: 2727
    return p401.Priority == Enum.AnimationPriority.Idle;
end;

function u3.PlayAnimation(p402, ...) -- Line: 2731
    return p402:Play(...);
end;

function u3.Dance(p403) -- Line: 2735
    local v404;

    if p403.isBeatDance then
        v404 = p403.danced and "IdleRight" or "IdleLeft";
    else
        v404 = p403.idleName;
    end;

    p403:Play(v404);
end;

u3.ChangeAnim = u3.LoadAnim;

function u3.TweenPosition(u405: table, p406, p407: userdata, p408: boolean?) -- Line: 2741
    -- upvalues: VarTweener (copy)
    u405.curTweenID = u405.curTweenID + 1;
    local curTweenID = u405.curTweenID;
    local u409 = p406 or (u405.currentPos or u405.startPos);
    local FinalPosition = u405:GetFinalPosition(u409);
    local ActiveCharacter = u405:GetActiveCharacter();
    local u410 = VarTweener:Create(u405, p407, {
        currentPos = u409
    });
    local u411 = nil;
    u411 = VarTweener:CreateValueTween(u405.finalPos, FinalPosition, p407, function(p412) -- Line: 2750
        -- upvalues: u405 (copy), curTweenID (copy), u410 (copy), u411 (ref), ActiveCharacter (copy)
        if u405.curTweenID == curTweenID then
            u405.finalPos = p412;
            ActiveCharacter:PivotTo(p412);

            return;
        end;

        u410:Pause();
        u411:Pause();
    end);
    u410:Play();
    u411:Play();

    if p408 then
        u410.Completed:Connect(function() -- Line: 2764
            -- upvalues: u405 (copy), u409 (ref)
            u405.startPos = u409;
        end);
    end;

    return VarTweener:MergeTweens(u410, u411);
end;

function u3.GetFinalPosition(p413, p414) -- Line: 2772
    local v415 = p414 or (p413.currentPos or p413.startPos);
    local v416 = (p413.offsetPos or CFrame.new()) * (p413.serverOff or CFrame.new());
    local currentRig = p413.currentRig;
    local v417;

    if currentRig == nil then
        v417 = v416 * (p413.heightOff or CFrame.new());
    else
        v417 = v416 * currentRig.offset;
    end;

    return v415 * v417, v417, v415;
end;

function u3.SetPosition(p418: table, p419, p420: boolean?) -- Line: 2791
    -- upvalues: u2 (ref), Logger (copy), u9 (copy)
    local FinalPosition, v421, v422 = p418:GetFinalPosition(p419);
    local v423 = p418.finalPos == FinalPosition;
    p418.finalPos = FinalPosition;
    p418.currentPos = v422;

    if p420 then
        p418.startPos = v422;
    end;

    if u2 then
        local ActiveCharacter = p418:GetActiveCharacter();

        if ActiveCharacter then
            ActiveCharacter:PivotTo(FinalPosition);
        else
            Logger.warn("NO ACTIVE CHARACTER!");
        end;
    else
        local ActiveCharacter = p418:GetActiveCharacter();

        local function v424() -- Line: 2813
            -- upvalues: ActiveCharacter (copy), FinalPosition (ref), Logger (ref)
            if ActiveCharacter then
                ActiveCharacter:PivotTo(FinalPosition);

                return;
            end;

            Logger.warn("NO ACTIVE CHARACTER!");
        end;

        if u9 then
            if v423 then
                FinalPosition = FinalPosition * CFrame.new(0, 0.001, 0);
                p418.finalPos = FinalPosition;
            end;

            if ActiveCharacter then
                ActiveCharacter:SetAttribute("ServerOffset", v421);
                ActiveCharacter:SetAttribute("ServerPos", v422);
            end;
        end;

        if u9 then
            if ActiveCharacter then
                ActiveCharacter:PivotTo(FinalPosition);
            else
                Logger.warn("NO ACTIVE CHARACTER!");
            end;
        else
            task.defer(v424);
        end;
    end;
end;

function u3.GetRigStorage(p425) -- Line: 2839
    -- upvalues: u11 (copy)
    return u11;
end;

return u3;