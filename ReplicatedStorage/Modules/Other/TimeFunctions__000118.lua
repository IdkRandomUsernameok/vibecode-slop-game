-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalSignals = require(ReplicatedStorage.Modules.Signals.LocalSignals);
local u2 = nil;
LocalSignals.APILoaded:Once(function(p3) -- Line: 7
    -- upvalues: u2 (ref)
    u2 = p3;
end);

function u1.getChartSongStepLength() -- Line: 11
    -- upvalues: u2 (ref)
    local v4 = 0;

    for _, v in u2.song.notes do
        local v5 = 16;

        if v.sectionBeats or not v.lengthInSteps then
            if v.sectionBeats then
                v5 = tonumber(v.sectionBeats) * 4;
            end;
        else
            v5 = tonumber(v.lengthInSteps) or 16;
        end;

        v4 = v4 + v5;
    end;

    return v4;
end;

function u1.getTimePast() -- Line: 28
    -- upvalues: u2 (ref)
    local Instrumental = u2.Music.Instrumental;
    local v6 = math.max(u2.Conductor.RawTimePosition, 0) / ((u2.songLength or Instrumental.TimeLength) / Instrumental.PlaybackSpeed);

    return v6 ~= v6 and 0 or v6;
end;

function u1.getTimeLeft() -- Line: 39
    -- upvalues: u2 (ref)
    local Instrumental = u2.Music.Instrumental;
    local v7 = (u2.songLength or Instrumental.TimeLength) / Instrumental.PlaybackSpeed - math.max(u2.Conductor.RawTimePosition, 0) / u2.playbackRate;

    return math.max(v7, 0);
end;

function u1.getBPMFromTime(p8) -- Line: 47
    -- upvalues: u2 (ref)
    local v9 = {
        stepTime = 0,
        songTime = 0,
        bpm = u2.Conductor.BPM,
        stepCrochet = u2.Conductor.StepCrochet
    };

    for i = 1, #u2.Conductor.BPMChangeMap do
        local v10 = u2.Conductor.BPMChangeMap[i];
        local v11;

        if v10.songTime <= p8 then
            v9 = v10;
            v11 = i;
        else
            v11 = i;
        end;
    end;

    if u2.lastBPMChange.songTime <= p8 and u2.lastBPMChange.songTime > v9.songTime then
        return u2.lastBPMChange;
    end;

    return v9;
end;

function u1.calculateSectionLength(p12) -- Line: 69
    -- upvalues: u2 (ref)
    return u2.Conductor.StepCrochet / (64 / (p12 or 1)) / u2.playbackRate;
end;

function u1.getTimeFromStep(p13) -- Line: 73
    -- upvalues: u1 (copy)
    local BPMFromTime = u1.getBPMFromTime(p13);

    return BPMFromTime.songTime + (p13 - BPMFromTime.stepTime) * BPMFromTime.stepCrochet;
end;

function u1.getTimeFromBeat(p14) -- Line: 78
    -- upvalues: u1 (copy)
    return u1.getTimeFromStep(p14 * 4);
end;

function u1.getStepFromTime(p15) -- Line: 82
    -- upvalues: u1 (copy)
    local BPMFromTime = u1.getBPMFromTime(p15);

    return BPMFromTime.stepTime + (p15 - BPMFromTime.songTime) / BPMFromTime.stepCrochet;
end;

function u1.getBeatFromTime(p16) -- Line: 87
    -- upvalues: u1 (copy)
    return u1.getStepFromTime(p16) / 4;
end;

function u1.getChartSongLength() -- Line: 91
    -- upvalues: u1 (copy)
    return u1.getTimeFromStep(u1.getChartSongStepLength());
end;

function u1.getTimeElapsed() -- Line: 95
    -- upvalues: u2 (ref)
    return math.max(u2.Conductor.RawTimePosition, 0);
end;

return u1;