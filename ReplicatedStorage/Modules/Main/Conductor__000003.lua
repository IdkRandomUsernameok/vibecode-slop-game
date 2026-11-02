-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local u1 = {
    bpm = "BPM",
    curStep = "Step",
    currentStep = "Step",
    curBeat = "Beat",
    currentBeat = "Beat",
    curMeasure = "Measure",
    currentMeasure = "Measure",
    crochet = "Crochet",
    SongPos = "SongPosition",
    songPosition = "SongPosition",
    TimePos = "TimePosition",
    timePosition = "TimePosition",
    safeZoneOffset = "SafeZoneOffset",
    stepCrochet = "StepCrochet",
    decimalStep = "DecimalStep",
    currentStepFloat = "DecimalStep",
    currentBeatFloat = "DecimalBeat",
    decimalBeat = "DecimalBeat",
    decimalMeasure = "DecimalMeasure",
    stepsPerBeat = "StepsPerBeat",
    beatsPerMeasure = "BeatsPerMeasure"
};
local u2 = {
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
    CurrentTrackPos = 0,
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
};
setmetatable(u2, {
    __index = function(p3, p4) -- Line: 61, Name: __index
        -- upvalues: u1 (copy)
        return rawget(p3, u1[p4] or p4);
    end
});

function round(p5, p6)
    local v7 = 10 ^ (p6 or 0);

    return math.floor(p5 * v7 + 0.5) / v7;
end;

function u2.setSongPos(p8) -- Line: 72
    -- upvalues: u2 (copy)
    local v9 = p8 + u2.Offset;
    u2.SongPosition = v9 * 1000;
    u2.TimePosition = v9;
    u2.RawTimePosition = p8;
end;

function u2.init(p10: any, p11: number?) -- Line: 80
    -- upvalues: u2 (copy)
    u2.BPM = p10;
    u2.Step = 0;
    u2.Beat = 0;
    u2.Measure = 0;
    u2.Paused = false;
    u2.BeatsPerMeasure = 4;
    u2.StepsPerBeat = 4;
    u2.Crochet = 60 / u2.BPM * 1000 * (4 / u2.StepsPerBeat);
    u2.StepCrochet = u2.Crochet / 4;
    u2.SongPosition = -(u2.Crochet * 4);
    u2.TimePosition = u2.SongPosition / 1000;
    u2.RawTimePosition = u2.TimePosition;
    u2.Offset = p11 or 0;
    u2.SafeZoneOffset = u2.SafeFrames / 60 * 1000;
    u2.BPMChangeMap = {};
end;

function u2.mapBPMChanges(p12) -- Line: 103
    -- upvalues: u2 (copy)
    u2.BPMChangeMap = {};
    u2.CurBPM = p12.song.bpm;
    u2.BaseBPM = p12.song.bpm;
    u2.TotalSteps = 0;
    u2.TotalPos = 0;

    if p12.song.timeSignature then
        local string_split_ret = string.split(p12.song.timeSignature, "/");
        u2.BeatsPerMeasure = tonumber(string_split_ret[1]);
        u2.StepsPerBeat = tonumber(string_split_ret[2]);
    end;

    local v13 = u2.BeatsPerMeasure or 4;
    local v14 = u2.StepsPerBeat or 4;

    if p12.bpmChanges then
        for _, v in p12.bpmChanges do
            if v.bpm ~= u2.CurBPM then
                u2.CurBPM = round(v.bpm, 2);

                if v.beatsPerMeasure and v.beatsPerMeasure ~= v13 then
                    v13 = v.beatsPerMeasure;
                end;

                if v.stepsPerBeat and v.stepsPerBeat ~= v14 then
                    v14 = v.stepsPerBeat;
                end;

                local v15 = 60 / u2.CurBPM * 1000 * (4 / v14);
                table.insert(u2.BPMChangeMap, {
                    stepTime = v.startTime / u2.StepCrochet,
                    songTime = v.startTime,
                    bpm = u2.CurBPM,
                    beatsPerMeasure = v13,
                    stepsPerBeat = v14,
                    crochet = v15,
                    stepCrochet = v15 / 4
                });
            end;
        end;
    else
        local song = p12.song;

        if not song.notes then
            warn("There\'s something wrong with the chart? idk");

            return u2.BPMChangeMap;
        end;

        local v16 = 60 / u2.CurBPM * 1000 * (4 / v14) / 4;

        for i = 1, #song.notes do
            local v17 = song.notes[i];
            local v18;

            if v17 == nil then
                v18 = i;
            else
                if v17.changeBPM and v17.bpm ~= u2.CurBPM then
                    u2.CurBPM = v17.bpm;

                    if v17.beatsPerMeasure and v17.beatsPerMeasure ~= v13 then
                        v13 = v17.beatsPerMeasure;
                    end;

                    if v17.stepsPerBeat and v17.stepsPerBeat ~= v14 then
                        v14 = v17.stepsPerBeat;
                    end;

                    local v19 = 60 / u2.CurBPM * 1000 * (4 / v14);
                    v16 = v19 / 4;
                    table.insert(u2.BPMChangeMap, {
                        stepTime = u2.TotalSteps,
                        songTime = u2.TotalPos,
                        bpm = u2.CurBPM,
                        crochet = v19,
                        stepCrochet = v16
                    });
                end;

                local sectionBeats = v17.sectionBeats;

                if not sectionBeats then
                    if v17.lengthInSteps then
                        sectionBeats = v17.lengthInSteps / 4 or v13;
                    else
                        sectionBeats = v13;
                    end;
                end;

                local v20 = sectionBeats * 4;
                local v21 = u2;
                v21.TotalSteps = v21.TotalSteps + v20;
                local v22 = u2;
                v22.TotalPos = v22.TotalPos + v16 * v20;
                v18 = i;
            end;
        end;
    end;

    return u2.BPMChangeMap;
end;

function u2.changeBPM(p23) -- Line: 205
    -- upvalues: u2 (copy)
    u2.BPM = p23;
    u2.Crochet = 60 / u2.BPM * 1000 * (4 / u2.StepsPerBeat);
    u2.StepCrochet = u2.Crochet / 4;
end;

return u2;