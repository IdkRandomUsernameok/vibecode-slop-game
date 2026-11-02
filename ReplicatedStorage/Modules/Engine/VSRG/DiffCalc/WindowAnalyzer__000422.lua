-- Decompiled with Potassium's decompiler.

require("./Types");
require("./Utils");
local u1 = require("./Config");

return {
    prepass = function(p2) -- Line: 7, Name: prepass
        -- upvalues: u1 (copy)
        local v3 = {};
        local u4 = {};
        local u5 = {};
        local v6 = {};
        local v7 = {};
        local v8 = {};
        local v9 = {};

        for i = 1, p2.keyCount do
            v3[i] = {};
            u4[i] = {
                lastHitTime = nil,
                hits = {},
                sizes = {}
            };
            local _ = i;
        end;

        local function flushColumnRun(p10) -- Line: 22
            -- upvalues: u4 (copy), u1 (ref), u5 (copy)
            local v11 = u4[p10];

            if #v11.hits >= u1.JACK_MIN_LENGTH then
                table.insert(u5, {
                    column = p10,
                    hits = v11.hits,
                    hitSizes = v11.sizes,
                    firstHit = v11.hits[1],
                    lastHit = v11.hits[#v11.hits]
                });
            end;

            v11.hits = {};
            v11.sizes = {};
            v11.lastHitTime = nil;
        end;

        local v12 = {};

        for _, v in ipairs(p2.notes) do
            table.insert(v12, v);
        end;

        local v13 = 1;
        local v14 = 0;

        while v13 <= #v12 do
            local time = v12[v13].time;
            local v15 = {};
            local v16 = 0;

            while v13 <= #v12 and v12[v13].time - time <= u1.CHORD_EPSILON do
                local column = v12[v13].column;

                if not v15[column] then
                    v15[column] = true;
                    v16 = v16 + 1;
                end;

                v13 = v13 + 1;
            end;

            v14 = v14 + 1;
            table.insert(v6, {
                inStream = false,
                isJack = false,
                time = time,
                size = v16
            });

            for i = 1, p2.keyCount do
                local v17;

                if v15[i] then
                    local v18 = u4[i];

                    if v18.lastHitTime and time - v18.lastHitTime > u1.JACK_GAP_THRESHOLD then
                        flushColumnRun(i);
                    end;

                    table.insert(v18.hits, time);
                    table.insert(v18.sizes, v16);
                    v18.lastHitTime = time;
                    table.insert(v3[i], {
                        time = time,
                        size = v16
                    });
                    v17 = i;
                else
                    v17 = i;
                end;
            end;
        end;

        for i = 1, p2.keyCount do
            flushColumnRun(i);
            local _ = i;
        end;

        if #v6 <= 1 then
            if #v6 == 1 then
                v6[1].inStream = false;
            end;
        else
            for i, v in ipairs(v6) do
                local v19 = i <= 1 and (1 / 0) or v.time - v6[i - 1].time;
                local v20 = i >= #v6 and (1 / 0) or v6[i + 1].time - v.time;

                if i == 1 then
                    v.inStream = v20 <= u1.STREAM_GAP_THRESHOLD;
                elseif i == #v6 then
                    v.inStream = v19 <= u1.STREAM_GAP_THRESHOLD;
                else
                    v.inStream = v19 <= u1.STREAM_GAP_THRESHOLD and true or v20 <= u1.STREAM_GAP_THRESHOLD;
                end;
            end;
        end;

        table.sort(u5, function(p21, p22) -- Line: 117, Name: sortSeq
            return p21.firstHit < p22.firstHit;
        end);

        for _, v in ipairs(p2.notes) do
            if v.noteType == "" or v.noteType == nil then
                table.insert(v7, v);

                if v.holdLength >= u1.MIN_LN_DURATION then
                    table.insert(v8, {
                        delta = 1,
                        time = v.time
                    });
                    table.insert(v8, {
                        delta = -1,
                        time = v.time + v.holdLength
                    });
                    table.insert(v9, v.time + v.holdLength);
                end;
            end;
        end;

        table.sort(v8, function(p23, p24) -- Line: 134
            if p23.time == p24.time then
                return p23.delta < p24.delta;
            end;

            return p23.time < p24.time;
        end);
        table.sort(v9);
        local v25 = 0;

        for _, v in ipairs(p2.notes) do
            local v26 = v.time + (v.holdLength or 0);

            if v25 < v26 then
                v25 = v26;
            end;
        end;

        if p2.svChanges and (#p2.svChanges > 0 and v25 < p2.svChanges[#p2.svChanges].time) then
            v25 = p2.svChanges[#p2.svChanges].time;
        end;

        local v27;

        if v25 > 0 then
            local math_ceil_ret = math.ceil(v25 / u1.WINDOW_STEP);
            local v28 = 1;
            local v29 = 0;

            for i = 0, math_ceil_ret - 1 do
                local v30 = i * u1.WINDOW_STEP;
                local _ = i;

                while v28 <= #v12 and v12[v28].time < v30 do
                    v28 = v28 + 1;
                end;

                if v28 <= #v12 and v12[v28].time < v30 + u1.WINDOW_STEP then
                    v29 = v29 + 1;
                end;
            end;

            v27 = v29 / math_ceil_ret;
        else
            v27 = 1;
        end;

        return {
            lnActiveAtStart = 0,
            chordEvents = v6,
            jackSeqs = u5,
            lnEvents = v8,
            tapEvents = v7,
            releaseTimes = v9,
            chartDuration = v25,
            activityRatio = v27
        };
    end
};