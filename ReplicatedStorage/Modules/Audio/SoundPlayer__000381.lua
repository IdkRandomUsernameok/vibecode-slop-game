-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 7
end;

local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalSignals = require(ReplicatedStorage.Modules.Signals.LocalSignals);
local DataManager = require(ReplicatedStorage.Modules.Data.DataManager);
local Main = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main");
local Data = DataManager:GetData();
local Sounds = Main.Sounds;
local u2 = nil;
LocalSignals.APILoaded:Once(function(p3) -- Line: 25
    -- upvalues: u2 (ref)
    u2 = p3;
end);

function u1.CacheSound(p4) -- Line: 29
    -- upvalues: Sounds (copy)
    if typeof(p4) ~= "string" then
        local v5 = p4:Clone();
        v5.Parent = Sounds;

        return v5;
    end;

    local Sound = Instance.new("Sound");
    Sound.Name = p4;
    Sound.SoundId = p4;
    Sound.Parent = Sounds;

    return Sound;
end;

function u1.PlaySound(p6: any, p7: number?, p8: number?, p9: boolean?, p10: function?) -- Line: 44
    -- upvalues: Sounds (copy), u1 (copy), Data (copy), Debris (copy)
    local v11;

    if type(p6) == "string" then
        v11 = Sounds:FindFirstChild(p6);

        if not v11 then
            print("[SoundPlayer] Sound " .. p6 .. " not found, creating...");
            v11 = u1.CacheSound(p6);
        end;
    else
        v11 = p6;
    end;

    local v12 = v11:Clone();
    v12.Name = v11.Name .. "_TEMP";
    v12.Volume = v12.Volume * (p7 or 1);
    v12.PlaybackSpeed = p8 or v12.PlaybackSpeed;
    v12.Parent = Sounds;
    v12.Volume = v12.Volume * (Data.GlobalVolume / 10);
    v12:Play();

    if p9 then
        v12.Looped = true;
    else
        Debris:AddItem(v12, v12.TimeLength > 0 and (v12.TimeLength + 0.5 or 15) or 15);

        if p10 then
            v12.Ended:Connect(p10);

            return v12;
        end;
    end;

    return v12;
end;

function u1.PlayTrackedSound(p13: any, p14: number?, p15: number?, p16: boolean?, p17: function?) -- Line: 77
    -- upvalues: Sounds (copy), Data (copy), Debris (copy), u2 (ref)
    local v18;

    if type(p13) == "string" then
        v18 = Sounds:FindFirstChild(p13);

        if not v18 then
            print("[SoundPlayer] Sound " .. p13 .. " not found, creating...");
            v18 = Instance.new("Sound");
            v18.Name = p13;
            v18.SoundId = p13;
            v18.Parent = Sounds;
        end;
    else
        v18 = p13;
    end;

    local v19 = v18:Clone();
    v19.Name = v18.Name .. "_TEMP";
    v19.Volume = v19.Volume * (p14 or 1);
    v19.PlaybackSpeed = p15 or v19.PlaybackSpeed;
    v19.Parent = Sounds;
    v19.Volume = v19.Volume * (Data.GlobalVolume / 10);
    v19:Play();

    if p16 then
        v19.Looped = true;
    else
        Debris:AddItem(v19, v19.TimeLength > 0 and (v19.TimeLength + 0.5 or 15) or 15);

        if p17 then
            v19.Ended:Connect(p17);
        end;
    end;

    u2.addToTrackedSounds(v19);

    return v19;
end;

return u1;