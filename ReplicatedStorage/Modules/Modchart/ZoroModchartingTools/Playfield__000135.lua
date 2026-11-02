-- Decompiled with Potassium's decompiler.

local u1 = {};

function u1.new(p2, p3, p4, p5) -- Line: 3
    -- upvalues: u1 (copy)
    return setmetatable({
        x = p2 or 0,
        y = p3 or 0,
        z = p4 or 0,
        alpha = p5 or 1
    }, {
        __index = u1
    });
end;

function u1.applyOffsets(p6, p7) -- Line: 12
    p7.x = p7.x + p6.x;
    p7.y = p7.y + p6.y;
    p7.z = p7.z + p6.z;
    p7.alpha = p7.alpha * p6.alpha;
end;

return u1;