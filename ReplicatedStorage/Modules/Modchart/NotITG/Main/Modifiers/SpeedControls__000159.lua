-- Decompiled with Potassium's decompiler.

local u1 = {
    Wave = 0,
    Boost = 0,
    Brake = 0
};

local function clamp(p2, p3, p4) -- Line: 4
    local math_min_ret = math.min(p4, p2);

    return math.max(p3, math_min_ret);
end;

local function scale(p5, p6, p7, p8, p9) -- Line: 5
    if p7 == p6 then
        return p8;
    end;

    return (p5 - p6) * (p9 - p8) / (p7 - p6) + p8;
end;

local function getReverseSign(p10, p11) -- Line: 10
    if p10 then
        p10 = p10.Reverse;
    end;

    return p10 and p10.GetReverseStatus and (p10.GetReverseStatus(p11) >= 50 and -1 or 1) or 1;
end;

return {
    Wave = {
        Set = function(p12) -- Line: 21, Name: Set
            -- upvalues: u1 (copy)
            u1.Wave = p12;
        end,

        Get = function() -- Line: 22, Name: Get
            -- upvalues: u1 (copy)
            return u1.Wave;
        end,

        Update = function(p13, p14, p15) -- Line: 23, Name: Update
            -- upvalues: u1 (copy)
            if u1.Wave == 0 then
                return p13;
            end;

            if p14 then
                p14 = p14.Reverse;
            end;

            local v16 = p14 and p14.GetReverseStatus and (p14.GetReverseStatus(p15) >= 50 and -1 or 1) or 1;
            p13.y = p13.y + u1.Wave * 20 * math.sin(p15.Y_OFFSET / 38) * v16;

            return p13;
        end
    },
    Brake = {
        Set = function(p17) -- Line: 31, Name: Set
            -- upvalues: u1 (copy)
            u1.Brake = p17;
        end,

        Get = function() -- Line: 32, Name: Get
            -- upvalues: u1 (copy)
            return u1.Brake;
        end,

        Update = function(p18, p19, p20) -- Line: 33, Name: Update
            -- upvalues: u1 (copy)
            if u1.Brake == 0 then
                return p18;
            end;

            if p19 then
                p19 = p19.Reverse;
            end;

            local v21 = p19 and p19.GetReverseStatus and (p19.GetReverseStatus(p20) >= 50 and -1 or 1) or 1;
            local y = p18.y;
            local math_min_ret = math.min(400, u1.Brake * (p20.Y_OFFSET * ((p20.Y_OFFSET - 0) * 1 / 500 + 0) - p20.Y_OFFSET));
            p18.y = y + math.max(-400, math_min_ret) * v21;

            return p18;
        end
    },
    Boost = {
        Set = function(p22) -- Line: 43, Name: Set
            -- upvalues: u1 (copy)
            u1.Boost = p22;
        end,

        Get = function() -- Line: 44, Name: Get
            -- upvalues: u1 (copy)
            return u1.Boost;
        end,

        Update = function(p23, p24, p25) -- Line: 45, Name: Update
            -- upvalues: u1 (copy)
            if u1.Boost == 0 then
                return p23;
            end;

            if p24 then
                p24 = p24.Reverse;
            end;

            local v26 = p24 and p24.GetReverseStatus and (p24.GetReverseStatus(p25) >= 50 and -1 or 1) or 1;
            local y = p23.y;
            local math_min_ret = math.min(400, u1.Boost * (p25.Y_OFFSET * 1.5 / ((p25.Y_OFFSET + 416.6666666666667) / 500) - p25.Y_OFFSET));
            p23.y = y + math.max(-400, math_min_ret) * v26;

            return p23;
        end
    }
};