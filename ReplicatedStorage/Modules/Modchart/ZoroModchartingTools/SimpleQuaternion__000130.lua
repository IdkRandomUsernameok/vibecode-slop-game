-- Decompiled with Potassium's decompiler.

return {
    fromEuler = function(p1: number, p2: number, p3: number) -- Line: 13, Name: fromEuler
        local math_cos_ret = math.cos(p1 * 0.017453292519943295);
        local math_sin_ret = math.sin(p1 * 0.017453292519943295);
        local math_cos_ret2 = math.cos(p2 * 0.017453292519943295);
        local math_sin_ret2 = math.sin(p2 * 0.017453292519943295);
        local math_cos_ret3 = math.cos(p3 * 0.017453292519943295);
        local math_sin_ret3 = math.sin(p3 * 0.017453292519943295);

        return {
            x = 0,
            y = 0,
            z = 0,
            w = 0,
            w = math_cos_ret * math_cos_ret2 * math_cos_ret3 + math_sin_ret * math_sin_ret2 * math_sin_ret3,
            x = math_sin_ret * math_cos_ret2 * math_cos_ret3 - math_cos_ret * math_sin_ret2 * math_sin_ret3,
            y = math_cos_ret * math_sin_ret2 * math_cos_ret3 + math_sin_ret * math_cos_ret2 * math_sin_ret3,
            z = math_cos_ret * math_cos_ret2 * math_sin_ret3 - math_sin_ret * math_sin_ret2 * math_cos_ret3
        };
    end,

    transformVector = function(p4: userdata, p5: table) -- Line: 30, Name: transformVector
        return p4;
    end,

    normalize = function(p6: table) -- Line: 34, Name: normalize
        local math_sqrt_ret = math.sqrt(p6.w * p6.w + p6.x * p6.x + p6.y * p6.y + p6.z * p6.z);
        p6.w = p6.w / math_sqrt_ret;
        p6.x = p6.x / math_sqrt_ret;
        p6.y = p6.y / math_sqrt_ret;
        p6.z = p6.z / math_sqrt_ret;

        return p6;
    end,

    conjugate = function(p7: table) -- Line: 44, Name: conjugate
        p7.y = -p7.y;
        p7.z = -p7.z;
        p7.w = -p7.w;

        return p7;
    end,

    multiply = function(p8: table, p9: table) -- Line: 51, Name: multiply
        local v10 = p8.x * p9.y + p8.y * p9.x + p8.z * p9.w - p8.w * p9.z;
        local v11 = p8.x * p9.z - p8.y * p9.w + p8.z * p9.x + p8.w * p9.y;
        local v12 = p8.x * p9.w + p8.y * p9.z - p8.z * p9.y + p8.w * p9.x;
        p8.x = p8.x * p9.x - p8.y * p9.y - p8.z * p9.z - p8.w * p9.w;
        p8.y = v10;
        p8.z = v11;
        p8.w = v12;

        return p8;
    end
};