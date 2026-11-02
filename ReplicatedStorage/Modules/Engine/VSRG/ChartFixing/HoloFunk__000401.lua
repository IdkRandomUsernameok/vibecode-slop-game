-- Decompiled with Potassium's decompiler.

return {
    FormatName = "HoloFunk",

    fixChart = function(p1, p2) -- Line: 5, Name: fixChart
        local u3 = {
            speed = 1,
            song = "",
            bpm = 100,
            notes = {}
        };

        if not p1.characterCharts then
            return p1;
        end;

        local v4 = p1.lanes or 4;
        local bpms = p1.bpms;
        u3.keyCount = v4;
        u3.bpm = (tonumber(bpms[1].bpm) or 200) / 2;
        local v5 = {};

        if p1.scrollSpeed then
            u3.speed = p1.scrollSpeed;
        end;

        for _, v in p1.characterCharts do
            if v.visible ~= false then
                local v6 = v.chartType == 1 and 0 or v4 * (v.chartType == 0 and 1 or v.chartType);
                local v7 = 60 / u3.bpm * 1000;

                local function makeSection(p8: boolean) -- Line: 35
                    -- upvalues: u3 (copy)
                    return {
                        typeOfSection = 0,
                        sectionBeats = 4,
                        altAnim = false,
                        changeBPM = false,
                        bpm = u3.bpm,
                        sectionNotes = {},
                        mustHitSection = p8
                    };
                end;

                for _, v2 in v.notes do
                    local v9 = {};
                    local v10 = {};
                    local v11 = math.floor(v2.time * 1000 / v7) + 1;
                    local v12 = 1665 - v7;
                    table.insert(v10, {
                        v2.time * v12,
                        v2.lane + v6,
                        v2.length * v12,
                        v2.type == "normal" and "" or v2.type
                    });

                    if nil == nil then
                        local _ = v2.lane + v6;
                    end;

                    if #v9 < v11 then
                        for i = #v9 + 1, v11 do
                            local v13 = makeSection(v10[1].mustPress);
                            table.insert(v9, v13);
                            local _ = i;
                        end;
                    end;

                    local v14 = v9[v11];

                    for _, v3 in v10 do
                        table.insert(v14.sectionNotes, v3);
                    end;

                    table.insert(v5, v14);
                end;
            end;
        end;

        u3.notes = v5;

        return u3;
    end
};