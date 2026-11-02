-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local v1 = game.PlaceId == 13042469490 and true or game.PlaceId == 114917403233671;
local u2 = RunService:IsStudio() and true or v1;

local function formatPrefix() -- Line: 8
    local debug_info_ret, v3, _ = debug.info(2, "sl");

    return not debug_info_ret and "[Unknown]" or `[{string.match(debug_info_ret, "[^%./]+$") or debug_info_ret}:{v3}]`;
end;

return {
    log = function(...) -- Line: 18, Name: log
        -- upvalues: u2 (copy)
        if not u2 then
            return;
        end;

        local debug_info_ret, v4, _ = debug.info(2, "sl");

        if debug_info_ret then
            ("[%*:%*]"):format(string.match(debug_info_ret, "[^%./]+$") or debug_info_ret, v4);
        end;

        local debug_info_ret2, v5, _ = debug.info(2, "sl");
        local v6 = not debug_info_ret2 and "[Unknown]" or `[{string.match(debug_info_ret2, "[^%./]+$") or debug_info_ret2}:{v5}]`;
        print(v6, ...);
    end,

    warn = function(...) -- Line: 27, Name: warn
        -- upvalues: u2 (copy)
        if not u2 then
            return;
        end;

        local debug_info_ret, v7, _ = debug.info(2, "sl");
        local v8 = not debug_info_ret and "[Unknown]" or `[{string.match(debug_info_ret, "[^%./]+$") or debug_info_ret}:{v7}]`;
        warn(v8, ...);
    end,

    error = function(...) -- Line: 36, Name: error
        local v9 = {};

        for i = 1, select("#", ...) do
            local v10 = tostring(select(i, ...));
            table.insert(v9, v10);
            local _ = i;
        end;

        local table_concat_ret = table.concat(v9, " ");
        local debug_info_ret, v11, _ = debug.info(2, "sl");
        local v12 = not debug_info_ret and "[Unknown]" or `[{string.match(debug_info_ret, "[^%./]+$") or debug_info_ret}:{v11}]`;
        error(`{v12} {table_concat_ret}`, 2);
    end
};