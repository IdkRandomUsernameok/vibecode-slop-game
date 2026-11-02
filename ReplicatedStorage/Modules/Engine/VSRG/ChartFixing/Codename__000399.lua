-- Decompiled with Potassium's decompiler.

return {
    FormatName = "Codename",

    fixChart = function(p1, p2) -- Line: 5, Name: fixChart
        local u3 = {
            speed = 1,
            song = "",
            bpm = 100,
            notes = {}
        };

        local function makeSection(p4: boolean) -- Line: 13
            -- upvalues: u3 (copy)
            return {
                typeOfSection = 0,
                sectionBeats = 4,
                altAnim = false,
                changeBPM = false,
                bpm = u3.bpm,
                sectionNotes = {},
                mustHitSection = p4
            };
        end;

        if not p1.codenameChart then
            return p1;
        end;

        local v5 = {};
        local v6 = {};
        u3.bpm = p1.bpm or 100;
        u3.speed = p1.scrollSpeed or 1;

        if p1.meta then
            u3.bpm = p1.meta.bpm or u3.bpm;
        end;

        local v7 = false;
        local v8 = false;

        for _, v in p1.strumLines do
            if v.type == 0 then
                if v8 == false then
                    u3.keyCount = v.keyCount or 4;
                    v8 = true;
                end;

                for _, v2 in v.notes do
                    table.insert(v5, {
                        v2.time,
                        v2.id,
                        v2.sLen,
                        v2.type == 0 and "" or p1.noteTypes[v2.type]
                    });
                end;
            elseif v.type == 1 then
                if v7 == false then
                    u3.playerKeyCount = v.keyCount or 4;
                    v7 = true;
                end;

                local v9 = v;

                for _, v2 in v.notes do
                    table.insert(v5, {
                        v2.time,
                        v2.id + (v9.keyCount or 4),
                        v2.sLen,
                        v2.type == 0 and "" or p1.noteTypes[v2.type]
                    });
                end;
            elseif v.type == 2 then
                for _, v2 in v.notes do
                    table.insert(v5, {
                        v2.time,
                        v2.id,
                        v2.sLen,
                        v2.type == 0 and "GF Sing" or p1.noteTypes[v2.type]
                    });
                end;
            end;
        end;

        local v10 = math.floor(v5[#v5][1] * 1000 / (60 / u3.bpm * 1000)) + 1;
        local v11 = makeSection(false);
        v11.sectionBeats = v10 * 4;
        v11.sectionNotes = v5;
        u3.notes = { v11 };
        local v12 = {};

        if p1.events then
            for _, v in p1.events do
                if v.name == "Camera Movement" then
                    local v13 = {
                        StrumTime = v.time,
                        Target = v.params[1],
                        Position = Vector2.new()
                    };
                    table.insert(v6, v13);
                else
                    table.insert(v12, v);
                end;
            end;
        end;

        u3.codenameEvents = v12;
        u3.camEvents = v6;

        return u3;
    end,

    fixEvents = function(p14) -- Line: 117, Name: fixEvents
        if not p14.codenameEvents then
            return p14;
        end;

        local v15 = {};
        local v16 = {};

        for _, v in p14.codenameEvents do
            if v.name == "Camera Movement" then
                local v17 = {
                    StrumTime = v.time,
                    Target = v.params[1],
                    Position = Vector2.new()
                };
                table.insert(v15, v17);
            else
                table.insert(v16, v);
            end;
        end;

        return {
            codenameEvents = v16,
            camEvents = v15
        };
    end
};