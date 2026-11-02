-- Decompiled with Potassium's decompiler.

local Utils = script.Parent.Parent:WaitForChild("Utils");
local Signal = require(Utils:WaitForChild("Signal"));
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 18
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.Changed = Signal.new();
    v2._items = {};
    v2._currentState = {};

    return v2;
end;

function u1._resolve(p3) -- Line: 32
    -- upvalues: u1 (copy)
    local v4 = (-1 / 0);
    local v5 = nil;

    for i, v in pairs(u1.GetItems(p3)) do
        local Priority = v.Priority;

        if Priority >= v4 then
            if Priority == v4 then
                warn((`[PriorityState]: {i} and {v5} both have the same priority {Priority}`));
            end;

            v5 = i;
            v4 = Priority;
        end;
    end;

    local v6 = p3._items[v5] or {};
    local _currentState = p3._currentState;

    if v6 ~= _currentState then
        p3._currentState = v6;
        p3.Changed:Fire(v6, _currentState);
    end;
end;

function u1.Set(p7: any, p8: string, p9: table) -- Line: 60
    -- upvalues: u1 (copy)
    local v10 = type(p9) == "table";
    assert(v10, "State item must be a table");
    local v11 = type(p9.Priority) == "number";
    assert(v11, "State item must have a priority value which is a number");
    p7._items[p8] = p9;
    u1._resolve(p7);
end;

function u1.Remove(p12: any, p13: string) -- Line: 68
    -- upvalues: u1 (copy)
    if not p12._items[p13] then
        return;
    end;

    p12._items[p13] = nil;
    u1._resolve(p12);
end;

function u1.Clear(p14) -- Line: 75
    -- upvalues: u1 (copy)
    table.clear(p14._items);
    u1._resolve(p14);
end;

function u1.Get(p15) -- Line: 81
    return p15._currentState;
end;

function u1.GetItems(p16) -- Line: 85
    return p16._items;
end;

return u1;