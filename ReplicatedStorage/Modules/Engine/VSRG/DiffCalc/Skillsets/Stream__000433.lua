-- Decompiled with Potassium's decompiler.

require("../Types");
local u1 = require("../Config");
local u2 = require("../Utils");

return {
    calculate = function(p3, p4) -- Line: 7, Name: calculate
        -- upvalues: u1 (copy), u2 (copy)
        local chordEvents = p4.chordEvents;
        local tapEvents = p4.tapEvents;

        if #chordEvents == 0 or #tapEvents == 0 then
            return 0;
        end;

        local WINDOW_DURATION = u1.WINDOW_DURATION;
        local WINDOW_STEP = u1.WINDOW_STEP;
        local chartDuration = p4.chartDuration;

        if chartDuration == 0 then
            return 0;
        end;

        local math_min_ret = math.min(WINDOW_DURATION, chartDuration);
        local v5 = math.ceil((chartDuration - WINDOW_DURATION) / WINDOW_STEP) + 1;
        local math_max_ret = math.max(1, v5);
        local math_max_ret2 = math.max(2, p3.keyCount or 4);
        local v6 = 0;
        local v7 = 1;
        local v8 = 1;
        local v9 = 1;
        local v10 = 1;
        local v11 = 0;
        local v12 = 0;
        local v13 = 0;

        for i = 0, math_max_ret - 1 do
            local v14 = i * WINDOW_STEP;
            local v15 = v14 + WINDOW_DURATION;
            local _ = i;

            while v7 <= #chordEvents and chordEvents[v7].time < v14 do
                if chordEvents[v7].inStream then
                    v11 = v11 - 1;

                    if chordEvents[v7].size == 1 then
                        v6 = v6 - 1;
                    end;
                end;

                v7 = v7 + 1;
            end;

            while v8 <= #chordEvents and chordEvents[v8].time <= v15 do
                if chordEvents[v8].inStream then
                    v11 = v11 + 1;

                    if chordEvents[v8].size == 1 then
                        v6 = v6 + 1;
                    end;
                end;

                v8 = v8 + 1;
            end;

            while v9 <= #tapEvents and tapEvents[v9].time < v14 do
                v9 = v9 + 1;
            end;

            while v10 <= #tapEvents and tapEvents[v10].time <= v15 do
                v10 = v10 + 1;
            end;

            local v16 = v10 - v9;
            local v17;

            if v11 > 0 and (v6 > 0 and v16 > 0) then
                local v18 = v6 / math_min_ret;

                if u1.STREAM_SPEED_CAP_BASE < v18 then
                    v18 = u1.STREAM_SPEED_CAP_BASE + (v18 - u1.STREAM_SPEED_CAP_BASE) ^ u1.STREAM_SPEED_COMPRESSION_EXP;
                end;

                local v19 = {};
                local v20 = 0;
                local v21 = 0;

                for i2 = v9, v10 - 1 do
                    local column = tapEvents[i2].column;
                    local v22;

                    if v19[column] then
                        v22 = i2;
                    else
                        v19[column] = true;
                        v20 = v20 + 1;
                        v22 = i2;
                    end;
                end;

                for i2 = 2, math.min(math_max_ret2, v16 - 1) do
                    local v23 = i2;
                    local v24 = 0;

                    for i3 = v9 + i2, v10 - 1 do
                        local v25;

                        if tapEvents[i3].column == tapEvents[i3 - v23].column then
                            v24 = v24 + 1;
                            v25 = i3;
                        else
                            v25 = i3;
                        end;
                    end;

                    local v26 = v24 / (v16 - v23) * (u1.STREAM_BASE_CYCLE_PENALTY * u1.STREAM_CYCLE_DECAY ^ (v23 - 2));

                    if v21 < v26 then
                        v21 = v26;
                    end;
                end;

                local v27 = 1 - math.clamp(v21, 0, u1.STREAM_MAX_REPETITION_NERF);
                local v28 = math.clamp(v20 / math_max_ret2 / u1.STREAM_TARGET_COL_RATIO, 0, 1) ^ u1.STREAM_DIVERSITY_EXPONENT;
                local math_clamp_ret = math.clamp(v28, u1.STREAM_MIN_DIVERSITY_MULT, 1);
                v17 = v18 ^ 0.975 * (v6 / v11) * v27 * math_clamp_ret * u1.STREAM_SCALE;
            else
                v17 = 0;
            end;

            local v29 = v17 ^ u1.POWER_EXPONENT;
            v12 = v12 + v29;
            v13 = v13 + v17 * v29;
        end;

        if v12 == 0 then
            return 0;
        end;

        local v30 = u2.localActivityRatio(chordEvents, chartDuration, WINDOW_STEP);

        return v13 / v12 * v30;
    end
};