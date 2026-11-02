-- Decompiled with Potassium's decompiler.

return {
    getParametersFromString = function(p1) -- Line: 3, Name: getParametersFromString
        local v2 = 1;
        local v3 = {};
        local v4 = {};

        while true do
            local string_find_ret = string.find(p1, "{", v2, true);

            if not string_find_ret then
                break;
            end;

            local string_find_ret2 = string.find(p1, "}", string_find_ret, true);

            if not string_find_ret2 then
                warn("What in the sigma");
                break;
            end;

            local v5 = string.sub(p1, string_find_ret + 1, string_find_ret2 - 1):split(":")[1];
            local string_sub_ret = string.sub(p1, v2, string_find_ret - 1);
            table.insert(v3, string_sub_ret);
            local v6 = `\{{v5}}`;
            table.insert(v3, v6);
            v4[v5] = #v3;
            v2 = string_find_ret2 + 1;
        end;

        local string_sub_ret = string.sub(p1, v2);
        table.insert(v3, string_sub_ret);

        return {
            content = v3,
            params = v4
        };
    end,

    Format = function(p7, p8) -- Line: 32, Name: Format
        local content = p7.content;

        for i, v in p7.params do
            local v9 = p8[i];

            if v9 then
                content[v] = v9;
            end;
        end;

        return table.concat(content);
    end
};