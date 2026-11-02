-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local AtomicBinding = require(script:WaitForChild("AtomicBinding"));

local function loadFlag(u1: string) -- Line: 12
    local success, result = pcall(function() -- Line: 13
        -- upvalues: u1 (copy)
        return UserSettings():IsUserFeatureEnabled(u1);
    end);

    return success and result;
end;

local u2 = "UserSoundsUseRelativeVelocity2";
local success, result = pcall(function() -- Line: 13
    -- upvalues: u2 (copy)
    return UserSettings():IsUserFeatureEnabled(u2);
end);
local u3 = success and result;
local u4 = "UserNewCharacterSoundsApi3";
local success2, result2 = pcall(function() -- Line: 13
    -- upvalues: u4 (copy)
    return UserSettings():IsUserFeatureEnabled(u4);
end);
local u5 = success2 and result2;
local u6 = "UserFixCharSoundsEmitters";
local success3, result3 = pcall(function() -- Line: 13
    -- upvalues: u6 (copy)
    return UserSettings():IsUserFeatureEnabled(u6);
end);
local u7 = success3 and result3;
local u8 = "UserFixCharSoundsEmitterRootPart";
local success4, result4 = pcall(function() -- Line: 13
    -- upvalues: u8 (copy)
    return UserSettings():IsUserFeatureEnabled(u8);
end);
local u9 = success4 and result4;
local u10 = {
    Died = {
        SoundId = "rbxasset://sounds/uuhhh.mp3"
    },
    FreeFalling = {
        SoundId = "rbxasset://sounds/action_falling.ogg",
        Looped = true
    },
    GettingUp = {
        SoundId = "rbxasset://sounds/action_get_up.mp3"
    },
    Jumping = {
        SoundId = "rbxasset://sounds/action_jump.mp3"
    },
    Landing = {
        SoundId = "rbxasset://sounds/action_jump_land.mp3"
    },
    Running = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true,
        Pitch = 1.85
    },
    Splash = {
        SoundId = "rbxasset://sounds/impact_water.mp3"
    },
    Swimming = {
        SoundId = "rbxasset://sounds/action_swim.mp3",
        Looped = true,
        Pitch = 1.6
    }
};
local u11 = {
    Died = {
        AssetId = "rbxasset://sounds/uuhhh.mp3"
    },
    FreeFalling = {
        AssetId = "rbxasset://sounds/action_falling.ogg",
        Looping = true
    },
    GettingUp = {
        AssetId = "rbxasset://sounds/action_get_up.mp3"
    },
    Jumping = {
        AssetId = "rbxasset://sounds/action_jump.mp3"
    },
    Landing = {
        AssetId = "rbxasset://sounds/action_jump_land.mp3"
    },
    Running = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true,
        PlaybackSpeed = 1.85
    },
    Splash = {
        AssetId = "rbxasset://sounds/impact_water.mp3"
    },
    Swimming = {
        AssetId = "rbxasset://sounds/action_swim.mp3",
        Looping = true,
        PlaybackSpeed = 1.6
    }
};

local function map(p12: number, p13: number, p14: number, p15: number, p16: number) -- Line: 89
    return (p12 - p13) * (p16 - p15) / (p14 - p13) + p15;
end;

local function getRelativeVelocity(p17, p18) -- Line: 93
    if not p17 then
        return p18;
    end;

    local v19 = p17.ActiveController and (p17.ActiveController:IsA("GroundController") and p17.GroundSensor or p17.ActiveController:IsA("ClimbController") and p17.ClimbSensor);

    if v19 and v19.SensedPart then
        return p18 - v19.SensedPart:GetVelocityAtPosition(p17.RootPart.Position);
    end;

    return p18;
end;

local function playSound(p20: userdata, p21: boolean?) -- Line: 110
    -- upvalues: u5 (copy)
    if not p21 then
        p20.TimePosition = 0;
    end;

    if u5 and p20:IsA("AudioPlayer") then
        p20:Play();

        return;
    end;

    p20.Playing = true;
end;

local function stopSound(p22: userdata) -- Line: 121
    -- upvalues: u5 (copy)
    if u5 and p22:IsA("AudioPlayer") then
        p22:Stop();

        return;
    end;

    p22.Playing = false;
end;

local function playSoundIf(p23: userdata, p24: boolean) -- Line: 129
    -- upvalues: u5 (copy)
    if u5 and p23:IsA("AudioPlayer") then
        if p23.IsPlaying and not p24 then
            p23:Stop();

            return;
        end;

        if not p23.IsPlaying and p24 then
            p23:Play();
        end;
    else
        p23.Playing = p24;
    end;
end;

local function setSoundLooped(p25: userdata, p26: boolean) -- Line: 141
    -- upvalues: u5 (copy)
    if u5 and p25:IsA("AudioPlayer") then
        p25.Looping = p26;

        return;
    end;

    p25.Looped = p26;
end;

local function shallowCopy(p27) -- Line: 149
    local v28 = {};

    for i, v in pairs(p27) do
        v28[i] = v;
    end;

    return v28;
end;

local u64 = AtomicBinding.new({
    humanoid = "Humanoid",
    rootPart = "HumanoidRootPart"
}, function(p29: table) -- Line: 157, Name: initializeSoundSystem
    -- upvalues: u3 (copy), u5 (copy), SoundService (copy), u7 (copy), u9 (copy), Players (copy), u11 (copy), u10 (copy), RunService (copy)
    local humanoid = p29.humanoid;
    local rootPart = p29.rootPart;
    local u30 = nil;

    if u3 then
        humanoid.Parent:FindFirstChild("ControllerManager");
    end;

    local u31 = {};

    if u5 and SoundService.CharacterSoundsUseNewApi == Enum.RolloutState.Enabled then
        local v32 = nil;
        local v33 = nil;

        if u7 then
            if u9 then
                v33 = humanoid.RootPart or humanoid.Parent;
            else
                v33 = humanoid.RootPart;
            end;
        else
            v32 = Players.LocalPlayer.Character;
        end;

        local v34 = 5;
        local v35 = {};

        while v34 < 150 do
            v35[v34] = 5 / v34;
            v34 = v34 * 1.25;
        end;

        v35[150] = 0;

        if u7 then
            u30 = Instance.new("AudioEmitter", v33);
        else
            u30 = Instance.new("AudioEmitter", v32);
        end;

        u30.Name = "RbxCharacterSoundsEmitter";
        u30:SetDistanceAttenuation(v35);

        for i, v in pairs(u11) do
            local AudioPlayer = Instance.new("AudioPlayer");
            local Wire = Instance.new("Wire");
            AudioPlayer.Name = i;
            Wire.Name = i .. "Wire";
            AudioPlayer.Archivable = false;
            AudioPlayer.Volume = 0.65;

            for i2, v2 in pairs(v) do
                AudioPlayer[i2] = v2;
            end;

            AudioPlayer.Parent = rootPart;
            Wire.Parent = AudioPlayer;
            Wire.SourceInstance = AudioPlayer;
            Wire.TargetInstance = u30;
            u31[i] = AudioPlayer;
        end;
    else
        for i, v in pairs(u10) do
            local Sound = Instance.new("Sound");
            Sound.Name = i;
            Sound.Archivable = false;
            Sound.RollOffMinDistance = 5;
            Sound.RollOffMaxDistance = 150;
            Sound.Volume = 0.65;

            for i2, v2 in pairs(v) do
                Sound[i2] = v2;
            end;

            Sound.Parent = rootPart;
            u31[i] = Sound;
        end;
    end;

    local u36 = {};

    local function stopPlayingLoopedSounds(p37: userdata?) -- Line: 233
        -- upvalues: u36 (copy), u5 (ref)
        local l_pairs = pairs;
        local v38 = {};
        local v39 = p37 or nil;

        for i, v in pairs(u36) do
            v38[i] = v;
        end;

        for i in l_pairs(v38) do
            if i ~= v39 then
                if u5 and i:IsA("AudioPlayer") then
                    i:Stop();
                else
                    i.Playing = false;
                end;

                u36[i] = nil;
            end;
        end;
    end;

    local u40 = {
        [Enum.HumanoidStateType.FallingDown] = function() -- Line: 245
            -- upvalues: stopPlayingLoopedSounds (copy)
            stopPlayingLoopedSounds();
        end,

        [Enum.HumanoidStateType.GettingUp] = function() -- Line: 249
            -- upvalues: stopPlayingLoopedSounds (copy), u31 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local GettingUp = u31.GettingUp;
            GettingUp.TimePosition = 0;

            if u5 and GettingUp:IsA("AudioPlayer") then
                GettingUp:Play();

                return;
            end;

            GettingUp.Playing = true;
        end,

        [Enum.HumanoidStateType.Jumping] = function() -- Line: 254
            -- upvalues: stopPlayingLoopedSounds (copy), u31 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local Jumping = u31.Jumping;
            Jumping.TimePosition = 0;

            if u5 and Jumping:IsA("AudioPlayer") then
                Jumping:Play();

                return;
            end;

            Jumping.Playing = true;
        end,

        [Enum.HumanoidStateType.Swimming] = function() -- Line: 259
            -- upvalues: rootPart (copy), u31 (copy), u5 (ref), stopPlayingLoopedSounds (copy), u36 (copy)
            local math_abs_ret = math.abs(rootPart.AssemblyLinearVelocity.Y);

            if math_abs_ret > 0.1 then
                u31.Splash.Volume = math.clamp((math_abs_ret - 100) * 0.72 / 250 + 0.28, 0, 1);
                local Splash = u31.Splash;
                Splash.TimePosition = 0;

                if u5 and Splash:IsA("AudioPlayer") then
                    Splash:Play();
                else
                    Splash.Playing = true;
                end;
            end;

            stopPlayingLoopedSounds(u31.Swimming);
            local Swimming = u31.Swimming;

            if u5 and Swimming:IsA("AudioPlayer") then
                Swimming:Play();
            else
                Swimming.Playing = true;
            end;

            u36[u31.Swimming] = true;
        end,

        [Enum.HumanoidStateType.Freefall] = function() -- Line: 270
            -- upvalues: u31 (copy), stopPlayingLoopedSounds (copy), u5 (ref), u36 (copy)
            u31.FreeFalling.Volume = 0;
            stopPlayingLoopedSounds(u31.FreeFalling);
            local FreeFalling = u31.FreeFalling;

            if u5 and FreeFalling:IsA("AudioPlayer") then
                FreeFalling.Looping = true;
            else
                FreeFalling.Looped = true;
            end;

            if u31.FreeFalling:IsA("Sound") then
                u31.FreeFalling.PlaybackRegionsEnabled = true;
            end;

            u31.FreeFalling.LoopRegion = NumberRange.new(2, 9);
            local FreeFalling2 = u31.FreeFalling;
            FreeFalling2.TimePosition = 0;

            if u5 and FreeFalling2:IsA("AudioPlayer") then
                FreeFalling2:Play();
            else
                FreeFalling2.Playing = true;
            end;

            u36[u31.FreeFalling] = true;
        end,

        [Enum.HumanoidStateType.Landed] = function() -- Line: 284
            -- upvalues: stopPlayingLoopedSounds (copy), rootPart (copy), u31 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local math_abs_ret = math.abs(rootPart.AssemblyLinearVelocity.Y);

            if math_abs_ret > 75 then
                u31.Landing.Volume = math.clamp((math_abs_ret - 50) * 1 / 50 + 0, 0, 1);
                local Landing = u31.Landing;
                Landing.TimePosition = 0;

                if u5 and Landing:IsA("AudioPlayer") then
                    Landing:Play();

                    return;
                end;

                Landing.Playing = true;
            end;
        end,

        [Enum.HumanoidStateType.Running] = function() -- Line: 293
            -- upvalues: stopPlayingLoopedSounds (copy), u31 (copy), u5 (ref), u36 (copy)
            stopPlayingLoopedSounds(u31.Running);
            local Running = u31.Running;

            if u5 and Running:IsA("AudioPlayer") then
                Running:Play();
            else
                Running.Playing = true;
            end;

            u36[u31.Running] = true;
        end,

        [Enum.HumanoidStateType.Seated] = function() -- Line: 299
            -- upvalues: stopPlayingLoopedSounds (copy)
            stopPlayingLoopedSounds();
        end,

        [Enum.HumanoidStateType.Dead] = function() -- Line: 303
            -- upvalues: stopPlayingLoopedSounds (copy), u31 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local Died = u31.Died;
            Died.TimePosition = 0;

            if u5 and Died:IsA("AudioPlayer") then
                Died:Play();

                return;
            end;

            Died.Playing = true;
        end
    };
    local u48 = {
        [u31.FreeFalling] = function(p41: number, p42: userdata, p43: vector) -- Line: 311
            if p43.Magnitude > 75 then
                p42.Volume = math.clamp(p42.Volume + p41 * 0.9, 0, 1);

                return;
            end;

            p42.Volume = 0;
        end,

        [u31.Running] = function(p44: number, p45: userdata, p46: vector) -- Line: 319
            -- upvalues: humanoid (copy), u5 (ref)
            local v47;

            if p46.Magnitude > 0.5 then
                v47 = humanoid.MoveDirection.Magnitude > 0.5;
            else
                v47 = false;
            end;

            if u5 and p45:IsA("AudioPlayer") then
                if p45.IsPlaying and not v47 then
                    p45:Stop();

                    return;
                end;

                if not p45.IsPlaying and v47 then
                    p45:Play();
                end;
            else
                p45.Playing = v47;
            end;
        end
    };
    local u49 = {
        [Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running
    };
    local u50 = u49[humanoid:GetState()] or humanoid:GetState();

    local function transitionTo(p51) -- Line: 331
        -- upvalues: u40 (copy), u50 (ref)
        local v52 = u40[p51];

        if v52 then
            v52();
        end;

        u50 = p51;
    end;

    local v53 = u50;
    local v54 = u40[v53];

    if v54 then
        v54();
    end;

    u50 = v53;
    local u59 = humanoid.StateChanged:Connect(function(p55, p56) -- Line: 343
        -- upvalues: u49 (copy), u50 (ref), u40 (copy)
        local v57 = u49[p56] or p56;

        if v57 ~= u50 then
            local v58 = u40[v57];

            if v58 then
                v58();
            end;

            u50 = v57;
        end;
    end);
    local u63 = RunService.Stepped:Connect(function(p60: any, p61: number) -- Line: 351
        -- upvalues: u36 (copy), u48 (copy), rootPart (copy)
        for i in pairs(u36) do
            local v62 = u48[i];

            if v62 then
                v62(p61, i, rootPart.AssemblyLinearVelocity);
            end;
        end;
    end);

    return function() -- Line: 362, Name: terminate
        -- upvalues: u59 (copy), u63 (copy), u9 (ref), u30 (ref), u31 (copy)
        u59:Disconnect();
        u63:Disconnect();

        if u9 and u30 then
            u30:Destroy();
        end;

        for _, v in pairs(u31) do
            v:Destroy();
        end;

        table.clear(u31);
    end;
end);
local u65 = {};

local function characterAdded(p66) -- Line: 389
    -- upvalues: u64 (copy)
    u64:bindRoot(p66);
end;

local function characterRemoving(p67) -- Line: 393
    -- upvalues: u64 (copy)
    u64:unbindRoot(p67);
end;

local function playerAdded(p68: userdata) -- Line: 397
    -- upvalues: u65 (copy), u64 (copy), characterAdded (copy), characterRemoving (copy)
    local v69 = u65[p68];

    if not v69 then
        v69 = {};
        u65[p68] = v69;
    end;

    if p68.Character then
        u64:bindRoot(p68.Character);
    end;

    table.insert(v69, p68.CharacterAdded:Connect(characterAdded));
    table.insert(v69, p68.CharacterRemoving:Connect(characterRemoving));
end;

local function playerRemoving(p70: userdata) -- Line: 411
    -- upvalues: u65 (copy), u64 (copy)
    local v71 = u65[p70];

    if v71 then
        for _, v in ipairs(v71) do
            v:Disconnect();
        end;

        u65[p70] = nil;
    end;

    if p70.Character then
        u64:unbindRoot(p70.Character);
    end;
end;

for _, v in ipairs(Players:GetPlayers()) do
    task.spawn(playerAdded, v);
end;

Players.PlayerAdded:Connect(playerAdded);
Players.PlayerRemoving:Connect(playerRemoving);