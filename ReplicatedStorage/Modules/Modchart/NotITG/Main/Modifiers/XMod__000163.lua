-- Decompiled with Potassium's decompiler.

local u1 = {
    XMod = 1,
    ["XMod" .. 0] = 1,
    ["XMod" .. 1] = 1,
    ["XMod" .. 2] = 1,
    ["XMod" .. 3] = 1
};
local v6 = {
    XMod = {
        Set = function(p2) -- Line: 6, Name: Set
            -- upvalues: u1 (copy)
            u1.XMod = p2;
        end,

        Get = function() -- Line: 7, Name: Get
            -- upvalues: u1 (copy)
            return u1.XMod;
        end,

        Update = function(p3, p4, p5) -- Line: 8, Name: Update
            -- upvalues: u1 (copy)
            p3.scrollSpeed = u1.XMod * (u1["XMod" .. p5.COLUMN] or 1);

            return p3;
        end
    }
};

for i = 0, 3 do
    v6["XMod" .. i] = {
        Set = function(p7) -- Line: 18, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["XMod" .. i] = p7;
        end,

        Get = function() -- Line: 19, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["XMod" .. i];
        end,

        Update = function(p8) -- Line: 20, Name: Update
            return p8;
        end
    };
    local _ = i;
end;

return v6;