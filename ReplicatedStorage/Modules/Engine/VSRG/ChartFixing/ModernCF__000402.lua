-- Decompiled with Potassium's decompiler.

return {
    FormatName = "ModernCF",

    fixChart = function(p1, p2) -- Line: 5, Name: fixChart
        if not (p1.sections and p1.opponent) then
            return p1;
        end;

        if p1.sections then
            p1.notes = p1.sections;
            p1.sections = nil;
        end;

        if not p1.song.song then
            p1.song = p1;
        end;

        if p1.song.notes and not p1.song.camEvents then
            local bpm = p1.song.bpm;
            local v3 = 60 / bpm * 1000;
            local v4 = 0;
            local v5 = {};

            for _, v in p1.song.notes do
                local v6;

                if v.sectionBeats == nil and v.lengthInSteps then
                    v6 = (tonumber(v.lengthInSteps) or 16) / 4;
                    v.lengthInSteps = nil;
                else
                    v6 = 4;
                end;

                local v7 = v.sectionBeats and (tonumber(v.sectionBeats) or 4) or v6;
                local v8;

                if v.changeBPM then
                    v8 = tonumber(v.bpm) or bpm;
                else
                    v8 = bpm;
                end;

                if v8 == bpm then
                    v8 = bpm;
                else
                    v3 = 60 / v8 * 1000;
                end;

                local v9 = {
                    StrumTime = v4,
                    Target = v.gfSection and 2 or (v.mustHitSection and 1 or 0),
                    Position = Vector2.new()
                };
                table.insert(v5, v9);
                v4 = v4 + v7 * v3;
                bpm = v8;
            end;

            p1.song.camEvents = v5;
        end;

        return p1;
    end,

    fixEvents = function(p10) -- Line: 78, Name: fixEvents
        if not p10.events then
            return p10;
        end;

        p10.song = {
            events = p10.events
        };

        return p10;
    end
};