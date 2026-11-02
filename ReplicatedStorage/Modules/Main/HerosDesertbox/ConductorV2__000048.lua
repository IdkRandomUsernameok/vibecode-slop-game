-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local script_Aliases = require(script.Aliases);

local function round(p1: number, p2: number?) -- Line: 8
    local v3 = 10 ^ (p2 or 0);

    return math.floor(p1 * v3 + 0.5) / v3;
end;

local function crochetFromBPM(p4: number) -- Line: 13
    return 60 / p4 * 1000;
end;

local u5 = {};

function u5.__index(p6, p7) -- Line: 26
    -- upvalues: script_Aliases (copy), u5 (copy)
    local v8 = script_Aliases[p7] or p7;
    local v9 = rawget(p6, v8);

    if v9 == nil then
        return u5[v8];
    end;

    return v9;
end;

function u5.new(p10: number?, p11: number?) -- Line: 33
    -- upvalues: u5 (copy)
    local v12 = setmetatable({
        BPM = 0,
        Step = 0,
        Beat = 0,
        Measure = 0,
        Paused = false,
        Crochet = 0,
        StepCrochet = 0,
        SongPosition = 0,
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
        BPMChangeMap = {}
    }, u5);

    if p10 then
        v12:start(p10, p11);
    end;

    return v12;
end;

function u5.start(p13: table, p14: number, p15: number?) -- Line: 76
    p13.BPM = p14;
    p13.Step = 0;
    p13.Beat = 0;
    p13.Measure = 0;
    p13.Paused = false;
    p13.Crochet = 60 / p14 * 1000;
    p13.StepCrochet = p13.Crochet / p13.StepsPerBeat;
    p13.SongPosition = -(p13.Crochet * 4);
    p13.TimePosition = p13.SongPosition / 1000;
    p13.RawTimePosition = p13.TimePosition;
    p13.Offset = p15 or p13.Offset;
    p13.SafeZoneOffset = p13.SafeFrames / 60 * 1000;
    p13.BPMChangeMap = {};
end;

function u5.mapBPMChanges(p16, p17) -- Line: 97
    p16.BPMChangeMap = {};
    p16.CurBPM = p17.song.bpm;
    p16.BaseBPM = p17.song.bpm;
    p16.TotalSteps = 0;
    p16.TotalPos = 0;

    if p17.bpmChanges then
        for _, v in p17.bpmChanges do
            if v.bpm ~= p16.CurBPM then
                p16.CurBPM = math.floor(v.bpm * 100 + 0.5) / 100;
                table.insert(p16.BPMChangeMap, {
                    stepTime = v.startTime / p16.StepCrochet,
                    songTime = v.startTime,
                    bpm = p16.CurBPM,
                    crochet = 60 / p16.CurBPM * 1000,
                    stepCrochet = 60 / p16.CurBPM * 1000 / p16.StepsPerBeat
                });
            end;
        end;
    else
        local song = p17.song;

        if not song.notes then
            warn("Conductor: chart has no notes, BPM map will be empty boi!!!");

            return p16.BPMChangeMap;
        end;

        for i = 1, #song.notes do
            local v18 = song.notes[i];
            local v19;

            if v18 == nil then
                v19 = i;
            else
                if v18.changeBPM and v18.bpm ~= p16.CurBPM then
                    p16.CurBPM = v18.bpm;
                    table.insert(p16.BPMChangeMap, {
                        stepTime = p16.TotalSteps,
                        songTime = p16.TotalPos,
                        bpm = p16.CurBPM,
                        crochet = 60 / p16.CurBPM * 1000,
                        stepCrochet = 60 / p16.CurBPM * 1000 / p16.StepsPerBeat
                    });
                end;

                local v20 = v18.sectionBeats and v18.sectionBeats * p16.StepsPerBeat or (v18.lengthInSteps or p16.StepsPerBeat * p16.BeatsPerMeasure);
                p16.TotalSteps = p16.TotalSteps + v20;
                p16.TotalPos = p16.TotalPos + p16.StepCrochet * v20;
                v19 = i;
            end;
        end;
    end;

    return p16.BPMChangeMap;
end;

function u5.getBPMFromTime(p21: table, p22: number) -- Line: 158
    local v23 = {
        stepTime = 0,
        songTime = 0,
        bpm = p21.BPM,
        crochet = p21.Crochet,
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

    if globals.lastBPMChange and (globals.lastBPMChange.songTime <= p22 and globals.lastBPMChange.songTime > v23.songTime) then
        return globals.lastBPMChange;
    end;

    return v23;
end;

function u5.getStepFromTime(p26: table, p27: number) -- Line: 186
    local BPMFromTime = p26:getBPMFromTime(p27);

    return BPMFromTime.stepTime + (p27 - BPMFromTime.songTime) / BPMFromTime.stepCrochet;
end;

function u5.getBeatFromTime(p28: table, p29: number) -- Line: 191
    return p28:getStepFromTime(p29) / p28.StepsPerBeat;
end;

function u5.getTimeFromStep(p30: table, p31: number) -- Line: 195
    local BPMFromTime = p30:getBPMFromTime(p31);

    return BPMFromTime.songTime + (p31 - BPMFromTime.stepTime) * BPMFromTime.stepCrochet;
end;

function u5.getTimeFromBeat(p32: table, p33: number) -- Line: 200
    return p32:getTimeFromStep(p33 * p32.StepsPerBeat);
end;

function u5.setSongPos(p34: table, p35: number) -- Line: 204
    local v36 = p35 + p34.Offset;
    p34.SongPosition = v36 * 1000;
    p34.TimePosition = v36;
    p34.RawTimePosition = p35;
end;

function u5.getTimeElapsed(p37) -- Line: 211
    return math.max(p37.RawTimePosition, 0);
end;

function u5.changeBPM(p38: table, p39: number) -- Line: 215
    p38.BPM = p39;
    p38.Crochet = 60 / p39 * 1000;
    p38.StepCrochet = p38.Crochet / p38.StepsPerBeat;
end;

return u5;