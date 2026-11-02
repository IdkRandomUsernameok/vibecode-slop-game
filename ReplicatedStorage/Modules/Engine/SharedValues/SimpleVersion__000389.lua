-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local v10 = setmetatable({}, {
    __metatable = false,

    __index = function(p3, p4, p5) -- Line: 5, Name: __index
        -- upvalues: u1 (copy)
        return u1;
    end,

    __newindex = function(p6, p7, p8) -- Line: 9, Name: __newindex
        -- upvalues: u1 (copy), u2 (copy)
        u1[p7] = p8;
        local v9 = u2[p7];

        if v9 then
            for _, v in v9 do
                task.spawn(v, p8);
            end;

            u2[p7] = nil;
        end;
    end
});

function v10.await(p11: string) -- Line: 23
    -- upvalues: u1 (copy), u2 (copy)
    local v12 = u1[p11];

    if v12 ~= nil then
        return v12;
    end;

    if not u2[p11] then
        u2[p11] = {};
    end;

    table.insert(u2[p11], coroutine.running());

    return coroutine.yield();
end;

return v10;