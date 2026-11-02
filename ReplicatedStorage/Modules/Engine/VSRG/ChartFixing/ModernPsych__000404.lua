-- Decompiled with Potassium's decompiler.

return {
    FormatName = "ModernPsych",

    fixChart = function(p1, p2) -- Line: 4, Name: fixChart
        if not (p1.format and (p1.format == "psych_v1" or p1.format == "psych_v1_convert")) then
            return p1;
        end;

        if p1 ~= nil and p1.notes then
            local v3 = p1.keyCount or 4;
            local bpm = p1.bpm;
            local v4 = 60 / bpm * 1000 * 4 / 16;

            for _, v in p1.notes do
                if v.changeBPM and v.bpm ~= bpm then
                    bpm = v.bpm;
                    v4 = 60 / bpm * 1000 * 4 / 16;
                end;

                local v5 = v;

                for _, v2 in v.sectionNotes do
                    v2[2] = v2[2] % v3 + (v5.mustHitSection == (v3 <= v2[2]) and v3 and v3 or 0);
                    local v6 = v2[3];
                    local v7 = v6 - v4 * 1.5;

                    if v4 * 2 < v6 then
                        v2[3] = math.max(0, v7);
                    end;
                end;
            end;
        end;

        return {
            song = p1
        };
    end
};