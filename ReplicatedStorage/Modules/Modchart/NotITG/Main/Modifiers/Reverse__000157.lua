-- Decompiled with Potassium's decompiler.

local u1 = {
    Reverse = 0,
    Split = 0,
    Alternate = 0,
    Cross = 0,
    Centered = 0,
    ["Reverse" .. 0] = 0,
    ["Reverse" .. 1] = 0,
    ["Reverse" .. 2] = 0,
    ["Reverse" .. 3] = 0
};

local function clamp(p2, p3, p4) -- Line: 13
    local math_min_ret = math.min(p4, p2);

    return math.max(p3, math_min_ret);
end;

local function scale(p5, p6, p7, p8, p9) -- Line: 14
    if p7 == p6 then
        return p8;
    end;

    return (p5 - p6) * (p9 - p8) / (p7 - p6) + p8;
end;

local function getReverseValue(p10) -- Line: 19
    -- upvalues: u1 (copy)
    local v11 = u1.Reverse + (u1["Reverse" .. p10] or 0);

    if p10 >= 2 then
        v11 = v11 + u1.Split;
    end;

    if p10 % 2 == 1 then
        v11 = v11 + u1.Alternate;
    end;

    if p10 >= 1 and p10 <= 2 then
        v11 = v11 + u1.Cross;
    end;

    local v12 = v11 % 2;

    if v12 > 1 then
        v12 = 2 - v12;
    end;

    return v12;
end;

local v33 = {
    Reverse = {
        Set = function(p13) -- Line: 34, Name: Set
            -- upvalues: u1 (copy)
            u1.Reverse = p13 / 100;
        end,

        Get = function(p14) -- Line: 35, Name: Get
            -- upvalues: u1 (copy)
            if p14 then
                return (u1.Reverse + (u1["Reverse" .. p14] or 0)) * 100;
            end;

            return u1.Reverse * 100;
        end,

        GetReverseStatus = function(p15) -- Line: 39, Name: GetReverseStatus
            -- upvalues: u1 (copy)
            if p15 == nil then
                return 0;
            end;

            local COLUMN = p15.COLUMN;
            local v16 = u1.Reverse + (u1["Reverse" .. COLUMN] or 0);

            if COLUMN >= 2 then
                v16 = v16 + u1.Split;
            end;

            if COLUMN % 2 == 1 then
                v16 = v16 + u1.Alternate;
            end;

            if COLUMN >= 1 and COLUMN <= 2 then
                v16 = v16 + u1.Cross;
            end;

            local v17 = v16 % 2;

            if v17 > 1 then
                v17 = 2 - v17;
            end;

            return v17;
        end,

        Update = function(p18, p19, p20) -- Line: 43, Name: Update
            -- upvalues: u1 (copy)
            local COLUMN = p20.COLUMN;
            local v21 = u1.Reverse + (u1["Reverse" .. COLUMN] or 0);

            if COLUMN >= 2 then
                v21 = v21 + u1.Split;
            end;

            if COLUMN % 2 == 1 then
                v21 = v21 + u1.Alternate;
            end;

            if COLUMN >= 1 and COLUMN <= 2 then
                v21 = v21 + u1.Cross;
            end;

            local v22 = v21 % 2;

            if v22 > 1 then
                v22 = 2 - v22;
            end;

            local v23 = (v22 - 0) * (670 - p20.ARROW_SIZE - 50) / 1 + 50;
            local v24 = (v22 - 0) * -2 / 1 + 1;
            p18.y = p18.y + ((u1.Centered - 0) * (360 - v23) / 1 + v23 + p20.Y_OFFSET * v24 + p20.ARROW_SIZE * 0.5 - (p20.RECEPTOR_Y + p20.Y_OFFSET));
            p18.scrollSpeed = v24;

            return p18;
        end
    },
    Split = {
        Set = function(p25) -- Line: 57, Name: Set
            -- upvalues: u1 (copy)
            u1.Split = p25;
        end,

        Get = function() -- Line: 58, Name: Get
            -- upvalues: u1 (copy)
            return u1.Split;
        end,

        Update = function(p26) -- Line: 59, Name: Update
            return p26;
        end
    },
    Alternate = {
        Set = function(p27) -- Line: 62, Name: Set
            -- upvalues: u1 (copy)
            u1.Alternate = p27;
        end,

        Get = function() -- Line: 63, Name: Get
            -- upvalues: u1 (copy)
            return u1.Alternate;
        end,

        Update = function(p28) -- Line: 64, Name: Update
            return p28;
        end
    },
    Cross = {
        Set = function(p29) -- Line: 67, Name: Set
            -- upvalues: u1 (copy)
            u1.Cross = p29;
        end,

        Get = function() -- Line: 68, Name: Get
            -- upvalues: u1 (copy)
            return u1.Cross;
        end,

        Update = function(p30) -- Line: 69, Name: Update
            return p30;
        end
    },
    Centered = {
        Set = function(p31) -- Line: 72, Name: Set
            -- upvalues: u1 (copy)
            u1.Centered = p31;
        end,

        Get = function() -- Line: 73, Name: Get
            -- upvalues: u1 (copy)
            return u1.Centered;
        end,

        Update = function(p32) -- Line: 74, Name: Update
            return p32;
        end
    }
};

for i = 0, 3 do
    v33["Reverse" .. i] = {
        Set = function(p34) -- Line: 80, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["Reverse" .. i] = p34;
        end,

        Get = function() -- Line: 81, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["Reverse" .. i];
        end,

        Update = function(p35) -- Line: 82, Name: Update
            return p35;
        end
    };
    local _ = i;
end;

return v33;