-- Decompiled with Potassium's decompiler.

return {
    stringToCamelCase = function(p1: string) -- Line: 2, Name: stringToCamelCase
        local string_gsub_ret = string.gsub(p1, "(%u)", " %1");
        local string_sub_ret = string.sub(string_gsub_ret, 2, -1);
        local v2 = "";

        for i, v in string.split(string_sub_ret, " ") do
            if i == 1 then
                v2 = v2 .. v:lower();
            else
                v2 = v2 .. string.upper((string.sub(v, 1, 1))) .. string.sub(v, 2, -1);
            end;
        end;

        return v2;
    end,

    firstToUpper = function(p3: string) -- Line: 18, Name: firstToUpper
        return string.upper((string.sub(p3, 1, 1))) .. string.sub(p3, 2, -1);
    end,

    firstToLower = function(p4: string) -- Line: 21, Name: firstToLower
        return string.lower((string.sub(p4, 1, 1))) .. string.sub(p4, 2, -1);
    end
};