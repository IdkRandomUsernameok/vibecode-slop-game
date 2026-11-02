-- Decompiled with Potassium's decompiler.

local u1 = {};

function u1.new(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    local v5 = {
        time = tonumber(p2) or 0,
        func = p3,
        args = p4 or {},
        _tick = tick()
    };

    return setmetatable(v5, {
        __index = u1
    });
end;

return u1;