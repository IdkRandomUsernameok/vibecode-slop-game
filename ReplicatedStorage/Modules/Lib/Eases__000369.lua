-- Decompiled with Potassium's decompiler.

local Bezier = require(script.Parent.Bezier);
local math_sin = math.sin;
local math_cos = math.cos;
local math_exp = math.exp;
local math_sqrt = math.sqrt;

local function RevBack(p1: number) -- Line: 15
    -- upvalues: math_sin (copy), math_cos (copy)
    local v2 = 1 - p1;

    return 1 - (math_sin(v2 * 1.5707963267949) + math_sin(v2 * 3.1415926535898) * (math_cos(v2 * 3.1415926535898) + 1) / 2);
end;

local function Linear(p3: number) -- Line: 20
    return p3;
end;

local function Constant(p4: number) -- Line: 24
    return p4 == 1 and 1 or 0;
end;

local v5 = Bezier(0.4, 0, 0.6, 1);
local v6 = Bezier(0.4, 0, 0.2, 1);
local v7 = Bezier(0.4, 0, 1, 1);
local v8 = Bezier(0, 0, 0.2, 1);
local v9 = Bezier(0.8, 0, 0.2, 1);
local v10 = Bezier(0.9, 0.1, 1, 0.2);
local v11 = Bezier(0.1, 0.9, 0.2, 1);
local v12 = Bezier(0.7, 0, 1, 0.5);
local v13 = Bezier(0.2, 0, 0.38, 0.9);
local v14 = Bezier(0.4, 0.14, 0.3, 1);
local v15 = Bezier(0, 0, 0.38, 0.9);
local v16 = Bezier(0, 0, 0.3, 1);
local v17 = Bezier(0.2, 0, 1, 0.9);
local v18 = Bezier(0.4, 0.14, 1, 1);
local v19 = Bezier(0.07, 0.95, 0, 1);

local function Smooth(p20: number) -- Line: 60
    return p20 * p20 * (3 - p20 * 2);
end;

local function Smoother(p21: number) -- Line: 64
    return p21 * p21 * p21 * (p21 * (p21 * 6 - 15) + 10);
end;

local function RidiculousWiggle(p22: number) -- Line: 68
    -- upvalues: math_sin (copy)
    return math_sin(math_sin(p22 * 3.1415926535898) * 1.5707963267949);
end;

local function RidiculousWiggle2(p23: number) -- Line: 73
    -- upvalues: math_sin (copy)
    return p23 + math_sin(p23 * 3.1415926535898 * 6) * (1 - p23) * 0.25;
end;

local function Spring(p24: number) -- Line: 77
    -- upvalues: math_exp (copy), math_cos (copy)
    return -math_exp(p24 * -6.9) * math_cos(p24 * -20.106192982975) + 1;
end;

local function SoftSpring(p25: number) -- Line: 81
    -- upvalues: math_exp (copy), math_cos (copy)
    return -math_exp(p25 * -7.5) * math_cos(p25 * -10.053096491487) + 1;
end;

local v124 = {
    InLinear = Linear,
    OutLinear = Linear,
    InOutLinear = Linear,
    OutInLinear = Linear,
    InConstant = Constant,
    OutConstant = Constant,
    InOutConstant = Constant,
    OutInConstant = Constant,
    InSmooth = Smooth,
    OutSmooth = Smooth,
    InOutSmooth = Smooth,
    OutInSmooth = Smooth,
    InSmoother = Smoother,
    OutSmoother = Smoother,
    InOutSmoother = Smoother,
    OutInSmoother = Smoother,
    InRidiculousWiggle = RidiculousWiggle2,
    OutRidiculousWiggle = RidiculousWiggle2,
    InOutRidiculousWiggle = RidiculousWiggle2,
    OutInRidiculousWiggle = RidiculousWiggle2,
    InRevBack = RevBack,
    OutRevBack = RevBack,
    InOutRevBack = RevBack,
    OutInRevBack = RevBack,
    InSpring = Spring,
    OutSpring = Spring,
    InOutSpring = Spring,
    OutInSpring = Spring,
    InSoftSpring = SoftSpring,
    OutSoftSpring = SoftSpring,
    InOutSoftSpring = SoftSpring,
    OutInSoftSpring = SoftSpring,
    InSharp = v5,
    InOutSharp = v5,
    OutSharp = v5,
    OutInSharp = v5,
    InAcceleration = v7,
    InOutAcceleration = v7,
    OutAcceleration = v7,
    OutInAcceleration = v7,
    InStandard = v6,
    InOutStandard = v6,
    OutStandard = v6,
    OutInStandard = v6,
    InDeceleration = v8,
    InOutDeceleration = v8,
    OutDeceleration = v8,
    OutInDeceleration = v8,
    InFabricStandard = v9,
    InOutFabricStandard = v9,
    OutFabricStandard = v9,
    OutInFabricStandard = v9,
    InFabricAccelerate = v10,
    InOutFabricAccelerate = v10,
    OutFabricAccelerate = v10,
    OutInFabricAccelerate = v10,
    InFabricDecelerate = v11,
    InOutFabricDecelerate = v11,
    OutFabricDecelerate = v11,
    OutInFabricDecelerate = v11,
    InUWPAccelerate = v12,
    InOutUWPAccelerate = v12,
    OutUWPAccelerate = v12,
    OutInUWPAccelerate = v12,
    InStandardProductive = v13,
    OutStandardProductive = v13,
    InOutStandardProductive = v13,
    OutInStandardProductive = v13,
    InStandardExpressive = v14,
    OutStandardExpressive = v14,
    InOutStandardExpressive = v14,
    OutInStandardExpressive = v14,
    InEntranceProductive = v15,
    OutEntranceProductive = v15,
    InOutEntranceProductive = v15,
    OutInEntranceProductive = v15,
    InEntranceExpressive = v16,
    OutEntranceExpressive = v16,
    InOutEntranceExpressive = v16,
    OutInEntranceExpressive = v16,
    InExitProductive = v17,
    OutExitProductive = v17,
    InOutExitProductive = v17,
    OutInExitProductive = v17,
    InExitExpressive = v18,
    OutExitExpressive = v18,
    InOutExitExpressive = v18,
    OutInExitExpressive = v18,
    InMozillaCurve = v19,
    OutMozillaCurve = v19,
    InOutMozillaCurve = v19,
    OutInMozillaCurve = v19,

    InQuad = function(p26: number) -- Line: 250, Name: InQuad
        return p26 * p26;
    end,

    OutQuad = function(p27: number) -- Line: 253, Name: OutQuad
        return p27 * (2 - p27);
    end,

    InOutQuad = function(p28: number) -- Line: 256, Name: InOutQuad
        if p28 < 0.5 then
            return p28 * 2 * p28;
        end;

        return (2 - p28) * 2 * p28 - 1;
    end,

    OutInQuad = function(p29: number) -- Line: 263, Name: OutInQuad
        if p29 < 0.5 then
            local v30 = p29 * 2;

            return v30 * (2 - v30) / 2;
        end;

        local v31 = p29 * 2 - 1;

        return v31 * v31 / 2 + 0.5;
    end,

    InCubic = function(p32: number) -- Line: 274, Name: InCubic
        return p32 * p32 * p32;
    end,

    OutCubic = function(p33: number) -- Line: 277, Name: OutCubic
        local v34 = 1 - p33;

        return 1 - v34 * v34 * v34;
    end,

    InOutCubic = function(p35: number) -- Line: 281, Name: InOutCubic
        if p35 < 0.5 then
            return p35 * 4 * p35 * p35;
        end;

        local v36 = p35 - 1;

        return v36 * 4 * v36 * v36 + 1;
    end,

    OutInCubic = function(p37: number) -- Line: 289, Name: OutInCubic
        if p37 < 0.5 then
            local v38 = 1 - p37 * 2;

            return (1 - v38 * v38 * v38) / 2;
        end;

        local v39 = p37 * 2 - 1;

        return v39 * v39 * v39 / 2 + 0.5;
    end,

    InQuart = function(p40: number) -- Line: 300, Name: InQuart
        return p40 * p40 * p40 * p40;
    end,

    OutQuart = function(p41: number) -- Line: 303, Name: OutQuart
        local v42 = p41 - 1;

        return 1 - v42 * v42 * v42 * v42;
    end,

    InOutQuart = function(p43: number) -- Line: 307, Name: InOutQuart
        if p43 < 0.5 then
            local v44 = p43 * p43;

            return v44 * 8 * v44;
        end;

        local v45 = p43 - 1;

        return 1 - v45 * 8 * v45 * v45 * v45;
    end,

    OutInQuart = function(p46: number) -- Line: 316, Name: OutInQuart
        if p46 < 0.5 then
            local v47 = p46 * 2 - 1;

            return (1 - v47 * v47 * v47 * v47) / 2;
        end;

        local v48 = p46 * 2 - 1;

        return v48 * v48 * v48 * v48 / 2 + 0.5;
    end,

    InQuint = function(p49: number) -- Line: 327, Name: InQuint
        return p49 * p49 * p49 * p49 * p49;
    end,

    OutQuint = function(p50: number) -- Line: 330, Name: OutQuint
        local v51 = p50 - 1;

        return v51 * v51 * v51 * v51 * v51 + 1;
    end,

    InOutQuint = function(p52: number) -- Line: 334, Name: InOutQuint
        if p52 < 0.5 then
            return p52 * 16 * p52 * p52 * p52 * p52;
        end;

        local v53 = p52 - 1;

        return v53 * 16 * v53 * v53 * v53 * v53 + 1;
    end,

    OutInQuint = function(p54: number) -- Line: 342, Name: OutInQuint
        if p54 < 0.5 then
            local v55 = p54 * 2 - 1;

            return (v55 * v55 * v55 * v55 * v55 + 1) / 2;
        end;

        local v56 = p54 * 2 - 1;

        return v56 * v56 * v56 * v56 * v56 / 2 + 0.5;
    end,

    InBack = function(p57: number) -- Line: 353, Name: InBack
        return p57 * p57 * (p57 * 3 - 2);
    end,

    OutBack = function(p58: number) -- Line: 356, Name: OutBack
        local v59 = p58 - 1;

        return v59 * v59 * (p58 * 2 + v59) + 1;
    end,

    InOutBack = function(p60: number) -- Line: 360, Name: InOutBack
        if p60 < 0.5 then
            return p60 * 2 * p60 * (p60 * 6 - 2);
        end;

        return (p60 - 1) * 2 * (p60 - 1) * (p60 * 6 - 2 - 2) + 1;
    end,

    OutInBack = function(p61: number) -- Line: 367, Name: OutInBack
        if p61 >= 0.5 then
            local v62 = p61 * 2 - 1;

            return v62 * v62 * (v62 * 3 - 2) / 2 + 0.5;
        end;

        local v63 = p61 * 2;
        local v64 = v63 - 1;

        return (v64 * v64 * (v63 * 2 + v64) + 1) / 2;
    end,

    InSine = function(p65: number) -- Line: 379, Name: InSine
        -- upvalues: math_sin (copy)
        return math_sin(p65 * 1.5707963267949 - 1.5707963267949) + 1;
    end,

    OutSine = function(p66: number) -- Line: 383, Name: OutSine
        -- upvalues: math_sin (copy)
        return math_sin(p66 * 1.5707963267949);
    end,

    InOutSine = function(p67: number) -- Line: 387, Name: InOutSine
        -- upvalues: math_sin (copy)
        return math_sin(p67 * 3.1415926535898 - 1.5707963267949) * 0.5 + 0.5;
    end,

    OutInSine = function(p68: number) -- Line: 391, Name: OutInSine
        -- upvalues: math_sin (copy)
        if p68 <= 0.5 then
            return math_sin(p68 * 3.1415926535898) * 0.5;
        end;

        return math_sin(p68 * 3.1415926535898 - 3.1415926535898) * 0.5 + 1;
    end,

    InBounce = function(p69: number) -- Line: 97, Name: InBounce
        if p69 > 0.63636363636364 then
            local v70 = p69 - 1;

            return 1 - v70 * v70 * 7.5625;
        end;

        if p69 > 0.272727272727273 then
            return (p69 * 11 - 7) * (p69 * 11 - 3) / -16;
        end;

        if p69 > 0.090909090909091 then
            return ((4 - p69 * 11) * 11 * p69 - 3) / 16;
        end;

        return p69 * (p69 * 11 - 1) * -0.6875;
    end,

    OutBounce = function(p71: number) -- Line: 85, Name: OutBounce
        if p71 < 0.36363636363636 then
            return p71 * 7.5625 * p71;
        end;

        if p71 < 0.72727272727273 then
            return p71 * (p71 * 11 - 12) * 0.6875 + 3;
        end;

        if p71 < 0.090909090909091 then
            return p71 * (p71 * 11 - 18) * 0.6875 + 6;
        end;

        return p71 * (p71 * 11 - 21) * 0.6875 + 7.875;
    end,

    InOutBounce = function(p72: number) -- Line: 407, Name: InOutBounce
        if p72 < 0.5 then
            local v73 = p72 * 2;
            local v74;

            if v73 > 0.63636363636364 then
                local v75 = v73 - 1;
                v74 = 1 - v75 * v75 * 7.5625;
            elseif v73 > 0.272727272727273 then
                v74 = (v73 * 11 - 7) * (v73 * 11 - 3) / -16;
            elseif v73 > 0.090909090909091 then
                v74 = ((4 - v73 * 11) * 11 * v73 - 3) / 16;
            else
                v74 = v73 * (v73 * 11 - 1) * -0.6875;
            end;

            return v74 / 2;
        end;

        local v76 = p72 * 2 - 1;
        local v77;

        if v76 < 0.36363636363636 then
            v77 = v76 * 7.5625 * v76;
        elseif v76 < 0.72727272727273 then
            v77 = v76 * (v76 * 11 - 12) * 0.6875 + 3;
        elseif v76 < 0.090909090909091 then
            v77 = v76 * (v76 * 11 - 18) * 0.6875 + 6;
        else
            v77 = v76 * (v76 * 11 - 21) * 0.6875 + 7.875;
        end;

        return v77 / 2 + 0.5;
    end,

    OutInBounce = function(p78: number) -- Line: 414, Name: OutInBounce
        if p78 < 0.5 then
            local v79 = p78 * 2;
            local v80;

            if v79 < 0.36363636363636 then
                v80 = v79 * 7.5625 * v79;
            elseif v79 < 0.72727272727273 then
                v80 = v79 * (v79 * 11 - 12) * 0.6875 + 3;
            elseif v79 < 0.090909090909091 then
                v80 = v79 * (v79 * 11 - 18) * 0.6875 + 6;
            else
                v80 = v79 * (v79 * 11 - 21) * 0.6875 + 7.875;
            end;

            return v80 / 2;
        end;

        local v81 = p78 * 2 - 1;
        local v82;

        if v81 > 0.63636363636364 then
            local v83 = v81 - 1;
            v82 = 1 - v83 * v83 * 7.5625;
        elseif v81 > 0.272727272727273 then
            v82 = (v81 * 11 - 7) * (v81 * 11 - 3) / -16;
        elseif v81 > 0.090909090909091 then
            v82 = ((4 - v81 * 11) * 11 * v81 - 3) / 16;
        else
            v82 = v81 * (v81 * 11 - 1) * -0.6875;
        end;

        return v82 / 2 + 0.5;
    end,

    InElastic = function(p84: number) -- Line: 423, Name: InElastic
        -- upvalues: math_sin (copy)
        local v85 = p84 * 0.3;

        return -2 ^ ((p84 - 1) * 10) * math_sin((p84 - 1 - v85 / 4) * 6.2831853071796 / v85);
    end,

    OutElastic = function(p86: number) -- Line: 428, Name: OutElastic
        -- upvalues: math_sin (copy)
        local v87 = p86 * 0.3;

        return 2 ^ (p86 * -10) * math_sin((p86 - v87 / 4) * 6.2831853071796 / v87) + 1;
    end,

    InOutElastic = function(p88: number) -- Line: 433, Name: InOutElastic
        -- upvalues: math_sin (copy)
        if p88 < 0.5 then
            local v89 = p88 - 0.5;

            return 2 ^ (v89 * 10) * math_sin((v89 - 0.1) * 6.2831853071796 / 0.4) * -0.5;
        end;

        local v90 = p88 - 0.5;

        return 2 ^ (v90 * -10) * math_sin((v90 - 0.1) * 6.2831853071796 / 0.4) * 0.5 + 1;
    end,

    OutInElastic = function(p91: number) -- Line: 451, Name: OutInElastic
        -- upvalues: math_sin (copy)
        local v92 = p91 * 0.3;

        if p91 <= 0.5 then
            return 2 ^ (p91 * -20) * 0.5 * math_sin((p91 * 2 - v92 / 4) * 6.2831853071796 / v92) + 0.5;
        end;

        return 2 ^ ((p91 * 2 - 2) * 10) * -0.5 * math_sin((p91 * 2 - 2 - v92 / 4) * 6.2831853071796 / v92) + 0.5;
    end,

    InExpo = function(p93: number) -- Line: 462, Name: InExpo
        -- upvalues: math_exp (copy)
        return p93 * p93 * math_exp((p93 - 1) * 4);
    end,

    OutExpo = function(p94: number) -- Line: 465, Name: OutExpo
        -- upvalues: math_exp (copy)
        return 1 - (1 - p94) * (1 - p94) / math_exp(p94 * 4);
    end,

    InOutExpo = function(p95: number) -- Line: 468, Name: InOutExpo
        -- upvalues: math_exp (copy)
        if p95 < 0.5 then
            return p95 * 2 * p95 * math_exp((p95 * 2 - 1) * 4);
        end;

        return 1 - (p95 - 1) * 2 * (p95 - 1) * math_exp((1 - p95 * 2) * 4);
    end,

    OutInExpo = function(p96: number) -- Line: 475, Name: OutInExpo
        -- upvalues: math_exp (copy)
        if p96 < 0.5 then
            local v97 = p96 * 2;

            return (1 - (1 - v97) * (1 - v97) / math_exp(v97 * 4)) / 2;
        end;

        local v98 = p96 * 2 - 1;

        return v98 * v98 * math_exp((v98 - 1) * 4) / 2 + 0.5;
    end,

    InCirc = function(p99: number) -- Line: 486, Name: InCirc
        -- upvalues: math_sqrt (copy)
        return -(math_sqrt(1 - p99 * p99) - 1);
    end,

    OutCirc = function(p100: number) -- Line: 489, Name: OutCirc
        -- upvalues: math_sqrt (copy)
        local v101 = p100 - 1;

        return math_sqrt(1 - v101 * v101);
    end,

    InOutCirc = function(p102: number) -- Line: 493, Name: InOutCirc
        local v103 = p102 * 2;

        if v103 < 1 then
            return -(math.sqrt(1 - v103 * v103) - 1) / 2;
        end;

        local v104 = v103 - 2;

        return (math.sqrt(1 - v104 * v104) + 1) / 2;
    end,

    OutInCirc = function(p105: number) -- Line: 502, Name: OutInCirc
        -- upvalues: math_sqrt (copy)
        if p105 < 0.5 then
            local v106 = p105 * 2 - 1;

            return math_sqrt(1 - v106 * v106) / 2;
        end;

        local v107 = p105 * 2 - 1;

        return -(math_sqrt(1 - v107 * v107) - 1) / 2 + 0.5;
    end,

    InFlxSmoothStep = function(p108: number) -- Line: 516, Name: InFlxSmoothStep
        local v109 = p108 / 2;

        return v109 * v109 * (v109 * -2 + 3) * 2;
    end,

    OutFlxSmoothStep = function(p110: number) -- Line: 520, Name: OutFlxSmoothStep
        local v111 = p110 / 2 + 0.5;

        return v111 * v111 * (v111 * -2 + 3) * 2 - 1;
    end,

    InOutFlxSmoothStep = function(p112: number) -- Line: 524, Name: InOutFlxSmoothStep
        return p112 * p112 * (p112 * -2 + 3);
    end,

    OutInFlxSmoothStep = function(p113: number) -- Line: 527, Name: OutInFlxSmoothStep
        if p113 < 0.5 then
            local v114 = p113 / 2;

            return v114 * v114 * (v114 * -2 + 3) * 2;
        end;

        local v115 = p113 / 2 + 0.5;

        return v115 * v115 * (v115 * -2 + 3) * 2 - 1;
    end,

    InFlxSmootherStep = function(p116: number) -- Line: 538, Name: InFlxSmootherStep
        local v117 = p116 / 2;

        return v117 * v117 * v117 * (v117 * (v117 * 6 - 15) + 10) * 2;
    end,

    OutFlxSmootherStep = function(p118: number) -- Line: 542, Name: OutFlxSmootherStep
        local v119 = p118 / 2 + 0.5;

        return v119 * v119 * v119 * (v119 * (v119 * 6 - 15) + 10) * 2 - 1;
    end,

    InOutFlxSmootherStep = function(p120: number) -- Line: 546, Name: InOutFlxSmootherStep
        return p120 * p120 * p120 * (p120 * (p120 * 6 - 15) + 10);
    end,

    OutInFlxSmootherStep = function(p121: number) -- Line: 549, Name: OutInFlxSmootherStep
        if p121 < 0.5 then
            local v122 = p121 / 2;

            return v122 * v122 * v122 * (v122 * (v122 * 6 - 15) + 10) * 2;
        end;

        local v123 = p121 / 2 + 0.5;

        return v123 * v123 * v123 * (v123 * (v123 * 6 - 15) + 10) * 2 - 1;
    end
};
v124.InExponential = v124.InExpo;
v124.OutExponential = v124.OutExpo;
v124.InOutExponential = v124.InOutExpo;
v124.OutInExponential = v124.OutInExpo;
v124.InCircular = v124.InCirc;
v124.OutCircular = v124.OutCirc;
v124.InOutCircular = v124.InOutCirc;
v124.OutInCircular = v124.OutInCirc;
local u125 = {
    [Enum.EasingStyle.Linear] = {
        [Enum.EasingDirection.In] = v124.InLinear,
        [Enum.EasingDirection.Out] = v124.OutLinear,
        [Enum.EasingDirection.InOut] = v124.InOutLinear
    },
    [Enum.EasingStyle.Sine] = {
        [Enum.EasingDirection.In] = v124.InSine,
        [Enum.EasingDirection.Out] = v124.OutSine,
        [Enum.EasingDirection.InOut] = v124.InOutSine
    },
    [Enum.EasingStyle.Back] = {
        [Enum.EasingDirection.In] = v124.InBack,
        [Enum.EasingDirection.Out] = v124.OutBack,
        [Enum.EasingDirection.InOut] = v124.InOutBack
    },
    [Enum.EasingStyle.Quad] = {
        [Enum.EasingDirection.In] = v124.InQuad,
        [Enum.EasingDirection.Out] = v124.OutQuad,
        [Enum.EasingDirection.InOut] = v124.InOutQuad
    },
    [Enum.EasingStyle.Quart] = {
        [Enum.EasingDirection.In] = v124.InQuart,
        [Enum.EasingDirection.Out] = v124.OutQuart,
        [Enum.EasingDirection.InOut] = v124.InOutQuart
    },
    [Enum.EasingStyle.Quint] = {
        [Enum.EasingDirection.In] = v124.InQuint,
        [Enum.EasingDirection.Out] = v124.OutQuint,
        [Enum.EasingDirection.InOut] = v124.InOutQuint
    },
    [Enum.EasingStyle.Bounce] = {
        [Enum.EasingDirection.In] = v124.InBounce,
        [Enum.EasingDirection.Out] = v124.OutBounce,
        [Enum.EasingDirection.InOut] = v124.InOutBounce
    },
    [Enum.EasingStyle.Elastic] = {
        [Enum.EasingDirection.In] = v124.InElastic,
        [Enum.EasingDirection.Out] = v124.OutElastic,
        [Enum.EasingDirection.InOut] = v124.InOutElastic
    },
    [Enum.EasingStyle.Exponential] = {
        [Enum.EasingDirection.In] = v124.InExpo,
        [Enum.EasingDirection.Out] = v124.OutExpo,
        [Enum.EasingDirection.InOut] = v124.InOutExpo,
        Name = "Expo"
    },
    [Enum.EasingStyle.Circular] = {
        [Enum.EasingDirection.In] = v124.InCirc,
        [Enum.EasingDirection.Out] = v124.OutCirc,
        [Enum.EasingDirection.InOut] = v124.InOutCirc,
        Name = "Circ"
    },
    [Enum.EasingStyle.Cubic] = {
        [Enum.EasingDirection.In] = v124.InCubic,
        [Enum.EasingDirection.Out] = v124.OutCubic,
        [Enum.EasingDirection.InOut] = v124.InOutCubic
    }
};

function v124.getEaseFromEnum(p126, p127) -- Line: 646
    -- upvalues: u125 (copy)
    local v128 = u125[p126];

    if v128 then
        return v128[p127];
    end;

    return nil;
end;

local u129 = {
    backin = v124.InBack,
    backout = v124.OutBack,
    backinout = v124.InOutBack,
    bouncein = v124.InBounce,
    bounceout = v124.OutBounce,
    bounceinout = v124.InOutBounce,
    circin = v124.InCirc,
    circout = v124.OutCirc,
    circinout = v124.InOutCirc,
    cubein = v124.InCubic,
    cubeout = v124.OutCubic,
    cubeinout = v124.InOutCubic,
    elasticin = v124.InElastic,
    elasticout = v124.OutElastic,
    elasticinout = v124.InOutElastic,
    expoin = v124.InExpo,
    expoout = v124.OutExpo,
    expoinout = v124.InOutExpo,
    quadin = v124.InQuad,
    quadout = v124.OutQuad,
    quadinout = v124.InOutQuad,
    quartin = v124.InQuart,
    quartout = v124.OutQuart,
    quartinout = v124.InOutQuart,
    quintin = v124.InQuint,
    quintout = v124.OutQuint,
    quintinout = v124.InOutQuint,
    sinein = v124.InSine,
    sineout = v124.OutSine,
    sineinout = v124.InOutSine,
    smoothstepin = v124.InFlxSmoothStep,
    smoothstepout = v124.OutFlxSmoothStep,
    smoothstepinout = v124.InOutFlxSmoothStep,
    smootherstepin = v124.InFlxSmootherStep,
    smootherstepout = v124.OutFlxSmootherStep,
    smootherstepinout = v124.InOutFlxSmootherStep
};

function v124.getEaseFromFlixel(p130: string) -- Line: 696
    -- upvalues: u129 (copy)
    return u129[p130:lower()];
end;

return v124;