-- Decompiled with Potassium's decompiler.

local u1 = require("../Config");
local u2 = require("../Utils");
local v3 = {};

local function computeGapStats(p4, p5, p6) -- Line: 6
    if p6 - p5 <= 1 then
        return 0, 0;
    end;

    local v7 = 0;
    local v8 = 0;

    for i = p5, p6 - 2 do
        local v9 = p4[i + 1].time - p4[i].time;
        v7 = v7 + v9;
        v8 = v8 + v9 * v9;
        local _ = i;
    end;

    return v7, v8;
end;

function v3.calculate(p10, p11) -- Line: 20
    -- upvalues: u1 (copy), computeGapStats (copy), u2 (copy)
    if #p11.chordEvents == 0 then
        return 0;
    end;

    local chartDuration = p11.chartDuration;
    local v12 = math.ceil(chartDuration / u1.WINDOW_STEP) + 1;
    local v13 = #p11.chordEvents;
    local v14 = 0;
    local v15 = 0;
    local v16 = 1;
    local v17 = 1;
    local v18 = 1;
    local v19 = {};
    local v20 = 1;
    local v21 = 1;

    for i = 1, v12 do
        local v22 = (i - 1) * u1.WINDOW_STEP;
        local v23 = v22 + u1.WINDOW_DURATION;

        if math.min(u1.WINDOW_DURATION, chartDuration - v22) <= 0 then
            break;
        end;

        local _ = i;

        while v20 < v21 and p11.chordEvents[v20].time < v22 do
            local size = p11.chordEvents[v20].size;
            v14 = v14 - size;
            v15 = v15 - size * size;
            v20 = v20 + 1;
        end;

        while v21 <= v13 and p11.chordEvents[v21].time < v23 do
            local size = p11.chordEvents[v21].size;
            v14 = v14 + size;
            v15 = v15 + size * size;
            v21 = v21 + 1;
        end;

        if v20 == v21 then
            v14 = 0;
            v15 = 0;
        end;

        local v24, v25 = computeGapStats(p11.chordEvents, v20, v21);

        while v16 <= v13 and p11.chordEvents[v16].time < v22 + 0.375 do
            v16 = v16 + 1;
        end;

        while v17 <= v13 and p11.chordEvents[v17].time < v22 + 0.75 do
            v17 = v17 + 1;
        end;

        while v18 <= v13 and p11.chordEvents[v18].time < v22 + 1.125 do
            v18 = v18 + 1;
        end;

        if v16 < v20 then
            v16 = v20;
        end;

        if v17 < v16 then
            v17 = v16;
        end;

        if v18 < v17 then
            v18 = v17;
        end;

        if v21 < v16 then
            v16 = v21;
        end;

        if v21 < v17 then
            v17 = v21;
        end;

        if v21 < v18 then
            v18 = v21;
        end;

        local v26 = v21 - v20;
        local v27;

        if v26 > 0 then
            local v28 = v14 / v26;
            local math_max_ret = math.max(0, v15 / v26 - v28 * v28);
            local math_sqrt_ret = math.sqrt(math_max_ret);
            local v29 = v26 - 1;
            local v30;

            if v29 > 0 then
                local v31 = v24 / v29;
                local math_max_ret2 = math.max(0, v25 / v29 - v31 * v31);
                v30 = math.sqrt(math_max_ret2);
            else
                v30 = 0;
            end;

            local v32 = (v16 - v20) / 0.375;
            local v33 = (v17 - v16) / 0.375;
            local v34 = (v18 - v17) / 0.375;
            local v35 = (v21 - v18) / 0.375;
            local v36 = (v32 + v33 + v34 + v35) / 4;
            local math_max_ret2 = math.max(0, (v32 * v32 + v33 * v33 + v34 * v34 + v35 * v35) / 4 - v36 * v36);
            local math_sqrt_ret2 = math.sqrt(math_max_ret2);
            v27 = (v30 * u1.TECHNICAL_RHYTHM_NORM * u1.TECHNICAL_RHYTHM_W + math_sqrt_ret * u1.TECHNICAL_CHORD_NORM * u1.TECHNICAL_CHORD_W + math_sqrt_ret2 * u1.TECHNICAL_DENSITY_NORM * u1.TECHNICAL_DENSITY_W) * u1.TECHNICAL_SCALE;
        else
            v27 = 0;
        end;

        table.insert(v19, v27);
    end;

    local v37 = 0;
    local v38 = 0;

    for _, v in ipairs(v19) do
        local v39 = v ^ u1.POWER_EXPONENT;
        v37 = v37 + v39;
        v38 = v38 + v * v39;
    end;

    if v37 == 0 then
        return 0;
    end;

    local v40 = u2.localActivityRatio(p11.chordEvents, chartDuration, u1.WINDOW_STEP);

    return v38 / v37 * v40;
end;

return v3;