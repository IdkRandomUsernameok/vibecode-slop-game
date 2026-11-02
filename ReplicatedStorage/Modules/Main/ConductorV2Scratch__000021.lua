-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local script_Aliases = require(script.Aliases);
local u1 = {};

function u1.__index(p2, p3) -- Line: 14
    -- upvalues: script_Aliases (copy), u1 (copy)
    local v4 = script_Aliases[p3];

    if v4 then
        return p2[v4];
    end;

    return u1[p3];
end;

function round(p5: number, p6: any)
    local v7 = 10 ^ (p6 or 0);

    return math.floor(p5 * v7 + 0.5) / v7;
end;

function u1.new(p8, p9) -- Line: 28
    -- upvalues: u1 (copy)
    local v10 = setmetatable({
        Step = 0,
        Beat = 0,
        Measure = 0,
        Paused = false,
        Crochet = 0,
        StepCrochet = 0,
        SongPosition = 0,
        CurrentTrackPos = 0,
        TimePosition = 0,
        RawTimePosition = 0,
        Offset = 0,
        SafeFrames = 10,
        SafeZoneOffset = 166,
        CurBPM = 0,
        BaseBPM = 0,
        TotalPos = 0,
        TotalSteps = 0,
        StepsPerBeat = 4,
        BeatsPerMeasure = 4,
        DecimalStep = 0,
        DecimalBeat = 0,
        DecimalMeasure = 0,
        BPM = p8 or 0,
        BPMChangeMap = {}
    }, u1);

    if p8 then
        v10:start(p8, p9);
    end;

    return v10;
end;

function u1.start(p11: table, p12: any, p13: number?) -- Line: 73
    p11.BPM = p12;
    p11.Step = 0;
    p11.Beat = 0;
    p11.Measure = 0;
    p11.Paused = false;
    p11.Crochet = 60 / p11.BPM * 1000;
    p11.StepCrochet = p11.Crochet / p11.StepsPerBeat;
    p11.SongPosition = -(p11.Crochet * 4);
    p11.TimePosition = p11.SongPosition / 1000;
    p11.RawTimePosition = p11.TimePosition;
    p11.Offset = p13 or p11.Offset;
    p11.SafeZoneOffset = p11.SafeFrames / 60 * 1000;
    p11.BPMChangeMap = {};
end;

function u1.mapBPMChanges(p14, p15) -- Line: 93
    p14.BPMChangeMap = {};
    p14.CurBPM = p15.song.bpm;
    p14.BaseBPM = p15.song.bpm;
    p14.TotalSteps = 0;
    p14.TotalPos = 0;

    if p15.bpmChanges then
        for _, v in p15.bpmChanges do
            if v.bpm ~= p14.CurBPM then
                p14.CurBPM = round(v.bpm, 2);
                table.insert(p14.BPMChangeMap, {
                    stepTime = v.startTime / p14.StepCrochet,
                    songTime = v.startTime,
                    bpm = p14.CurBPM,
                    crochet = 60 / p14.CurBPM * 1000,
                    stepCrochet = 60 / p14.CurBPM * 1000 / 4
                });
            end;
        end;
    else
        local song = p15.song;

        if not song.notes then
            warn("THERE\'S SOMETHING WRONG WITH THE CHARTS WHY ARE THERE NO NOTES");

            return p14.BPMChangeMap;
        end;

        for i = 1, #song.notes do
            local v16 = song.notes[i];
            local v17;

            if v16 == nil then
                v17 = i;
            else
                if v16.changeBPM and v16.bpm ~= p14.CurBPM then
                    p14.CurBPM = v16.bpm;
                    table.insert(p14.BPMChangeMap, {
                        stepTime = p14.TotalSteps,
                        songTime = p14.TotalPos,
                        bpm = p14.CurBPM,
                        crochet = 60 / p14.CurBPM * 1000,
                        stepCrochet = 60 / p14.CurBPM * 1000 / 4
                    });
                end;

                local v18 = v16.sectionBeats and v16.sectionBeats * 4 or (v16.lengthInSteps or 16);
                p14.TotalSteps = p14.TotalSteps + v18;
                p14.TotalPos = p14.TotalPos + 60 / p14.CurBPM * 1000 / 4 * v18;
                v17 = i;
            end;
        end;
    end;

    return p14.BPMChangeMap;
end;

function u1.changeBPM(p19, p20) -- Line: 155
    p19.BPM = p20;
    p19.Crochet = 60 / p19.BPM * 1000;
    p19.StepCrochet = p19.Crochet / p19.StepsPerBeat;
end;

function u1.getBPMFromTime(p21, p22) -- Line: 161
    local v23 = {
        stepTime = 0,
        songTime = 0,
        bpm = p21.BPM,
        stepCrochet = p21.StepCrochet
    };

    for i = 1, #p21.BPMChangeMap do
        local v24 = p21.BPMChangeMap[i];
        local v25;

        if v24.songTime <= p22 then
            v23 = v24;
            v25 = i;
        else
            v25 = i;
        end;
    end;

    if globals.lastBPMChange.songTime <= p22 and globals.lastBPMChange.songTime > v23.songTime then
        return globals.lastBPMChange;
    end;

    return v23;
end;

function u1.getTimeFromStep(p26, p27) -- Line: 183
    -- upvalues: u1 (copy)
    local BPMFromTime = u1:getBPMFromTime(p27);

    return BPMFromTime.songTime + (p27 - BPMFromTime.stepTime) * BPMFromTime.stepCrochet;
end;

function u1.getTimeFromBeat(p28, p29) -- Line: 188
    -- upvalues: u1 (copy)
    return u1:getTimeFromStep(p29 * 4);
end;

function u1.getStepFromTime(p30, p31) -- Line: 192
    -- upvalues: u1 (copy)
    local BPMFromTime = u1:getBPMFromTime(p31);

    return BPMFromTime.stepTime + (p31 - BPMFromTime.songTime) / BPMFromTime.stepCrochet;
end;

function u1.getBeatFromTime(p32, p33) -- Line: 197
    -- upvalues: u1 (copy)
    return u1:getStepFromTime(p33) / 4;
end;

function u1.getChartSongLength(p34) -- Line: 201
    -- upvalues: u1 (copy)
    return u1:getTimeFromStep(u1:getChartSongStepLength());
end;

function u1.getTimeElapsed(p35) -- Line: 205
    return math.max(p35.RawTimePosition, 0);
end;

return u1;