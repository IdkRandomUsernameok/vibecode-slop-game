-- Decompiled with Potassium's decompiler.

return {
    FormatName = "OffsetFixing",

    fixChart = function(p1, p2) -- Line: 4, Name: fixChart
        local v3 = p1.offset or (p1.song and (p1.song.offset or 0) or 0);

        if v3 == 0 then
            return p1;
        end;

        if p1.song ~= nil and p1.song.notes then
            for _, v in p1.song.notes do
                for _, v2 in v.sectionNotes do
                    v2[1] = v2[1] - v3;
                end;
            end;
        end;

        return p1;
    end
};