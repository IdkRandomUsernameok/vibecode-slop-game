-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.newEnum(...) -- Line: 4
    -- upvalues: u1 (copy)
    local v2 = {};

    for i, v in ipairs({ ... }) do
        v2[v] = bit32.lshift(1, i);
    end;

    local u3 = setmetatable({
        flags = v2
    }, { u1 });

    function u3.new(p4: number?) -- Line: 14
        -- upvalues: u3 (copy), u1 (ref)
        return setmetatable({
            value = p4 or 0,
            enum = u3
        }, u1);
    end;

    return u3;
end;

function u1.getFlags(p5) -- Line: 23
    local value = p5.value;
    local v6 = {};

    for i, v in p5.enum.flags do
        if bit32.band(value, v) ~= 0 then
            table.insert(v6, i);
        end;
    end;

    return v6;
end;

function u1.hasFlag(p7, p8) -- Line: 37
    local v9 = p7.enum.flags[p8];

    if v9 then
        return bit32.band(p7.value, v9) ~= 0;
    end;

    return false;
end;

function u1.addFlag(p10, p11) -- Line: 43
    local v12 = p10.enum.flags[p11];

    if not v12 then
        return;
    end;

    p10.value = bit32.bor(p10.value, v12);
end;

function u1.removeFlag(p13, p14) -- Line: 50
    local v15 = p13.enum.flags[p14];

    if not v15 then
        return;
    end;

    local value = p13.value;
    local bit32_bnot_ret = bit32.bnot(v15);
    p13.value = bit32.band(value, bit32_bnot_ret);
end;

function u1.getValue(p16) -- Line: 57
    return p16.value;
end;

return u1;