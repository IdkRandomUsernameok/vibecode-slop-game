-- Decompiled with Potassium's decompiler.

local u1 = {};
game:GetService("RunService");

function u1.linear(p2, p3, p4, p5) -- Line: 9
    return p4 * p2 / p5 + p3;
end;

function u1.inQuad(p6, p7, p8, p9) -- Line: 13
    return p8 * math.pow(p6 / p9, 2) + p7;
end;

function u1.outQuad(p10, p11, p12, p13) -- Line: 18
    local v14 = p10 / p13;

    return -p12 * v14 * (v14 - 2) + p11;
end;

function u1.inOutQuad(p15, p16, p17, p18) -- Line: 23
    local v19 = p15 / p18 * 2;

    if v19 < 1 then
        return p17 / 2 * math.pow(v19, 2) + p16;
    end;

    return -p17 / 2 * ((v19 - 1) * (v19 - 3) - 1) + p16;
end;

function u1.outInQuad(p20, p21, p22, p23) -- Line: 32
    -- upvalues: u1 (copy)
    if p20 < p23 / 2 then
        return u1.outQuad(p20 * 2, p21, p22 / 2, p23);
    end;

    return u1.inQuad(p20 * 2 - p23, p21 + p22 / 2, p22 / 2, p23);
end;

function u1.inCubic(p24, p25, p26, p27) -- Line: 40
    return p26 * math.pow(p24 / p27, 3) + p25;
end;

function u1.outCubic(p28, p29, p30, p31) -- Line: 45
    return p30 * (math.pow(p28 / p31 - 1, 3) + 1) + p29;
end;

function u1.inOutCubic(p32, p33, p34, p35) -- Line: 50
    local v36 = p32 / p35 * 2;

    if v36 < 1 then
        return p34 / 2 * v36 * v36 * v36 + p33;
    end;

    local v37 = v36 - 2;

    return p34 / 2 * (v37 * v37 * v37 + 2) + p33;
end;

function u1.outInCubic(p38, p39, p40, p41) -- Line: 60
    -- upvalues: u1 (copy)
    if p38 < p41 / 2 then
        return u1.outCubic(p38 * 2, p39, p40 / 2, p41);
    end;

    return u1.inCubic(p38 * 2 - p41, p39 + p40 / 2, p40 / 2, p41);
end;

function u1.inQuart(p42, p43, p44, p45) -- Line: 68
    return p44 * math.pow(p42 / p45, 4) + p43;
end;

function u1.outQuart(p46, p47, p48, p49) -- Line: 73
    return -p48 * (math.pow(p46 / p49 - 1, 4) - 1) + p47;
end;

function u1.inOutQuart(p50, p51, p52, p53) -- Line: 78
    local v54 = p50 / p53 * 2;

    if v54 < 1 then
        return p52 / 2 * math.pow(v54, 4) + p51;
    end;

    return -p52 / 2 * (math.pow(v54 - 2, 4) - 2) + p51;
end;

function u1.outInQuart(p55, p56, p57, p58) -- Line: 88
    -- upvalues: u1 (copy)
    if p55 < p58 / 2 then
        return u1.outQuart(p55 * 2, p56, p57 / 2, p58);
    end;

    return u1.inQuart(p55 * 2 - p58, p56 + p57 / 2, p57 / 2, p58);
end;

function u1.inQuint(p59, p60, p61, p62) -- Line: 96
    return p61 * math.pow(p59 / p62, 5) + p60;
end;

function u1.outQuint(p63, p64, p65, p66) -- Line: 101
    return p65 * (math.pow(p63 / p66 - 1, 5) + 1) + p64;
end;

function u1.inOutQuint(p67, p68, p69, p70) -- Line: 106
    local v71 = p67 / p70 * 2;

    if v71 < 1 then
        return p69 / 2 * math.pow(v71, 5) + p68;
    end;

    return p69 / 2 * (math.pow(v71 - 2, 5) + 2) + p68;
end;

function u1.outInQuint(p72, p73, p74, p75) -- Line: 116
    -- upvalues: u1 (copy)
    if p72 < p75 / 2 then
        return u1.outQuint(p72 * 2, p73, p74 / 2, p75);
    end;

    return u1.inQuint(p72 * 2 - p75, p73 + p74 / 2, p74 / 2, p75);
end;

function u1.inSine(p76, p77, p78, p79) -- Line: 124
    return -p78 * math.cos(p76 / p79 * 1.5707963267948966) + p78 + p77;
end;

function u1.outSine(p80, p81, p82, p83) -- Line: 128
    return p82 * math.sin(p80 / p83 * 1.5707963267948966) + p81;
end;

function u1.inOutSine(p84, p85, p86, p87) -- Line: 132
    return -p86 / 2 * (math.cos(3.141592653589793 * p84 / p87) - 1) + p85;
end;

function u1.outInSine(p88, p89, p90, p91) -- Line: 136
    -- upvalues: u1 (copy)
    if p88 < p91 / 2 then
        return u1.outSine(p88 * 2, p89, p90 / 2, p91);
    end;

    return u1.inSine(p88 * 2 - p91, p89 + p90 / 2, p90 / 2, p91);
end;

function u1.inExpo(p92, p93, p94, p95) -- Line: 144
    if p92 == 0 then
        return p93;
    end;

    return p94 * math.pow(2, 10 * (p92 / p95 - 1)) + p93 - p94 * 0.001;
end;

function u1.outExpo(p96, p97, p98, p99) -- Line: 152
    if p96 == p99 then
        return p97 + p98;
    end;

    return p98 * 1.001 * (-math.pow(2, -10 * p96 / p99) + 1) + p97;
end;

function u1.inOutExpo(p100, p101, p102, p103) -- Line: 160
    if p100 == 0 then
        return p101;
    end;

    if p100 == p103 then
        return p101 + p102;
    end;

    local v104 = p100 / p103 * 2;

    if v104 < 1 then
        return p102 / 2 * math.pow(2, 10 * (v104 - 1)) + p101 - p102 * 0.0005;
    end;

    return p102 / 2 * 1.0005 * (-math.pow(2, -10 * (v104 - 1)) + 2) + p101;
end;

function u1.outInExpo(p105, p106, p107, p108) -- Line: 172
    -- upvalues: u1 (copy)
    if p105 < p108 / 2 then
        return u1.outExpo(p105 * 2, p106, p107 / 2, p108);
    end;

    return u1.inExpo(p105 * 2 - p108, p106 + p107 / 2, p107 / 2, p108);
end;

function u1.inCirc(p109, p110, p111, p112) -- Line: 180
    local v113 = 1 - math.pow(p109 / p112, 2);

    return -p111 * (math.sqrt(v113) - 1) + p110;
end;

function u1.outCirc(p114, p115, p116, p117) -- Line: 185
    local v118 = 1 - math.pow(p114 / p117 - 1, 2);

    return p116 * math.sqrt(v118) + p115;
end;

function u1.inOutCirc(p119, p120, p121, p122) -- Line: 190
    local v123 = p119 / p122 * 2;

    if v123 < 1 then
        return -p121 / 2 * (math.sqrt(1 - v123 * v123) - 1) + p120;
    end;

    local v124 = v123 - 2;

    return p121 / 2 * (math.sqrt(1 - v124 * v124) + 1) + p120;
end;

function u1.outInCirc(p125, p126, p127, p128) -- Line: 200
    -- upvalues: u1 (copy)
    if p125 < p128 / 2 then
        return u1.outCirc(p125 * 2, p126, p127 / 2, p128);
    end;

    return u1.inCirc(p125 * 2 - p128, p126 + p127 / 2, p127 / 2, p128);
end;

function u1.inElastic(p129, p130, p131, p132, p133, p134) -- Line: 208
    if p129 == 0 then
        return p130;
    end;

    local v135 = p129 / p132;

    if v135 == 1 then
        return p130 + p131;
    end;

    local v136 = p134 or p132 * 0.3;
    local v137;

    if p133 and p133 >= math.abs(p131) then
        v137 = v136 / 6.283185307179586 * math.asin(p131 / p133);
    else
        v137 = v136 / 4;
        p133 = p131;
    end;

    local v138 = v135 - 1;

    return -(p133 * math.pow(2, 10 * v138) * math.sin((v138 * p132 - v137) * 6.283185307179586 / v136)) + p130;
end;

function u1.outElastic(p139, p140, p141, p142, p143, p144) -- Line: 233
    if p139 == 0 then
        return p140;
    end;

    local v145 = p139 / p142;

    if v145 == 1 then
        return p140 + p141;
    end;

    local v146 = p144 or p142 * 0.3;
    local v147;

    if p143 and p143 >= math.abs(p141) then
        v147 = v146 / 6.283185307179586 * math.asin(p141 / p143);
    else
        v147 = v146 / 4;
        p143 = p141;
    end;

    return p143 * math.pow(2, -10 * v145) * math.sin((v145 * p142 - v147) * 6.283185307179586 / v146) + p141 + p140;
end;

function u1.inOutElastic(p148, p149, p150, p151, p152, p153) -- Line: 256
    if p148 == 0 then
        return p149;
    end;

    local v154 = p148 / p151 * 2;

    if v154 == 2 then
        return p149 + p150;
    end;

    local v155 = p153 or p151 * 0.44999999999999996;
    local v156 = p152 or 0;
    local v157;

    if v156 and v156 >= math.abs(p150) then
        v157 = v155 / 6.283185307179586 * math.asin(p150 / v156);
    else
        v157 = v155 / 4;
        v156 = p150;
    end;

    if v154 < 1 then
        local v158 = v154 - 1;

        return -0.5 * (v156 * math.pow(2, 10 * v158) * math.sin((v158 * p151 - v157) * 6.283185307179586 / v155)) + p149;
    end;

    local v159 = v154 - 1;

    return v156 * math.pow(2, -10 * v159) * math.sin((v159 * p151 - v157) * 6.283185307179586 / v155) * 0.5 + p150 + p149;
end;

function u1.outInElastic(p160, p161, p162, p163, p164, p165) -- Line: 284
    -- upvalues: u1 (copy)
    if p160 < p163 / 2 then
        return u1.outElastic(p160 * 2, p161, p162 / 2, p163, p164, p165);
    end;

    return u1.inElastic(p160 * 2 - p163, p161 + p162 / 2, p162 / 2, p163, p164, p165);
end;

function u1.inBack(p166, p167, p168, p169, p170) -- Line: 292
    local v171 = p170 or 1.70158;
    local v172 = p166 / p169;

    return p168 * v172 * v172 * ((v171 + 1) * v172 - v171) + p167;
end;

function u1.outBack(p173, p174, p175, p176, p177) -- Line: 298
    local v178 = p177 or 1.70158;
    local v179 = p173 / p176 - 1;

    return p175 * (v179 * v179 * ((v178 + 1) * v179 + v178) + 1) + p174;
end;

function u1.inOutBack(p180, p181, p182, p183, p184) -- Line: 304
    local v185 = (p184 or 1.70158) * 1.525;
    local v186 = p180 / p183 * 2;

    if v186 < 1 then
        return p182 / 2 * (v186 * v186 * ((v185 + 1) * v186 - v185)) + p181;
    end;

    local v187 = v186 - 2;

    return p182 / 2 * (v187 * v187 * ((v185 + 1) * v187 + v185) + 2) + p181;
end;

function u1.outInBack(p188, p189, p190, p191, p192) -- Line: 316
    -- upvalues: u1 (copy)
    if p188 < p191 / 2 then
        return u1.outBack(p188 * 2, p189, p190 / 2, p191, p192);
    end;

    return u1.inBack(p188 * 2 - p191, p189 + p190 / 2, p190 / 2, p191, p192);
end;

function u1.outBounce(p193, p194, p195, p196) -- Line: 324
    local v197 = p193 / p196;

    if v197 < 0.36363636363636365 then
        return p195 * (7.5625 * v197 * v197) + p194;
    end;

    if v197 < 0.7272727272727273 then
        local v198 = v197 - 0.5454545454545454;

        return p195 * (7.5625 * v198 * v198 + 0.75) + p194;
    end;

    if v197 < 0.9090909090909091 then
        local v199 = v197 - 0.8181818181818182;

        return p195 * (7.5625 * v199 * v199 + 0.9375) + p194;
    end;

    local v200 = v197 - 0.9545454545454546;

    return p195 * (7.5625 * v200 * v200 + 0.984375) + p194;
end;

function u1.inBounce(p201, p202, p203, p204) -- Line: 340
    -- upvalues: u1 (copy)
    return p203 - u1.outBounce(p204 - p201, 0, p203, p204) + p202;
end;

function u1.inOutBounce(p205, p206, p207, p208) -- Line: 344
    -- upvalues: u1 (copy)
    if p205 < p208 / 2 then
        return u1.inBounce(p205 * 2, 0, p207, p208) * 0.5 + p206;
    end;

    return u1.outBounce(p205 * 2 - p208, 0, p207, p208) * 0.5 + p207 * 0.5 + p206;
end;

function u1.outInBounce(p209, p210, p211, p212) -- Line: 352
    -- upvalues: u1 (copy)
    if p209 < p212 / 2 then
        return u1.outBounce(p209 * 2, p210, p211 / 2, p212);
    end;

    return u1.inBounce(p209 * 2 - p212, p210 + p211 / 2, p211 / 2, p212);
end;

function scale(p213, p214, p215, p216, p217)
    return (p213 - p214) * (p217 - p216) / (p215 - p214) + p216;
end;

function getNoteName(p218)
    if p218 == 0 then
        return "Left";
    end;

    if p218 == 1 then
        return "Down";
    end;

    if p218 == 2 then
        return "Up";
    end;

    if p218 == 3 then
        return "Right";
    end;
end;

beat = 0;
ARROW_SIZE = 108.5;
beatcutoff = 0;
storedScrollSpeed = 1.8;
fBeat = 0;
aliases = {};
reverse_aliases = {};
modchartApi = {};
modList = {
    beat = 0,
    fastBeat = 0,
    flip = 0,
    invert = 0,
    easydrunk = 0,
    drunk = 0,
    drunky = 0,
    tipsy = 0,
    tipsySpeed = 1,
    adrunk = 0,
    atipsy = 0,
    tipsyz = 0,
    transformX = 0,
    transformY = 0,
    transformZ = 0,
    movex = 0,
    movey = 0,
    amovex = 0,
    amovey = 0,
    reverse = 0,
    split = 0,
    centered = 0,
    cross = 0,
    dark = 0,
    stealth = 0,
    alpha = 1,
    confusion = 0,
    dizzy = 0,
    wave = 0,
    brake = 0,
    hidden = 0,
    hiddenoffset = 0,
    alternate = 0,
    camx = 0,
    camy = 0,
    rotationz = 0,
    camwag = 0,
    camwagpower = 1,
    xwag = 0,
    ywag = 0,
    cosxwag = 0,
    cosywag = 0,
    opponentSwap = 0,
    stretch = 0,
    squish = 0,
    mini = 0,
    xmod = 1,
    drawsize = 10,
    rotation = 0,
    offsetX = 0,
    offsetY = 0
};

for i = 0, 17 do
    modList["transform" .. i .. "X"] = 0;
    modList["transform" .. i .. "Y"] = 0;
    modList["transform" .. i .. "Z"] = 0;
    modList["movex" .. i] = 0;
    modList["movey" .. i] = 0;
    modList["amovex" .. i] = 0;
    modList["amovey" .. i] = 0;
    modList["dark" .. i] = 0;
    modList["stealth" .. i] = 0;
    modList["confusion" .. i] = 0;
    modList["reverse" .. i] = 0;
    modList["xmod" .. i] = 1;
    modList["stretch" .. i] = 0;
    modList["squish" .. i] = 0;
    modList["alpha" .. i] = 1;
    modList["mini" .. i] = 0;
    modList["mini" .. i .. "X"] = 0;
    modList["mini" .. i .. "Y"] = 0;
    local _ = i;
end;

u1.activeMods = { {}, {} };

for i = 1, 2 do
    local v219 = i;

    for i2, v in pairs(modList) do
        u1.activeMods[v219][i2] = v;
    end;
end;

storedMods = { {}, {} };
targetMods = { {}, {} };
isTweening = { {}, {} };
tweenStart = { {}, {} };
tweenLen = { {}, {} };
tweenCurve = { {}, {} };
tweenEx1 = { {}, {} };
tweenEx2 = { {}, {} };
modnames = {};
defaultPositions = { {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    } };

function u1.definemod(p220) -- Line: 494
    -- upvalues: u1 (copy)
    local v221 = p220[1];
    local v222 = p220[2] or 0;

    for i = 1, 2 do
        storedMods[i][v221] = v222;
        targetMods[i][v221] = v222;
        isTweening[i][v221] = false;
        tweenStart[i][v221] = 0;
        tweenLen[i][v221] = 0;
        tweenCurve[i][v221] = u1.linear;
        tweenEx1[i][v221] = nil;
        tweenEx2[i][v221] = nil;
        local v223;

        if i == 1 then
            table.insert(modnames, v221);
            v223 = i;
        else
            v223 = i;
        end;
    end;
end;

function u1.InitMods() -- Line: 513
    -- upvalues: u1 (copy)
    storedMods = { {}, {} };
    targetMods = { {}, {} };
    isTweening = { {}, {} };
    tweenStart = { {}, {} };
    tweenLen = { {}, {} };
    tweenCurve = { {}, {} };
    tweenEx1 = { {}, {} };
    tweenEx2 = { {}, {} };
    modnames = {};
    beatcutoff = 0;
    storedScrollSpeed = 1.8;
    fBeat = 0;
    defaultPositions = { {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        } };
    modchartApi = {};

    for i = 1, 2 do
        local _ = i;

        for i2, v in pairs(u1.activeMods[i]) do
            u1.definemod({ i2, v });
        end;
    end;
end;

function alias(p224, p225)
    local v226;

    if type(p224) == "table" then
        v226 = p224[1];
        p225 = p224[2];
    else
        v226 = p224;
    end;

    if type(v226) ~= "string" then
        warn("unexpected argument 1", 1, "alias");

        return alias;
    end;

    if type(p225) ~= "string" and (type(p225) ~= "function" and type(p225) ~= "nil") then
        warn("unexpected argument 2", 1, "alias");

        return alias;
    end;

    aliases[v226] = p225 or function() -- Line: 557
    end;
    reverse_aliases[aliases[v226]] = v226;

    return alias;
end;

function fastSin(p227)
    local v228 = p227 * 0.3183098862;

    if v228 > 1 then
        local math_ceil_ret = math.ceil(v228);
        local bit32_rshift_ret = bit32.rshift(math_ceil_ret, 1);
        v228 = v228 - bit32.lshift(bit32_rshift_ret, 1);
    elseif v228 < -1 then
        local math_ceil_ret = math.ceil(-v228);
        local bit32_rshift_ret = bit32.rshift(math_ceil_ret, 1);
        v228 = v228 + bit32.lshift(bit32_rshift_ret, 1);
    end;

    if v228 > 0 then
        return v228 * (3.1 + v228 * (0.5 + v228 * (-7.2 + v228 * 3.6)));
    end;

    return v228 * (3.1 - v228 * (0.5 + v228 * (7.2 + v228 * 3.6)));
end;

mods = {};
curmod = 1;
perframe = {};
event = {};
curevent = 1;
songStarted = false;
curScale = UDim2.new(1, 0, 1, 0);

function u1.cleanUp() -- Line: 591
    storedMods = { {}, {} };
    targetMods = { {}, {} };
    isTweening = { {}, {} };
    tweenStart = { {}, {} };
    tweenLen = { {}, {} };
    tweenCurve = { {}, {} };
    tweenEx1 = { {}, {} };
    tweenEx2 = { {}, {} };
    modnames = {};
    beatcutoff = 0;
    storedScrollSpeed = 1.8;
    fBeat = 0;
    defaultPositions = { {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        }, {
            X = 0,
            Y = 0
        } };
    modchartApi = {};
    modList = {
        beat = 0,
        fastBeat = 0,
        flip = 0,
        invert = 0,
        easydrunk = 0,
        drunk = 0,
        drunky = 0,
        tipsy = 0,
        tipsySpeed = 1,
        adrunk = 0,
        atipsy = 0,
        tipsyz = 0,
        transformX = 0,
        transformY = 0,
        transformZ = 0,
        movex = 0,
        movey = 0,
        amovex = 0,
        amovey = 0,
        reverse = 0,
        split = 0,
        centered = 0,
        cross = 0,
        dark = 0,
        stealth = 0,
        alpha = 1,
        confusion = 0,
        dizzy = 0,
        wave = 0,
        brake = 0,
        hidden = 0,
        hiddenoffset = 0,
        alternate = 0,
        camx = 0,
        camy = 0,
        rotationz = 0,
        camwag = 0,
        camwagpower = 1,
        xwag = 0,
        ywag = 0,
        cosxwag = 0,
        cosywag = 0,
        opponentSwap = 0,
        stretch = 0,
        squish = 0,
        mini = 0,
        xmod = 1,
        drawsize = 10,
        rotation = 0,
        offsetX = 0,
        offsetY = 0
    };

    for i = 0, 17 do
        modList["transform" .. i .. "X"] = 0;
        modList["transform" .. i .. "Y"] = 0;
        modList["transform" .. i .. "Z"] = 0;
        modList["movex" .. i] = 0;
        modList["movey" .. i] = 0;
        modList["amovex" .. i] = 0;
        modList["amovey" .. i] = 0;
        modList["dark" .. i] = 0;
        modList["stealth" .. i] = 0;
        modList["confusion" .. i] = 0;
        modList["reverse" .. i] = 0;
        modList["xmod" .. i] = 1;
        modList["stretch" .. i] = 0;
        modList["squish" .. i] = 0;
        modList["alpha" .. i] = 1;
        modList["mini" .. i] = 0;
        modList["mini" .. i .. "X"] = 0;
        modList["mini" .. i .. "Y"] = 0;
        local _ = i;
    end;

    mods = {};
    curmod = 1;
    perframe = {};
    event = {};
    curevent = 1;
    songStarted = false;
end;

function u1.setup(p229: any, p230: boolean?) -- Line: 701
    modchartApi = p229;

    if not p230 then
        modchartApi.API.setSetting(nil, "Middlescroll", false);
        modchartApi.API.recalculateStrums(true);
    end;

    if #event > 1 then
        table.sort(event, modtable_compare);
    end;

    if #mods > 1 then
        table.sort(mods, modtable_compare);
    end;
end;

function modtable_compare(p231, p232)
    if p231[1] == p232[1] then
        return p231.theTicker < p232.theTicker;
    end;

    return p231[1] < p232[1];
end;

function flicker()
    return modchartApi.Conductor.TimePosition * 0.001 * 60 % 2 < 1 and -1 or 1;
end;

function receptorAlpha(p233, p234)
    -- upvalues: u1 (copy)
    local v235 = 1;
    local v236 = u1.activeMods[p234];

    if v236.alpha ~= 1 then
        v235 = v235 * v236.alpha;
    end;

    if v236["alpha" .. p233] ~= 1 then
        v235 = v235 * v236["alpha" .. p233];
    end;

    if v236.dark ~= 0 or v236["dark" .. p233] ~= 0 then
        v235 = v235 * (1 - v236.dark) * (1 - v236["dark" .. p233]);
    end;

    return v235;
end;

function arrowAlpha(p237, p238, p239)
    -- upvalues: u1 (copy)
    local v240 = 1;
    local v241 = u1.activeMods[p239];

    if v241.alpha ~= 1 then
        v240 = v240 * v241.alpha;
    end;

    if v241["alpha" .. p238] ~= nil and v241["alpha" .. p238] ~= 1 then
        v240 = v240 * v241["alpha" .. p238];
    end;

    if v241.stealth ~= 0 then
        v240 = v240 * (1 - v241.stealth);
    end;

    if v241["stealth" .. p238] ~= nil and v241["stealth" .. p238] ~= 0 then
        v240 = v240 * (1 - v241["stealth" .. p238]);
    end;

    if v241.hidden ~= 0 then
        if p237 < v241.hiddenoffset and v241.hiddenoffset - 200 <= p237 then
            return v240 * (1 - -(p237 - v241.hiddenoffset) / 200) * v241.hidden;
        end;

        if p237 < v241.hiddenoffset - 100 then
            v240 = v240 * (1 - v241.hidden);
        end;
    end;

    return v240;
end;

function getReverseForCol(p242, p243)
    -- upvalues: u1 (copy)
    local v244 = u1.activeMods[p243];
    local v245 = 0;

    if v244["reverse" .. p242] ~= nil then
        v245 = v245 + v244["reverse" .. p242];
    end;

    if v244.reverse ~= 0 then
        v245 = v245 + v244.reverse;
    end;

    if v244.split ~= 0 and p242 > 1 then
        v245 = v245 + v244.split;
    end;

    if v244.cross ~= 0 and p242 == 1 or p242 == 2 then
        v245 = v245 + v244.cross;
    end;

    if v244.alternate ~= 0 and p242 % 2 == 1 then
        v245 = v245 + v244.alternate;
    end;

    return v245;
end;

function getYAdjust(p246, p247, p248)
    -- upvalues: u1 (copy)
    local v249 = u1.activeMods[p248];
    local v250 = 0;

    if v249.wave ~= 0 then
        v250 = v250 + v249.wave * 20 * math.sin((p246 + 250) / 76);
    end;

    if v249.brake ~= 0 then
        local v251 = p246 * scale(p246, 0, 500, 0, 1);
        v250 = v250 + math.clamp(v249.brake * (v251 - p246), -400, 400);
    end;

    if modchartApi.API.getSetting(p248 == 1 and "L" or "R", "Downscroll") then
        v250 = -v250;
    end;

    return p246 + v250;
end;

function lerp(p252, p253, p254)
    return p252 + (p253 - p252) * p254;
end;

function arrowEffects(p255, p256, p257, p258)
    -- upvalues: u1 (copy)
    local v259 = u1.activeMods[p257];
    local v260 = 0;
    local v261 = 0;
    local v262 = 0;
    local v263 = 1;
    local v264 = 1;

    if v259.offsetX ~= 0 then
        v260 = v260 + v259.offsetX;
    end;

    if v259.offsetY ~= 0 then
        v261 = v261 + v259.offsetY;
    end;

    if v259.mini ~= nil then
        local v265 = v259.mini or 0;
        v263 = v263 * (1 - v265);
        v264 = v264 * (1 - v265);
    end;

    if v259["mini" .. p256] ~= nil then
        local v266 = v259["mini" .. p256] or 0;
        v263 = v263 * (1 - (v266 + (v259["mini" .. p256 .. "X"] or 0)));
        v264 = v264 * (1 - (v266 + (v259["mini" .. p256 .. "Y"] or 0)));
    end;

    if v259.transformZ ~= nil then
        local v267 = v259.transformZ or 0;
        v263 = v263 * (1 + v267);
        v264 = v264 * (1 + v267);
    end;

    if v259["transform" .. p256 .. "Z"] ~= nil then
        local v268 = v259["transform" .. p256 .. "Z"] or 0;
        v263 = v263 * (1 + v268);
        v264 = v264 * (1 + v268);
    end;

    if v259.stretch ~= nil then
        local v269 = v259.stretch or 0;
        local v270 = lerp(1, 0.5, v269);
        local v271 = lerp(1, 2, v269);
        v263 = v263 * (0 * v271 + 1 * v270);
        v264 = v264 * (1 * v271 + 0 * v270);
    end;

    if v259["stretch" .. p256] ~= nil then
        local v272 = v259["stretch" .. p256] or 0;
        local v273 = lerp(1, 0.5, v272);
        local v274 = lerp(1, 2, v272);
        v263 = v263 * (0 * v274 + 1 * v273);
        v264 = v264 * (1 * v274 + 0 * v273);
    end;

    if v259.squish ~= nil then
        local v275 = v259.squish or 0;
        local v276 = lerp(1, 2, v275);
        local v277 = lerp(1, 0.5, v275);
        v263 = v263 * (0 * v277 + 1 * v276);
        v264 = v264 * (1 * v277 + 0 * v276);
    end;

    if v259["squish" .. p256] ~= nil then
        local v278 = v259["squish" .. p256] or 0;
        local v279 = lerp(1, 2, v278);
        local v280 = lerp(1, 0.5, v278);
        v263 = v263 * (0 * v280 + 1 * v279);
        v264 = v264 * (1 * v280 + 0 * v279);
    end;

    if v259.opponentSwap ~= nil then
        local KeyData = modchartApi.API.getKeyData();
        v260 = v260 + math.abs(defaultPositions[1].X - defaultPositions[KeyData.leftKeyCount + 1].X) * (p257 == 1 and 1 or -1) * v259.opponentSwap;
    end;

    if v259.confusion ~= 0 then
        v262 = v262 + v259.confusion;
    end;

    if v259["confusion" .. p256] ~= nil and v259["confusion" .. p256] ~= 0 then
        v262 = v262 + v259["confusion" .. p256];
    end;

    if v259.dizzy ~= 0 then
        v262 = v262 + v259.dizzy * p255;
    end;

    if v259.easydrunk ~= 0 then
        v260 = v260 + v259.easydrunk * (math.cos(modchartApi.Conductor.SongPosition * 0.001 + p256 * 0.2 + 0.2) * ARROW_SIZE * 0.5);
    end;

    if v259.drunk ~= 0 then
        v260 = v260 + v259.drunk * (math.cos(modchartApi.Conductor.SongPosition * 0.001 + p256 * 0.2 + 0.2 + p255 * 10 / 720) * ARROW_SIZE * 0.5);
    end;

    if v259.drunky ~= 0 then
        v261 = v261 + v259.drunky * (math.cos(modchartApi.Conductor.SongPosition * 0.001 + p256 * 0.2 + 0.2 + p255 * 10 / 720) * ARROW_SIZE * 0.5);
    end;

    if v259.tipsy ~= 0 then
        v261 = v261 + v259.tipsy * (math.cos(modchartApi.Conductor.SongPosition * 0.001 * (v259.tipsySpeed * 1.2) + p256 * 2 + 0.2) * ARROW_SIZE * 0.4);
    end;

    if v259.adrunk ~= 0 then
        v260 = v260 + v259.adrunk * (math.cos(modchartApi.Conductor.SongPosition * 0.001 + p256 * 0.2 + 0.2 + p255 * 10 / 720) * ARROW_SIZE * 0.5);
    end;

    if v259.atipsy ~= 0 then
        v261 = v261 + v259.atipsy * (math.cos(modchartApi.Conductor.SongPosition * 0.001 * (v259.tipsySpeed * 1.2) + p256 * 2 + 0.2) * ARROW_SIZE * 0.4);
    end;

    if v259.tipsyz ~= 0 then
        v263 = v263 + v259.tipsyz * (math.cos(modchartApi.Conductor.SongPosition * 0.001 * (v259.tipsySpeed * 1.2) + p256 * 2 + 0.2) * ARROW_SIZE * 0.4) / 650;
        v264 = v264 + v259.tipsyz * (math.cos(modchartApi.Conductor.SongPosition * 0.001 * (v259.tipsySpeed * 1.2) + p256 * 2 + 0.2) * ARROW_SIZE * 0.4) / 650;
    end;

    if v259.movex ~= 0 then
        v260 = v260 + v259.movex;
    end;

    if v259.amovex ~= 0 then
        v260 = v260 + v259.amovex;
    end;

    if v259.movey ~= 0 then
        v261 = v261 + v259.movey;
    end;

    if v259.amovey ~= 0 then
        v261 = v261 + v259.amovey;
    end;

    if v259.xwag ~= 0 then
        v260 = v260 + v259.xwag * math.sin(beat * 3.141592653589793);
    end;

    if v259.cosxwag ~= 0 then
        v260 = v260 + v259.cosxwag * math.cos(beat * 3.141592653589793);
    end;

    if v259.ywag ~= 0 then
        v261 = v261 + v259.ywag * math.sin(beat * 3.141592653589793);
    end;

    if v259.cosywag ~= 0 then
        v261 = v261 + v259.cosywag * math.sin(beat * 3.141592653589793);
    end;

    if v259.transformX ~= 0 then
        v260 = v260 + v259.transformX;
    end;

    if v259.transformY ~= 0 then
        v261 = v261 + v259.transformY;
    end;

    if v259["transform" .. p256 .. "X"] ~= nil and v259["transform" .. p256 .. "X"] ~= 0 then
        v260 = v260 + v259["transform" .. p256 .. "X"];
    end;

    if v259["transform" .. p256 .. "Y"] ~= nil and v259["transform" .. p256 .. "Y"] ~= 0 then
        v261 = v261 + v259["transform" .. p256 .. "Y"];
    end;

    if v259["movex" .. p256] ~= nil and v259["movex" .. p256] ~= 0 then
        v260 = v260 + v259["movex" .. p256];
    end;

    if v259["amovex" .. p256] ~= nil and v259["amovex" .. p256] ~= 0 then
        v260 = v260 + v259["amovex" .. p256];
    end;

    if v259["movey" .. p256] ~= nil and v259["movey" .. p256] ~= 0 then
        v261 = v261 + v259["movey" .. p256];
    end;

    if v259["amovey" .. p256] ~= nil and v259["amovey" .. p256] ~= 0 then
        v261 = v261 + v259["amovey" .. p256];
    end;

    if v259.reverse ~= 0 or (v259.split ~= 0 or (v259.cross ~= 0 or (v259.alternate ~= 0 or v259["reverse" .. p256] ~= nil and v259["reverse" .. p256] ~= 0))) then
        v261 = v261 + getReverseForCol(p256, p257) * 450;
    end;

    if v259.centered ~= 0 then
        v261 = v261 + v259.centered * 0.5 * 450;
    end;

    if v259.flip ~= 0 then
        v260 = v260 + ARROW_SIZE * 2 * (1.5 - p256) * v259.flip;
    end;

    if v259.invert ~= 0 then
        v260 = v260 + ARROW_SIZE * (p256 % 2 == 0 and 1 or -1) * v259.invert;
    end;

    if v259.beat ~= 0 then
        local beat2 = v259.beat;
        fBeat = beat + 0.3;
        local v281 = math.floor(fBeat) % 2 ~= 0;
        fBeat = fBeat - math.floor(fBeat);
        fBeat = fBeat + 1;
        fBeat = fBeat - math.floor(fBeat);

        if fBeat < 0.7 then
            local v282;

            if fBeat < 0.3 then
                local v283 = scale(fBeat, 0, 0.3, 0, 1);
                v282 = v283 * v283;
            else
                local v284 = scale(fBeat, 0.3, 0.7, 1, 0);
                v282 = 1 - (1 - v284) * (1 - v284);
            end;

            if v281 then
                v282 = v282 * -1;
            end;

            v260 = v260 + beat2 * (v282 * 40 * math.sin(p255 / 30 + 1.5707963267948966));
        end;
    end;

    if v259.fastBeat ~= 0 then
        local fastBeat = v259.fastBeat;
        fBeat = beat + 0.3;
        local v285 = math.floor(fBeat) % 2 ~= 0;
        fBeat = fBeat - math.floor(fBeat);
        fBeat = fBeat + 1;
        fBeat = fBeat - math.floor(fBeat);

        if fBeat < 0.7 then
            local v286;

            if fBeat < 0.3 then
                local v287 = scale(fBeat, 0, 0.3, 0, 1);
                v286 = v287 * v287;
            else
                local v288 = scale(fBeat, 0.3, 0.7, 1, 0);
                v286 = 1 - (1 - v288) * (1 - v288);
            end;

            if v285 then
                v286 = v286 * -1;
            end;

            v260 = v260 + fastBeat * (v286 * 40 * math.sin(p255 / 30 + 1.5707963267948966));
        end;
    end;

    if modchartApi.API.getSetting(p257 == 1 and "L" or "R", "Downscroll") then
        v261 = -v261;
    end;

    return v260, v261, v262, v263, v264;
end;

function remapToRange(p289, p290, p291, p292, p293)
    return p292 + (p293 - p292) * ((p289 - p290) / (p291 - p290));
end;

function splitTitleCaps(p294)
    local v295 = p294:gsub("(%u)", " %1"):gsub("^%s", "");

    return string.split(v295, " ");
end;

function firstToUpper(p296)
    return p296:gsub("^%l", string.upper);
end;

function firstToLower(p297)
    return string.lower((string.sub(p297, 1, 1))) .. string.sub(p297, 2, -1);
end;

function getTweenStyle(p298)
    if p298 == nil then
        return "Linear";
    end;

    local v299 = splitTitleCaps(p298);

    if #v299 == 0 then
        return "Linear";
    end;

    local v300 = firstToUpper(v299[1]);

    return (v300 == "Cube" or v300 == "cube") and "Cubic" or ((v300 == "Ease" or v300 == "ease") and "Back" or v300);
end;

function getTweenDir(p301)
    if p301 == nil then
        return "inOut";
    end;

    local v302 = splitTitleCaps(p301);

    if #v302 <= 1 then
        return "inOut";
    end;

    local table_concat_ret = table.concat(v302, "", 2, #v302);

    return firstToLower(table_concat_ret);
end;

function getEaseName(p303)
    local v304 = getTweenDir(p303);
    local v305 = getTweenStyle(p303);

    return v305:lower() == "linear" and "linear" or firstToLower(v304) .. firstToUpper(v305);
end;

function u1.me(p306) -- Line: 1208
    -- upvalues: u1 (copy)
    if typeof(p306[3]) == "string" then
        local v307 = getEaseName(p306[3]);

        if u1[v307] then
            p306[3] = u1[v307];
        else
            print("Invalid easing - " .. p306[3]);
        end;
    end;

    p306.theTicker = tick();
    table.insert(mods, p306);
end;

function u1.setMod(p308, p309, p310) -- Line: 1226
    -- upvalues: u1 (copy)
    u1.activeMods[p310][p308] = p309;
end;

function u1.m2(p311) -- Line: 1230
    p311.theTicker = tick();
    table.insert(event, p311);
end;

function u1.mpf(p312) -- Line: 1235
    p312.theTicker = tick();
    table.insert(perframe, p312);
end;

function u1.set(p313) -- Line: 1240
    -- upvalues: u1 (copy)
    local l_mods = mods;
    local v314 = {
        p313[1],
        0,
        u1.linear,
        p313[2],
        p313[3],
        pn = p313.pn,
        theTicker = tick(),
        setter = true
    };
    table.insert(l_mods, v314);
end;

function u1.getMods() -- Line: 1244
    return mods;
end;

function u1.songStart() -- Line: 1248
    -- upvalues: u1 (copy)
    local KeyData = modchartApi.API.getKeyData();

    for i = 0, KeyData.totalKeys - 1 do
        local v315 = modchartApi.Receptors[i];

        if defaultPositions[i + 1] == nil then
            defaultPositions[i + 1] = {
                X = 0,
                Y = 0
            };
        end;

        local _ = KeyData.leftKeyCount - 1 < i;
        defaultPositions[i + 1].X = v315.x + 0;
        defaultPositions[i + 1].Y = v315.y;
        local _ = i;
    end;

    for i = 1, 2 do
        local v316 = i;

        for i2, v in pairs(modList) do
            u1.activeMods[v316][i2] = v;
        end;
    end;

    u1.activeMods[1].xmod = 1;
    u1.activeMods[2].xmod = 1;
    curScale = modchartApi.Camera.Size;
    songStarted = true;
end;

function point_direction(p317, p318, p319, p320)
    local math_atan2_ret = math.atan2(p318 - p320, p317 - p319);

    return -math.deg(math_atan2_ret);
end;

function u1.updateMods(p321) -- Line: 1283
    -- upvalues: u1 (copy)
    if modchartApi.Camera ~= nil then
        modchartApi.API.Game.Rotation = u1.activeMods[1].rotationz + u1.activeMods[1].camwag * math.sin(beat * 3.141592653589793) * u1.activeMods[1].camwagpower or 0;
        modchartApi.API.Game.Position = UDim2.fromScale(0.5 + u1.activeMods[1].camx / 1280, 0.5 + u1.activeMods[1].camy / 720);
    end;

    local KeyData = modchartApi.API.getKeyData();

    if KeyData == nil then
        return;
    end;

    if modchartApi.Receptors ~= nil then
        for i = 1, 2 do
            local v322 = i;

            for i2 = 0, (i == 1 and KeyData.leftKeyCount or KeyData.rightKeyCount) - 1 do
                local v323 = i2 + (v322 - 1) * KeyData.leftKeyCount;
                local v324 = modchartApi.Receptors[v323];
                local X = defaultPositions[v323 + 1].X;
                local Y = defaultPositions[v323 + 1].Y;
                local v325, v326, v327, v328, v329 = arrowEffects(0, i2, v322, true);
                local v330 = receptorAlpha(i2, v322);
                v324.x = X + v325;
                v324.y = Y + v326;
                v324.angle = v327;
                v324.alpha = v330;
                v324.scale.x = 0.7 * v328;
                v324.scale.y = 0.7 * v329;
                local _ = i2;
            end;
        end;
    end;

    for _, v in shared.getNotes() do
        if v.active then
            local v331 = v.side == "R" and 2 or 1;
            local column = v.column;
            local v332 = column + KeyData.leftKeyCount * (v331 - 1);
            local Setting = modchartApi.API.getSetting(v.side, "Downscroll");
            local v333 = Setting and -1 or 1;
            local X = defaultPositions[v332 + 1].X;
            local Y = defaultPositions[v332 + 1].Y;
            local v334 = u1.activeMods[v331].xmod * (1 - 2 * getReverseForCol(column, v331));
            local v335 = -modchartApi.API.getYPosAt(v.strumTime, v334);

            if Setting then
                v335 = v335 * -1;
            end;

            local v336 = getYAdjust(v335 + Y, column, v331);
            local v337, v338, v339, v340, v341 = arrowEffects(v336 - Y, column, v331, false);
            local v342 = arrowAlpha(Setting and getYAdjust(-v335 + 50, column, v331) - 50 or v336 - Y, column, v331);
            local v343;

            if v.sustainNote then
                local v344 = v.strum or v.strumLine.Strums[v.noteData];
                local v345 = -modchartApi.API.getYPosAt(v.isEnd and v.endPixelTime or v.susEndTime, v334);

                if Setting then
                    v345 = v345 * -1;
                end;

                local v346 = getYAdjust(v345 + Y, column, v331);
                local v347, v348 = arrowEffects(v346 - Y, column, v331, false);
                v.useAngleAnchor = true;
                v.angle = -point_direction(X + v337, v336 + v338, X + v347, v346 + v348) + 90;
                v343 = (v.isEnd and 0.7 or math.abs((v346 + v348 - (v336 + v338)) / 44)) * v333;

                if v.isClipping then
                    X = v344.x;
                    v336 = v344.y;
                    v337 = 0;
                    v338 = 0;
                end;
            else
                v343 = 0.7 * v341;
                v.angle = v339;
            end;

            v.x = X + v337;
            v.y = v336 + v338;
            v.alpha = v342;
            v.Scale = Vector2.new(0.7 * v340, v343);
        end;
    end;
end;

function u1.update(p349, p350) -- Line: 1391
    -- upvalues: u1 (copy)
    if songStarted or p350 then
        beat = modchartApi.Conductor.DecimalBeat;

        if p350 or beat < 0 then
            beat = 0;
        end;

        while curmod <= #mods and beat >= mods[curmod][1] do
            local v351 = mods[curmod];
            local v352 = v351[5];
            local v353 = v351[2];

            if v351.timing and v351.timing == "end" then
                v353 = v351[2] - v351[1];
            end;

            if v351.plr and not v351.pn then
                v351.pn = v351.plr;
            end;

            for i = 1, 2 do
                local v354;

                if v351.pn and i ~= v351.pn then
                    v354 = i;
                else
                    tweenStart[i][v352] = v351[1];
                    tweenLen[i][v352] = v353;
                    tweenCurve[i][v352] = v351[3] or u1.linear;

                    if v351.startVal then
                        storedMods[i][v352] = v351.startVal;
                    else
                        storedMods[i][v352] = u1.activeMods[i][v352];
                    end;

                    targetMods[i][v352] = v351[4];
                    tweenEx1[i][v352] = v351.ex1;
                    tweenEx2[i][v352] = v351.ex2;

                    if v353 <= 0 then
                        u1.activeMods[i][v352] = v351[4];
                        v354 = i;
                    else
                        isTweening[i][v352] = true;
                        v354 = i;
                    end;
                end;
            end;

            curmod = curmod + 1;
        end;

        for i = 1, 2 do
            local v355 = i;

            for _, v in modnames do
                if isTweening[v355][v] then
                    local v356 = tweenLen[v355][v];
                    local v357 = storedMods[v355][v];
                    local v358 = tweenCurve[v355][v](beat - tweenStart[v355][v], v357, targetMods[v355][v] - v357, v356, tweenEx1[v355][v], tweenEx2[v355][v]);
                    u1.activeMods[v355][v] = v358;

                    if beat > tweenStart[v355][v] + v356 then
                        isTweening[v355][v] = false;
                    end;
                else
                    u1.activeMods[v355][v] = targetMods[v355][v];
                end;
            end;
        end;

        if #perframe > 0 then
            for i = 1, #perframe do
                local v359 = perframe[i];
                local v360;

                if beat >= v359[1] and beat <= v359[2] then
                    v359[3](beat);
                    v360 = i;
                else
                    v360 = i;
                end;
            end;
        end;

        while curevent <= #event and beat >= event[curevent][1] do
            if event[curevent][3] or beat < event[curevent][1] + 2 then
                event[curevent][2]();
            end;

            curevent = curevent + 1;
        end;

        u1.updateMods(p349);
    end;
end;

return u1;