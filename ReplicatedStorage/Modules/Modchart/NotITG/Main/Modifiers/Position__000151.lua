-- Decompiled with Potassium's decompiler.

local u1 = 0;
local u2 = 0;

return {
    X = {
        Set = function(p3) -- Line: 6, Name: Set
            -- upvalues: u1 (ref)
            u1 = p3;
        end,

        Get = function() -- Line: 9, Name: Get
            -- upvalues: u1 (ref)
            return u1;
        end,

        Update = function(p4) -- Line: 12, Name: Update
            -- upvalues: u1 (ref)
            p4.x = p4.x + u1;

            return p4;
        end
    },
    Y = {
        Set = function(p5) -- Line: 18, Name: Set
            -- upvalues: u2 (ref)
            u2 = p5;
        end,

        Get = function() -- Line: 21, Name: Get
            -- upvalues: u2 (ref)
            return u2;
        end,

        Update = function(p6) -- Line: 24, Name: Update
            -- upvalues: u2 (ref)
            p6.y = p6.y + u2;

            return p6;
        end
    }
};