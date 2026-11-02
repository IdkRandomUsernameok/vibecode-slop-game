-- Decompiled with Potassium's decompiler.

local u1 = require("../Config");
require("../Types");
local u2 = require("../Utils");

return {
    calculate = function(p3, u4) -- Line: 7, Name: calculate
        -- upvalues: u2 (copy), u1 (copy)
        if u4.chartDuration == 0 or #u4.jackSeqs == 0 then
            return 0;
        end;

        local u5 = {};
        local u6 = 1;

        local function processWindow(p7: number, p8: number) -- Line: 15
            -- upvalues: u6 (ref), u4 (copy), u2 (ref), u1 (ref), u5 (copy)
            while u6 <= #u4.jackSeqs and u4.jackSeqs[u6].lastHit < p7 do
                u6 = u6 + 1;
            end;

            local v9 = u6;
            local v10 = 0;

            while v9 <= #u4.jackSeqs do
                local v11 = u4.jackSeqs[v9];

                if p8 < v11.firstHit then
                    break;
                end;

                local v12 = 0;
                local v13 = nil;
                local v14 = nil;

                for i = u2.binarySearch(v11.hits, p7), #v11.hits do
                    local v15 = v11.hits[i];

                    if v15 > p8 then
                        break;
                    end;

                    v12 = v12 + 1;
                    v14 = v15;
                    local _ = i;
                    v13 = v13 or v15;
                end;

                local v16;

                if v12 >= 2 then
                    local v17 = (v14 - v13) / (v12 - 1);

                    if v17 > 0 then
                        local v18 = 1 / v17;

                        if u1.JACK_SPEED_CAP_BASE < v18 then
                            v18 = u1.JACK_SPEED_CAP_BASE + (v18 - u1.JACK_SPEED_CAP_BASE) ^ u1.JACK_SPEED_COMPRESSION_EXP;
                        end;

                        v16 = v18 * (math.min(0.5, (v12 - 2) * 0.05) + 1) * u1.JACK_SCALE;

                        if v10 >= v16 then
                            v16 = v10;
                        end;
                    else
                        v16 = v10;
                    end;
                else
                    v16 = v10;
                end;

                v9 = v9 + 1;
                v10 = v16;
            end;

            table.insert(u5, v10);
        end;

        if u4.chartDuration < u1.WINDOW_DURATION then
            processWindow(0, u4.chartDuration);
        else
            local v19 = 0;

            while v19 + u1.WINDOW_DURATION <= u4.chartDuration + 0.001 do
                processWindow(v19, v19 + u1.WINDOW_DURATION);
                v19 = v19 + u1.WINDOW_STEP;
            end;
        end;

        local v20 = 0;
        local v21 = 0;

        for _, v in ipairs(u5) do
            local v22 = v ^ u1.POWER_EXPONENT;
            v20 = v20 + v22;
            v21 = v21 + v * v22;
        end;

        if v20 == 0 then
            return 0;
        end;

        local v23 = {};

        for _, v in ipairs(u4.jackSeqs) do
            for _, v2 in ipairs(v.hits) do
                table.insert(v23, {
                    time = v2
                });
            end;
        end;

        table.sort(v23, function(p24, p25) -- Line: 106
            return p24.time < p25.time;
        end);
        local v26 = u2.localActivityRatio(v23, u4.chartDuration, u1.WINDOW_STEP);

        return v21 / v20 * v26;
    end
};