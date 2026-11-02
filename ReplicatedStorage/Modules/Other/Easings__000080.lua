-- Decompiled with Potassium's decompiler.

local u11 = {
    Lerp = function(p1, p2, p3) -- Line: 5
        return p1 + (p2 - p1) * p3;
    end,

    Constant = function(p4, p5, p6, p7) -- Line: 9
        return p6 == 1 and 1 or 0;
    end,

    Linear = function(p8, p9, p10) -- Line: 27
        return p10;
    end
};

function u11.Quad(p12, p13, p14, p15) -- Line: 31
    -- upvalues: u11 (copy)
    local v16 = nil;

    if p15 == Enum.EasingDirection.In then
        v16 = p14 ^ 2;
    elseif p15 == Enum.EasingDirection.Out then
        v16 = -(p14 - 1) ^ 2 + 1;
    elseif p15 == Enum.EasingDirection.InOut then
        if p14 <= 0.5 then
            v16 = 2 * p14 ^ 2;
        elseif p14 <= 1 then
            v16 = -2 * (p14 - 1) ^ 2 + 1;
        end;
    elseif p14 <= 0.5 then
        v16 = -2 * (p14 - 0.5) ^ 2 + 0.5;
    elseif p14 <= 1 then
        v16 = 2 * (p14 - 0.5) ^ 2 + 0.5;
    end;

    return u11.Lerp(p12, p13, v16);
end;

function u11.Sine(p17, p18, p19, p20) -- Line: 53
    -- upvalues: u11 (copy)
    local v21 = nil;

    if p20 == Enum.EasingDirection.In then
        v21 = math.sin(1.5707963267948966 * p19 - 1.5707963267948966) + 1;
    elseif p20 == Enum.EasingDirection.Out then
        v21 = math.sin(1.5707963267948966 * p19);
    elseif p20 == Enum.EasingDirection.InOut then
        v21 = math.sin(3.141592653589793 * p19 - 1.5707963267948966) * 0.5 + 0.5;
    elseif p19 <= 0.5 then
        v21 = math.sin(3.141592653589793 * p19) * 0.5;
    elseif p19 <= 1 then
        v21 = math.sin(3.141592653589793 * p19 - 3.141592653589793) * 0.5 + 1;
    end;

    return u11.Lerp(p17, p18, v21);
end;

function u11.Quint(p22, p23, p24, p25) -- Line: 71
    -- upvalues: u11 (copy)
    local v26 = nil;

    if p25 == Enum.EasingDirection.In then
        v26 = p24 ^ 5;
    elseif p25 == Enum.EasingDirection.Out then
        v26 = (p24 - 1) ^ 5 + 1;
    elseif p25 == Enum.EasingDirection.InOut then
        if p24 <= 0.5 then
            v26 = 16 * p24 ^ 5;
        elseif p24 <= 1 then
            v26 = 16 * (p24 - 1) ^ 5 + 1;
        end;
    else
        v26 = 16 * (p24 - 0.5) ^ 5 + 0.5;
    end;

    return u11.Lerp(p22, p23, v26);
end;

function u11.Quart(p27, p28, p29, p30) -- Line: 89
    -- upvalues: u11 (copy)
    local v31 = nil;

    if p30 == Enum.EasingDirection.In then
        v31 = p29 ^ 4;
    elseif p30 == Enum.EasingDirection.Out then
        v31 = -(p29 - 1) ^ 4 + 1;
    elseif p30 == Enum.EasingDirection.InOut then
        if p29 <= 0.5 then
            v31 = 8 * p29 ^ 4;
        elseif p29 <= 1 then
            v31 = -8 * (p29 - 1) ^ 4 + 1;
        end;
    elseif p29 <= 0.5 then
        v31 = -8 * (p29 - 0.5) ^ 4 + 0.5;
    elseif p29 <= 1 then
        v31 = 8 * (p29 - 0.5) ^ 4 + 0.5;
    end;

    return u11.Lerp(p27, p28, v31);
end;

function u11.Cubic(p32, p33, p34, p35) -- Line: 111
    -- upvalues: u11 (copy)
    local v36 = nil;

    if p35 == Enum.EasingDirection.In then
        v36 = p34 ^ 3;
    elseif p35 == Enum.EasingDirection.Out then
        v36 = (p34 - 1) ^ 3 + 1;
    elseif p35 == Enum.EasingDirection.InOut then
        if p34 <= 0.5 then
            v36 = 4 * p34 ^ 3;
        elseif p34 <= 1 then
            v36 = 4 * (p34 - 1) ^ 3 + 1;
        end;
    else
        v36 = 4 * (p34 - 0.5) ^ 3 + 0.5;
    end;

    return u11.Lerp(p32, p33, v36);
end;

function u11.Back(p37, p38, p39, p40) -- Line: 129
    -- upvalues: u11 (copy)
    local v41 = nil;
    local v42 = p39 * 0.3;

    if p40 == Enum.EasingDirection.In then
        v41 = p39 * p39 * (p39 * (v42 + 1) - v42);
    elseif p40 == Enum.EasingDirection.Out then
        v41 = (p39 - 1) ^ 2 * ((p39 - 1) * (v42 + 1) + v42) + 1;
    elseif p40 == Enum.EasingDirection.InOut then
        if p39 <= 0.5 then
            v41 = 2 * p39 * p39 * (2 * p39 * (v42 + 1) - v42);
        elseif p39 <= 1 then
            v41 = 0.5 * (2 * p39 - 2) ^ 2 * ((2 * p39 - 2) * (v42 + 1) + v42) + 1;
        end;
    elseif p39 <= 0.5 then
        v41 = 0.5 * (2 * p39 - 1) ^ 2 * ((2 * p39 - 1) * (v42 + 1) + v42) + 0.5;
    elseif p39 <= 1 then
        v41 = 0.5 * (2 * p39 - 1) ^ 2 * ((2 * p39 - 1) * (v42 + 1) - v42) + 0.5;
    end;

    return u11.Lerp(p37, p38, v41);
end;

function u11.Circular(p43, p44, p45, p46) -- Line: 153
    -- upvalues: u11 (copy)
    local v47 = nil;

    if p46 == Enum.EasingDirection.In then
        v47 = -math.sqrt(1 - p45 ^ 2) + 1;
    elseif p46 == Enum.EasingDirection.Out then
        v47 = math.sqrt(-(p45 - 1) ^ 2 + 1);
    elseif p46 == Enum.EasingDirection.InOut then
        if p45 <= 0.5 then
            v47 = -math.sqrt(-p45 ^ 2 + 0.25) + 0.5;
        elseif p45 <= 1 then
            v47 = math.sqrt(-(p45 - 1) ^ 2 + 0.25) + 0.5;
        end;
    elseif p45 <= 0.5 then
        v47 = math.sqrt(-(p45 - 0.5) ^ 2 + 0.25);
    elseif p45 <= 1 then
        v47 = -math.sqrt(-(p45 - 0.5) ^ 2 + 0.25) + 1;
    end;

    return u11.Lerp(p43, p44, v47);
end;

function u11.Elastic(p48, p49, p50, p51) -- Line: 175
    -- upvalues: u11 (copy)
    local v52 = 0;
    local v53 = p50 * 0.3;

    if p51 == Enum.EasingDirection.In then
        v52 = -2 ^ (10 * (p50 - 1)) * math.sin(6.283185307179586 * (p50 - 1 - v53 / 4) / v53);
    elseif p51 == Enum.EasingDirection.Out then
        v52 = 2 ^ (-10 * p50) * math.sin(6.283185307179586 * (p50 - v53 / 4) / v53) + 1;
    elseif p51 == Enum.EasingDirection.InOut then
        local math_sin_ret = math.sin(6.283185307179586 * (2 * p50 - 1.1125) / v53);

        if p50 <= 0.5 then
            v52 = -0.5 * 2 ^ (20 * p50 - 10) * math_sin_ret;
        elseif p50 <= 1 then
            v52 = 0.5 * 2 ^ (-20 * p50 + 10) * math_sin_ret + 1;
        end;
    elseif p50 <= 0.5 then
        v52 = 0.5 * 2 ^ (-20 * p50) * math.sin(6.283185307179586 * (2 * p50 - v53 / 4) / v53) + 0.5;
    elseif p50 <= 1 then
        v52 = -0.5 * 2 ^ (10 * (2 * p50 - 2)) * math.sin(6.283185307179586 * (2 * p50 - 2 - v53 / 4) / v53) + 0.5;
    end;

    return u11.Lerp(p48, p49, v52);
end;

function u11.Exponential(p54, p55, p56, p57) -- Line: 200
    -- upvalues: u11 (copy)
    local v58 = nil;

    if p57 == Enum.EasingDirection.In then
        v58 = 2 ^ (10 * p56 - 10) - 0.001;
    elseif p57 == Enum.EasingDirection.Out then
        v58 = 1.001 * -2 ^ (-10 * p56) + 1;
    elseif p57 == Enum.EasingDirection.InOut then
        if p56 <= 0.5 then
            v58 = 0.5 * 2 ^ (20 * p56 - 10) - 0.0005;
        elseif p56 <= 1 then
            v58 = 0.50025 * -2 ^ (-20 * p56 + 10) + 1;
        end;
    elseif p56 <= 0.5 then
        v58 = 0.5005 * -2 ^ (-20 * p56) + 0.5005;
    elseif p56 <= 1 then
        v58 = 0.5 * 2 ^ (10 * (2 * p56 - 2)) + 0.4995;
    end;

    return u11.Lerp(p54, p55, v58);
end;

function u11.Bounce(p59, p60, p61, p62) -- Line: 222
    -- upvalues: u11 (copy)
    local v63 = nil;

    if p62 == Enum.EasingDirection.In then
        if p61 <= 0.36363636363636365 then
            v63 = 7.5625 * p61 * p61;
        elseif p61 <= 0.7272727272727273 then
            v63 = 7.5625 * (p61 - 0.5454545454545454) ^ 2 + 0.75;
        elseif p61 <= 0.9090909090909091 then
            v63 = 7.5625 * (p61 - 0.8181818181818182) ^ 2 + 0.9375;
        elseif p61 <= 1 then
            v63 = 7.5625 * (p61 - 0.9545454545454546) ^ 2 + 0.984375;
        end;
    elseif p62 == Enum.EasingDirection.Out then
        if p61 <= 0.09090909090909091 then
            v63 = -7.5625 * (1 - p61 - 0.9545454545454546) ^ 2 + 0.015625;
        elseif p61 <= 0.2727272727272727 then
            v63 = -7.5625 * (1 - p61 - 0.8181818181818182) ^ 2 + 0.0625;
        elseif p61 <= 0.6363636363636364 then
            v63 = -7.5625 * (1 - p61 - 0.5454545454545454) ^ 2 + 0.25;
        elseif p61 <= 1 then
            v63 = 1 - 7.5625 * (1 - p61) ^ 2;
        end;
    elseif p62 == Enum.EasingDirection.InOut then
        if p61 <= 0.045454545454545456 then
            v63 = 0.5 * (-7.5625 * (1 - 2 * p61 - 0.9545454545454546) ^ 2 + 0.015625);
        elseif p61 <= 0.13636363636363635 then
            v63 = 0.5 * (-7.5625 * (1 - 2 * p61 - 0.9545454545454546) ^ 2 + 0.0625);
        elseif p61 <= 0.3181818181818182 then
            v63 = 0.5 * (-7.5625 * (1 - 2 * p61 - 0.5454545454545454) ^ 2 + 0.25);
        elseif p61 <= 0.5 then
            v63 = 0.5 * (1 - 7.5625 * (1 - 2 * p61) ^ 2);
        elseif p61 <= 0.6818181818181818 then
            v63 = 0.5 + 3.78125 * (2 * p61 - 1) ^ 2;
        elseif p61 <= 0.8636363636363636 then
            v63 = 3.78125 * (2 * p61 - 1.5454545454545454) ^ 2 + 0.875;
        elseif p61 <= 0.9545454545454546 then
            v63 = 3.78125 * (2 * p61 - 1.8181818181818181) ^ 2 + 0.96875;
        elseif p61 <= 1 then
            v63 = 3.78125 * (2 * p61 - 1.9545454545454546) ^ 2 + 0.9921875;
        end;
    elseif p61 <= 0.18181818181818182 then
        v63 = 15.125 * p61 * p61;
    elseif p61 <= 0.36363636363636365 then
        v63 = 3.78125 * (2 * p61 - 0.5454545454545454) ^ 2 + 0.375;
    elseif p61 <= 0.45454545454545453 then
        v63 = 3.78125 * (2 * p61 - 0.8181818181818182) ^ 2 + 0.46875;
    elseif p61 <= 0.5 then
        v63 = 3.78125 * (2 * p61 - 0.9545454545454546) ^ 2 + 0.4921875;
    elseif p61 <= 0.5454545454545454 then
        v63 = -3.78125 * (2 * p61 - 1.0454545454545454) ^ 2 + 0.5078125;
    elseif p61 <= 0.6363636363636364 then
        v63 = -3.78125 * (2 * p61 - 1.1818181818181819) ^ 2 + 0.53125;
    elseif p61 <= 0.8181818181818182 then
        v63 = -3.78125 * (2 * p61 - 1.4545454545454546) ^ 2 + 0.625;
    elseif p61 <= 1 then
        v63 = -15.125 * (p61 - 1) ^ 2 + 1;
    end;

    return u11.Lerp(p59, p60, v63);
end;

function u11.BezierCurve(p64, p65) -- Line: 286
    -- upvalues: u11 (copy)
    if #p65 <= 2 then
        return p65[1]:Lerp(p65[2], p64);
    end;

    local v66 = {};

    for i = 1, #p65 - 1 do
        v66[#v66 + 1] = p65[i]:Lerp(p65[i + 1], p64);
        local _ = i;
    end;

    return u11.BezierCurve(p64, v66);
end;

return u11;