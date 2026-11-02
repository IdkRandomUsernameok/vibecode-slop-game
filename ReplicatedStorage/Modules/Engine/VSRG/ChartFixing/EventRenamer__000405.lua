-- Decompiled with Potassium's decompiler.

return {
    FormatName = "EventRenaming",

    fixChart = function(p1, p2) -- Line: 4, Name: fixChart
        local song = p1.song;

        if song and (type(song.scripts) == "table" and type(song.keyNumber) == "number") then
            song.yoshiEvents = song.events;
            song.events = nil;
        end;

        return p1;
    end
};