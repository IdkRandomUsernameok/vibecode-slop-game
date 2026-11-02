-- Decompiled with Potassium's decompiler.

local u1 = {
    RotateX = 0,
    RotateY = 0,
    RotateZ = 0,
    ["Rotate" .. 0 .. "X"] = 0,
    ["Rotate" .. 0 .. "Y"] = 0,
    ["Rotate" .. 0 .. "Z"] = 0,
    ["Rotate" .. 1 .. "X"] = 0,
    ["Rotate" .. 1 .. "Y"] = 0,
    ["Rotate" .. 1 .. "Z"] = 0,
    ["Rotate" .. 2 .. "X"] = 0,
    ["Rotate" .. 2 .. "Y"] = 0,
    ["Rotate" .. 2 .. "Z"] = 0,
    ["Rotate" .. 3 .. "X"] = 0,
    ["Rotate" .. 3 .. "Y"] = 0,
    ["Rotate" .. 3 .. "Z"] = 0
};

local function rotate2D(p2, p3, p4) -- Line: 14
    local math_rad_ret = math.rad(p4);
    local math_cos_ret = math.cos(math_rad_ret);
    local math_sin_ret = math.sin(math_rad_ret);

    return p2 * math_cos_ret - p3 * math_sin_ret, p2 * math_sin_ret + p3 * math_cos_ret;
end;

local function rotateV3(p5, p6, p7, p8, p9, p10) -- Line: 20
    local math_rad_ret = math.rad(p10);
    local math_cos_ret = math.cos(math_rad_ret);
    local math_sin_ret = math.sin(math_rad_ret);
    local v11 = p5 * math_cos_ret - p6 * math_sin_ret;
    local v12 = p5 * math_sin_ret + p6 * math_cos_ret;
    local math_rad_ret2 = math.rad(p8);
    local math_cos_ret2 = math.cos(math_rad_ret2);
    local math_sin_ret2 = math.sin(math_rad_ret2);
    local v13 = p7 * math_cos_ret2 - v12 * math_sin_ret2;
    local math_rad_ret3 = math.rad(p9);
    local math_cos_ret3 = math.cos(math_rad_ret3);
    local math_sin_ret3 = math.sin(math_rad_ret3);

    return v11 * math_cos_ret3 - v13 * math_sin_ret3, p7 * math_sin_ret2 + v12 * math_cos_ret2, v11 * math_sin_ret3 + v13 * math_cos_ret3;
end;

return {
    RotateX = {
        Set = function(p14) -- Line: 29, Name: Set
            -- upvalues: u1 (copy)
            u1.RotateX = p14;
        end,

        Get = function() -- Line: 30, Name: Get
            -- upvalues: u1 (copy)
            return u1.RotateX;
        end,

        Update = function(p15, p16, p17) -- Line: 31, Name: Update
            -- upvalues: u1 (copy)
            local v18 = u1.RotateX + (u1["Rotate" .. p17.COLUMN .. "X"] or 0);
            local v19 = u1.RotateY + (u1["Rotate" .. p17.COLUMN .. "Y"] or 0);
            local v20 = u1.RotateZ + (u1["Rotate" .. p17.COLUMN .. "Z"] or 0);

            if v18 == 0 and (v19 == 0 and v20 == 0) then
                return p15;
            end;

            local v21 = p15.x - 640;
            local v22 = p15.y - 360;
            local v23 = 0 * 720;
            local math_rad_ret = math.rad(v20);
            local math_cos_ret = math.cos(math_rad_ret);
            local math_sin_ret = math.sin(math_rad_ret);
            local v24 = v21 * math_cos_ret - v22 * math_sin_ret;
            local v25 = v21 * math_sin_ret + v22 * math_cos_ret;
            local math_rad_ret2 = math.rad(v18);
            local math_cos_ret2 = math.cos(math_rad_ret2);
            local math_sin_ret2 = math.sin(math_rad_ret2);
            local v26 = v23 * math_cos_ret2 - v25 * math_sin_ret2;
            local math_rad_ret3 = math.rad(v19);
            local math_cos_ret3 = math.cos(math_rad_ret3);
            local math_sin_ret3 = math.sin(math_rad_ret3);
            local _ = (v24 * math_sin_ret3 + v26 * math_cos_ret3) / 720;
            p15.x = 640 + (v24 * math_cos_ret3 - v26 * math_sin_ret3);
            p15.y = 360 + (v23 * math_sin_ret2 + v25 * math_cos_ret2);

            return p15;
        end
    },
    RotateY = {
        Set = function(p27) -- Line: 52, Name: Set
            -- upvalues: u1 (copy)
            u1.RotateY = p27;
        end,

        Get = function() -- Line: 53, Name: Get
            -- upvalues: u1 (copy)
            return u1.RotateY;
        end
    },
    RotateZ = {
        Set = function(p28) -- Line: 56, Name: Set
            -- upvalues: u1 (copy)
            u1.RotateZ = p28;
        end,

        Get = function() -- Line: 57, Name: Get
            -- upvalues: u1 (copy)
            return u1.RotateZ;
        end
    }
};