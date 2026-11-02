-- Decompiled with Potassium's decompiler.

local v1 = {};
local l_bit32 = bit32;

function _hx_bit_clamp(p2)
    -- upvalues: l_bit32 (copy)
    if p2 <= 2147483647 and p2 >= -2147483648 then
        if p2 > 0 then
            return math.floor(p2);
        end;

        return math.ceil(p2);
    end;

    if p2 > 2251798999999999 then
        p2 = p2 * 2;
    end;

    if p2 ~= p2 or math.abs(p2) == (1 / 0) then
        return nil;
    end;

    local v3 = l_bit32.band(p2, 2147483647);
    local v4 = l_bit32.band(p2, 2147483648);

    return v3 - math.abs(v4);
end;

local u7 = setmetatable({}, {
    __index = function(p5, u6) -- Line: 16, Name: __index
        -- upvalues: l_bit32 (copy)
        return function(...) -- Line: 16
            -- upvalues: l_bit32 (ref), u6 (copy)
            _hx_bit_clamp(l_bit32[u6](...));
        end;
    end
});

function u7.bor(...) -- Line: 17
    -- upvalues: l_bit32 (copy)
    return _hx_bit_clamp((l_bit32.bor(...)));
end;

function u7.band(...) -- Line: 18
    -- upvalues: l_bit32 (copy)
    return _hx_bit_clamp((l_bit32.band(...)));
end;

function u7.arshift(...) -- Line: 19
    -- upvalues: l_bit32 (copy)
    return _hx_bit_clamp((l_bit32.arshift(...)));
end;

function u7.bnot(...) -- Line: 20
    -- upvalues: l_bit32 (copy)
    return _hx_bit_clamp((l_bit32.bnot((...))));
end;

function u7.bxor(...) -- Line: 21
    -- upvalues: l_bit32 (copy)
    return _hx_bit_clamp((l_bit32.bxor(...)));
end;

function u7.lshift(...) -- Line: 22
    -- upvalues: l_bit32 (copy)
    return _hx_bit_clamp((l_bit32.lshift(...)));
end;

function u7.arshift(...) -- Line: 23
    -- upvalues: l_bit32 (copy)
    return _hx_bit_clamp((l_bit32.arshift(...)));
end;

local u10 = {
    isNaN = function(p8) -- Line: 27
        return p8 ~= p8;
    end,

    isFinite = function(p9) -- Line: 30
        if p9 > (-1 / 0) then
            return p9 < (1 / 0);
        end;

        return false;
    end
};

function u10.min(p11, p12) -- Line: 37
    -- upvalues: u10 (copy)
    return (u10.isNaN(p11) or u10.isNaN(p12)) and (0 / 0) or math.min(p11, p12);
end;

local u15 = {
    string = function(p13) -- Line: 47
        return tostring(p13);
    end,

    int = function(p14) -- Line: 50
        -- upvalues: u10 (copy)
        return (not u10.isFinite(p14) or u10.isNaN(p14)) and 0 or _hx_bit_clamp(p14);
    end
};

function v1.roundDecimal(p16, p17) -- Line: 58
    local v18 = 0;
    local v19 = 1;

    while v18 < p17 do
        v18 = v18 + 1;
        local _ = v18 - 1;
        v19 = v19 * 10;
    end;

    return math.floor(p16 * v19 + 0.5) / v19;
end;

function v1.isNaN(p20) -- Line: 69
    return p20 ~= p20;
end;

function v1.bound(p21, p22, p23) -- Line: 72
    if p22 ~= nil and p21 < p22 then
        p21 = p22;
    end;

    if p23 == nil or p23 >= p21 then
        return p21;
    end;

    return p23;
end;

function v1.lerp(p24, p25, p26) -- Line: 86
    return p24 + p26 * (p25 - p24);
end;

function v1.inBounds(p27, p28, p29) -- Line: 89
    if p28 == nil or p28 <= p27 then
        return p29 == nil and true or p27 <= p29;
    end;

    return false;
end;

function v1.isOdd(p30) -- Line: 100
    -- upvalues: u7 (copy), u15 (copy)
    return u7.band(u15.int(p30), 1) ~= 0;
end;

function v1.isEven(p31) -- Line: 103
    -- upvalues: u7 (copy), u15 (copy)
    return u7.band(u15.int(p31), 1) == 0;
end;

function v1.numericComparison(p32, p33) -- Line: 106
    return p32 < p33 and -1 or (p33 < p32 and 1 or 0);
end;

function v1.pointInCoordinates(p34, p35, p36, p37, p38, p39) -- Line: 116
    return p36 <= p34 and (p34 <= p36 + p38 and (p37 <= p35 and p35 <= p37 + p39));
end;

function v1.pointInFlxRect(p40, p41, p42) -- Line: 124
    if p42.x <= p40 and (p40 <= p42.right and p42.y <= p41) then
        return p41 <= p42.bottom;
    end;

    return false;
end;

function v1.pointInRectangle(p43, p44, p45) -- Line: 131
    if p45.x <= p43 and (p43 <= p45.right and p45.y <= p44) then
        return p44 <= p45.bottom;
    end;

    return false;
end;

function v1.maxAdd(p46, p47, p48, p49) -- Line: 138
    local v50 = p49 == nil and 0 or p49;
    local v51 = p46 + p47;

    if p48 < v51 then
        return p48;
    end;

    if v51 > v50 then
        v50 = v51;
    end;

    return v50;
end;

function v1.wrap(p52, p53, p54) -- Line: 152
    -- upvalues: u15 (copy)
    local v55 = p54 - p53 + 1;

    if p52 < p53 then
        p52 = p52 + v55 * u15.int((p53 - p52) / v55 + 1);
    end;

    return p53 + math.fmod(p52 - p53, v55);
end;

function v1.remapToRange(p56, p57, p58, p59, p60) -- Line: 159
    return p59 + (p56 - p57) * ((p60 - p59) / (p58 - p57));
end;

function v1.dotProduct(p61, p62, p63, p64) -- Line: 162
    return p61 * p63 + p62 * p64;
end;

function v1.vectorLength(p65, p66) -- Line: 165
    return math.sqrt(p65 * p65 + p66 * p66);
end;

function v1.equal(p67, p68, p69) -- Line: 168
    return (p69 == nil and 1e-7 or p69) >= math.abs(p67 - p68);
end;

function v1.signOf(p70) -- Line: 174
    return p70 < 0 and -1 or 1;
end;

function v1.sameSign(p71, p72) -- Line: 181
    return (p71 < 0 and -1 or 1) == (p72 < 0 and -1 or 1);
end;

function v1.fastSin(p73) -- Line: 196
    -- upvalues: u7 (copy)
    local v74 = p73 * 0.3183098862;

    if v74 > 1 then
        v74 = v74 - u7.lshift(u7.arshift(math.ceil(v74), 1), 1);
    elseif v74 < -1 then
        v74 = v74 + u7.lshift(u7.arshift(math.ceil(-v74), 1), 1);
    end;

    if v74 > 0 then
        return v74 * (3.1 + v74 * (0.5 + v74 * (-7.2 + v74 * 3.6)));
    end;

    return v74 * (3.1 - v74 * (0.5 + v74 * (7.2 + v74 * 3.6)));
end;

function v1.fastCos(p75) -- Line: 211
    -- upvalues: u7 (copy)
    local v76 = (p75 + 1.570796327) * 0.3183098862;

    if v76 > 1 then
        v76 = v76 - u7.lshift(u7.arshift(math.ceil(v76), 1), 1);
    elseif v76 < -1 then
        v76 = v76 + u7.lshift(u7.arshift(math.ceil(-v76), 1), 1);
    end;

    if v76 > 0 then
        return v76 * (3.1 + v76 * (0.5 + v76 * (-7.2 + v76 * 3.6)));
    end;

    return v76 * (3.1 - v76 * (0.5 + v76 * (7.2 + v76 * 3.6)));
end;

function v1.sinh(p77) -- Line: 227
    return (math.exp(p77) - math.exp(-p77)) / 2;
end;

function v1.maxInt(p78, p79) -- Line: 230
    if p79 < p78 then
        return p78;
    end;

    return p79;
end;

function v1.minInt(p80, p81) -- Line: 237
    if p81 < p80 then
        return p81;
    end;

    return p80;
end;

function v1.absInt(p82) -- Line: 244
    if p82 > 0 then
        return p82;
    end;

    return -p82;
end;

v1.MIN_VALUE_FLOAT = 5e-324;
v1.MAX_VALUE_FLOAT = 1.79e308;
v1.MIN_VALUE_INT = -2147483647;
v1.MAX_VALUE_INT = 2147483647;
v1.SQUARE_ROOT_OF_TWO = 1.41421356237;
v1.EPSILON = 1e-7;

return v1;