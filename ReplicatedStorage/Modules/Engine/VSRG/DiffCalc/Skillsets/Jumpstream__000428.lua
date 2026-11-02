-- Decompiled with Potassium's decompiler.

require("../Types");
local u1 = require("../Config");
local u2 = require("../Utils");

return {
    calculate = function(p3, p4) -- Line: 7, Name: calculate
        -- upvalues: u1 (copy), u2 (copy)
        local chordEvents = p4.chordEvents;

        if #chordEvents == 0 then
            return 0;
        end;

        local WINDOW_DURATION = u1.WINDOW_DURATION;
        local WINDOW_STEP = u1.WINDOW_STEP;
        local chartDuration = p4.chartDuration;

        if chartDuration <= 0 then
            return 0;
        end;

        local math_min_ret = math.min(WINDOW_DURATION, chartDuration);
        local v5 = math.ceil((chartDuration - WINDOW_DURATION) / WINDOW_STEP) + 1;
        local v6 = 0;
        local v7 = 1;
        local v8 = 1;
        local v9 = 0;
        local v10 = 0;
        local v11 = 0;

        for i = 0, math.max(1, v5) - 1 do
            local v12 = i * WINDOW_STEP;
            local _ = i;

            while v8 <= #chordEvents and chordEvents[v8].time < v12 do
                if chordEvents[v8].inStream then
                    v9 = v9 - 1;

                    if chordEvents[v8].size >= 2 then
                        v6 = v6 - 1;
                    end;
                end;

                v8 = v8 + 1;
            end;

            while v7 <= #chordEvents and chordEvents[v7].time <= v12 + WINDOW_DURATION do
                if chordEvents[v7].inStream then
                    v9 = v9 + 1;

                    if chordEvents[v7].size >= 2 then
                        v6 = v6 + 1;
                    end;
                end;

                v7 = v7 + 1;
            end;

            local v13;

            if v9 > 0 then
                local math_min_ret2 = math.min(1, v6 / v9 / 0.2);
                local v14 = v9 / math_min_ret;

                if u1.STREAM_SPEED_CAP_BASE < v14 then
                    v14 = u1.STREAM_SPEED_CAP_BASE + (v14 - u1.STREAM_SPEED_CAP_BASE) ^ u1.STREAM_SPEED_COMPRESSION_EXP;
                end;

                v13 = v14 ^ 0.975 * math_min_ret2 * u1.JUMPSTREAM_SCALE;
            else
                v13 = 0;
            end;

            local v15 = v13 ^ u1.POWER_EXPONENT;
            v10 = v10 + v15;
            v11 = v11 + v13 * v15;
        end;

        if v10 == 0 then
            return 0;
        end;

        local v16 = u2.localActivityRatio(chordEvents, chartDuration, WINDOW_STEP);

        return v11 / v10 * v16;
    end
};