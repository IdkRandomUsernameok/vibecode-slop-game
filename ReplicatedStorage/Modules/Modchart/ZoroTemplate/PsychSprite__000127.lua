-- Decompiled with Potassium's decompiler.

local u1 = {
    objects = {}
};

function u1.makeLuaSprite(p2, p3, p4, p5) -- Line: 5
    -- upvalues: u1 (copy)
    u1.objects[p2] = {
        alpha = 1,
        angle = 0,
        zoom = 1,
        x = p4,
        y = p5
    };
end;

function u1.setProperty(p6, p7) -- Line: 15
    -- upvalues: u1 (copy)
    local objects = u1.objects;
    local string_split_ret = string.split(p6, ".");

    if #string_split_ret > 1 then
        for i = 1, #string_split_ret - 1 do
            objects = objects[string_split_ret[i]];
            local _ = i;
        end;
    end;

    objects[string_split_ret[#string_split_ret]] = p7;
end;

function u1.getProperty(p8) -- Line: 28
    -- upvalues: u1 (copy)
    local objects = u1.objects;
    local string_split_ret = string.split(p8, ".");

    if #string_split_ret > 1 then
        for i = 1, #string_split_ret - 1 do
            objects = objects[string_split_ret[i]];
            local _ = i;
        end;
    end;

    return objects[string_split_ret[#string_split_ret]];
end;

return u1;