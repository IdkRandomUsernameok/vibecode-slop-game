-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
require(Modules.Main.Conductor);
local script_PBOTScoring = require(script.PBOTScoring);
local u1 = {};

for _, child in Modules.Customization.JudgementWindows:GetChildren() do
    u1[child.Name] = require(child);
end;

local u2 = {
    {
        name = "Marvelous",
        ratingMod = 1,
        ratingWindow = 22.5,
        score = 400,
        spawnSplash = true,
        comboBreak = false,
        color = Color3.new(1, 1, 1)
    },
    {
        name = "Sick",
        ratingMod = 1,
        ratingWindow = 45,
        score = 350,
        spawnSplash = true,
        comboBreak = false,
        color = Color3.new(0.968627, 1, 0.352941)
    },
    {
        name = "Good",
        ratingMod = 0.667,
        ratingWindow = 90,
        score = 200,
        spawnSplash = false,
        comboBreak = false,
        color = Color3.new(0.243137, 1, 0.243137)
    },
    {
        name = "Ok",
        ratingMod = 0.333,
        ratingWindow = 135,
        score = 100,
        spawnSplash = false,
        comboBreak = false,
        color = Color3.new(0.313725, 0.529412, 1)
    },
    {
        name = "Bad",
        ratingMod = 0.167,
        ratingWindow = 180,
        score = 0,
        spawnSplash = false,
        comboBreak = false,
        color = Color3.new(0.713725, 0.152941, 0.992157)
    },
    {
        name = "Miss",
        ratingMod = 0,
        ratingWindow = 205,
        score = -400,
        spawnSplash = false,
        comboBreak = true,
        color = Color3.new(1, 0, 0)
    }
};
local u3 = {
    {
        name = "MFC",
        ratingReqs = {
            Marvelous = -1,
            Sick = 0,
            Good = 0,
            Ok = 0,
            Bad = 0,
            Miss = 0
        },
        countsAs = { "MFC", "PFC", "GFC", "FC", "CLEAR" }
    },
    {
        name = "WF",
        ratingReqs = {
            Marvelous = -1,
            Sick = 1,
            Good = 0,
            Ok = 0,
            Bad = 0,
            Miss = 0
        },
        countsAs = { "PFC", "GFC", "FC", "CLEAR" }
    },
    {
        name = "SDP",
        ratingReqs = {
            Marvelous = -1,
            Sick = 9,
            Good = 0,
            Ok = 0,
            Bad = 0,
            Miss = 0
        },
        countsAs = { "PFC", "GFC", "FC", "CLEAR" }
    },
    {
        name = "PFC",
        ratingReqs = {
            Marvelous = -1,
            Sick = -1,
            Good = 0,
            Ok = 0,
            Bad = 0,
            Miss = 0
        },
        countsAs = { "PFC", "GFC", "FC", "CLEAR" }
    },
    {
        name = "BF",
        ratingReqs = {
            Marvelous = -1,
            Sick = -1,
            Good = 1,
            Ok = 0,
            Bad = 0,
            Miss = 0
        },
        countsAs = { "GFC", "FC", "CLEAR" }
    },
    {
        name = "SDG",
        ratingReqs = {
            Marvelous = -1,
            Sick = -1,
            Good = 9,
            Ok = 0,
            Bad = 0,
            Miss = 0
        },
        countsAs = { "GFC", "FC", "CLEAR" }
    },
    {
        name = "GFC",
        ratingReqs = {
            Marvelous = -1,
            Sick = -1,
            Good = -1,
            Ok = 0,
            Bad = 0,
            Miss = 0
        },
        countsAs = { "GFC", "FC", "CLEAR" }
    },
    {
        name = "SDO",
        ratingReqs = {
            Marvelous = -1,
            Sick = -1,
            Good = -1,
            Ok = 9,
            Bad = 0,
            Miss = 0
        },
        countsAs = { "FC", "CLEAR" }
    },
    {
        name = "SDB",
        ratingReqs = {
            Marvelous = -1,
            Sick = -1,
            Good = -1,
            Ok = -1,
            Bad = 9,
            Miss = 0
        },
        countsAs = { "FC", "CLEAR" }
    },
    {
        name = "FC",
        ratingReqs = {
            Marvelous = -1,
            Sick = -1,
            Good = -1,
            Ok = -1,
            Bad = -1,
            Miss = 0
        },
        countsAs = { "FC", "CLEAR" }
    },
    {
        name = "MF",
        ratingReqs = {
            Marvelous = -1,
            Sick = -1,
            Good = -1,
            Ok = -1,
            Bad = -1,
            Miss = 1
        },
        countsAs = { "CLEAR" }
    },
    {
        name = "SDCB",
        ratingReqs = {
            Marvelous = -1,
            Sick = -1,
            Good = -1,
            Ok = -1,
            Bad = -1,
            Miss = 9
        },
        countsAs = { "CLEAR" }
    },
    {
        name = "CLEAR",
        ratingReqs = {
            Marvelous = -1,
            Sick = -1,
            Good = -1,
            Ok = -1,
            Bad = -1,
            Miss = -1
        },
        countsAs = { "CLEAR" }
    }
};
local u4 = {
    Keys = { "Marvelous", "Sick", "Good", "Ok", "Bad", "Miss" },
    Data = u2
};
local math_abs = math.abs;

function u4.getRatingLetter(p5: number) -- Line: 55
    return p5 <= 60 and "F" or (p5 <= 70 and "D" or (p5 <= 80 and "C" or (p5 <= 90 and "B" or (p5 <= 95 and "A" or (p5 < 100 and "S" or "P")))));
end;

function u4.getJudgement(p6) -- Line: 66
    -- upvalues: u3 (copy)
    if p6 then
        for i = 1, #u3 do
            local v7 = u3[i];
            local _ = i;
            local v8 = true;

            for i2, v in v7.ratingReqs do
                if v ~= -1 and v < (p6[i2] or 0) then
                    v8 = false;
                    break;
                end;
            end;

            if v8 then
                return v7;
            end;
        end;
    end;
end;

function u4.getJudgementTitle(p9) -- Line: 88
    -- upvalues: u4 (copy)
    local Judgement = u4.getJudgement(p9);

    return Judgement and Judgement.name or "CLEAR";
end;

function u4.recalculateWindows(p10) -- Line: 93
    -- upvalues: u1 (copy), u2 (copy)
    if u1[p10] then
        for i, v in u1[p10] do
            local v11 = v;
            local v12 = i;

            for _, v2 in u2 do
                if v2.name == v12 then
                    v2.ratingWindow = v11;
                end;
            end;
        end;

        return;
    end;

    for i, v in u1.J4 do
        local v13 = v;
        local v14 = i;

        for _, v2 in u2 do
            if v2.name == v14 then
                v2.ratingWindow = v13;
            end;
        end;
    end;
end;

function u4.getRatingByName(p15) -- Line: 113
    -- upvalues: u2 (copy)
    for _, v in u2 do
        if p15 == v.name then
            return v;
        end;
    end;

    return u2[#u2];
end;

u4.recalculateWindows("J4");

function u4.GetScoreAndJudgement(p16: number) -- Line: 124
    -- upvalues: math_abs (copy), u2 (copy), script_PBOTScoring (copy)
    local v17 = type(p16) == "number";
    assert(v17, "Cannot find rating as this is not a number!");
    local v18 = math_abs(p16);
    local v19 = nil;

    for _, v in u2 do
        if v18 <= v.ratingWindow and v19 == nil then
            v19 = table.clone(v);
        end;
    end;

    if script_PBOTScoring:IsEnabled() and v19 then
        v19.score = script_PBOTScoring:ScoreNote(v18);
    end;

    return v19 or u2[#u2];
end;

function u4.GetMissScore() -- Line: 144
    -- upvalues: script_PBOTScoring (copy), u2 (copy)
    if script_PBOTScoring:IsEnabled() then
        return script_PBOTScoring:ScoreNote(500000);
    end;

    return u2[#u2].score;
end;

function u4.GetHoldNoteScorePerSecond() -- Line: 152
    -- upvalues: script_PBOTScoring (copy)
    return not script_PBOTScoring:IsEnabled() and 0 or script_PBOTScoring:GetHoldNoteScorePerSecond();
end;

function u4.GetTieThreshold() -- Line: 160
    -- upvalues: script_PBOTScoring (copy)
    return not script_PBOTScoring:IsEnabled() and 50 or script_PBOTScoring:GetTieThreshold();
end;

return u4;