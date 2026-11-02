-- Decompiled with Potassium's decompiler.

return {
    FormatName = "CameraFixing",

    fixChart = function(p1, p2) -- Line: 4, Name: fixChart
        local v3 = nil;

        if p1.song ~= nil and (p1.song.notes and not p1.song.camEvents) then
            local v4 = p1.song.bpm or 100;
            local v5 = 60 / v4 * 1000;
            local v6 = {};
            local v7 = 0;

            for _, v in p1.song.notes do
                local v8;

                if v.sectionBeats == nil and v.lengthInSteps then
                    v8 = (tonumber(v.lengthInSteps) or 16) / 4;
                    v.lengthInSteps = nil;
                else
                    v8 = 4;
                end;

                local v9 = v.sectionBeats and (tonumber(v.sectionBeats) or 4) or v8;
                local v10;

                if v.changeBPM then
                    v10 = tonumber(v.bpm) or v4;
                else
                    v10 = v4;
                end;

                if v10 == v4 then
                    v10 = v4;
                else
                    v5 = 60 / v10 * 1000;
                end;

                local v11 = {
                    StrumTime = v7,
                    Target = v.mustHitSection and 1 or 0,
                    Position = Vector2.new()
                };

                if v3 ~= v11.Target then
                    table.insert(v6, v11);
                end;

                v3 = v11.Target;
                v7 = v7 + v9 * v5;
                v4 = v10;
            end;

            p1.song.camEvents = v6;
        end;

        return p1;
    end
};