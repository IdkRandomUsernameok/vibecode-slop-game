-- Decompiled with Potassium's decompiler.

ModifierType = {
    ALL = 0,
    PLAYERONLY = 1,
    OPPONENTONLY = 2,
    LANESPECIFIC = 3
};

function getSuper(u1, u2)
    return setmetatable({}, {
        __index = function(p3, u4) -- Line: 16, Name: __index
            -- upvalues: u2 (copy), u1 (copy)
            local u5 = getmetatable(u2) and getmetatable(u2).__index or u2;

            if u4 == "super" then
                return getSuper(u1, u5);
            end;

            return setmetatable({}, {
                __call = function(...) -- Line: 19, Name: __call
                    -- upvalues: u5 (copy), u4 (copy), u1 (ref)
                    local v6 = u5[u4];
                    local v7 = {
                        __super = u1
                    };
                    local v13 = {
                        __index = function(p8, p9) -- Line: 21, Name: __index
                            -- upvalues: u1 (ref), u5 (ref)
                            if p9 == "super" then
                                return getSuper(u1, u5);
                            end;

                            return u1[p9];
                        end,

                        __newindex = function(p10, p11, p12) -- Line: 27, Name: __newindex
                            -- upvalues: u1 (ref)
                            u1[p11] = p12;
                        end,

                        __metatable = getmetatable(u1)
                    };

                    return v6(setmetatable(v7, v13), unpack({ ... }, 3, select("#", ...)));
                end
            });
        end
    });
end;

function deepcopy(p14, p15)
    local v16 = p15 or {};

    if type(p14) ~= "table" then
        return p14;
    end;

    if v16[p14] then
        return v16[p14];
    end;

    local v17 = {};
    v16[p14] = v17;

    for i, v in next, p14 do
        v17[deepcopy(i, v16)] = deepcopy(v, v16);
    end;

    local l_deepcopy = deepcopy;
    local v18 = getmetatable(p14);
    setmetatable(v17, l_deepcopy(v18, v16));

    return v17;
end;

function getExtended(p19)
    local v20 = {};

    while true do
        local v21 = getmetatable(p19) or p19;

        if not v21.__index then
            break;
        end;

        p19 = v21.__index;
        table.insert(v20, p19);
    end;

    return v20;
end;

function extend(u22)
    local v23 = deepcopy(u22);
    local u24 = setmetatable(v23, {
        __index = u22
    });

    function u24.__index(p25, p26) -- Line: 74
        -- upvalues: u24 (copy), u22 (copy)
        local v27 = u24[p26] or u22.__index and u22.__index(p25, p26);

        return v27;
    end;

    function u24.__newindex(p28, p29, p30) -- Line: 78
        -- upvalues: u22 (copy)
        if u22.__newindex then
            return u22.__newindex(p28, p29, p30);
        end;

        return rawset(p28, p29, p30);
    end;

    local u31 = getExtended(u24);

    local function setExtended(p32) -- Line: 87
        -- upvalues: u31 (copy)
        for _, v in u31 do
            rawset(v, "__extended", p32);
        end;
    end;

    local function v36(...) -- Line: 94
        -- upvalues: u24 (copy), u31 (copy), u22 (copy)
        local v33 = u24;

        for _, v in u31 do
            rawset(v, "__extended", v33);
        end;

        local v34 = u22.new(...);
        local v35 = setmetatable(v34, u24);
        v35.super = getSuper(v35, u24);

        if rawget(u24, "__extended") == nil then
            v35:postCreate();
        end;

        for _, v in u31 do
            rawset(v, "__extended", nil);
        end;

        return v35;
    end;

    u24.new = v36;

    return u24, v36, u22;
end;

local SimpleQuaternion = require(script.Parent.SimpleQuaternion);
local FlxEase = require(script.Parent.FlxEase);
local math_sin = math.sin;
local math_cos = math.cos;
local math_abs = math.abs;
local math_clamp = math.clamp;
local math_floor = math.floor;

function remapToRange(p37, p38, p39, p40, p41)
    return p40 + (p37 - p38) * ((p41 - p40) / (p39 - p38));
end;

local u42 = nil;
local NoteMovement = require(script.Parent.NoteMovement);
local u43 = nil;
local u44 = nil;
local ModchartUtil = require(script.Parent.ModchartUtil);
local u45 = {};

function u45.new(p46) -- Line: 142
    -- upvalues: u45 (copy)
    return setmetatable({
        value = p46,
        baseValue = p46
    }, {
        __index = u45
    });
end;

function u45.postCreate(p47) -- Line: 149
end;

local u48 = {
    beat = 0
};

function u48.new(p49, p50, p51) -- Line: 157
    -- upvalues: u48 (copy)
    return setmetatable({
        baseValue = 0,
        currentValue = 0,
        subValues = {},
        tag = p49 or "",
        type = p50 or ModifierType.ALL,
        playfield = p51 or -1,
        targetLane = -1,
        instance = nil,
        renderer = nil
    }, {
        __index = u48
    });
end;

function u48.postCreate(p52) -- Line: 172
    p52:setupSubValues();
end;

function u48.getNotePath(p53: table, p54: table, p55: number, p56: number, p57: number) -- Line: 174
    if p53.currentValue ~= p53.baseValue then
        p53:noteMath(p54, p55, p56, p57);
    end;
end;

function u48.getStrumPath(p58: table, p59: table, p60: number, p61: number) -- Line: 180
    if p58.currentValue ~= p58.baseValue then
        p58:strumMath(p59, p60, p61);
    end;
end;

function u48.getIncomingAngle(p62: table, p63: number, p64: number, p65: number) -- Line: 186
    return p62.currentValue == p62.baseValue and { 0, 0 } or p62:incomingAngleMath(p63, p64, p65);
end;

function u48.getNoteCurPos(p66: table, p67: number, p68: number, p69: number) -- Line: 194
    if p66.currentValue ~= p66.baseValue then
        p68 = p66:curPosMath(p67, p68, p69);
    end;

    return p68;
end;

function u48.getNoteDist(p70: table, p71: number, p72: number, p73: number, p74: number) -- Line: 204
    if p70.currentValue ~= p70.baseValue then
        p71 = p70:noteDistMath(p71, p72, p73, p74);
    end;

    return p71;
end;

function u48.noteMath(p75: table, p76: table, p77: number, p78: number, p79: number) -- Line: 211
end;

function u48.strumMath(p80: table, p81: table, p82: number, p83: number) -- Line: 212
end;

function u48.incomingAngleMath(p84: table, p85: number, p86: number, p87: number) -- Line: 213
    return { 0, 0 };
end;

function u48.curPosMath(p88: table, p89: number, p90: number, p91: number) -- Line: 214
    return p90;
end;

function u48.noteDistMath(p92: table, p93: number, p94: number, p95: number, p96: number) -- Line: 215
    return p93;
end;

function u48.setupSubValues(p97) -- Line: 216
end;

function u48.checkPlayField(p98: table, p99: number) -- Line: 218
    return p98.playfield == -1 and true or p99 == p98.playfield;
end;

local u104 = {
    [ModifierType.LANESPECIFIC] = function(p100, p101) -- Line: 223
        return p100 == p101.targetLane;
    end,

    [ModifierType.PLAYERONLY] = function(p102) -- Line: 226
        -- upvalues: NoteMovement (copy)
        return NoteMovement.keyCount <= p102;
    end,

    [ModifierType.OPPONENTONLY] = function(p103) -- Line: 229
        -- upvalues: NoteMovement (copy)
        return p103 < NoteMovement.keyCount;
    end
};

function u48.checkLane(p105: table, p106: number) -- Line: 234
    -- upvalues: u104 (copy)
    local v107 = u104[p105.type];

    return not v107 and true or v107(p106, p105);
end;

function u48.reset(p108) -- Line: 241
    p108.currentValue = p108.baseValue;

    for _, v in p108.subValues do
        v.value = v.baseValue;
    end;
end;

function u48.copy(p109) -- Line: 248
    -- upvalues: u48 (copy)
    local v110 = u48.new(p109.tag, p109.type, p109.playfield);
    v110.noteMath = p109.noteMath;
    v110.strumMath = p109.strumMath;
    v110.incomingAngleMath = p109.incomingAngleMath;
    v110.curPosMath = p109.curPosMath;
    v110.noteDistMath = p109.noteDistMath;
    v110.currentValue = p109.currentValue;
    v110.baseValue = p109.currentValue;
    v110.subValues = p109.subValues;
    v110.targetLane = p109.targetLane;
    v110.instance = p109.instance;
    v110.renderer = p109.renderer;

    return v110;
end;

function u48.createSubMod(p111: table, p112: userdata, p113: number) -- Line: 266
    -- upvalues: u45 (copy)
    p111.subValues[p112] = u45.new(p113);
end;

local v114 = extend(u48);
local v115 = extend(u48);
local v116 = extend(u48);

function v114.setupSubValues(p117) -- Line: 275
    p117:createSubMod("speed", 1);
end;

function v114.strumMath(p118: table, p119: table, p120: number, p121: number) -- Line: 279
    return p118:noteMath(p119, p120, 0, p121);
end;

local setupSubValues = v114.setupSubValues;
v115.setupSubValues = v114.setupSubValues;
v116.setupSubValues = setupSubValues;
local strumMath = v114.strumMath;
v115.strumMath = v114.strumMath;
v116.strumMath = strumMath;

function v114.noteMath(p122: table, p123: table, p124: number, p125: number, p126: number) -- Line: 286
    -- upvalues: u42 (ref), NoteMovement (copy), u43 (ref), math_cos (copy), u44 (ref)
    p123.x = p123.x + p122.currentValue * (math_cos((u42.TimePosition + p124 % NoteMovement.keyCount * 0.2 + p125 * 0.45 * (10 / u43.height)) * (p122.subValues.speed.value * 0.2)) * u44.swagWidth * 0.5);
end;

function v115.noteMath(p127: table, p128: table, p129: number, p130: number, p131: number) -- Line: 291
    -- upvalues: u42 (ref), NoteMovement (copy), u43 (ref), math_cos (copy), u44 (ref)
    p128.y = p128.y + p127.currentValue * (math_cos((u42.TimePosition + p129 % NoteMovement.keyCount * 0.2 + p130 * 0.45 * (10 / u43.height)) * (p127.subValues.speed.value * 0.2)) * u44.swagWidth * 0.5);
end;

function v116.noteMath(p132: table, p133: table, p134: number, p135: number, p136: number) -- Line: 296
    -- upvalues: u42 (ref), NoteMovement (copy), u43 (ref), math_cos (copy), u44 (ref)
    p133.z = p133.z + p132.currentValue * (math_cos((u42.TimePosition + p134 % NoteMovement.keyCount * 0.2 + p135 * 0.45 * (10 / u43.height)) * (p132.subValues.speed.value * 0.2)) * u44.swagWidth * 0.5);
end;

local v137 = extend(u48);
local v138 = extend(u48);
local v139 = extend(u48);
local setupSubValues2 = v114.setupSubValues;
local setupSubValues3 = v114.setupSubValues;
v137.setupSubValues = v114.setupSubValues;
v138.setupSubValues = setupSubValues2;
v139.setupSubValues = setupSubValues3;
local strumMath2 = v114.strumMath;
local strumMath3 = v114.strumMath;
v137.strumMath = v114.strumMath;
v138.strumMath = strumMath2;
v139.strumMath = strumMath3;

function v137.noteMath(p140: table, p141: table, p142: number, p143: number, p144: number) -- Line: 307
    -- upvalues: u42 (ref), NoteMovement (copy), math_cos (copy), u44 (ref)
    p141.x = p141.x + p140.currentValue * (math_cos(u42.TimePosition * 1.2 + p142 % NoteMovement.keyCount * 2 + p140.subValues.speed.value * 0.2) * u44.swagWidth * 0.4);
end;

function v138.noteMath(p145: table, p146: table, p147: number, p148: number, p149: number) -- Line: 312
    -- upvalues: u42 (ref), NoteMovement (copy), math_cos (copy), u44 (ref)
    p146.y = p146.y + p145.currentValue * (math_cos(u42.TimePosition * 1.2 + p147 % NoteMovement.keyCount * 2 + p145.subValues.speed.value * 0.2) * u44.swagWidth * 0.4);
end;

function v139.noteMath(p150: table, p151: table, p152: number, p153: number, p154: number) -- Line: 316
    -- upvalues: u42 (ref), NoteMovement (copy), math_cos (copy), u44 (ref)
    p151.z = p151.z + p150.currentValue * (math_cos(u42.TimePosition * 1.2 + p152 % NoteMovement.keyCount * 2 + p150.subValues.speed.value * 0.2) * u44.swagWidth * 0.4);
end;

local v155 = extend(u48);

function v155.noteMath(p156: table, p157: table, p158: number, p159: number, p160: number) -- Line: 324
    -- upvalues: ModchartUtil (copy)
    p157.y = p157.y + 520 * (ModchartUtil:getDownscroll(p158) and -1 or 1) * p156.currentValue;
end;

function v155.noteDistMath(p161: table, p162: number, p163: number, p164: number, p165: number) -- Line: 328
    return p162 * (1 - p161.currentValue * 2);
end;

v155.strumMath = v114.strumMath;
local v166 = extend(u48);

function v166.setupSubValues(p167) -- Line: 336
    p167:createSubMod("x", 0);
    p167:createSubMod("y", 0);
    p167.currentValue = 1;
end;

function v166.incomingAngleMath(p168: table, p169: number, p170: number, p171: number) -- Line: 343
    return { p168.subValues.x.value, p168.subValues.y.value };
end;

function v166.reset(p172) -- Line: 347
    p172.super:reset();
    p172.currentValue = 1;
end;

local v173 = extend(u48);

function v173.setupSubValues(p174) -- Line: 354
    -- upvalues: u43 (ref), NoteMovement (copy)
    p174:createSubMod("x", 0);
    p174:createSubMod("y", 0);
    p174:createSubMod("rotatePointX", u43.width / 2 - NoteMovement.arrowSize / 2);
    p174:createSubMod("rotatePointY", u43.height / 2 - NoteMovement.arrowSize / 2);
    p174.currentValue = 1;
end;

function v173.noteMath(p175: table, p176: table, p177: number, p178: number, p179: number) -- Line: 363
    -- upvalues: NoteMovement (copy), ModchartUtil (copy)
    local v180 = NoteMovement.defaultStrumX[p177];
    local v181 = NoteMovement.defaultStrumY[p177];
    local CartesianCoords3D = ModchartUtil:getCartesianCoords3D(p175.subValues.x.value, 90, v180 - p175.subValues.rotatePointX.value);
    p176.x = p176.x + (CartesianCoords3D.x + p175.subValues.rotatePointX.value - v180);
    local CartesianCoords3D2 = ModchartUtil:getCartesianCoords3D(90, p175.subValues.y.value, v181 - p175.subValues.rotatePointY.value);
    p176.y = p176.y + (CartesianCoords3D2.y + p175.subValues.rotatePointY.value - v181);
    p176.z = p176.z + (CartesianCoords3D.z + CartesianCoords3D2.z);
end;

v173.strumMath = v114.strumMath;
v173.reset = v166.reset;
local v182 = extend(u48);

function v182.setupSubValues(p183) -- Line: 379
    p183:createSubMod("x", 0);
    p183:createSubMod("y", 0);
    p183:createSubMod("z", 90);
    p183.currentValue = 1;
end;

function v182.noteMath(p184: table, p185: table, p186: number, p187: number, p188: number) -- Line: 387
    -- upvalues: NoteMovement (copy), ModchartUtil (copy), SimpleQuaternion (copy)
    local v189 = p186 % NoteMovement.keyCount;
    local v190 = NoteMovement.keyCount / 2;
    local v191;

    if p186 < v190 then
        v189 = p186 + 1;
        v191 = -0.5;
    else
        v191 = 0.5;
    end;

    local v192 = v189 - v190 + v191;
    p185.x = p185.x + -v192 * NoteMovement.arrowSize;
    local v193 = not ModchartUtil:getDownscroll(p186);
    local v194 = SimpleQuaternion.fromEuler(p184.subValues.z.value, p184.subValues.x.value, v193 and -p184.subValues.y.value or p184.subValues.y.value);
    p185.x = p185.x + v194.x * v192 * NoteMovement.arrowSize;
    p185.y = p185.y + v194.y * v192 * NoteMovement.arrowSize;
    p185.z = p185.z + v194.z * v192 * NoteMovement.arrowSize;
end;

v182.strumMath = v114.strumMath;
v182.reset = v173.reset;
local v195 = extend(u48);
v195.setupSubValues = v114.setupSubValues;

function v195.noteMath(p196: table, p197: table, p198: number, p199: number, p200: number) -- Line: 421
    -- upvalues: math_sin (copy)
    p197.z = p197.z + p196.currentValue * 40 * math_sin(p199 * 0.01 * p196.subValues.speed.value);
end;

local v201 = extend(u48);
local v202 = extend(u48);
local v203 = extend(u48);

function v201.noteMath(p204: table, p205: table, p206: number, p207: number, p208: number) -- Line: 427
    p205.x = p205.x + p204.currentValue;
end;

v201.strumMath = v201.noteMath;

function v202.noteMath(p209: table, p210: table, p211: number, p212: number, p213: number) -- Line: 433
    -- upvalues: ModchartUtil (copy)
    p210.y = p210.y + p209.currentValue * (ModchartUtil:getDownscroll(p211) and -1 or 1);
end;

v202.strumMath = v202.noteMath;

function v203.noteMath(p214: table, p215: table, p216: number, p217: number, p218: number) -- Line: 439
    p215.z = p215.z + p214.currentValue;
end;

v203.strumMath = v203.noteMath;
local v219 = extend(u48);

function v219.noteMath(p220: table, p221: table, p222: number, p223: number, p224: number) -- Line: 447
    p221.angle = p221.angle + p220.currentValue;
end;

v219.strumMath = v219.noteMath;
local v225 = extend(u48);
local v226 = extend(u48);
local v227 = extend(u48);

function v225.setupSubValues(p228) -- Line: 455
    p228.baseValue = 1;
    p228.currentValue = 1;
end;

function v225.noteMath(p229: table, p230: table, p231: number, p232: number, p233: number) -- Line: 460
    p230.scaleX = p230.scaleX * p229.currentValue;
    p230.scaleY = p230.scaleY * p229.currentValue;
end;

v225.strumMath = v225.noteMath;

function v226.noteMath(p234: table, p235: table, p236: number, p237: number, p238: number) -- Line: 467
    p235.scaleX = p235.scaleX * p234.currentValue;
end;

function v227.noteMath(p239: table, p240: table, p241: number, p242: number, p243: number) -- Line: 471
    p240.scaleY = p240.scaleY * p239.currentValue;
end;

local setupSubValues4 = v225.setupSubValues;
v226.setupSubValues = v225.setupSubValues;
v227.setupSubValues = setupSubValues4;
v226.strumMath = v226.noteMath;
v227.strumMath = v227.noteMath;
local v244 = extend(u48);
v244.setupSubValues = v225.setupSubValues;

function v244.curPosMath(p245: table, p246: number, p247: number, p248: number) -- Line: 484
    return p247 * p245.currentValue;
end;

local v249 = extend(u48);
v249.playfieldSafe = true;

function v249.checkLane(p250: table, p251: number) -- Line: 491
    -- upvalues: u104 (copy), ModchartUtil (copy), NoteMovement (copy)
    local v252 = u104[p250.type];

    if ModchartUtil:isLeftSide() then
        if NoteMovement.keyCount <= p251 then
            p251 = p251 - NoteMovement.playerKeyCount;
        else
            p251 = p251 + NoteMovement.keyCount;
        end;
    end;

    return not v252 and true or v252(p251, p250);
end;

function v249.noteMath(p253: table, p254: table, p255: number, p256: number, p257: number) -- Line: 513
    p254.alpha = p254.alpha * (1 - p253.currentValue);
end;

v249.strumMath = v114.strumMath;
local v258 = extend(u48);
v258.noteMath = v249.noteMath;
local v259 = extend(u48);

function v259.noteMath(p260: table, p261: table, p262: number, p263: number, p264: number) -- Line: 525
    -- upvalues: NoteMovement (copy)
    p261.x = p261.x + NoteMovement.arrowSizes[p262] * (p262 % 2 == 0 and 1 or -1) * p260.currentValue;
end;

v259.strumMath = v114.strumMath;
local v265 = extend(u48);

function v265.noteMath(p266: table, p267: table, p268: number, p269: number, p270: number) -- Line: 533
    -- upvalues: NoteMovement (copy)
    local v271 = remapToRange(p268 % NoteMovement.keyCount, 0, NoteMovement.keyCount, NoteMovement.keyCount, -NoteMovement.keyCount);
    p267.x = p267.x + NoteMovement.arrowSizes[p268] * v271 * p266.currentValue;
    p267.x = p267.x - NoteMovement.arrowSizes[p268] * p266.currentValue;
end;

v265.strumMath = v114.strumMath;
local v272 = extend(u48);
v272.setupSubValues = v225.setupSubValues;

function v272.noteMath(p273: table, p274: table, p275: number, p276: number, p277: number) -- Line: 546
    -- upvalues: NoteMovement (copy)
    local _ = p275 % NoteMovement.keyCount;
    p274.scaleX = p274.scaleX * p273.currentValue;
    p274.scaleY = p274.scaleY * p273.currentValue;
    p274.x = p274.x - NoteMovement.arrowSizes[p275] / 2 * (p274.scaleX - NoteMovement.defaultScale[p275]);
    p274.y = p274.y - NoteMovement.arrowSizes[p275] / 2 * (p274.scaleY - NoteMovement.defaultScale[p275]);
end;

v272.strumMath = v114.strumMath;
local v278 = extend(u48);

function v278.noteMath(p279: table, p280: table, p281: number, p282: number, p283: number) -- Line: 561
    local v284 = 1 + p282 * 0.001 * p279.currentValue;
    p280.scaleX = p280.scaleX * v284;
    p280.scaleY = p280.scaleY * v284;
end;

local v285 = extend(u48);
local v286 = extend(u48);
local v287 = extend(u48);

function v285.getShift(p288: table, p289: table, p290: number, p291: number, p292: number) -- Line: 572
    -- upvalues: u48 (copy), math_floor (copy), math_sin (copy)
    local v293 = u48.beat + 0.2;
    local v294 = math_floor(v293) % 2 ~= 0;

    if v293 < 0 then
        return 0;
    end;

    local v295 = v293 - math_floor(v293) + 1;
    local v296 = v295 - math_floor(v295);

    if v296 >= 0.5 then
        return 0;
    end;

    local v297;

    if v296 < 0.2 then
        local v298 = remapToRange(v296, 0, 0.2, 0, 1);
        v297 = v298 * v298;
    else
        local v299 = remapToRange(v296, 0.2, 0.5, 1, 0);
        v297 = 1 - (1 - v299) * (1 - v299);
    end;

    if v294 then
        v297 = v297 * -1;
    end;

    return 20 * v297 * math_sin(p291 * 0.01 + 1.5707963267948966);
end;

local getShift = v285.getShift;
v286.getShift = v285.getShift;
v287.getShift = getShift;

function v285.noteMath(p300: table, p301: table, p302: number, p303: number, p304: number) -- Line: 619
    p301.x = p301.x + p300.currentValue * p300:getShift(p301, p302, p303, p304);
end;

function v286.noteMath(p305: table, p306: table, p307: number, p308: number, p309: number) -- Line: 623
    p306.y = p306.y + p305.currentValue * p305:getShift(p306, p307, p308, p309);
end;

function v287.noteMath(p310: table, p311: table, p312: number, p313: number, p314: number) -- Line: 627
    p311.z = p311.z + p310.currentValue * p310:getShift(p311, p312, p313, p314);
end;

local strumMath4 = v114.strumMath;
local strumMath5 = v114.strumMath;
v285.strumMath = v114.strumMath;
v286.strumMath = strumMath4;
v287.strumMath = strumMath5;
local v315 = extend(u48);
local v316 = extend(u48);
local v317 = extend(u48);
local setupSubValues5 = v114.setupSubValues;
local setupSubValues6 = v114.setupSubValues;
v315.setupSubValues = v114.setupSubValues;
v316.setupSubValues = setupSubValues5;
v317.setupSubValues = setupSubValues6;

function v315.noteMath(p318: table, p319: table, p320: number, p321: number, p322: number) -- Line: 637
    -- upvalues: NoteMovement (copy), math_sin (copy), math_abs (copy)
    p319.x = p319.x + p318.currentValue * NoteMovement.arrowSizes[p320] * math_abs((math_sin(p321 * 0.005 * p318.subValues.speed.value)));
end;

function v316.noteMath(p323: table, p324: table, p325: number, p326: number, p327: number) -- Line: 641
    -- upvalues: NoteMovement (copy), math_sin (copy), math_abs (copy)
    p324.y = p324.y + p323.currentValue * NoteMovement.arrowSizes[p325] * math_abs((math_sin(p326 * 0.005 * p323.subValues.speed.value)));
end;

function v317.noteMath(p328: table, p329: table, p330: number, p331: number, p332: number) -- Line: 645
    -- upvalues: NoteMovement (copy), math_sin (copy), math_abs (copy)
    p329.z = p329.z + p328.currentValue * NoteMovement.arrowSizes[p330] * math_abs((math_sin(p331 * 0.005 * p328.subValues.speed.value)));
end;

local v333, u334 = extend(u48);

function v333.new(...) -- Line: 651
    -- upvalues: u334 (copy), FlxEase (copy)
    u334(...).easeFunc = FlxEase.linear;
end;

function v333.setEase(p335: table, p336: string) -- Line: 656
    -- upvalues: FlxEase (copy)
    if typeof(p336) == "string" then
        p336 = FlxEase.getFlxEaseByString(p336) or p335.easeFunc;
    end;

    p335.easeFunc = p336;
end;

local v337 = extend(v333);
local v338 = extend(v333);
local v339 = extend(v333);
local v340 = extend(v333);
local v341 = extend(v333);

function v337.noteMath(p342: table, p343: table, p344: number, p345: number, p346: number) -- Line: 667
    p343.x = p343.x + p342.easeFunc(p345 * 0.01) * p342.currentValue * 0.2;
end;

function v338.noteMath(p347: table, p348: table, p349: number, p350: number, p351: number) -- Line: 671
    p348.y = p348.y + p347.easeFunc(p350 * 0.01) * p347.currentValue * 0.2;
end;

function v339.noteMath(p352: table, p353: table, p354: number, p355: number, p356: number) -- Line: 675
    p353.z = p353.z + p352.easeFunc(p355 * 0.01) * p352.currentValue * 0.2;
end;

function v340.noteMath(p357: table, p358: table, p359: number, p360: number, p361: number) -- Line: 679
    p358.angle = p358.angle + p357.easeFunc(p360 * 0.01) * p357.currentValue * 0.2;
end;

function v341.noteMath(p362: table, p363: table, p364: number, p365: number, p366: number) -- Line: 684
    p363.scaleX = p363.scaleX + p362.easeFunc(p365 * 0.01) * p362.currentValue * 0.2;
    p363.scaleY = p363.scaleY + p362.easeFunc(p365 * 0.01) * p362.currentValue * 0.2;
end;

local v367 = extend(u48);

function v367.noteMath(p368: table, p369: table, p370: number, p371: number, p372: number) -- Line: 691
    -- upvalues: math_sin (copy), NoteMovement (copy)
    p369.x = p369.x + math_sin(p371 * 0.004 + 0) * (NoteMovement.arrowSizes[p370] * (p370 % 2 == 0 and 1 or -1) * p368.currentValue * 0.5);
end;

local v373 = extend(u48);

function v373.curPosMath(p374: table, p375: number, p376: number, p377: number) -- Line: 697
    -- upvalues: u43 (ref), math_clamp (copy)
    local CorrectScrollSpeed = p374.renderer:getCorrectScrollSpeed();
    local v378 = -p376 / CorrectScrollSpeed;
    local height = u43.height;

    return p376 + (0 - math_clamp(p374.currentValue * (v378 * 1.5 / ((v378 + height / 1.2) / height) - v378), -400, 400) * CorrectScrollSpeed);
end;

local v379 = extend(u48);

function v379.curPosMath(p380: table, p381: number, p382: number, p383: number) -- Line: 715
    -- upvalues: u43 (ref), math_clamp (copy)
    local CorrectScrollSpeed = p380.renderer:getCorrectScrollSpeed();
    local v384 = -p382 / CorrectScrollSpeed;
    local v385 = v384 * remapToRange(v384, 0, u43.height, 0, 1);

    return p382 + (0 - math_clamp(p380.currentValue * (v385 - v384), -400, 400) * CorrectScrollSpeed);
end;

local v386 = extend(u48);

function v386.strumMath(p387: table, p388: table, p389: userdata, p390: userdata) -- Line: 734
    -- upvalues: u48 (copy), math_floor (copy), ModchartUtil (copy), u42 (ref)
    local v391 = u48.beat - math_floor(u48.beat);
    local v392 = ModchartUtil:getDownscroll(p389) and -1 or 1;
    p388.y = p388.y + v391 * (u42.StepCrochet * p387.currentValue) * p387.renderer:getCorrectScrollSpeed() * 0.45 * v392;
end;

function v386.noteMath(p393: table, p394: table, p395: number, p396: number, p397: number) -- Line: 741
    p393:strumMath(p394, p395, p397);
end;

return {
    Init = function(p398) -- Line: 746, Name: Init
        -- upvalues: u42 (ref), u43 (ref), u44 (ref)
        u42 = p398.Conductor;
        u43 = {
            width = 1280,
            height = 720
        };
        u44 = {
            swagWidth = 116.19999999999999
        };
    end,

    ModifierSubValue = u45,
    Modifier = u48,
    DrunkXModifier = v114,
    DrunkYModifier = v115,
    DrunkZModifier = v116,
    TipsyXModifier = v137,
    TipsyYModifier = v138,
    TipsyZModifier = v139,
    ReverseModifier = v155,
    IncomingAngleModifier = v166,
    RotateModifier = v173,
    StrumLineRotateModifier = v182,
    BumpyModifier = v195,
    XModifier = v201,
    YModifier = v202,
    ZModifier = v203,
    ConfusionModifier = v219,
    ScaleModifier = v225,
    ScaleXModifier = v226,
    ScaleYModifier = v227,
    SpeedModifier = v244,
    StealthModifier = v249,
    NoteStealthModifier = v258,
    InvertModifier = v259,
    FlipModifier = v265,
    MiniModifier = v272,
    ShrinkModifier = v278,
    BeatXModifier = v285,
    BeatYModifier = v286,
    BeatZModifier = v287,
    BounceXModifier = v315,
    BounceYModifier = v316,
    BounceZModifier = v317,
    EaseCurveModifier = v333,
    EaseCurveXModifier = v337,
    EaseCurveYModifier = v338,
    EaseCurveZModifier = v339,
    EaseCurveAngleModifier = v340,
    EaseCurveScaleModifier = v341,
    InvertSineModifier = v367,
    BoostModifier = v373,
    BrakeModifier = v379,
    JumpModifier = v386,
    ModifierType = ModifierType
};