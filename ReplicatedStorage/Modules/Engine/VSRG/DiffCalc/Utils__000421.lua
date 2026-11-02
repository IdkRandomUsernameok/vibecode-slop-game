-- Decompiled with Potassium's decompiler.

require("./Types");
require("./Config");

return {
    isSpecialColumn = function(p1: any, p2: number) -- Line: 6, Name: isSpecialColumn
        local v3 = p1.columnRoles[p2];
        local v4;

        if v3 == nil then
            v4 = false;
        else
            v4 = v3 ~= 0;
        end;

        return v4;
    end,

    binarySearch = function(p5: table, p6: number) -- Line: 11, Name: binarySearch
        local v7 = #p5;
        local v8 = 1;

        while v8 <= v7 do
            local math_floor_ret = math.floor((v8 + v7) / 2);

            if p5[math_floor_ret] < p6 then
                v8 = math_floor_ret + 1;
            else
                v7 = math_floor_ret - 1;
            end;
        end;

        return v8;
    end,

    formatValue = function(p9: number) -- Line: 25, Name: formatValue
        local v10 = math.round(p9 * 100) / 100;

        return math.clamp(v10, 0, 100);
    end,

    slideWindows = function(p11: table, p12: number, p13: number, p14: number, p15: function) -- Line: 29, Name: slideWindows
        if p12 <= 0 then
            return;
        end;

        local v16 = #p11;
        local v17 = math.ceil((p12 - p13) / p14) + 1;
        local v18 = 1;
        local v19 = 1;

        for i = 0, math.max(1, v17) - 1 do
            local v20 = i * p14;
            local v21 = v20 + p13;
            local _ = i;

            while v19 <= v16 and p11[v19].time < v20 do
                v19 = v19 + 1;
            end;

            while v18 <= v16 and p11[v18].time <= v21 do
                v18 = v18 + 1;
            end;

            p15(v19, v18, v20, v21);
        end;
    end,

    localActivityRatio = function(p22: table, p23: number, p24: number) -- Line: 59, Name: localActivityRatio
        if not (p22 and (#p22 ~= 0 and p23 > 0)) then
            return 0;
        end;

        local math_ceil_ret = math.ceil(p23 / p24);

        if math_ceil_ret <= 0 then
            return 0;
        end;

        local v25 = 1;
        local v26 = 0;

        for i = 0, math_ceil_ret - 1 do
            local v27 = i * p24;
            local _ = i;

            while v25 <= #p22 and p22[v25].time < v27 do
                v25 = v25 + 1;
            end;

            if v25 <= #p22 and p22[v25].time < v27 + p24 then
                v26 = v26 + 1;
            end;
        end;

        return v26 / math_ceil_ret;
    end,

    chordjackBlend = function(p28: number, p29: number, p30: number) -- Line: 85, Name: chordjackBlend
        return p30 <= p29 and (p29 <= p28 and 1 or 0) or math.clamp((p28 - p29) / (p30 - p29), 0, 1);
    end
};