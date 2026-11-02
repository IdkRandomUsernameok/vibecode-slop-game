-- Decompiled with Potassium's decompiler.

local u32 = {
    PI2 = 1.5707963267948966,
    EL = 13.962634015954636,
    B1 = 0.36363636363636365,
    B2 = 0.7272727272727273,
    B3 = 0.5454545454545454,
    B4 = 0.9090909090909091,
    B5 = 0.8181818181818182,
    B6 = 0.9545454545454546,
    ELASTIC_AMPLITUDE = 1,
    ELASTIC_PERIOD = 0.4,

    linear = function(p1: number) -- Line: 17
        return p1;
    end,

    quadIn = function(p2: number) -- Line: 20
        return p2 * p2;
    end,

    quadOut = function(p3: number) -- Line: 23
        return -p3 * (p3 - 2);
    end,

    quadInOut = function(p4: number) -- Line: 26
        if p4 <= 0.5 then
            return p4 * p4 * 2;
        end;

        local v5 = p4 - 1;

        return 1 - v5 * v5 * 2;
    end,

    cubeIn = function(p6: number) -- Line: 34
        return p6 * p6 * p6;
    end,

    cubeOut = function(p7: number) -- Line: 37
        local v8 = p7 - 1;

        return v8 * v8 * v8 + 1;
    end,

    cubeInOut = function(p9: number) -- Line: 41
        if p9 <= 0.5 then
            return p9 * p9 * p9 * 4;
        end;

        local v10 = p9 - 1;

        return v10 * v10 * v10 * 4 + 1;
    end,

    quartIn = function(p11: number) -- Line: 49
        return p11 * p11 * p11 * p11;
    end,

    quartOut = function(p12: number) -- Line: 52
        local v13 = p12 - 1;

        return 1 - v13 * v13 * v13 * v13;
    end,

    quartInOut = function(p14: number) -- Line: 56
        if p14 <= 0.5 then
            return p14 * p14 * p14 * p14 * 8;
        end;

        local v15 = p14 * 2 - 2;

        return (1 - v15 * v15 * v15 * v15) / 2 + 0.5;
    end,

    quintIn = function(p16: number) -- Line: 64
        return p16 * p16 * p16 * p16 * p16;
    end,

    quintOut = function(p17: number) -- Line: 67
        local v18 = p17 - 1;

        return v18 * v18 * v18 * v18 * v18 + 1;
    end,

    quintInOut = function(p19: number) -- Line: 71
        local v20 = p19 * 2;

        if v20 < 1 then
            return v20 * v20 * v20 * v20 * v20 / 2;
        end;

        local v21 = v20 - 2;

        return (v21 * v21 * v21 * v21 * v21 + 2) / 2;
    end,

    smoothStepIn = function(p22: number) -- Line: 80
        local v23 = p22 / 2;

        return v23 * v23 * (v23 * -2 + 3) * 2;
    end,

    smoothStepOut = function(p24: number) -- Line: 84
        local v25 = p24 / 2 + 0.5;

        return v25 * v25 * (v25 * -2 + 3) * 2 - 1;
    end,

    smoothStepInOut = function(p26: number) -- Line: 88
        return p26 * p26 * (p26 * -2 + 3);
    end,

    smootherStepIn = function(p27: number) -- Line: 91
        local v28 = p27 / 2;

        return v28 * v28 * v28 * (v28 * (v28 * 6 - 15) + 10) * 2;
    end,

    smootherStepOut = function(p29: number) -- Line: 95
        local v30 = p29 / 2 + 0.5;

        return v30 * v30 * v30 * (v30 * (v30 * 6 - 15) + 10) * 2 - 1;
    end,

    smootherStepInOut = function(p31: number) -- Line: 99
        return p31 * p31 * p31 * (p31 * (p31 * 6 - 15) + 10);
    end
};

function u32.sineIn(p33: number) -- Line: 102
    -- upvalues: u32 (copy)
    return -math.cos(u32.PI2 * p33) + 1;
end;

function u32.sineOut(p34: number) -- Line: 105
    -- upvalues: u32 (copy)
    return math.sin(u32.PI2 * p34);
end;

function u32.sineInOut(p35: number) -- Line: 108
    return -math.cos(3.141592653589793 * p35) / 2 + 0.5;
end;

function u32.bounceIn(p36: number) -- Line: 111
    -- upvalues: u32 (copy)
    local v37 = 1 - p36;

    if v37 < u32.B1 then
        return 1 - v37 * 7.5625 * v37;
    end;

    if v37 < u32.B2 then
        return 1 - (7.5625 * (v37 - u32.B3) * (v37 - u32.B3) + 0.75);
    end;

    if v37 < u32.B4 then
        return 1 - (7.5625 * (v37 - u32.B5) * (v37 - u32.B5) + 0.9375);
    end;

    return 1 - (7.5625 * (v37 - u32.B6) * (v37 - u32.B6) + 0.984375);
end;

function u32.bounceOut(p38: number) -- Line: 124
    -- upvalues: u32 (copy)
    if p38 < u32.B1 then
        return p38 * 7.5625 * p38;
    end;

    if p38 < u32.B2 then
        return 7.5625 * (p38 - u32.B3) * (p38 - u32.B3) + 0.75;
    end;

    if p38 < u32.B4 then
        return 7.5625 * (p38 - u32.B5) * (p38 - u32.B5) + 0.9375;
    end;

    return 7.5625 * (p38 - u32.B6) * (p38 - u32.B6) + 0.984375;
end;

function u32.bounceInOut(p39: number) -- Line: 136
    -- upvalues: u32 (copy)
    if p39 < 0.5 then
        local v40 = 1 - p39 * 2;

        if v40 < u32.B1 then
            return (1 - v40 * 7.5625 * v40) / 2;
        end;

        if v40 < u32.B2 then
            return (1 - (7.5625 * (v40 - u32.B3) * (v40 - u32.B3) + 0.75)) / 2;
        end;

        if v40 < u32.B4 then
            return (1 - (7.5625 * (v40 - u32.B5) * (v40 - u32.B5) + 0.9375)) / 2;
        end;

        return (1 - (7.5625 * (v40 - u32.B6) * (v40 - u32.B6) + 0.984375)) / 2;
    end;

    local v41 = p39 * 2 - 1;

    if v41 < u32.B1 then
        return v41 * 7.5625 * v41 / 2 + 0.5;
    end;

    if v41 < u32.B2 then
        return (7.5625 * (v41 - u32.B3) * (v41 - u32.B3) + 0.75) / 2 + 0.5;
    end;

    if v41 < u32.B4 then
        return (7.5625 * (v41 - u32.B5) * (v41 - u32.B5) + 0.9375) / 2 + 0.5;
    end;

    return (7.5625 * (v41 - u32.B6) * (v41 - u32.B6) + 0.984375) / 2 + 0.5;
end;

function u32.circIn(p42: number) -- Line: 162
    return -(math.sqrt(1 - p42 * p42) - 1);
end;

function u32.circOut(p43: number) -- Line: 165
    return math.sqrt(1 - (p43 - 1) * (p43 - 1));
end;

function u32.circInOut(p44: number) -- Line: 168
    if p44 <= 0.5 then
        return (math.sqrt(1 - p44 * p44 * 4) - 1) / -2;
    end;

    return (math.sqrt(1 - (p44 * 2 - 2) * (p44 * 2 - 2)) + 1) / 2;
end;

function u32.expoIn(p45: number) -- Line: 175
    return math.pow(2, (p45 - 1) * 10);
end;

function u32.expoOut(p46: number) -- Line: 178
    return -math.pow(2, p46 * -10) + 1;
end;

function u32.expoInOut(p47: number) -- Line: 181
    if p47 < 0.5 then
        return math.pow(2, (p47 * 2 - 1) * 10) / 2;
    end;

    return (-math.pow(2, (p47 * 2 - 1) * -10) + 2) / 2;
end;

function u32.backIn(p48: number) -- Line: 188
    return p48 * p48 * (p48 * 2.70158 - 1.70158);
end;

function u32.backOut(p49: number) -- Line: 191
    local v50 = p49 - 1;

    return 1 - v50 * v50 * (v50 * -2.70158 - 1.70158);
end;

function u32.backInOut(p51: number) -- Line: 195
    local v52 = p51 * 2;

    if v52 < 1 then
        return v52 * v52 * (v52 * 2.70158 - 1.70158) / 2;
    end;

    local v53 = v52 - 1 - 1;

    return (1 - v53 * v53 * (v53 * -2.70158 - 1.70158)) / 2 + 0.5;
end;

function u32.elasticIn(p54: number) -- Line: 204
    -- upvalues: u32 (copy)
    local v55 = p54 - 1;
    local v56 = u32.ELASTIC_AMPLITUDE * math.pow(2, v55 * 10);
    local v57 = (v55 - u32.ELASTIC_PERIOD / 6.283185307179586 * math.asin(1 / u32.ELASTIC_AMPLITUDE)) * 6.283185307179586 / u32.ELASTIC_PERIOD;

    return -(v56 * math.sin(v57));
end;

function u32.elasticOut(p58: number) -- Line: 208
    -- upvalues: u32 (copy)
    local v59 = u32.ELASTIC_AMPLITUDE * math.pow(2, p58 * -10);
    local v60 = (p58 - u32.ELASTIC_PERIOD / 6.283185307179586 * math.asin(1 / u32.ELASTIC_AMPLITUDE)) * 6.283185307179586 / u32.ELASTIC_PERIOD;

    return v59 * math.sin(v60) + 1;
end;

function u32.elasticInOut(p61: number) -- Line: 211
    -- upvalues: u32 (copy)
    if p61 < 0.5 then
        local v62 = p61 - 0.5;

        return math.pow(2, v62 * 10) * math.sin((v62 - u32.ELASTIC_PERIOD / 4) * 6.283185307179586 / u32.ELASTIC_PERIOD) * -0.5;
    end;

    local v63 = p61 - 0.5;

    return math.pow(2, v63 * -10) * math.sin((v63 - u32.ELASTIC_PERIOD / 4) * 6.283185307179586 / u32.ELASTIC_PERIOD) * 0.5 + 1;
end;

for i, v in u32 do
    u32[i:lower()] = v;
end;

function u32.getFlxEaseByString(p64: string) -- Line: 224
    -- upvalues: u32 (copy)
    return u32[p64:lower()];
end;

return u32;