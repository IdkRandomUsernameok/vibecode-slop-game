-- Decompiled with Potassium's decompiler.

local u1 = require("../Config");
require("../Types");

return {
    calculate = function(p2, p3) -- Line: 6, Name: calculate
        -- upvalues: u1 (copy)
        local releaseTimes = p3.releaseTimes;

        if not (releaseTimes and (#releaseTimes ~= 0 and p3.chartDuration > 0)) then
            return 0;
        end;

        local WINDOW_DURATION = u1.WINDOW_DURATION;
        local WINDOW_STEP = u1.WINDOW_STEP;
        local chartDuration = p3.chartDuration;
        local v4 = #releaseTimes;
        local v5 = {};
        local v6 = 1;
        local v7 = 1;
        local v8 = {};

        if chartDuration <= WINDOW_DURATION then
            table.insert(v8, {
                start = 0,
                stop = chartDuration
            });
        else
            local v9 = 0;

            while v9 + WINDOW_DURATION <= chartDuration + 0.001 do
                table.insert(v8, {
                    start = v9,
                    stop = v9 + WINDOW_DURATION
                });
                v9 = v9 + WINDOW_STEP;
            end;
        end;

        for _, v in ipairs(v8) do
            local start = v.start;
            local stop = v.stop;
            local math_min_ret = math.min(WINDOW_DURATION, chartDuration);

            while v6 <= v4 and releaseTimes[v6] < start do
                v6 = v6 + 1;
            end;

            local v10;

            if v7 < v6 then
                v10 = v6;
            else
                v10 = v6;
                v6 = v7;
            end;

            while v6 <= v4 and releaseTimes[v6] <= stop do
                v6 = v6 + 1;
            end;

            local v11 = v6 - v10;
            local v12;

            if v11 > 0 and math_min_ret > 0 then
                local v13 = v11 / math_min_ret;
                local v14;

                if v11 > 1 then
                    local v15 = 0;

                    for i = v10, v6 - 2 do
                        local v16 = releaseTimes[i + 1] - releaseTimes[i];
                        local v17;

                        if v16 > 0 and v16 < u1.LN_RELEASE_GAP then
                            v15 = v15 + (1 - v16 / u1.LN_RELEASE_GAP);
                            v17 = i;
                        else
                            v17 = i;
                        end;
                    end;

                    v14 = v15 / v11 * v13;
                else
                    v14 = 0;
                end;

                v12 = (v13 * u1.LN_RELEASE_NPS_W + v14 * u1.LN_RELEASE_STAGGER_W) * u1.LN_RELEASE_SCALE;
            else
                v12 = 0;
            end;

            table.insert(v5, v12);
            v7 = v6;
            v6 = v10;
        end;

        local v18 = 0;
        local v19 = 0;

        for _, v in ipairs(v5) do
            local v20 = v ^ u1.POWER_EXPONENT;
            v18 = v18 + v20;
            v19 = v19 + v * v20;
        end;

        return v18 == 0 and 0 or v19 / v18 * (p3.activityRatio or 1);
    end
};