-- Decompiled with Potassium's decompiler.

local u1 = {
    Tornado = 0,
    TornadoSpeed = 1,
    InfinitePath = 0
};

return {
    Tornado = {
        Set = function(p2) -- Line: 9, Name: Set
            -- upvalues: u1 (copy)
            u1.Tornado = p2;
        end,

        Get = function() -- Line: 10, Name: Get
            -- upvalues: u1 (copy)
            return u1.Tornado;
        end,

        Update = function(p3, p4, p5) -- Line: 11, Name: Update
            -- upvalues: u1 (copy)
            if u1.Tornado == 0 then
                return p3;
            end;

            local v6 = p5.COLUMN % 4 * 1.0471975511965976;
            local v7 = p5.Y_OFFSET / 135 * u1.TornadoSpeed;
            local v8 = (-math.cos(-v6) + 1) * (p5.ARROW_SIZE / 2) * 3;
            local v9 = (-math.cos(v7 - v6) + 1) * (p5.ARROW_SIZE / 2) * 3 - v8;
            p3.x = p3.x + v9 * u1.Tornado;

            return p3;
        end
    },
    TornadoSpeed = {
        Set = function(p10) -- Line: 23, Name: Set
            -- upvalues: u1 (copy)
            u1.TornadoSpeed = p10;
        end,

        Get = function() -- Line: 24, Name: Get
            -- upvalues: u1 (copy)
            return u1.TornadoSpeed;
        end
    },
    InfinitePath = {
        Set = function(p11) -- Line: 27, Name: Set
            -- upvalues: u1 (copy)
            u1.InfinitePath = p11;
        end,

        Get = function() -- Line: 28, Name: Get
            -- upvalues: u1 (copy)
            return u1.InfinitePath;
        end,

        Update = function(p12, p13, p14) -- Line: 29, Name: Update
            -- upvalues: u1 (copy)
            if u1.InfinitePath == 0 then
                return p12;
            end;

            local v15 = p14.Y_OFFSET / 1850 * 3.141592653589793 * 2;
            local v16 = math.sin(v15) * 600 + 640;
            local v17 = math.sin(v15) * math.cos(v15) * 600 + 360;
            local v18 = u1.InfinitePath / 100;
            p12.x = p12.x + (v16 - p12.x) * v18;
            p12.y = p12.y + (v17 - p12.y) * v18;

            return p12;
        end
    }
};