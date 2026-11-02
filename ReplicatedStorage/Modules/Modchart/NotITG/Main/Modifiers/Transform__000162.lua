-- Decompiled with Potassium's decompiler.

local u1 = {
    TransformX = 0,
    TransformY = 0,
    TransformZ = 0,
    FieldY = 0,
    FieldRoll = 0,
    ["Transform" .. 0 .. "X"] = 0,
    ["Transform" .. 0 .. "Y"] = 0,
    ["Transform" .. 0 .. "Z"] = 0,
    ["Transform" .. 1 .. "X"] = 0,
    ["Transform" .. 1 .. "Y"] = 0,
    ["Transform" .. 1 .. "Z"] = 0,
    ["Transform" .. 2 .. "X"] = 0,
    ["Transform" .. 2 .. "Y"] = 0,
    ["Transform" .. 2 .. "Z"] = 0,
    ["Transform" .. 3 .. "X"] = 0,
    ["Transform" .. 3 .. "Y"] = 0,
    ["Transform" .. 3 .. "Z"] = 0
};
local v16 = {
    TransformX = {
        Set = function(p2) -- Line: 16, Name: Set
            -- upvalues: u1 (copy)
            u1.TransformX = p2;
        end,

        Get = function() -- Line: 17, Name: Get
            -- upvalues: u1 (copy)
            return u1.TransformX;
        end,

        Update = function(p3, p4, p5) -- Line: 18, Name: Update
            -- upvalues: u1 (copy)
            p3.x = p3.x + (u1.TransformX + (u1["Transform" .. p5.COLUMN .. "X"] or 0));

            return p3;
        end
    },
    TransformY = {
        Set = function(p6) -- Line: 24, Name: Set
            -- upvalues: u1 (copy)
            u1.TransformY = p6;
        end,

        Get = function() -- Line: 25, Name: Get
            -- upvalues: u1 (copy)
            return u1.TransformY;
        end,

        Update = function(p7, p8, p9) -- Line: 26, Name: Update
            -- upvalues: u1 (copy)
            p7.y = p7.y + (u1.TransformY + (u1["Transform" .. p9.COLUMN .. "Y"] or 0));

            return p7;
        end
    },
    TransformZ = {
        Set = function(p10) -- Line: 32, Name: Set
            -- upvalues: u1 (copy)
            u1.TransformZ = p10;
        end,

        Get = function() -- Line: 33, Name: Get
            -- upvalues: u1 (copy)
            return u1.TransformZ;
        end,

        Update = function(p11) -- Line: 34, Name: Update
            return p11;
        end
    },
    FieldY = {
        Set = function(p12) -- Line: 37, Name: Set
            -- upvalues: u1 (copy)
            u1.FieldY = p12;
        end,

        Get = function() -- Line: 38, Name: Get
            -- upvalues: u1 (copy)
            return u1.FieldY;
        end,

        Update = function(p13) -- Line: 39, Name: Update
            -- upvalues: u1 (copy)
            p13.y = p13.y + u1.FieldY;

            return p13;
        end
    },
    FieldRoll = {
        Set = function(p14) -- Line: 45, Name: Set
            -- upvalues: u1 (copy)
            u1.FieldRoll = p14;
        end,

        Get = function() -- Line: 46, Name: Get
            -- upvalues: u1 (copy)
            return u1.FieldRoll;
        end,

        Update = function(p15) -- Line: 47, Name: Update
            -- upvalues: u1 (copy)
            p15.angle = p15.angle + u1.FieldRoll;

            return p15;
        end
    }
};

for i = 0, 3 do
    v16["Transform" .. i .. "X"] = {
        Set = function(p17) -- Line: 56, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["Transform" .. i .. "X"] = p17;
        end,

        Get = function() -- Line: 57, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["Transform" .. i .. "X"];
        end,

        Update = function(p18) -- Line: 58, Name: Update
            return p18;
        end
    };
    v16["Transform" .. i .. "Y"] = {
        Set = function(p19) -- Line: 61, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["Transform" .. i .. "Y"] = p19;
        end,

        Get = function() -- Line: 62, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["Transform" .. i .. "Y"];
        end,

        Update = function(p20) -- Line: 63, Name: Update
            return p20;
        end
    };
    v16["Transform" .. i .. "Z"] = {
        Set = function(p21) -- Line: 66, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["Transform" .. i .. "Z"] = p21;
        end,

        Get = function() -- Line: 67, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["Transform" .. i .. "Z"];
        end,

        Update = function(p22) -- Line: 68, Name: Update
            return p22;
        end
    };
    local _ = i;
end;

return v16;