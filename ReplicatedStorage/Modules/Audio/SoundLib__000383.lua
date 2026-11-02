-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("SoundService");
local RunService = game:GetService("RunService");
local ContentProvider = game:GetService("ContentProvider");
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Assets = ReplicatedStorage:WaitForChild("Assets");
local VolumeManager = require(Modules.Audio.VolumeManager);
local Logger = require(Modules.Other.Logger);
local General = require(Assets:WaitForChild("UISounds").General);
local SoundGroup = VolumeManager:GetSoundGroup("SFX");
local __CachedSounds = PlayerGui:FindFirstChild("__CachedSounds");

if not __CachedSounds then
    __CachedSounds = Instance.new("Folder");
    __CachedSounds.Name = "__CachedSounds";
    __CachedSounds.Parent = PlayerGui;
end;

local u1 = {
    Pools = {},
    Caches = {},
    Attached = {}
};
local u2 = {};

local function cacheAsset(u3) -- Line: 31
    -- upvalues: ContentProvider (copy)
    if not u3 then
        return;
    end;

    task.spawn(function() -- Line: 33
        -- upvalues: ContentProvider (ref), u3 (copy)
        ContentProvider:PreloadAsync({ u3 });
    end);
end;

local function getSoundFromPath(p4) -- Line: 38
    -- upvalues: SoundGroup (copy), General (copy), Logger (copy)
    if string.sub(p4, 1, 13) == "rbxassetid://" or tonumber(p4) ~= nil then
        local Sound = Instance.new("Sound");
        Sound.Name = "SoundID_" .. string.match(p4, "%d+");
        Sound.SoundId = string.sub(p4, 1, 13) == "rbxassetid://" and p4 and p4 or "rbxassetid://" .. p4;
        Sound.SoundGroup = SoundGroup;

        return Sound;
    end;

    local string_split_ret = string.split(p4, "/");
    local v5 = General;

    for i = 1, #string_split_ret do
        v5 = v5[string_split_ret[i]];

        if not v5 then
            Logger.log("Metadata path not found:", p4);

            return nil;
        end;

        local _ = i;
    end;

    if typeof(v5) ~= "string" then
        return nil;
    end;

    local Sound = Instance.new("Sound");
    Sound.Name = string_split_ret[#string_split_ret];
    Sound.SoundId = v5;
    Sound.SoundGroup = SoundGroup;

    return Sound;
end;

RunService.Heartbeat:Connect(function(p6) -- Line: 69
    -- upvalues: u2 (copy)
    local v7 = {};

    for i, v in u2 do
        if v <= os.clock() then
            v7[#v7 + 1] = i;
        end;
    end;

    for i = 1, #v7 do
        local v8 = v7[i];
        u2[v8] = nil;
        local v9;

        if v8.IsPlaying then
            u2[v8] = os.clock() + v8.TimeLength * 1.5;
            v9 = i;
        else
            v8:Destroy();
            v9 = i;
        end;
    end;
end);

local function queueDeletion(p10) -- Line: 88
    -- upvalues: u2 (copy)
    u2[p10] = os.clock() + p10.TimeLength * 1.5;
end;

function u1.Pool(p11, p12, p13, p14) -- Line: 92
    -- upvalues: getSoundFromPath (copy), ContentProvider (copy), Logger (copy), __CachedSounds (ref)
    if typeof(p12) == "table" then
        for i = 1, #p12 do
            local v15 = p12[i];
            p11:Pool(v15[1], v15[2], v15[3]);
            local _ = i;
        end;

        return;
    end;

    if not p11.Pools[p12] then
        local u16 = getSoundFromPath(p12);

        if not u16 then
            return;
        end;

        if u16 then
            task.spawn(function() -- Line: 33
                -- upvalues: ContentProvider (ref), u16 (copy)
                ContentProvider:PreloadAsync({ u16 });
            end);
        end;

        Logger.log("Initializing pool:", p12 .. ", count:", p13 .. ", aggressive:", p14);
        p11.Pools[p12] = {
            Template = u16,
            Instances = {},
            Aggressive = p14 or false
        };

        for i = 1, p13 do
            local v17 = u16:Clone();
            v17.Parent = __CachedSounds;
            p11.Pools[p12].Instances[#p11.Pools[p12].Instances + 1] = v17;
            local _ = i;
        end;
    end;
end;

function u1.Cache(p18, p19) -- Line: 123
    -- upvalues: getSoundFromPath (copy), ContentProvider (copy), Logger (copy), __CachedSounds (ref)
    if typeof(p19) == "table" then
        for i = 1, #p19 do
            p18:Cache(p19[i]);
            local _ = i;
        end;

        return;
    end;

    if not p18.Caches[p19] then
        local u20 = getSoundFromPath(p19);

        if not u20 then
            return;
        end;

        if u20 then
            task.spawn(function() -- Line: 33
                -- upvalues: ContentProvider (ref), u20 (copy)
                ContentProvider:PreloadAsync({ u20 });
            end);
        end;

        Logger.log("Initializing single cache:", p19);
        u20.Parent = __CachedSounds;
        p18.Caches[p19] = u20;
    end;
end;

function u1.CacheInstance(p21, p22) -- Line: 144
    -- upvalues: getSoundFromPath (copy), ContentProvider (copy), Logger (copy), __CachedSounds (ref)
    if typeof(p22) ~= "table" then
        if not p21.Caches[p22] then
            local u23 = getSoundFromPath(p22);

            if not u23 then
                return nil;
            end;

            if u23 then
                task.spawn(function() -- Line: 33
                    -- upvalues: ContentProvider (ref), u23 (copy)
                    ContentProvider:PreloadAsync({ u23 });
                end);
            end;

            Logger.log("Initializing single cache:", p22);
            u23.Parent = __CachedSounds;
            p21.Caches[p22] = u23;
        end;

        return p21.Caches[p22];
    end;

    local v24 = {};

    for i = 1, #p22 do
        v24[i] = p21:CacheInstance(p22[i]);
        local _ = i;
    end;

    return v24;
end;

local function playFromPool(p25) -- Line: 168
    -- upvalues: u1 (copy), __CachedSounds (ref), u2 (copy)
    local v26 = u1.Pools[p25];

    if not v26 then
        return nil;
    end;

    for i = 1, #v26.Instances do
        local v27 = v26.Instances[i];

        if not v27.IsPlaying then
            v27:Play();

            return v27;
        end;

        local _ = i;
    end;

    local u28 = v26.Template:Clone();
    u28.Parent = __CachedSounds;

    if v26.Aggressive then
        u28.Ended:Connect(function() -- Line: 184
            -- upvalues: u28 (copy), u2 (ref)
            local v29 = u28;
            u2[v29] = os.clock() + v29.TimeLength * 1.5;
        end);
    else
        v26.Instances[#v26.Instances + 1] = u28;
    end;

    u28:Play();

    return u28;
end;

function u1.Play(p30: any, p31: string, p32: number?) -- Line: 195
    -- upvalues: playFromPool (copy), getSoundFromPath (copy), ContentProvider (copy), __CachedSounds (ref), u2 (copy)
    if p30.Pools[p31] then
        local v33 = playFromPool(p31);

        if v33 and p32 then
            v33.Volume = p32;
        end;

        return v33;
    end;

    if p30.Caches[p31] then
        local v34 = p30.Caches[p31];

        if v34.IsPlaying then
            v34:Stop();
        end;

        if p32 then
            v34.Volume = p32;
        end;

        v34:Play();

        return v34;
    end;

    local u35 = getSoundFromPath(p31);

    if not u35 then
        return nil;
    end;

    if p32 then
        u35.Volume = p32;
    end;

    if u35 then
        task.spawn(function() -- Line: 33
            -- upvalues: ContentProvider (ref), u35 (copy)
            ContentProvider:PreloadAsync({ u35 });
        end);
    end;

    u35.Parent = __CachedSounds;
    u35.Ended:Connect(function() -- Line: 226
        -- upvalues: u35 (copy), u2 (ref)
        local v36 = u35;
        u2[v36] = os.clock() + v36.TimeLength * 1.5;
    end);
    u35:Play();

    return u35;
end;

function u1.PlayFromId(p37: any, p38: any, p39: number?, p40: number?, p41: boolean?, u42: function?) -- Line: 234
    -- upvalues: SoundGroup (copy), u2 (copy), ContentProvider (copy), __CachedSounds (ref)
    if typeof(p38) == "number" then
        p38 = tostring(p38) or p38;
    end;

    local v43 = string.sub(p38, 1, 13) == "rbxassetid://" and p38 and p38 or "rbxassetid://" .. p38;
    local Sound = Instance.new("Sound");
    Sound.Name = "SoundID_" .. (string.match(p38, "%d+") or "Unknown");
    Sound.SoundId = v43;
    Sound.SoundGroup = SoundGroup;

    if p39 then
        Sound.Volume = p39;
    end;

    if p40 then
        Sound.PlaybackSpeed = p40;
    end;

    if p41 then
        Sound.Looped = true;
    else
        Sound.Ended:Connect(function() -- Line: 249
            -- upvalues: Sound (copy), u2 (ref), u42 (copy)
            local v44 = Sound;
            u2[v44] = os.clock() + v44.TimeLength * 1.5;

            if u42 then
                u42();
            end;
        end);
    end;

    if Sound then
        task.spawn(function() -- Line: 33
            -- upvalues: ContentProvider (ref), Sound (copy)
            ContentProvider:PreloadAsync({ Sound });
        end);
    end;

    Sound.Parent = __CachedSounds;
    Sound:Play();

    return Sound;
end;

function u1.Attach(u45, u46, p47, u48) -- Line: 261
    -- upvalues: getSoundFromPath (copy), ContentProvider (copy), __CachedSounds (ref), u2 (copy)
    if not u45.Attached[u46] then
        u45.Attached[u46] = {
            Connections = {},
            RogueSounds = {},
            AttachedEvents = {}
        };
        local v49 = u46.Destroying:Connect(function() -- Line: 269
            -- upvalues: u45 (copy), u46 (copy)
            u45:Detach(u46);
        end);
        u45.Attached[u46].Connections[#u45.Attached[u46].Connections + 1] = v49;
    end;

    local u50 = u45.Attached[u46];
    local v51 = {};
    local v52 = {};

    for i, v in next, p47 do
        v51[#v51 + 1] = { i, v };
    end;

    for i = 1, #v51 do
        local u53 = v51[i][1];
        local u54 = v51[i][2];
        local v55;

        if u50.AttachedEvents[u53] or typeof(u46[u53]) ~= "RBXScriptSignal" then
            v55 = i;
        else
            local v62 = u46[u53]:Connect(function(...) -- Line: 287
                -- upvalues: u54 (copy), u45 (copy), u50 (copy), getSoundFromPath (ref), ContentProvider (ref), __CachedSounds (ref), u2 (ref), u48 (copy), u53 (copy)
                local v56 = "";

                if typeof(u54) == "table" then
                    if #u54 > 0 then
                        v56 = u54[math.random(1, #u54)];
                    end;
                else
                    v56 = u54;
                end;

                if v56 and v56 ~= "" then
                    if u45.Pools[v56] or u45.Caches[v56] then
                        u45:Play(v56);
                    else
                        local u57 = not u50.RogueSounds[v56] and getSoundFromPath(v56);

                        if u57 then
                            if u57 then
                                task.spawn(function() -- Line: 33
                                    -- upvalues: ContentProvider (ref), u57 (copy)
                                    ContentProvider:PreloadAsync({ u57 });
                                end);
                            end;

                            u57.Parent = __CachedSounds;
                            u57.Ended:Connect(function() -- Line: 307
                                -- upvalues: u57 (copy), u2 (ref)
                                local v58 = u57;
                                u2[v58] = os.clock() + v58.TimeLength * 1.5;
                            end);
                            u50.RogueSounds[v56] = u57;
                        end;

                        if u50.RogueSounds[v56] then
                            if u50.RogueSounds[v56].IsPlaying then
                                local v59 = u50.RogueSounds[v56];
                                u2[v59] = os.clock() + v59.TimeLength * 1.5;
                                local u60 = u50.RogueSounds[v56]:Clone();
                                u60.Parent = __CachedSounds;
                                u60.Ended:Connect(function() -- Line: 321
                                    -- upvalues: u60 (copy), u2 (ref)
                                    local v61 = u60;
                                    u2[v61] = os.clock() + v61.TimeLength * 1.5;
                                end);
                                u60:Play();
                            else
                                u50.RogueSounds[v56]:Play();
                            end;
                        end;
                    end;
                end;

                if u48 then
                    u48(u53, ...);
                end;
            end);
            u50.Connections[#u50.Connections + 1] = v62;
            u50.AttachedEvents[u53] = true;
            v52[u53] = v62;
            v55 = i;
        end;
    end;

    return u46, v52;
end;

function u1.Detach(p63, p64) -- Line: 347
    -- upvalues: u2 (copy)
    local v65 = p63.Attached[p64];

    if v65 then
        for i = 1, #v65.Connections do
            v65.Connections[i]:Disconnect();
            local _ = i;
        end;

        local v66 = {};

        for i in next, v65.RogueSounds do
            v66[#v66 + 1] = i;
        end;

        for i = 1, #v66 do
            local v67 = v65.RogueSounds[v66[i]];
            u2[v67] = os.clock() + v67.TimeLength * 1.5;
            local _ = i;
        end;

        p63.Attached[p64] = nil;
    end;
end;

return u1;