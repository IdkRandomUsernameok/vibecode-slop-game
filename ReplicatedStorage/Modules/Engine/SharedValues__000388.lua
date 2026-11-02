-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = setmetatable({}, {
    __mode = "k"
});
u2.SF = {};

local function internalAwait(u6, u7, p8, u9) -- Line: 15
    -- upvalues: u2 (copy), u3 (copy)
    local v10 = u2[u6];

    if v10 then
        local v11 = v10[u7];

        if v11 ~= nil then
            if not u9 then
                return v11;
            end;

            task.spawn(u9, v11);

            return;
        end;
    end;

    local u12 = `{u6}_{u7}`;

    if not u3[u12] then
        u3[u12] = {};
    end;

    local u13 = u9 or coroutine.running();
    table.insert(u3[u12], u13);
    local u14 = false;
    task.delay(p8 or 5, function() -- Line: 35
        -- upvalues: u14 (ref), u3 (ref), u12 (copy), u13 (copy), u7 (copy), u6 (copy), u9 (copy)
        if u14 then
            return;
        end;

        local v15 = u3[u12];

        if v15 then
            for i, v in v15 do
                if v == u13 then
                    v15[i] = v15[#v15];
                    table.remove(v15);
                    break;
                end;
            end;
        end;

        warn((`[SharedValues] Await timed out for Key: "{u7}" in Scope: "{u6}"`));

        if u9 then
            task.spawn(u9, nil);

            return;
        end;

        if coroutine.status(u13) ~= "dead" then
            task.spawn(u13, nil);
        end;
    end);

    if not u9 then
        local coroutine_yield_ret = coroutine.yield();
        u14 = true;

        return coroutine_yield_ret;
    end;
end;

function u1.await(p16, p17, p18, p19) -- Line: 65
    -- upvalues: u4 (copy), internalAwait (copy)
    local v20 = "SF";

    for i, v in u4 do
        if v == p16 then
            v20 = i;
            break;
        end;
    end;

    return internalAwait(v20, p17, p18, p19);
end;

function u1.awaitFrom(p21, p22, p23, p24, p25) -- Line: 76
    -- upvalues: internalAwait (copy)
    return internalAwait(p22, p23, p24, p25);
end;

local function sharedIndex(p26: any, p27: string) -- Line: 80
    -- upvalues: u1 (copy), u5 (copy), u2 (copy)
    return rawget(u1, p27) or (u5[p26] or u2.SF)[p27];
end;

local function callNewIndex(p28, p29, p30) -- Line: 88
    -- upvalues: u5 (copy), u2 (copy), u3 (copy), u1 (copy), u4 (copy)
    (u5[p28] or u2.SF)[p29] = p30;

    if next(u3) then
        local v31 = "SF";

        if p28 ~= u1 then
            for i, v in u4 do
                if v == p28 then
                    v31 = i;
                    break;
                end;
            end;
        end;

        local v32 = `{v31}_{p29}`;
        local v33 = u3[v32];

        if v33 then
            u3[v32] = nil;

            for _, v in v33 do
                task.spawn(v, p30);
            end;
        end;
    end;
end;

setmetatable(u1, {
    __index = sharedIndex,
    __newindex = callNewIndex
});

function u1.register(p34: string) -- Line: 119
    -- upvalues: u4 (copy), u2 (copy), sharedIndex (copy), callNewIndex (copy), u5 (copy)
    debug.profilebegin((`SharedRegister::{p34}`));
    local v35 = u4[p34];

    if v35 then
        debug.profileend();

        return v35;
    end;

    if not u2[p34] then
        u2[p34] = {};
    end;

    local v36 = setmetatable({}, {
        __index = sharedIndex,
        __newindex = callNewIndex
    });
    u5[v36] = u2[p34];
    u4[p34] = v36;
    debug.profileend();

    return v36;
end;

return u1;