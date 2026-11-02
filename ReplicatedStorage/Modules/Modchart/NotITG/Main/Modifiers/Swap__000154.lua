-- Decompiled with Potassium's decompiler.

local u1 = {
    Flip = 0,
    Invert = 0,
    OpponentSwap = 0
};

return {
    Flip = {
        Set = function(p2) -- Line: 9, Name: Set
            -- upvalues: u1 (copy)
            u1.Flip = p2;
        end,

        Get = function() -- Line: 10, Name: Get
            -- upvalues: u1 (copy)
            return u1.Flip;
        end,

        Update = function(p3, p4, p5) -- Line: 11, Name: Update
            -- upvalues: u1 (copy)
            if u1.Flip == 0 then
                return p3;
            end;

            p3.x = p3.x + p5.ARROW_SIZE * (2 * (1.5 - p5.COLUMN)) * u1.Flip;

            return p3;
        end
    },
    Invert = {
        Set = function(p6) -- Line: 19, Name: Set
            -- upvalues: u1 (copy)
            u1.Invert = p6;
        end,

        Get = function() -- Line: 20, Name: Get
            -- upvalues: u1 (copy)
            return u1.Invert;
        end,

        Update = function(p7, p8, p9) -- Line: 21, Name: Update
            -- upvalues: u1 (copy)
            if u1.Invert == 0 then
                return p7;
            end;

            p7.x = p7.x + p9.ARROW_SIZE * (p9.COLUMN % 2 == 0 and 1 or -1) * u1.Invert;

            return p7;
        end
    },
    OpponentSwap = {
        Set = function(p10) -- Line: 29, Name: Set
            -- upvalues: u1 (copy)
            u1.OpponentSwap = p10;
        end,

        Get = function() -- Line: 30, Name: Get
            -- upvalues: u1 (copy)
            return u1.OpponentSwap;
        end,

        Update = function(p11, p12, p13) -- Line: 31, Name: Update
            -- upvalues: u1 (copy)
            if u1.OpponentSwap == 0 then
                return p11;
            end;

            p11.x = p11.x + 640 * (p13.STRUMLINE_ID % 2 == 0 and 1 or -1) * u1.OpponentSwap;

            return p11;
        end
    }
};