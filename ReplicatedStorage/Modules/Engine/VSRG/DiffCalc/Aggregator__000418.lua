-- Decompiled with Potassium's decompiler.

local u1 = require("./Config");

return {
    compute = function(p2: table) -- Line: 5, Name: compute
        -- upvalues: u1 (copy)
        local v3 = {};

        for _, v in pairs(p2) do
            table.insert(v3, v);
        end;

        table.sort(v3, function(p4, p5) -- Line: 11
            return p5 < p4;
        end);

        if #v3 == 0 then
            return 0;
        end;

        local v6 = v3[1];
        local v7 = 0;
        local v8 = 0;

        for i = 1, #v3 do
            local v9 = u1.RANK_DECAY ^ (i - 1) * (v6 > 0 and (v3[i] / v6 or 0) or 0) ^ u1.RANK_RELEVANCE_EXPONENT;
            v7 = v7 + v9;
            v8 = v8 + v3[i] * v9;
            local _ = i;
        end;

        if v7 == 0 then
            return v6;
        end;

        return v8 / v7;
    end
};