-- Decompiled with Potassium's decompiler.

return {
    FormatName = "NightmareVisionV2",

    fixChart = function(p1, p2) -- Line: 5, Name: fixChart
        local v3 = p1.song or p1;

        if v3.format ~= "nmv2" then
            return p1;
        end;

        local v4 = v3.keys or 4;

        for _, v in v3.notes do
            local v5 = v;

            for _, v2 in v.sectionNotes do
                local v6 = v2[2];
                v2[2] = v6 % v4 + (v4 <= v6 == v5.mustHitSection and v4 and v4 or 0);
            end;
        end;

        return p1.song and p1 and p1 or {
            song = v3
        };
    end
};