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
                local v14 = 0;
                local v15 = nil;

                for i = u2.binarySearch(v11.hits, p7), #v11.hits do
                    local v16 = v11.hits[i];

                    if v16 > p8 then
                        break;
                    end;

                    v12 = v12 + 1;
                    v14 = v14 + v11.hitSizes[i];
                    v15 = v16;
                    local _ = i;
                    v13 = v13 or v16;
                end;

                local v17;

                if v12 >= 2 then
                    local v18 = (v15 - v13) / (v12 - 1);

                    if v18 > 0 then
                        local v19 = v14 / v12;
                        local v20 = 1 / v18;

                        if u1.JACK_SPEED_CAP_BASE < v20 then
                            v20 = u1.JACK_SPEED_CAP_BASE + (v20 - u1.JACK_SPEED_CAP_BASE) ^ u1.JACK_SPEED_COMPRESSION_EXP;
                        end;

                        local v21 = math.min(1.5, (v19 - 1) * 0.5) + 1;
                        local v22 = u2.chordjackBlend(v19, u1.CHORDJACK_BLEND_LOW, u1.CHORDJACK_BLEND_HIGH);
                        v17 = v20 * v21 * u1.CHORDJACK_SCALE * v22;

                        if v10 >= v17 then
                            v17 = v10;
                        end;
                    else
                        v17 = v10;
                    end;
                else
                    v17 = v10;
                end;

                v9 = v9 + 1;
                v10 = v17;
            end;

            table.insert(u5, v10);
        end;

        if u4.chartDuration < u1.WINDOW_DURATION then
            processWindow(0, u4.chartDuration);
        else
            local v23 = 0;

            while v23 + u1.WINDOW_DURATION <= u4.chartDuration + 0.001 do
                processWindow(v23, v23 + u1.WINDOW_DURATION);
                v23 = v23 + u1.WINDOW_STEP;
            end;
        end;

        local v24 = 0;
        local v25 = 0;

        for _, v in ipairs(u5) do
            local v26 = v ^ u1.POWER_EXPONENT;
            v24 = v24 + v26;
            v25 = v25 + v * v26;
        end;

        if v24 == 0 then
            return 0;
        end;

        local v27 = {};

        for _, v in ipairs(u4.jackSeqs) do
            for _, v2 in ipairs(v.hits) do
                table.insert(v27, {
                    time = v2
                });
            end;
        end;

        table.sort(v27, function(p28, p29) -- Line: 111
            return p28.time < p29.time;
        end);
        local v30 = u2.localActivityRatio(v27, u4.chartDuration, u1.WINDOW_STEP);

        return v25 / v24 * v30;
    end
};