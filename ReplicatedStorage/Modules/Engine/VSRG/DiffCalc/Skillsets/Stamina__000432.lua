-- Decompiled with Potassium's decompiler.

local u1 = require("../Config");
require("../Types");
local u2 = require("../Utils");

return {
    calculate = function(p3, p4) -- Line: 8, Name: calculate
        -- upvalues: u1 (copy), u2 (copy)
        local chordEvents = p4.chordEvents;

        if not (chordEvents and (#chordEvents ~= 0 and p4.chartDuration > 0)) then
            return 0;
        end;

        local chartDuration = p4.chartDuration;
        local WINDOW_DURATION = u1.WINDOW_DURATION;
        local WINDOW_STEP = u1.WINDOW_STEP;
        local v5 = math.ceil((chartDuration - WINDOW_DURATION) / WINDOW_STEP) + 1;
        local math_max_ret = math.max(1, v5);
        local v6 = #chordEvents;
        local v7 = 0;
        local v8 = 1;
        local v9 = 0;
        local v10 = 1;
        local v11 = {};

        for i = 0, math_max_ret - 1 do
            local v12 = i * WINDOW_STEP;
            local _ = i;

            while v10 <= v6 and chordEvents[v10].time < v12 do
                v7 = v7 - chordEvents[v10].size;
                v10 = v10 + 1;
            end;

            while v8 <= v6 and chordEvents[v8].time <= v12 + WINDOW_DURATION do
                v7 = v7 + chordEvents[v8].size;
                v8 = v8 + 1;
            end;

            local v13 = v7 / WINDOW_DURATION;

            if u1.FATIGUE_THRESHOLD_NPS < v13 then
                v9 = math.min(u1.MAX_FATIGUE_BONUS, v9 + (v13 - u1.FATIGUE_THRESHOLD_NPS) * u1.FATIGUE_BUILDUP_RATE * WINDOW_STEP);
            else
                local v14 = 1 - math.clamp(v13 / u1.FATIGUE_THRESHOLD_NPS, 0, 1);
                v9 = math.max(0, v9 - u1.FATIGUE_RECOVERY_RATE * v14 * WINDOW_STEP);
            end;

            if u1.STAMINA_SPEED_CAP_BASE < v13 then
                v13 = u1.STAMINA_SPEED_CAP_BASE + (v13 - u1.STAMINA_SPEED_CAP_BASE) ^ u1.STAMINA_SPEED_COMPRESSION_EXP;
            end;

            table.insert(v11, v13 * (v9 + 1) * u1.STAMINA_SCALE);
        end;

        local v15 = 0;
        local v16 = 0;

        for _, v in ipairs(v11) do
            local v17 = v ^ u1.STAMINA_POWER_EXPONENT;
            v15 = v15 + v17;
            v16 = v16 + v * v17;
        end;

        if v15 == 0 then
            return 0;
        end;

        local v18 = u2.localActivityRatio(chordEvents, chartDuration, WINDOW_STEP);

        return v16 / v15 * v18 + (u1.STAMINA_ENDURANCE_THRESHOLD >= chartDuration and 0 or math.min(u1.STAMINA_ENDURANCE_CAP, (chartDuration - u1.STAMINA_ENDURANCE_THRESHOLD) / 60 * u1.STAMINA_ENDURANCE_RATE));
    end
};