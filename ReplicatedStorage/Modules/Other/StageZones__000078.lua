-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local DataManager = require(Modules.Data.DataManager);
local Signal = require(Modules.Lib.Signal);
local VolumeManager = require(Modules.Audio.VolumeManager);
local LocalPlayer = Players.LocalPlayer;
local u2 = 0;
local Data = DataManager:GetData();
local u3 = nil;
local u4 = nil;
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = nil;
local OverlapParams_new_ret = OverlapParams.new();
OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
OverlapParams_new_ret.MaxParts = 1;

function u1.disableZones(p9) -- Line: 35
    -- upvalues: u1 (copy)
    u1:setUpdateState(false);
end;

function u1.reenableZones(p10) -- Line: 39
    -- upvalues: u1 (copy)
    u1:setUpdateState(true);
end;

function u1.setUpdateState(u11, p12) -- Line: 43
    -- upvalues: RunService (copy), u4 (ref), u2 (ref)
    if RunService:IsServer() then
        return;
    end;

    local v13 = p12 and true or nil;

    if u11.updateState == v13 then
        return;
    end;

    u11.updateState = v13;

    if not v13 then
        if u4 then
            u4:Disconnect();
            u4 = nil;
        end;

        return;
    end;

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    u4 = RunService.Heartbeat:Connect(function(p14: number) -- Line: 53
        -- upvalues: u2 (ref), u11 (copy)
        u2 = u2 + p14;

        if u2 >= 0.016666666666666666 then
            u2 = 0;
            u11:update();
        end;
    end);
end;

function u1.update(p15) -- Line: 65
    -- upvalues: u3 (ref), OverlapParams_new_ret (copy), u6 (copy), u8 (ref)
    if not u3 then
        return;
    end;

    local v16 = workspace:GetPartsInPart(u3, OverlapParams_new_ret)[1];
    local v17 = u6[v16 or -1];

    if not (v16 and v17) then
        if u8 then
            u8.isPlrInside = false;
            u8.localPlrExited:Fire();
            u8 = nil;
        end;

        return;
    end;

    if u8 then
        if u8 == v17 then
            return;
        end;

        u8.isPlrInside = false;
        u8.localPlrExited:Fire();
    end;

    v17.isPlrInside = true;
    v17.localPlrEntered:Fire();
    u8 = v17;
end;

function u1.addStage(p18: table, u19: userdata) -- Line: 97
    -- upvalues: u5 (copy), Signal (copy), TweenService (copy), Data (copy), VolumeManager (copy), u6 (copy), u7 (copy), OverlapParams_new_ret (copy)
    if u5[u19] then
        return;
    end;

    local Sound = u19:WaitForChild("Sound");
    local u20 = Sound:FindFirstChildOfClass("SoundGroup");
    local u21 = Sound:FindFirstChildOfClass("AudioFader");
    local u22;

    if u21 then
        u22 = u21:FindFirstChildOfClass("Wire") or nil;
    else
        u22 = nil;
    end;

    local StageHitbox = u19:WaitForChild("StageHitbox");
    local v23 = {
        isPlrInside = false,
        soundPart = Sound,
        hitbox = StageHitbox,
        localPlrEntered = Signal.new(),
        localPlrExited = Signal.new()
    };

    if u20 then
        u20.Volume = 0;
    end;

    if u21 then
        u21.Volume = 0;
    end;

    if u22 then
        u22.TargetInstance = nil;
    end;

    local u24 = nil;
    v23.localPlrExited:Connect(function() -- Line: 130
        -- upvalues: u20 (copy), TweenService (ref), u21 (copy), u24 (ref), u22 (copy)
        if u20 then
            TweenService:Create(u20, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                Volume = 0
            }):Play();
        end;

        if u21 then
            TweenService:Create(u21, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                Volume = 0
            }):Play();
        end;

        u24 = task.delay(1, function() -- Line: 138
            -- upvalues: u24 (ref), u22 (ref)
            u24 = nil;

            if u22 then
                u22.TargetInstance = nil;
            end;
        end);
    end);
    v23.localPlrEntered:Connect(function() -- Line: 146
        -- upvalues: Sound (copy), u19 (copy), Data (ref), u24 (ref), u22 (copy), VolumeManager (ref), u20 (copy), TweenService (ref), u21 (copy)
        if Sound then
            if not u19:GetAttribute("Playing") then
                for _, child in Sound:GetChildren() do
                    if child:IsA("Sound") and child.Name ~= "Emote" then
                        child:Stop();
                    end;
                end;
            end;

            if not Data.StreamerMode and true or not u19:GetAttribute("CopyrightedSong") then
                if u24 then
                    task.cancel(u24);
                    u24 = nil;
                end;

                if u22 then
                    u22.TargetInstance = VolumeManager:GetOutput("Stages");
                end;

                if u20 then
                    TweenService:Create(u20, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                        Volume = 1
                    }):Play();
                end;

                if u21 then
                    TweenService:Create(u21, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                        Volume = 1
                    }):Play();
                end;
            end;
        end;
    end);
    u5[u19] = v23;

    if StageHitbox then
        u6[StageHitbox] = v23;
        table.insert(u7, StageHitbox);
        OverlapParams_new_ret.FilterDescendantsInstances = u7;
    end;
end;

function u1.getStageData(p25: table, p26: userdata) -- Line: 186
    -- upvalues: u5 (copy)
    return u5[p26];
end;

function u1.removeStage(p27: table, p28: userdata) -- Line: 190
    -- upvalues: u5 (copy), u7 (copy), OverlapParams_new_ret (copy), u6 (copy)
    if not u5[p28] then
        return;
    end;

    local v29 = u5[p28];
    u5[p28] = nil;
    local hitbox = v29.hitbox;

    if hitbox then
        local table_find_ret = table.find(u7, hitbox);

        if table_find_ret then
            table.remove(u7, table_find_ret);
            OverlapParams_new_ret.FilterDescendantsInstances = u7;
        end;

        u6[hitbox] = nil;
    end;
end;

if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(function(p30: userdata) -- Line: 210, Name: forChar
        -- upvalues: u3 (ref)
        local u31 = p30:WaitForChild("HumanoidRootPart", 5) or p30.PrimaryPart;
        u3 = u31;
        p30.Destroying:Once(function() -- Line: 214
            -- upvalues: u3 (ref), u31 (copy)
            if u3 == u31 then
                u3 = nil;
            end;
        end);
    end);

    if LocalPlayer.Character then
        local Character = LocalPlayer.Character;
        local u32 = Character:WaitForChild("HumanoidRootPart", 5) or Character.PrimaryPart;
        u3 = u32;
        Character.Destroying:Once(function() -- Line: 214
            -- upvalues: u3 (ref), u32 (copy)
            if u3 == u32 then
                u3 = nil;
            end;
        end);
    end;
end;

return u1;