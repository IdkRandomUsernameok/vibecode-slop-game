-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local Signal = require(Modules.Lib.Signal);

function u1.new() -- Line: 16
    -- upvalues: Signal (copy), u1 (copy)
    local u2 = {};
    local u3 = {};
    local v4 = {
        _calls = u2,
        _registeredFuncs = u3,
        isCloned = {},
        scripts = {},
        aliases = {},
        onError = Signal.new(),
        onPreAdd = Signal.new(),
        onAdd = Signal.new(),
        onRemove = Signal.new()
    };
    local u5 = setmetatable(v4, u1);

    local function u7(p6) -- Line: 35
        -- upvalues: u5 (copy)
        u5.onError:Fire(p6);
    end;

    function u5.call(p8: table, p9: string, ...) -- Line: 40
        -- upvalues: u2 (copy), u7 (copy)
        local v10 = u2[p9];

        if not v10 then
            return;
        end;

        for _, v in v10 do
            xpcall(v, u7, ...);
        end;
    end;

    function u5.singleCall(p11: table, p12: table, p13: string, ...) -- Line: 49
        -- upvalues: u3 (copy), u7 (copy)
        local v14 = u3[p12];
        local v15;

        if v14 then
            v15 = v14[p13] or nil;
        else
            v15 = nil;
        end;

        if v15 then
            for _, v in v15 do
                xpcall(v, u7, ...);
            end;

            return;
        end;

        local v16 = p12[p13];

        if not v16 then
            return;
        end;

        xpcall(v16, u7, ...);
    end;

    return u5;
end;

function u1.defineAliases(p17: table, p18: table) -- Line: 69
    local v19 = {};

    for i, v in p18 do
        local v20 = i;

        for _, v2 in v do
            v19[v2] = v20;
        end;
    end;

    p17.aliases = v19;
end;

function u1.mapScript(p21: table, p22: table) -- Line: 81
    local _calls = p21._calls;
    local aliases = p21.aliases;
    local v23 = {};

    for i, v in p22 do
        if type(i) == "string" and type(v) == "function" then
            local v24 = aliases[i] or i;
            local v25 = _calls[v24];

            if v25 then
                table.insert(v25, v);
            else
                _calls[v24] = { v };
            end;

            local v26 = v23[v24];

            if v26 then
                table.insert(v26, v);
            else
                v23[v24] = { v };
            end;
        else
            print(i, type(i), v, (type(v)));
        end;
    end;

    p21._registeredFuncs[p22] = v23;
end;

function u1.add(p27: table, p28: any, p29: boolean?) -- Line: 111
    if p28 then
        local v30;

        if typeof(p28) == "Instance" then
            if p29 then
                v30 = p28;
            else
                v30 = p28:Clone() or p28;
            end;
        else
            v30 = p28;
        end;

        if typeof(v30) == "Instance" and v30 ~= p28 then
            p27.isCloned[v30] = true;
        end;

        p27.onPreAdd:Fire(v30);
        local v31 = type(v30) == "table" and v30 and v30 or require(v30);
        p27.scripts[v30] = v31;
        p27:mapScript(v31);
        p27.onAdd:Fire(v30, v31);

        return v31, v30;
    end;
end;

function u1.remove(p32, p33) -- Line: 135
    if not p33 then
        return;
    end;

    local v34 = p32.scripts[p33];

    if not v34 then
        return;
    end;

    p32.onRemove:Fire(p33, v34);

    if p32.isCloned[p33] then
        p33:Destroy();
    end;

    local v35 = p32._registeredFuncs[v34];

    if v35 then
        for i, v in v35 do
            local v36 = p32._calls[i];

            if v36 then
                for _, v2 in v do
                    local table_find_ret = table.find(v36, v2);

                    if table_find_ret then
                        table.remove(v36, table_find_ret);
                    end;
                end;
            end;
        end;

        p32._registeredFuncs[v34] = nil;
    end;

    p32.scripts[p33] = nil;
end;

function u1.getModule(p37, p38) -- Line: 167
    return p37.scripts[p38];
end;

function u1.removeAll(p39) -- Line: 171
    for i, _ in p39.scripts do
        p39:remove(i);
    end;

    table.clear(p39.scripts);
    table.clear(p39._calls);
end;

function u1.stats(p40) -- Line: 180
    local v41 = 0;
    local v42 = {};

    for _, _ in p40.scripts do
        v41 = v41 + 1;
    end;

    v42.scripts = v41;
    local v43 = 0;
    local v44 = 0;

    for _, v in p40._calls do
        v43 = v43 + 1;
        v44 = v44 + #v;
    end;

    v42.calls = v43;
    v42.callsRegistered = v44;

    return v42;
end;

return u1;