-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Signal = require(Modules.Lib.Signal);
local Logger = require(Modules.Other.Logger);
local Medium = Enum.AudioWindowSize.Medium;
latency_samples = (Medium == Enum.AudioWindowSize.Large and 4096 or (Medium == Enum.AudioWindowSize.Small and 256 or 1024)) * 0.75;
local u2 = latency_samples / 48000;
Logger.log("Internal pitch effect offset used:", u2 * 1000, "ms");

function u1.new(u3: userdata, p4: userdata) -- Line: 102
    -- upvalues: Signal (copy), u1 (copy), Medium (copy)
    if pcall(function() -- Line: 103
        -- upvalues: u3 (copy)
        return u3:GetOutputPins();
    end) then
        p4 = p4 or u3;
    end;

    local v5 = {
        isStatic = false,
        curAudio = nil,
        curPath = "",
        timeLength = -1,
        speed = 1,
        pitched = true,
        paused = true,
        timePosition = 0,
        _startTime = 0,
        curAudioChanged = Signal.new(),
        playingPaths = {},
        paths = {},
        audios = {},
        timeLengthChanged = Signal.new(),
        parent = u3,
        output = p4,
        ended = Signal.new()
    };
    local v6 = setmetatable(v5, u1);
    local AudioPitchShifter = Instance.new("AudioPitchShifter");
    AudioPitchShifter.Pitch = 1;
    AudioPitchShifter.Bypass = true;
    AudioPitchShifter.WindowSize = Medium;
    AudioPitchShifter.Name = "PitchEffect";
    local AudioFader = Instance.new("AudioFader");
    AudioFader.Volume = 0.6683439175686147;
    AudioFader.Bypass = true;
    local Wire = Instance.new("Wire");
    Wire.SourceInstance = AudioPitchShifter;
    Wire.TargetInstance = AudioFader;
    local Wire2 = Instance.new("Wire");
    Wire2.SourceInstance = AudioFader;
    Wire2.TargetInstance = p4;
    v6.pitchEffect = AudioPitchShifter;
    v6.pitchEffectWire = Wire;
    v6.volFix = AudioFader;
    v6.volFixWire = Wire2;
    Wire.Parent = AudioPitchShifter;
    Wire2.Parent = AudioFader;
    AudioPitchShifter.Parent = u3;
    AudioFader.Parent = u3;
    v6.streamTarget = AudioPitchShifter;
    v6.streamFinal = Wire2;

    return v6;
end;

function u1.setSpeed(p7: table, p8: number) -- Line: 201
    p7.speed = p8;
    p7.isPitchEffectUsed = not p7.pitched and p8 ~= 1;
    local volFix = p7.volFix;

    if volFix then
        volFix.Bypass = not p7.isPitchEffectUsed;
    end;

    local pitchEffect = p7.pitchEffect;

    if pitchEffect then
        pitchEffect.Bypass = not p7.isPitchEffectUsed;
        pitchEffect.Pitch = 1 / p8;
    end;

    for _, v in p7.paths do
        for _, v2 in v.audios do
            v2.Obj.PlaybackSpeed = p8 * v2.Speed;
        end;
    end;
end;

function u1.setPitched(p9: table, p10: boolean) -- Line: 225
    p9.pitched = p10 or false;

    if p10 then
        p10 = p9.speed ~= 1;
    end;

    p9.isPitchEffectUsed = p10;
    local volFix = p9.volFix;

    if volFix then
        volFix.Bypass = not p9.isPitchEffectUsed;
    end;

    local pitchEffect = p9.pitchEffect;

    if pitchEffect then
        pitchEffect.Bypass = not p9.isPitchEffectUsed;
    end;
end;

function u1.setOutput(p11: table, p12: userdata) -- Line: 240
    p11.output = p12;
    local volFixWire = p11.volFixWire;

    if volFixWire then
        volFixWire.TargetInstance = p12;
    end;
end;

function u1.getAudios(p13) -- Line: 249
    local v14 = {};

    for _, v in p13.audios do
        table.insert(v14, v.Obj);
    end;

    return v14;
end;

local u15 = {};

function getIdInfo(p16)
    -- upvalues: u15 (ref)
    local v17 = u15[tostring(p16)] or (u15[tonumber(p16) or -1] or p16);

    return type(v17) ~= "table" and {
        Id = v17
    } or v17;
end;

function u1.setIdOverrides(p18: table, p19: table) -- Line: 271
    -- upvalues: u15 (ref)
    u15 = p19;
end;

function u1.parsePath(p20: table, p21: table, p22: string?) -- Line: 275
    local v23 = {
        usesSplits = false,
        splitLength = 0,
        splitGap = 10,
        playing = false,
        curSplit = 0,
        length = -1,
        audios = {},
        audiosByName = {},
        wires = {},
        pathName = p22,
        folder = Instance.new("Folder")
    };
    v23.folder.Name = p22 or "unnamedPath";

    if p21.Segments then
        local v24 = p21.InitVolumeMult or 1;

        if v24 <= 0 and p20.isStatic then
            return;
        end;

        local Wire = Instance.new("Wire");
        Wire.Parent = v23.folder;
        table.insert(v23.wires, Wire);
        local v25 = {};

        for i = 1, #p21.Segments do
            table.insert(v25, p21.Segments[i][1]);
            local _ = i;
        end;

        local v26 = getIdInfo(table.concat(v25, ","));
        local v27 = type(v26) ~= "table" and {} or v26;
        local v28 = v27.SegmentExtraTime or (p21.SegmentExtraTime or 10);
        local v29 = v27.SegmentLength or (p21.SegmentLength or 0);
        v23.usesSplits = true;
        v23.splitLength = v29 / (v27.Speed or (p21.Speed or 1));
        v23.splitGap = v28;
        v23.length = 0;

        for i = 1, #(v27.Segments or p21.Segments) do
            local v30 = (v27.Segments or p21.Segments)[i];
            local v31 = v30[1];
            local v32;

            if v31 then
                local AudioPlayer = Instance.new("AudioPlayer");
                AudioPlayer.Name = (p22 and (p22 .. "/" or "") or "") .. "Segment" .. i;
                local Content_fromUri_ret = Content.fromUri("rbxassetid://" .. (v31 or ""));
                local v33 = v30[3] or v27.Speed or (p21.Speed or 1);
                local v34 = v30[2] or v27.Volume or (p21.Volume or 1);
                local v35 = v27.Side or (p21.Side or nil);
                local v36 = v27.ChannelLayout or (p21.ChannelLayout or nil);
                v23.length = v23.length + v29 / v33;
                AudioPlayer.AudioContent = Content_fromUri_ret;
                AudioPlayer.PlaybackSpeed = p20.speed * v33;
                AudioPlayer.Volume = v34 * v24;
                AudioPlayer.Parent = v23.folder;

                if v35 then
                    local AudioChannelSplitter = Instance.new("AudioChannelSplitter");
                    local AudioChannelMixer = Instance.new("AudioChannelMixer");
                    AudioChannelSplitter.Layout = Enum.AudioChannelLayout:FromName(v36 or "Stereo") or Enum.AudioChannelLayout.Stereo;
                    AudioChannelMixer.Layout = Enum.AudioChannelLayout.Mono;
                    local Wire2 = Instance.new("Wire");
                    Wire2.SourceName = v35;
                    Wire2.SourceInstance = AudioChannelSplitter;
                    Wire2.TargetName = "Center";
                    Wire2.TargetInstance = AudioChannelMixer;
                    Wire2.Parent = AudioChannelSplitter;
                    local Wire3 = Instance.new("Wire");
                    Wire3.SourceInstance = AudioChannelMixer;
                    Wire3.TargetInstance = p20.streamTarget;
                    Wire3.Parent = AudioChannelMixer;
                    Wire.TargetInstance = AudioChannelSplitter;
                    table.insert(v23.wires, Wire2);
                    table.insert(v23.wires, Wire3);
                    AudioChannelSplitter.Parent = v23.folder;
                    AudioChannelMixer.Parent = v23.folder;
                else
                    Wire.TargetInstance = p20.streamTarget;
                end;

                table.insert(v23.audios, {
                    Obj = AudioPlayer,
                    Speed = v33,
                    Volume = v34,
                    Name = "Segment" .. i,
                    Wire = Wire
                });
                v23.audiosByName["Segment" .. i] = v23.audios[#v23.audios];
                v32 = i;
            else
                v32 = i;
            end;
        end;

        v23.mainAudio = v23.audios[#v23.audios];
    else
        if not p21.SoundNames then
            local v37 = p21.Voices and p21.Voices ~= 0;
            local v38 = {};

            if p21.Instrumental and p21.Instrumental ~= 0 then
                table.insert(v38, "Instrumental");
            end;

            if v37 then
                table.insert(v38, "Voices");
            end;

            p21.SoundNames = v38;
        end;

        if table.find(p21.SoundNames, p21.MainSound or "") then
            p21.MainSound = p21.SoundNames[1];
        end;

        local v39 = nil;

        for _, v in p21.SoundNames do
            local v40 = p21[v];

            if v40 then
                local v41, v42, v43, v44, v45, v46;

                if type(v40) == "table" then
                    local v47 = getIdInfo(v40.Id) or getIdInfo(v40[1]);
                    v41 = Content.fromUri("rbxassetid://" .. (v47.Id or ""));
                    v42 = v47.Volume or v40.Volume or (p21.Volume or 1);
                    v43 = v40.InitVolumeMult or (p21.InitVolumeMult or 1);
                    v44 = v47.Speed or v40.Speed or (p21.Speed or 1);
                    v45 = v47.Side or v40.Side or (p21.Side or nil);
                    v46 = v47.ChannelLayout or v40.ChannelLayout or (p21.ChannelLayout or nil);
                else
                    local v48 = getIdInfo(v40);
                    v41 = typeof(v40) == "Content" and v40 and v40 or Content.fromUri("rbxassetid://" .. (v48.Id or ""));
                    v42 = v48.Volume or p21[v .. "Volume"] or (p21.Volume or 1);
                    v43 = p21[v .. "InitVolumeMult"] or (p21.InitVolumeMult or 1);
                    v44 = v48.Speed or p21[v .. "Speed"] or (p21.Speed or 1);
                    v45 = v48.Side or p21[v .. "Side"] or (p21.Side or nil);
                    v46 = v48.ChannelLayout or p21[v .. "ChannelLayout"] or (p21.ChannelLayout or nil);
                end;

                if v43 > 0 or not p20.isStatic then
                    local AudioPlayer = Instance.new("AudioPlayer");
                    AudioPlayer.Name = (p22 and (p22 .. "/" or "") or "") .. v;
                    AudioPlayer.AudioContent = v41;
                    AudioPlayer.PlaybackSpeed = p20.speed * v44;
                    AudioPlayer.Volume = v42 * v43;
                    local Wire = Instance.new("Wire");
                    Wire.Parent = AudioPlayer;

                    if v45 then
                        local AudioChannelSplitter = Instance.new("AudioChannelSplitter");
                        local AudioChannelMixer = Instance.new("AudioChannelMixer");
                        AudioChannelSplitter.Layout = Enum.AudioChannelLayout:FromName(v46 or "Stereo") or Enum.AudioChannelLayout.Stereo;
                        AudioChannelMixer.Layout = Enum.AudioChannelLayout.Mono;
                        local Wire2 = Instance.new("Wire");
                        Wire2.SourceName = v45;
                        Wire2.SourceInstance = AudioChannelSplitter;
                        Wire2.TargetName = "Center";
                        Wire2.TargetInstance = AudioChannelMixer;
                        Wire2.Parent = AudioChannelSplitter;
                        local Wire3 = Instance.new("Wire");
                        Wire3.SourceInstance = AudioChannelMixer;
                        Wire3.TargetInstance = p20.streamTarget;
                        Wire3.Parent = AudioChannelMixer;
                        Wire.TargetInstance = AudioChannelSplitter;
                        table.insert(v23.wires, Wire2);
                        table.insert(v23.wires, Wire3);
                        AudioChannelSplitter.Parent = AudioPlayer;
                        AudioChannelMixer.Parent = AudioPlayer;
                    else
                        Wire.TargetInstance = p20.streamTarget;
                    end;

                    AudioPlayer.Parent = v23.folder;
                    table.insert(v23.wires, Wire);
                    table.insert(v23.audios, {
                        Obj = AudioPlayer,
                        Speed = v44,
                        Volume = v42,
                        Name = v,
                        Wire = Wire
                    });

                    if p21.MainSound == v then
                        v39 = v23.audios[#v23.audios];
                    end;

                    v23.audiosByName[v] = v23.audios[#v23.audios];
                end;
            end;
        end;

        p20:setMainAudioForPath(v39 or v23.audios[1], v23);
    end;

    v23.folder.Parent = p20.parent;

    return v23;
end;

function u1.setMainAudioForPath(u49, u50, u51) -- Line: 520
    if not u51 then
        return;
    end;

    u51.mainAudio = u50;

    if not u50 then
        return;
    end;

    u51.length = u50.Obj.TimeLength / u50.Speed;

    if u51.length <= 0 then
        u50.Obj:GetPropertyChangedSignal("TimeLength"):Once(function() -- Line: 528
            -- upvalues: u51 (copy), u50 (copy), u49 (copy)
            if u51.mainAudio ~= u50 then
                return;
            end;

            u51.length = u50.Obj.TimeLength / u50.Speed;

            if u49.curPath == u51.pathName then
                u49.timeLength = u51.length;
                u49.timeLengthChanged:Fire(u51.length);
            end;
        end);
    end;
end;

function u1.setVolume(p52: table, p53: number, p54: string?, p55: string?) -- Line: 542
    if not (p55 and p54) then
        if not p55 or p54 then
            if p55 or not p54 then
                for _, v in p52.audios do
                    v.Obj.Volume = v.Volume * p53;
                end;

                return;
            end;

            for _, v in p52.audios do
                if v.Name == p54 then
                    v.Obj.Volume = v.Volume * p53;
                end;
            end;

            return;
        end;

        local v56 = p52.paths[p55];

        if not v56 then
            return warn("[SongPlayer] Tried to set volume of non-existent path");
        end;

        for _, v in v56.audios do
            v.Obj.Volume = v.Volume * p53;
        end;

        return;
    end;

    local v57 = p52.paths[p55];

    if not v57 then
        return warn("[SongPlayer] Tried to set volume of non-existent path");
    end;

    local v58 = v57.audiosByName[p54];

    if not v58 then
        return warn("[SongPlayer] Tried to set volume of non-existent audio");
    end;

    v58.Obj.Volume = v58.Volume * p53;
end;

function u1.tweenVolume(p59: table, p60: userdata, p61: number, p62: string?, p63: string?) -- Line: 575
    -- upvalues: TweenService (copy)
    if not p62 then
        for _, v in p59.paths do
            for _, v2 in v.audios do
                if not p63 or v2.Name == p63 then
                    TweenService:Create(v2.Obj, p60, {
                        Volume = v2.Volume * p61
                    }):Play();
                end;
            end;
        end;

        return;
    end;

    local v64 = p59.paths[p62];

    if not v64 then
        return warn("[SongPlayer] Tried to set volume of non-existent path");
    end;

    for _, v in v64.audios do
        if not p63 or v.Name == p63 then
            TweenService:Create(v.Obj, p60, {
                Volume = v.Volume * p61
            }):Play();
        end;
    end;
end;

function u1.load(p65: table, p66: table) -- Line: 594
    if next(p65.paths) then
        p65:unload();
    end;

    local v67 = not p66.Paths and {
        Paths = {
            _default = p66
        },
        StartingPaths = { "_default" }
    } or p66;

    if v67.DefaultPath and not v67.StartingPaths then
        v67.StartingPaths = v67.DefaultPath;
    end;

    if type(v67.StartingPaths) == "string" then
        v67.StartingPaths = { v67.StartingPaths };
    end;

    for i, v in v67.Paths do
        if not v67.StartingPaths then
            v67.StartingPaths = { i };
        end;

        if table.find(v67.StartingPaths, i) or not p65.isStatic then
            local v68 = p65:parsePath(v, i);

            if v68 then
                p65.paths[i] = v68;

                for _, v2 in v68.audios do
                    table.insert(p65.audios, v2);
                end;
            end;
        end;
    end;

    p65:setPosition(0);
    p65:switchPath(v67.StartingPaths);
end;

function u1.unload(p69) -- Line: 637
    -- upvalues: Medium (copy)
    p69:Pause();

    for _, v in p69.paths do
        local v70 = v;

        for _, v2 in v.wires do
            v2.SourceInstance = nil;
            v2.TargetInstance = nil;
            v2:Destroy();
        end;

        for _, v2 in v70.audios do
            v2.Obj:Destroy();
        end;

        if v70.folder then
            v70.folder:Destroy();
        end;
    end;

    table.clear(p69.paths);
    table.clear(p69.audios);

    if p69.pitchEffect then
        local AudioPitchShifter = Instance.new("AudioPitchShifter");
        AudioPitchShifter.Pitch = 1 / p69.speed;
        AudioPitchShifter.Bypass = not p69.isPitchEffectUsed;
        AudioPitchShifter.WindowSize = Medium;
        AudioPitchShifter.Name = "PitchEffect";
        AudioPitchShifter.Parent = p69.parent;
        local pitchEffectWire = p69.pitchEffectWire;
        pitchEffectWire.SourceInstance = AudioPitchShifter;
        pitchEffectWire.Parent = AudioPitchShifter;

        if p69.streamTarget == p69.pitchEffect then
            p69.streamTarget = AudioPitchShifter;
        end;

        p69.pitchEffect:Destroy();
        p69.pitchEffect = AudioPitchShifter;
    end;
end;

local u71 = {};
local u72 = {};
local u73 = 0;
local u74 = {};

local function acquireLengthSlot() -- Line: 693
    -- upvalues: u73 (ref), u74 (copy)
    if u73 < 10 then
        u73 = u73 + 1;

        return;
    end;

    table.insert(u74, coroutine.running());
    coroutine.yield();
end;

local function releaseLengthSlot() -- Line: 702
    -- upvalues: u74 (copy), u73 (ref)
    local table_remove_ret = table.remove(u74, 1);

    if table_remove_ret then
        task.spawn(table_remove_ret);

        return;
    end;

    u73 = u73 - 1;
end;

local function loadRawLength(p75) -- Line: 711
    local AudioPlayer = Instance.new("AudioPlayer");
    AudioPlayer.AudioContent = Content.fromUri("rbxassetid://" .. tostring(p75));
    AudioPlayer.Parent = game:GetService("SoundService");
    local TimeLength = AudioPlayer.TimeLength;

    if TimeLength <= 0 then
        local coroutine_running_ret = coroutine.running();
        local u76 = false;
        local v77 = AudioPlayer:GetPropertyChangedSignal("TimeLength"):Connect(function() -- Line: 721
            -- upvalues: u76 (ref), AudioPlayer (copy), coroutine_running_ret (copy)
            if u76 or AudioPlayer.TimeLength <= 0 then
                return;
            end;

            u76 = true;
            task.spawn(coroutine_running_ret, AudioPlayer.TimeLength);
        end);
        task.delay(10, function() -- Line: 727
            -- upvalues: u76 (ref), coroutine_running_ret (copy)
            if u76 then
                return;
            end;

            u76 = true;
            task.spawn(coroutine_running_ret, 0);
        end);
        TimeLength = coroutine.yield();
        v77:Disconnect();
    end;

    AudioPlayer:Destroy();

    return TimeLength;
end;

local function getAssetLength(p78) -- Line: 741
    -- upvalues: u71 (copy), u72 (copy), u73 (ref), u74 (copy), loadRawLength (copy)
    if u71[p78] then
        return u71[p78];
    end;

    local v79 = u72[p78];

    if v79 then
        table.insert(v79, coroutine.running());

        return coroutine.yield();
    end;

    local v80 = {};
    u72[p78] = v80;

    if u73 >= 10 then
        table.insert(u74, coroutine.running());
        coroutine.yield();
    else
        u73 = u73 + 1;
    end;

    local v81 = 0;

    for i = 1, 5 do
        v81 = loadRawLength(p78);

        if v81 > 0 then
            break;
        end;

        local _ = i;
    end;

    local table_remove_ret = table.remove(u74, 1);

    if table_remove_ret then
        task.spawn(table_remove_ret);
    else
        u73 = u73 - 1;
    end;

    if v81 > 0 then
        u71[p78] = v81;
    end;

    u72[p78] = nil;

    for _, v in v80 do
        task.spawn(v, v81);
    end;

    return v81;
end;

function u1.getTotalLength(p82) -- Line: 775
    -- upvalues: getAssetLength (copy)
    if not p82 then
        return 0;
    end;

    local v83 = p82.Audio or p82;

    if v83.Paths then
        local v84 = v83.StartingPaths and v83.StartingPaths[1] or next(v83.Paths);
        v83 = v83.Paths[v84];

        if not v83 then
            return 0;
        end;
    end;

    if v83.Segments and #v83.Segments > 0 then
        local v85 = v83.SegmentLength or 0;
        local v86 = v83.Speed or 1;
        local v87 = 0;

        for _, v in v83.Segments do
            v87 = v87 + v85 / (v[3] or v86);
        end;

        return v87;
    end;

    local v88 = v83[v83.MainSound or (v83.SoundNames and (v83.SoundNames[1] or "Instrumental") or "Instrumental")] or (v83.Instrumental or v83.Voices);
    local v89 = nil;
    local v90 = v83.Speed or 1;

    if type(v88) == "table" then
        v90 = v88.Speed or v90;
        v88 = v88.Id or v88[1];
    elseif type(v88) ~= "number" then
        v88 = v89;
    end;

    if not v88 then
        return 0;
    end;

    local v91 = getAssetLength(v88);

    return v91 <= 0 and 0 or v91 / v90;
end;

function u1.Destroy(p92) -- Line: 821
    p92:unload();

    if p92.pitchEffect then
        p92.pitchEffect:Destroy();
        p92.pitchEffect = nil;
        p92.pitchEffectWire = nil;
    end;

    if p92.volFix then
        p92.volFix:Destroy();
        p92.volFix = nil;
        p92.volFixWire = nil;
    end;
end;

function u1.Play(p93) -- Line: 838
    p93:setPosition(0);
    p93:Resume();
end;

function u1.Resume(p94) -- Line: 843
    if not p94.curAudio then
        return;
    end;

    local paused = p94.paused;
    p94.paused = false;
    p94._appliedFix = 0;
    p94._lastRbxPos = (p94.timePosition * 1000 + 0.5) // 1 / 1000;
    p94._startTime = os.clock() - p94.timePosition / p94.speed;

    if paused then
        for _, v in p94.audios do
            v.Obj:Play();
        end;
    end;
end;

function u1.ResumeSyncedWith(p95: table) -- Line: 862
    local os_clock_ret = os.clock();
    local v96 = {};

    for _, v in p95 do
        local paused = v.paused;
        v.paused = false;
        v._appliedFix = 0;
        v._lastRbxPos = (v.timePosition * 1000 + 0.5) // 1 / 1000;
        v._startTime = os_clock_ret - v.timePosition / v.speed;

        if paused then
            local audios = v.audios;
            table.move(audios, 1, #audios, #v96 + 1, v96);
        end;
    end;

    for _, v in v96 do
        v.Obj:Play();
    end;
end;

function u1.Pause(p97) -- Line: 888
    if not p97.paused then
        p97:update();
    end;

    p97.paused = true;

    for _, v in p97.audios do
        v.Obj:Stop();
    end;
end;

function u1.update(p98) -- Line: 900
    -- upvalues: u2 (ref)
    if p98.paused then
        return;
    end;

    local speed = p98.speed;
    local paths = p98.paths;
    local os_clock_ret = os.clock();
    local _appliedFix = p98._appliedFix;

    if _appliedFix ~= 10 then
        local v99 = paths[p98.curPath];

        if not v99 then
            return;
        end;

        local curAudio = p98.curAudio;
        local v100 = curAudio.Obj.TimePosition / curAudio.Speed + v99.splitLength * v99.curSplit;

        if v100 - p98._lastRbxPos > 0 then
            if _appliedFix == 0 then
                p98._startTime = os_clock_ret - v100 / speed;
            else
                p98._startTime = p98._startTime + (os_clock_ret - v100 / speed - p98._startTime) * 0.2;
            end;

            p98._appliedFix = p98._appliedFix + 1;
            p98._lastRbxPos = v100;
        end;
    end;

    local v101 = (os_clock_ret - p98._startTime) * speed - (p98.isPitchEffectUsed and u2 or 0);
    p98.timePosition = v101;

    for i, v in paths do
        if v.usesSplits then
            local v102 = (v101 - 1.5) / speed // (v.splitLength / speed);

            if v.curSplit < v102 then
                v.curSplit = v102;
                local v103 = v.audios[v102 + 1];

                if v103 then
                    local Obj = v103.Obj;
                    Obj.Looping = false;

                    if v.playing then
                        v103.Wire.SourceInstance = Obj;

                        if i == p98.curPath then
                            p98:setCurAudio(v103);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

function u1.setPosition(p104: table, p105: number) -- Line: 960
    local v106 = not p104.paused;

    if v106 then
        p104:Pause();
    end;

    p104.timePosition = p105;

    for i, v in p104.paths do
        if v.usesSplits then
            local math_max_ret = math.max((p105 - 1.5) / p104.speed // (v.splitLength / p104.speed), 0);
            v.curSplit = math_max_ret;
            local v107 = math_max_ret + 1;
            local v108 = i == p104.curPath;
            local v109;

            if #v.audios < v107 then
                v109 = v;

                for _, v2 in v.wires do
                    v2.SourceInstance = nil;
                end;

                if v108 then
                    p104:setCurAudio(v109.audios[#v109.audios]);
                end;
            else
                v109 = v;
            end;

            for i2, v2 in v109.audios do
                local Obj = v2.Obj;
                local v110 = v107 < i2;
                Obj.TimePosition = p105 % v109.splitLength * v2.Speed;
                Obj.Looping = v110;
                Obj.LoopRegion = NumberRange.new(0, v109.splitLength * v2.Speed + (v110 and 0 or v109.splitGap));

                if i2 == v107 and v109.playing then
                    v2.Wire.SourceInstance = Obj;

                    if v108 then
                        p104:setCurAudio(v2);
                    end;
                end;
            end;
        else
            if i == p104.curPath then
                p104:setCurAudio(v.mainAudio);
            end;

            for _, v2 in v.audios do
                v2.Obj.TimePosition = p105 * v2.Speed;
            end;
        end;
    end;

    if v106 then
        p104:Resume();
    end;
end;

function u1.setCurAudio(u111, p112) -- Line: 1020
    if u111.curAudio == p112 then
        return;
    end;

    if u111._audioEnded then
        u111._audioEnded:Disconnect();
        u111._audioEnded = nil;
    end;

    if p112 then
        u111._audioEnded = p112.Obj.Ended:Connect(function() -- Line: 1026
            -- upvalues: u111 (copy)
            u111.ended:Fire();
        end);
    end;

    u111.curAudio = p112;
    u111.curAudioChanged:Fire(p112);
end;

function u1.getLength(p113: table, p114: string?) -- Line: 1035
    local v115 = p113.paths[p114 or ""] or p113.paths[p113.curPath];

    return not v115 and -1 or v115.length;
end;

function u1.switchPath(p116: table, p117: string?) -- Line: 1044
    local v118 = type(p117) == "string" and ({ p117 } or p117) or p117;

    if not v118 then
        return warn("[SongPlayer] Invalid path list");
    end;

    local v119 = p116.paths[v118[1] or ""];

    if not v119 then
        return warn("[SongPlayer] Main path not found: " .. (v118[1] or ""));
    end;

    p116.curPath = v118[1];
    p116.playingPaths = v118;
    p116.timeLength = v119.length;
    p116.timeLengthChanged:Fire(v119.length);

    if v119.usesSplits then
        p116:setCurAudio(v119.audios[v119.curSplit + 1]);
    else
        p116:setCurAudio(v119.mainAudio);
    end;

    for i, v in p116.paths do
        local playing = v.playing;
        local table_find_ret = table.find(v118, i);

        if playing and not table_find_ret then
            v.playing = false;

            for _, v2 in v.wires do
                v2.SourceInstance = nil;
            end;
        elseif not playing and table_find_ret then
            v.playing = true;

            if v.usesSplits then
                local v120 = v.audios[v.curSplit + 1];

                if v120 then
                    v120.Wire.SourceInstance = v120.Obj;
                end;
            else
                for _, v2 in v.audios do
                    v2.Wire.SourceInstance = v2.Obj;
                end;
            end;
        end;
    end;
end;

function u1.stats(p121) -- Line: 1089
    local v122 = 0;

    for _, _ in p121.paths do
        v122 = v122 + 1;
    end;

    local v123 = 0;

    for _, _ in p121.audios do
        v123 = v123 + 1;
    end;

    return {
        totalPaths = v122,
        totalAudios = v123,
        curPath = p121.curPath
    };
end;

return u1;