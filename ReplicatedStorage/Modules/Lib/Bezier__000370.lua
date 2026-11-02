-- Decompiled with Potassium's decompiler.

local function Linear(p1: number) -- Line: 5
    return p1;
end;

return function(u2: number, u3: number, u4: number, u5: number) -- Line: 9, Name: Bezier
    -- upvalues: Linear (copy)
    if not (u2 and (u3 and (u4 and u5))) then
        error("Need 4 numbers to construct a Bezier curve", 0);
    end;

    if u2 < 0 or (u2 > 1 or (u4 < 0 or u4 > 1)) then
        error("The x values must be within range [0, 1]", 0);
    end;

    if u2 == u3 and u4 == u5 then
        return Linear;
    end;

    local u6 = {};

    for i = 0, 10 do
        local v7 = i / 10;
        u6[i] = (((1 - u4 * 3 + u4 * 3) * v7 + (u4 * 3 - u2 * 6)) * v7 + u2 * 3) * v7;
        local _ = i;
    end;

    return function(p8: number) -- Line: 28
        -- upvalues: u6 (copy), u4 (copy), u2 (copy), u5 (copy), u3 (copy)
        if p8 == 0 or p8 == 1 then
            return p8;
        end;

        local v9 = 1;
        local v10 = 0;

        while v9 ~= 10 and u6[v9] <= p8 do
            v10 = v10 + 0.1;
            v9 = v9 + 1;
        end;

        local v11 = v9 - 1;
        local v12 = v10 + (p8 - u6[v11]) / (u6[v11 + 1] - u6[v11]) / 10;
        local v13 = (1 - u4 * 3 + u2 * 3) * 3 * v12 * v12 + (u4 * 3 - u2 * 6) * 2 * v12 + u2 * 3;

        if v13 >= 0.001 then
            for i = 0, 3 do
                v12 = v12 - ((((1 - u4 * 3 + u2 * 3) * v12 + (u4 * 3 - u2 * 6)) * v12 + u2 * 3) * v12 - p8) / ((1 - u4 * 3 + u2 * 3) * 3 * v12 * v12 + (u4 * 3 - u2 * 6) * 2 * v12 + u2 * 3);
                local _ = i;
            end;
        elseif v13 ~= 0 then
            local v14 = v10 + 0.1;
            local v15 = 0;
            local v16 = nil;
            v12 = nil;

            while math.abs(v15) > 1e-7 and v16 < 10 do
                v12 = v10 + (v14 - v10) / 2;
                v15 = (((1 - u4 * 3 + u2 * 3) * v12 + (u4 * 3 - u2 * 6)) * v12 + u2 * 3) * v12 - p8;

                if v15 > 0 then
                    v14 = v12;
                else
                    v10 = v12;
                end;

                v16 = v16 + 1;
            end;
        end;

        return (((1 - u5 * 3 + u3 * 3) * v12 + (u5 * 3 - u3 * 6)) * v12 + u3 * 3) * v12;
    end;
end;