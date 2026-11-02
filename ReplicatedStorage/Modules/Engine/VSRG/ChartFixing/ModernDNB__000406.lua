-- Decompiled with Potassium's decompiler.

return {
    FormatName = "ModernDNB",

    fixChart = function(p1, p2) -- Line: 4, Name: fixChart
        if not (p1.notes and (p1.version and not p1.generatedBy)) then
            return p1;
        end;

        local function formatSection(p3: number, p4: any) -- Line: 7
            local v5 = {
                typeOfSection = 0,
                sectionBeats = 4,
                altAnim = false,
                changeBPM = false,
                bpm = p3,
                sectionNotes = {},
                mustHitSection = p4.mustHitSection
            };

            if p4.notes and #p4.notes > 0 then
                for _, v in p4.notes do
                    local sectionNotes = v5.sectionNotes;
                    local v6 = {};
                    local v7;

                    if (v.type or "") == "" then
                        v7 = nil;
                    else
                        v7 = v.type or nil;
                    end;

                    v6[1], v6[2], v6[3], v6[4] = v.time, v.direction, v.length or 0, v7;
                    table.insert(sectionNotes, v6);
                end;
            end;

            return v5;
        end;

        local v8 = {
            song = "",
            bpm = 100,
            timeSignature = "4/4",
            notes = {},
            speed = p1.speed or 3,
            events = {}
        };
        p1.events = p1.events or {};

        if p1.meta then
            v8.song = p1.meta.songName or "Insert Song Name Here";

            if p1.meta.timeChanges then
                local v9 = p1.meta.timeChanges[1];

                if v9 then
                    v8.bpm = v9.bpm or 100;
                    v8.timeSignature = `{v9.numerator or 4}/{v9.denominator or 4}`;
                end;

                local bpm = v8.bpm;
                local timeSignature = v8.timeSignature;

                for i, v in p1.meta.timeChanges do
                    if i ~= 1 then
                        if bpm ~= v.bpm then
                            table.insert(p1.events, {
                                v.time,
                                { "BPM Change", v.bpm, "" }
                            });
                            bpm = v.bpm;
                        end;

                        local v10 = `{v.numerator or 4}/{v.denominator or 4}`;

                        if timeSignature ~= v10 then
                            table.insert(p1.events, {
                                v.time,
                                { "Time Sig Change", v10, "" }
                            });
                            timeSignature = v10;
                        end;
                    end;
                end;
            end;
        end;

        if p1.notes and #p1.notes > 0 then
            for _, v in p1.notes do
                local notes = v8.notes;
                local v11 = formatSection(v8.bpm, v);
                table.insert(notes, v11);
            end;
        end;

        return {
            song = v8
        };
    end
};