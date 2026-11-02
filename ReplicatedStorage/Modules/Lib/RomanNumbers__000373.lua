-- Decompiled with Potassium's decompiler.

local u1 = {
    I = 1,
    V = 5,
    X = 10,
    L = 50,
    C = 100,
    D = 500,
    M = 1000
};
local u2 = { 1, 5, 10, 50, 100, 500, 1000 };
local u3 = { "I", "V", "X", "L", "C", "D", "M" };

return {
    ToRomanNumerals = function(p4) -- Line: 17, Name: ToRomanNumerals
        -- upvalues: u2 (copy), u3 (copy)
        local v5 = tonumber(p4);

        if not v5 or v5 ~= v5 then
            error("Unable to convert to number");
        end;

        if v5 == (1 / 0) then
            error("Unable to convert infinity");
        end;

        local math_floor_ret = math.floor(v5);

        if math_floor_ret <= 0 then
            return math_floor_ret;
        end;

        local v6 = "";

        for i = #u2, 1, -1 do
            local v7 = u2[i];
            local v8 = i;

            while math_floor_ret - v7 >= 0 and math_floor_ret > 0 do
                v6 = v6 .. u3[v8];
                math_floor_ret = math_floor_ret - v7;
            end;

            for i2 = 1, v8 - 1 do
                local v9 = u2[i2];

                if math_floor_ret - (v7 - v9) >= 0 and (math_floor_ret < v7 and (math_floor_ret > 0 and v7 - v9 ~= v9)) then
                    v6 = v6 .. u3[i2] .. u3[v8];
                    math_floor_ret = math_floor_ret - (v7 - v9);
                    break;
                end;

                local _ = i2;
            end;
        end;

        return v6;
    end,

    ToNumber = function(p10) -- Line: 44, Name: ToNumber
        -- upvalues: u1 (copy)
        local v11 = p10:upper();
        local v12 = 1;
        local v13 = 0;

        while v12 <= v11:len() do
            local v14 = v11:sub(v12, v12);

            if v14 ~= " " then
                local v15 = u1[v14] or error("Unknown Roman Numeral \'" .. v14 .. "\'");
                local v16 = v11:sub(v12 + 1, v12 + 1);
                local v17 = u1[v16];

                if v16 and v17 then
                    if v15 < v17 then
                        v13 = v13 + (v17 - v15);
                        v12 = v12 + 1;
                    else
                        v13 = v13 + v15;
                    end;
                else
                    v13 = v13 + v15;
                end;
            end;

            v12 = v12 + 1;
        end;

        return v13;
    end
};