-- Decompiled with Potassium's decompiler.

local u1 = require("../Config");
require("../Types");

return {
    calculate = function(p2, p3) -- Line: 6, Name: calculate
        -- upvalues: u1 (copy)
        local lnEvents = p3.lnEvents;

        if not (lnEvents and (#lnEvents ~= 0 and p3.chartDuration > 0)) then
            return 0;
        end;

        local v4 = {};
        local math_min_ret = math.min(u1.WINDOW_DURATION, p3.chartDuration);
        local math_max_ret = math.max(1, p2.keyCount or 4);
        local v5 = p3.lnActiveAtStart or 0;
        local v6 = 1;
        local v7 = {};

        if p3.chartDuration <= u1.WINDOW_DURATION then
            table.insert(v7, {
                start = 0,
                stop = p3.chartDuration
            });
        else
            local v8 = 0;

            while v8 + u1.WINDOW_DURATION <= p3.chartDuration + 0.001 do
                table.insert(v7, {
                    start = v8,
                    stop = v8 + u1.WINDOW_DURATION
                });
                v8 = v8 + u1.WINDOW_STEP;
            end;
        end;

        for _, v in ipairs(v7) do
            local start = v.start;
            local stop = v.stop;
            local math_min_ret2 = math.min(math_min_ret, stop - start);

            while v6 <= #lnEvents and lnEvents[v6].time < start do
                v5 = v5 + lnEvents[v6].delta;
                v6 = v6 + 1;
            end;

            local v9 = v5;
            local v10 = v6;
            local v11 = 0;
            local v12 = 0;

            while v6 <= #lnEvents and lnEvents[v6].time <= stop do
                local v13 = lnEvents[v6];
                local v14 = v13.time - start;

                if v14 > 0 then
                    v11 = v11 + v14 * v5;
                end;

                if v13.delta > 0 then
                    v12 = v12 + 1;
                end;

                v5 = v5 + v13.delta;
                start = v13.time;
                v6 = v6 + 1;
            end;

            if start < stop then
                v11 = v11 + (stop - start) * v5;
            end;

            if math_min_ret2 > 0 and v12 > 0 then
                local v15 = 1 + math.clamp(v11 / math_min_ret2 / math_max_ret, 0, 1) ^ u1.LN_SATURATION_EXPONENT * u1.LN_SATURATION_BONUS;
                table.insert(v4, (v12 / math_min_ret2) ^ u1.LN_DENSITY_EXPONENT * v15 * u1.LN_DENSITY_SCALE);
                v5 = v9;
                v6 = v10;
            else
                table.insert(v4, 0);
                v5 = v9;
                v6 = v10;
            end;
        end;

        local v16 = 0;
        local v17 = 0;

        for _, v in ipairs(v4) do
            local v18 = v ^ u1.POWER_EXPONENT;
            v16 = v16 + v18;
            v17 = v17 + v * v18;
        end;

        return v16 == 0 and 0 or v17 / v16 * (p3.activityRatio or 1);
    end
};