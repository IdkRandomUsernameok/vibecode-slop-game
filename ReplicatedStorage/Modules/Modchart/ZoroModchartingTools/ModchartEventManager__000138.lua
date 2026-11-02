-- Decompiled with Potassium's decompiler.

local u1 = {};
local ModchartEvent = require(script.Parent.ModchartEvent);
local Modifiers = require(script.Parent.Modifiers);
local ModchartUtil = require(script.Parent.ModchartUtil);
local u2 = nil;

function u1.Init(p3) -- Line: 8
    -- upvalues: u2 (ref)
    u2 = p3.Conductor;
end;

function u1.new() -- Line: 12
    -- upvalues: u1 (copy)
    return setmetatable({
        events = {}
    }, {
        __index = u1
    });
end;

function u1.update(p4) -- Line: 16
    -- upvalues: Modifiers (copy), u2 (ref)
    Modifiers.Modifier.beat = u2.SongPosition * 0.001 * (u2.BPM / 60);

    while #p4.events > 0 do
        local v5 = p4.events[1];

        if u2.SongPosition < v5.time then
            break;
        end;

        v5.func(v5.args);
        table.remove(p4.events, 1);
    end;
end;

function u1.addEvent(p6, p7, p8, p9) -- Line: 31
    -- upvalues: ModchartUtil (copy), ModchartEvent (copy)
    local TimeFromBeat = ModchartUtil:getTimeFromBeat(p7);
    table.insert(p6.events, ModchartEvent.new(TimeFromBeat, p8, p9));
    table.sort(p6.events, function(p10, p11) -- Line: 35
        if p10.time == p11.time then
            return p10._tick < p11._tick;
        end;

        return p10.time < p11.time;
    end);
end;

return u1;