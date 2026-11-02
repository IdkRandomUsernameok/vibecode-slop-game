-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local ExperimentalFeatures = require(Modules.Other.ExperimentalFeatures);

return {
    IsEnabled = function(p1) -- Line: 8, Name: IsEnabled
        -- upvalues: ExperimentalFeatures (copy)
        return ExperimentalFeatures:IsEnabled("feature_pbot1_scoring");
    end,

    ScoreNote = function(p2: table, p3: number) -- Line: 21, Name: ScoreNote
        local math_abs_ret = math.abs(p3);

        if math_abs_ret > 160 then
            return -100;
        end;

        if math_abs_ret < 5 then
            return 500;
        end;

        local v4 = (1 - 1 / (math.exp((math_abs_ret - 54.99) * -0.08) + 1)) * 500 + 9;

        return math.floor(v4);
    end,

    GetHoldNoteScorePerSecond = function(p5) -- Line: 37, Name: GetHoldNoteScorePerSecond
        return 250;
    end,

    GetTieThreshold = function(p6) -- Line: 41, Name: GetTieThreshold
        return 750;
    end
};