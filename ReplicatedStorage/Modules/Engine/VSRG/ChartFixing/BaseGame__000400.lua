-- Decompiled with Potassium's decompiler.

local v1 = {
    FormatName = "BaseGame"
};
local u2 = {
    quint = "Quint",
    expo = "Exponential",
    quart = "Quart",
    elastic = "Elastic",
    linear = "Linear",
    quad = "Quad",
    sine = "Sine",
    cubic = "Cubic",
    bounce = "Bounce",
    back = "Back",
    circ = "Circular",
    circular = "Circular",
    INSTANT = "Instant"
};

function v1.fixChart(p3, p4) -- Line: 13
    -- upvalues: u2 (copy)
    local function makeSection(p5: boolean, p6: number) -- Line: 14
        return {
            typeOfSection = 0,
            sectionBeats = 4,
            altAnim = false,
            changeBPM = false,
            bpm = p6 or 120,
            sectionNotes = {},
            mustHitSection = p5
        };
    end;

    local v7 = {
        speed = 1,
        song = "",
        bpm = 100,
        notes = {}
    };

    if not (p3.generatedBy and p3.version) then
        return p3;
    end;

    local v8 = p4 or "Normal";
    local v9 = p3.scrollSpeed or {};
    v7.speed = v9[v8] or (v9[v8:lower()] or 3);
    v7.vanillaEvents = p3.events;
    local v10 = {};

    if p3.events then
        for _, v in p3.events do
            if v.e == "FocusCamera" then
                local v11 = v.v ~= nil and typeof(v.v) == "number" and v.v or v.v.char;
                local v12 = tonumber(v11) or 2;

                if v12 <= 1 then
                    v12 = math.abs(v12 - 1);
                end;

                local v13 = typeof(v.v) ~= "number" and (v.v == nil and "" or (u2[v.v.ease] or "")) or nil;
                local v14 = typeof(v.v) ~= "number" and ((v.v == nil or v.v.ease == nil) and "" or (v.v.easeDir or "")) or nil;
                local v15 = {
                    StrumTime = v.t,
                    Target = v12,
                    Duration = typeof(v.v) ~= "number" and (v.v == nil and 0 or (v.v.duration or 0)) or nil,
                    Easing = v13,
                    EasingDirection = v14
                };
                local Vector2_new = Vector2.new;
                local v16 = (typeof(v.v) == "number" or v.v == nil) and 0 or (v.v.x or 0);
                local v17 = tonumber(v16) or 0;
                local v18 = typeof(v.v) == "number" and 0 or (v.v ~= nil and v.v.y or 0);
                v15.Position = Vector2_new(v17, tonumber(v18) or 0);
                table.insert(v10, v15);
            end;
        end;
    end;

    if p3.meta then
        local v19 = p3.meta.timeChanges or { {
                bpm = 120
            } };
        v7.song = p3.meta.songName or "A good song probably!";
        v7.bpm = v19[1].bpm or 120;
        v7.artist = p3.meta.artist;

        if v7.artist == "Unknown" then
            v7.artist = nil;
        end;

        if p3.events then
            for i, v in v19 do
                if i ~= 1 then
                    table.insert(p3.events, {
                        e = "BPM Change",
                        t = v.t,
                        v = v.bpm
                    });
                end;
            end;
        end;
    end;

    if p3.timeChanges then
        local v20 = p3.timeChanges or { {
                bpm = 120
            } };
        v7.bpm = v20[1].bpm or 120;

        if p3.events then
            for i, v in v20 do
                if i ~= 1 then
                    table.insert(p3.events, {
                        e = "BPM Change",
                        t = v.t,
                        v = v.bpm
                    });
                end;
            end;
        end;
    end;

    local v21 = makeSection(true, v7.bpm);
    local v22 = p3.notes or {};

    for _, v in v22[v8] or (v22[v8:lower()] or {}) do
        table.insert(v21.sectionNotes, {
            v.t,
            v.d,
            v.l or 0,
            v.k or nil
        });
    end;

    v7.notes = { v21 };
    v7.camEvents = v10;

    return v7;
end;

return v1;