-- Decompiled with Potassium's decompiler.

local u1 = { "__newindex", "__call", "__concat", "__unm", "__add", "__sub", "__mul", "__div", "__idiv", "__mod", "__pow", "__tostring", "__eq", "__lt", "__le", "__mode", "__len", "__iter" };

local function deepcopy(p2: any, p3: table?) -- Line: 24
    -- upvalues: deepcopy (copy)
    local v4 = p3 or {};

    if type(p2) ~= "table" then
        return p2;
    end;

    local v5 = v4[p2];

    if v5 then
        return v5;
    end;

    local v6 = {};
    v4[p2] = v6;

    for i, v in next, p2 do
        v6[i] = deepcopy(v, v4);
    end;

    local v7 = getmetatable(p2);
    setmetatable(v6, v7);

    return v6;
end;

local function getSuper(u8, u9) -- Line: 47
    -- upvalues: getSuper (copy)
    if not u9 then
        return nil;
    end;

    local v10 = getSuper(u8, u9.__extending);
    local u15 = setmetatable({
        __super = u8,
        super = v10
    }, {
        __index = function(p11, p12) -- Line: 54, Name: __index
            -- upvalues: u8 (copy)
            local u13 = u8[p12];

            if type(u13) ~= "function" then
                return u13;
            end;

            local v14 = setmetatable({}, {
                __call = function(...) -- Line: 57, Name: __call
                    -- upvalues: u13 (copy), u8 (ref)
                    return u13(u8, select(3, ...));
                end
            });
            p11[p12] = v14;

            return v14;
        end,

        __newindex = u8
    });

    return setmetatable({
        super = v10
    }, {
        __index = function(p16, p17) -- Line: 70, Name: __index
            -- upvalues: u9 (copy), u15 (copy)
            local u18 = u9[p17];

            if type(u18) ~= "function" then
                return u18;
            end;

            local v19 = setmetatable({}, {
                __call = function(...) -- Line: 73, Name: __call
                    -- upvalues: u18 (copy), u15 (ref)
                    return u18(u15, select(3, ...));
                end
            });
            p16[p17] = v19;

            return v19;
        end
    });
end;

local u20 = {
    getSuper = getSuper
};

function u20.Extend(p21, p22) -- Line: 89
    -- upvalues: deepcopy (copy), u1 (copy), getSuper (copy), u20 (copy)
    local u23 = deepcopy(p22);
    local table_clone_ret = table.clone(u23);
    local u24 = u23.__upperIndex or u23.__index;

    local function u27(p25, p26) -- Line: 100
        -- upvalues: table_clone_ret (copy), u24 (copy)
        return table_clone_ret[p26] or u24(p25, p26);
    end;

    local v28;

    if type(u24) == "function" then
        v28 = u27 or table_clone_ret;
    else
        v28 = table_clone_ret;
    end;

    table_clone_ret.__index = v28;

    for _, v in u1 do
        if u23[v] then
            table_clone_ret[v] = u23[v];
        end;
    end;

    table_clone_ret.__extending = u23;
    local u29 = nil;
    local u30 = u23.constructor or u23.new;

    local function v32(...) -- Line: 119
        -- upvalues: u30 (copy), getSuper (ref), u23 (copy), table_clone_ret (copy)
        local v31 = u30(...);
        v31.super = getSuper(v31, u23);

        return setmetatable(v31, table_clone_ret);
    end;

    local u33 = v32;

    local function u35(...) -- Line: 127
        -- upvalues: u33 (ref), table_clone_ret (copy), u29 (ref)
        local v34 = u33(...);
        v34.__class = table_clone_ret;

        if u29 then
            u29(v34);
        end;

        return v34;
    end;

    local u36 = false;

    local function lockClass() -- Line: 139
        -- upvalues: u36 (ref), u29 (ref), table_clone_ret (copy), u35 (copy), u27 (copy), u24 (copy), u33 (ref)
        if u36 then
            return;
        end;

        u36 = true;
        u29 = table_clone_ret.postCreate or nil;

        if u35 ~= table_clone_ret.new then
            table_clone_ret.constructor = table_clone_ret.new;
            table_clone_ret.new = u35;
        end;

        if type(table_clone_ret.__index) == "function" then
            table_clone_ret.__upperIndex = table_clone_ret.__index == u27 and u24 or table_clone_ret.__index;
        end;

        u33 = table_clone_ret.constructor;
        table.freeze(table_clone_ret);
    end;

    table_clone_ret.constructor = v32;
    table_clone_ret.new = u35;
    table_clone_ret.lock = lockClass;

    function table_clone_ret.Extend(p37) -- Line: 192
        -- upvalues: u20 (ref), table_clone_ret (copy)
        return u20:Extend(table_clone_ret);
    end;

    return table_clone_ret, v32, lockClass, u23;
end;

function u20.newClass() -- Line: 199
    -- upvalues: u20 (copy)
    local v38, _, v39 = u20:Extend({});

    return v38, v39;
end;

return u20;