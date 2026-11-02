-- Decompiled with Potassium's decompiler.

local u1 = {
    Mini = 0,
    MiniX = 0,
    MiniY = 0,
    Squish = 0,
    Stretch = 0,
    ["Mini" .. 0 .. "X"] = 0,
    ["Mini" .. 0 .. "Y"] = 0,
    ["Squish" .. 0] = 0,
    ["Stretch" .. 0] = 0,
    ["Mini" .. 1 .. "X"] = 0,
    ["Mini" .. 1 .. "Y"] = 0,
    ["Squish" .. 1] = 0,
    ["Stretch" .. 1] = 0,
    ["Mini" .. 2 .. "X"] = 0,
    ["Mini" .. 2 .. "Y"] = 0,
    ["Squish" .. 2] = 0,
    ["Stretch" .. 2] = 0,
    ["Mini" .. 3 .. "X"] = 0,
    ["Mini" .. 3 .. "Y"] = 0,
    ["Squish" .. 3] = 0,
    ["Stretch" .. 3] = 0
};

local function lerp(p2, p3, p4) -- Line: 15
    return p2 + (p3 - p2) * p4;
end;

local v16 = {
    Mini = {
        Set = function(p5) -- Line: 19, Name: Set
            -- upvalues: u1 (copy)
            u1.Mini = p5;
        end,

        Get = function() -- Line: 20, Name: Get
            -- upvalues: u1 (copy)
            return u1.Mini;
        end,

        Update = function(p6, p7, p8) -- Line: 21, Name: Update
            -- upvalues: u1 (copy)
            local COLUMN = p8.COLUMN;
            local v9 = 1 + 1 * (u1.Squish + (u1["Squish" .. COLUMN] or 0));
            local v10 = 1 + -0.5 * (u1.Stretch + (u1["Stretch" .. COLUMN] or 0));
            local v11 = (1 - u1.Mini - u1.MiniY - (u1["Mini" .. COLUMN .. "Y"] or 0)) / v9 / v10;
            p6.scaleX = p6.scaleX * math.max((1 - u1.Mini - u1.MiniX - (u1["Mini" .. COLUMN .. "X"] or 0)) * v9 * v10, 0);
            p6.scaleY = p6.scaleY * math.max(v11, 0);

            return p6;
        end
    },
    MiniX = {
        Set = function(p12) -- Line: 38, Name: Set
            -- upvalues: u1 (copy)
            u1.MiniX = p12;
        end,

        Get = function() -- Line: 39, Name: Get
            -- upvalues: u1 (copy)
            return u1.MiniX;
        end
    },
    MiniY = {
        Set = function(p13) -- Line: 42, Name: Set
            -- upvalues: u1 (copy)
            u1.MiniY = p13;
        end,

        Get = function() -- Line: 43, Name: Get
            -- upvalues: u1 (copy)
            return u1.MiniY;
        end
    },
    Squish = {
        Set = function(p14) -- Line: 46, Name: Set
            -- upvalues: u1 (copy)
            u1.Squish = p14;
        end,

        Get = function() -- Line: 47, Name: Get
            -- upvalues: u1 (copy)
            return u1.Squish;
        end
    },
    Stretch = {
        Set = function(p15) -- Line: 50, Name: Set
            -- upvalues: u1 (copy)
            u1.Stretch = p15;
        end,

        Get = function() -- Line: 51, Name: Get
            -- upvalues: u1 (copy)
            return u1.Stretch;
        end
    }
};

for i = 0, 3 do
    v16["Mini" .. i .. "X"] = {
        Set = function(p17) -- Line: 57, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["Mini" .. i .. "X"] = p17;
        end,

        Get = function() -- Line: 58, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["Mini" .. i .. "X"];
        end,

        Update = function(p18) -- Line: 59, Name: Update
            return p18;
        end
    };
    v16["Mini" .. i .. "Y"] = {
        Set = function(p19) -- Line: 62, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["Mini" .. i .. "Y"] = p19;
        end,

        Get = function() -- Line: 63, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["Mini" .. i .. "Y"];
        end,

        Update = function(p20) -- Line: 64, Name: Update
            return p20;
        end
    };
    v16["Squish" .. i] = {
        Set = function(p21) -- Line: 67, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["Squish" .. i] = p21;
        end,

        Get = function() -- Line: 68, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["Squish" .. i];
        end,

        Update = function(p22) -- Line: 69, Name: Update
            return p22;
        end
    };
    v16["Stretch" .. i] = {
        Set = function(p23) -- Line: 72, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["Stretch" .. i] = p23;
        end,

        Get = function() -- Line: 73, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["Stretch" .. i];
        end,

        Update = function(p24) -- Line: 74, Name: Update
            return p24;
        end
    };
    local _ = i;
end;

return v16;