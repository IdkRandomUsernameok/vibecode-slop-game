-- Decompiled with Potassium's decompiler.

local u1 = {
    Zigzag = 0,
    Square = 0,
    Bounce = 0
};

return {
    Zigzag = {
        Set = function(p2) -- Line: 5, Name: Set
            -- upvalues: u1 (copy)
            u1.Zigzag = p2;
        end,

        Get = function() -- Line: 6, Name: Get
            -- upvalues: u1 (copy)
            return u1.Zigzag;
        end,

        Update = function(p3, p4, p5) -- Line: 7, Name: Update
            -- upvalues: u1 (copy)
            if u1.Zigzag == 0 then
                return p3;
            end;

            local v6 = math.abs(p5.Y_OFFSET) / p5.ARROW_SIZE;
            local v7 = math.floor(v6) % 2 == 0 and 1 or -1;
            p3.x = p3.x + v7 * u1.Zigzag * p5.ARROW_SIZE * 0.5;

            return p3;
        end
    },
    Square = {
        Set = function(p8) -- Line: 16, Name: Set
            -- upvalues: u1 (copy)
            u1.Square = p8;
        end,

        Get = function() -- Line: 17, Name: Get
            -- upvalues: u1 (copy)
            return u1.Square;
        end,

        Update = function(p9, p10, p11) -- Line: 18, Name: Update
            -- upvalues: u1 (copy)
            if u1.Square == 0 then
                return p9;
            end;

            local v12 = math.abs(p11.Y_OFFSET) / p11.ARROW_SIZE;
            local v13 = math.floor(v12) % 2 == 0 and 1 or -1;
            p9.x = p9.x + v13 * u1.Square * p11.ARROW_SIZE;

            return p9;
        end
    },
    Bounce = {
        Set = function(p14) -- Line: 27, Name: Set
            -- upvalues: u1 (copy)
            u1.Bounce = p14;
        end,

        Get = function() -- Line: 28, Name: Get
            -- upvalues: u1 (copy)
            return u1.Bounce;
        end,

        Update = function(p15, p16, p17) -- Line: 29, Name: Update
            -- upvalues: u1 (copy)
            if u1.Bounce == 0 then
                return p15;
            end;

            local y = p15.y;
            local Bounce = u1.Bounce;
            local math_sin_ret = math.sin(p17.Y_OFFSET / p17.ARROW_SIZE * 3.141592653589793);
            p15.y = y + Bounce * math.abs(math_sin_ret) * p17.ARROW_SIZE * 0.5;

            return p15;
        end
    }
};