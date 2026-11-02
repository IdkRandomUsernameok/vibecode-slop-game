-- Decompiled with Potassium's decompiler.

local SoundService = game:GetService("SoundService");
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local DataManager = require(Modules.Data.DataManager);
local Data = DataManager:GetData();
local u1 = {
    Main = {
        Setting = "GlobalVolume",
        AudioFader = SoundService:WaitForChild("MainFader"),
        SoundGroup = SoundService:WaitForChild("Main")
    },
    Gameplay = {
        Setting = "GameplayVolume",
        AudioFader = SoundService.MainFader:WaitForChild("Gameplay"),
        SoundGroup = SoundService.Main:WaitForChild("Gameplay")
    },
    SFX = {
        Setting = "SFXVolume",
        AudioFader = SoundService.MainFader:WaitForChild("SFX"),
        SoundGroup = SoundService.Main:WaitForChild("SFX")
    },
    UI = {
        Setting = "UIVolume",
        AudioFader = SoundService.MainFader:WaitForChild("UI"),
        SoundGroup = SoundService.Main:WaitForChild("UI")
    },
    Stages = {
        Setting = "StageVolume",
        AudioFader = SoundService.MainFader:WaitForChild("Stages"),
        SoundGroup = SoundService.Main:WaitForChild("Stages")
    }
};
local u2 = {};
local u3 = {};

for _, v in u1 do
    if v.Setting then
        u2[v.Setting] = true;
    end;
end;

function u3.UpdateVolume(p4) -- Line: 57
    -- upvalues: u1 (copy), DataManager (copy), Data (copy)
    for _, v in u1 do
        local Setting = v.Setting;

        if Setting then
            local v5 = DataManager.getByPath(Data, Setting) / 10;
            v.SoundGroup.Volume = v5;
            v.AudioFader.Volume = v5;
        end;
    end;
end;

function u3.SetGroupVolume(p6: table, p7: string, p8: number) -- Line: 71
    -- upvalues: u1 (copy)
    local v9 = u1[p7];

    if not v9 then
        return warn("[VolManager] Invalid group to set volume to");
    end;

    v9.SoundGroup.Volume = p8;
    v9.AudioFader.Volume = p8;
end;

function u3.GetGroupVolume(p10: table, p11: string) -- Line: 79
    -- upvalues: u1 (copy)
    local v12 = u1[p11];

    if v12 then
        return v12.AudioFader.Volume;
    end;

    return warn("[VolManager] Invalid group to set volume to");
end;

function u3.GetOutput(p13: table, p14: string) -- Line: 87
    -- upvalues: u1 (copy)
    return u1[p14] and u1[p14].AudioFader or nil;
end;

function u3.GetSoundGroup(p15: table, p16: string) -- Line: 92
    -- upvalues: u1 (copy)
    return u1[p16] and u1[p16].SoundGroup or nil;
end;

DataManager.DataChanged:Connect(function(p17) -- Line: 96
    -- upvalues: u2 (copy), u3 (copy)
    if not u2[p17] then
        return;
    end;

    u3:UpdateVolume();
end);
u3:UpdateVolume();

return u3;