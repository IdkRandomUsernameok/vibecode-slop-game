-- Decompiled with Potassium's decompiler.

local u1 = require("../Config");
require("../Types");

return {
    calculate = function(p2, p3) -- Line: 6, Name: calculate
        -- upvalues: u1 (copy)
        if not p3.lnEvents or #p3.lnEvents == 0 then
            return 0;
        end;

        local chartDuration = p3.chartDuration;

        if not chartDuration or chartDuration <= 0 then
            return 0;
        end;

        local v4 = {};

        if chartDuration <= u1.WINDOW_DURATION then
            table.insert(v4, {
                start = 0,
                stop = chartDuration
            });
        else
            local v5 = 0;

            while v5 + u1.WINDOW_DURATION <= chartDuration + 0.001 do
                table.insert(v4, {
                    start = v5,
                    stop = v5 + u1.WINDOW_DURATION
                });
                v5 = v5 + u1.WINDOW_STEP;
            end;
        end;

        local v6 = p3.lnActiveAtStart or 0;
        local v7 = p3.tapEvents or {};
        local lnEvents = p3.lnEvents;
        local v8 = 1;
        local v9 = 1;
        local v10 = {};

        for _, v in ipairs(v4) do
            local start = v.start;

            while v8 <= #lnEvents and lnEvents[v8].time < start do
                v6 = v6 + lnEvents[v8].delta;
                v8 = v8 + 1;
            end;

            while v9 <= #v7 and v7[v9].time < start do
                v9 = v9 + 1;
            end;

            local v11 = v9;
            local v12 = v6;
            local v13 = v8;
            local v14 = 0;

            while v9 <= #v7 and v7[v9].time <= v.stop do
                while v8 <= #lnEvents and lnEvents[v8].time <= v7[v9].time do
                    v6 = v6 + lnEvents[v8].delta;
                    v8 = v8 + 1;
                end;

                if v6 > 0 then
                    v14 = v14 + 1;
                end;

                v9 = v9 + 1;
            end;

            local math_min_ret = math.min(u1.WINDOW_DURATION, chartDuration - start);
            table.insert(v10, (math_min_ret <= 0 and 0 or v14 / math_min_ret) * u1.COORDINATION_SCALE);
            v9 = v11;
            v6 = v12;
            v8 = v13;
        end;

        local v15 = 0;
        local v16 = 0;

        for _, v in ipairs(v10) do
            local v17 = v ^ u1.POWER_EXPONENT;
            v15 = v15 + v17;
            v16 = v16 + v * v17;
        end;

        return v15 == 0 and 0 or v16 / v15 * (p3.activityRatio or 1);
    end
};