-- Decompiled with Potassium's decompiler.

local u1 = {
    Stealth = 0,
    Alpha = 0,
    Dark = 0,
    Hidden = 0,
    HiddenOffset = 0,
    Sudden = 0,
    SuddenOffset = 0,
    Blink = 0,
    ["Alpha" .. 0] = 0,
    ["Dark" .. 0] = 0,
    ["Alpha" .. 1] = 0,
    ["Dark" .. 1] = 0,
    ["Alpha" .. 2] = 0,
    ["Dark" .. 2] = 0,
    ["Alpha" .. 3] = 0,
    ["Dark" .. 3] = 0
};

local function getHiddenSudden(p2, p3) -- Line: 18
    return p2 * p3;
end;

local function getHiddenEnd(p4, p5, p6) -- Line: 20
    local function scale(p7, p8, p9, p10, p11) -- Line: 22
        return (p7 - p8) * (p11 - p10) / (p9 - p8) + p10;
    end;

    return 360 + 120 * ((p4 * p5 - 0) * -0.25 / 1 + -1) + 360 * p6;
end;

local function getHiddenStart(p12, p13, p14) -- Line: 26
    local function _(p15, p16, p17, p18, p19) -- Line: 28
        return (p15 - p16) * (p19 - p18) / (p17 - p16) + p18;
    end;

    return 360 + 120 * ((p12 * p13 - 0) * -0.25 / 1 + 0) + 360 * p14;
end;

local function getSuddenEnd(p20, p21, p22) -- Line: 32
    local function _(p23, p24, p25, p26, p27) -- Line: 34
        return (p23 - p24) * (p27 - p26) / (p25 - p24) + p26;
    end;

    return 360 + 120 * ((p20 * p21 - 0) * 0.25 / 1 + 1) + 360 * p22;
end;

local function getSuddenStart(p28, p29, p30) -- Line: 38
    local function _(p31, p32, p33, p34, p35) -- Line: 40
        return (p31 - p32) * (p35 - p34) / (p33 - p32) + p34;
    end;

    return 360 + 120 * ((p28 * p29 - 0) * 0.25 / 1 + 0) + 360 * p30;
end;

local function clamp(p36, p37, p38) -- Line: 44
    local math_min_ret = math.min(p38, p36);

    return math.max(p37, math_min_ret);
end;

local function _(p39, p40, p41, p42, p43) -- Line: 46
    if p41 == p40 then
        return p42;
    end;

    return (p39 - p40) * (p43 - p42) / (p41 - p40) + p42;
end;

local function getVisibility(p44, p45) -- Line: 51
    -- upvalues: u1 (copy)
    local Hidden = u1.Hidden;
    local Sudden = u1.Sudden;
    local v46 = 0;

    if Hidden ~= 0 then
        local function _(p47, p48, p49, p50, p51) -- Line: 28
            return (p47 - p48) * (p51 - p50) / (p49 - p48) + p50;
        end;

        local v52 = 360 + 120 * ((Hidden * Sudden - 0) * -0.25 / 1 + 0) + 360 * u1.HiddenOffset;

        local function _(p53, p54, p55, p56, p57) -- Line: 22
            return (p53 - p54) * (p57 - p56) / (p55 - p54) + p56;
        end;

        local v58 = 360 + 120 * ((Hidden * Sudden - 0) * -0.25 / 1 + -1) + 360 * u1.HiddenOffset;
        local math_min_ret = math.min(0, v58 == v52 and 0 or (p44 - v52) * -1 / (v58 - v52) + 0);
        v46 = v46 + Hidden * math.max(-1, math_min_ret);
    end;

    if Sudden ~= 0 then
        local function _(p59, p60, p61, p62, p63) -- Line: 40
            return (p59 - p60) * (p63 - p62) / (p61 - p60) + p62;
        end;

        local v64 = 360 + 120 * ((Hidden * Sudden - 0) * 0.25 / 1 + 0) + 360 * u1.SuddenOffset;

        local function _(p65, p66, p67, p68, p69) -- Line: 34
            return (p65 - p66) * (p69 - p68) / (p67 - p66) + p68;
        end;

        local v70 = 360 + 120 * ((Hidden * Sudden - 0) * 0.25 / 1 + 1) + 360 * u1.SuddenOffset;
        local math_min_ret = math.min(0, v70 == v64 and 0 or (p44 - v64) * -1 / (v70 - v64) + 0);
        v46 = v46 + Sudden * math.max(-1, math_min_ret);
    end;

    if u1.Stealth ~= 0 then
        v46 = v46 - u1.Stealth / 100;
    end;

    if u1.Alpha ~= 0 then
        v46 = v46 - u1.Alpha / 100;
    end;

    if u1.Blink ~= 0 then
        local v71 = math.sin(p45.SONG_POSITION * 0.001 * 10) / 0.3333 + 0.5;
        v46 = v46 + ((math.floor(v71) * 0.3333 - 0) * 1 / 1 + -1) * u1.Blink;
    end;

    local math_min_ret = math.min(1, v46 + 1);

    return math.max(0, math_min_ret);
end;

local v90 = {
    Alpha = {
        Set = function(p72) -- Line: 85, Name: Set
            -- upvalues: u1 (copy)
            u1.Alpha = p72;
        end,

        Get = function(p73) -- Line: 86, Name: Get
            -- upvalues: u1 (copy)
            return u1.Alpha + (p73 and (u1["Alpha" .. p73] or 0) or 0);
        end,

        Update = function(p74, p75, p76) -- Line: 89, Name: Update
            -- upvalues: u1 (copy)
            p74.alpha = p74.alpha * (u1.Alpha + (u1["Alpha" .. p76.COLUMN] or 0));

            return p74;
        end
    },
    Stealth = {
        Set = function(p77) -- Line: 97, Name: Set
            -- upvalues: u1 (copy)
            u1.Stealth = p77;
        end,

        Get = function() -- Line: 98, Name: Get
            -- upvalues: u1 (copy)
            return u1.Stealth;
        end,

        Update = function(p78, p79, p80) -- Line: 99, Name: Update
            -- upvalues: getVisibility (copy)
            p78.alpha = p78.alpha * getVisibility(p80.Y_OFFSET, p80);

            return p78;
        end
    },
    Dark = {
        OnlyReceptors = true,

        Set = function(p81) -- Line: 106, Name: Set
            -- upvalues: u1 (copy)
            u1.Dark = p81;
        end,

        Get = function() -- Line: 107, Name: Get
            -- upvalues: u1 (copy)
            return u1.Dark;
        end,

        Update = function(p82, p83, p84) -- Line: 108, Name: Update
            -- upvalues: u1 (copy)
            p82.alpha = p82.alpha * ((1 - u1.Dark) * (1 - (u1["Dark" .. p84.COLUMN] or 0)));

            return p82;
        end
    },
    Hidden = {
        Set = function(p85) -- Line: 115, Name: Set
            -- upvalues: u1 (copy)
            u1.Hidden = p85;
        end,

        Get = function() -- Line: 116, Name: Get
            -- upvalues: u1 (copy)
            return u1.Hidden;
        end
    },
    HiddenOffset = {
        Set = function(p86) -- Line: 119, Name: Set
            -- upvalues: u1 (copy)
            u1.HiddenOffset = p86;
        end,

        Get = function() -- Line: 120, Name: Get
            -- upvalues: u1 (copy)
            return u1.HiddenOffset;
        end
    },
    Sudden = {
        Set = function(p87) -- Line: 123, Name: Set
            -- upvalues: u1 (copy)
            u1.Sudden = p87;
        end,

        Get = function() -- Line: 124, Name: Get
            -- upvalues: u1 (copy)
            return u1.Sudden;
        end
    },
    SuddenOffset = {
        Set = function(p88) -- Line: 127, Name: Set
            -- upvalues: u1 (copy)
            u1.SuddenOffset = p88;
        end,

        Get = function() -- Line: 128, Name: Get
            -- upvalues: u1 (copy)
            return u1.SuddenOffset;
        end
    },
    Blink = {
        Set = function(p89) -- Line: 131, Name: Set
            -- upvalues: u1 (copy)
            u1.Blink = p89;
        end,

        Get = function() -- Line: 132, Name: Get
            -- upvalues: u1 (copy)
            return u1.Blink;
        end
    }
};

for i = 0, 3 do
    v90["Alpha" .. i] = {
        Set = function(p91) -- Line: 138, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["Alpha" .. i] = p91;
        end,

        Get = function() -- Line: 139, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["Alpha" .. i];
        end,

        Update = function(p92) -- Line: 140, Name: Update
            return p92;
        end
    };
    v90["Dark" .. i] = {
        Set = function(p93) -- Line: 143, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["Dark" .. i] = p93;
        end,

        Get = function() -- Line: 144, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["Dark" .. i];
        end,

        Update = function(p94) -- Line: 145, Name: Update
            return p94;
        end
    };
    local _ = i;
end;

return v90;