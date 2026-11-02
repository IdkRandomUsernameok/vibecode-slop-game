-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = nil;

local function RunHandlerInFreeThread(p3: thread, p4: any, p5: function, ...) -- Line: 12
    -- upvalues: u2 (ref)
    local v6 = u2;
    u2 = nil;
    local table_pack_ret = table.pack(p5(...));
    p4.completed = true;
    p4.results = table_pack_ret;

    if p4.yielded then
        task.spawn(p3);
    end;

    u2 = v6;
end;

local function CreateFreeThread() -- Line: 28
    -- upvalues: u2 (ref), RunHandlerInFreeThread (copy)
    u2 = coroutine.running();

    while true do
        RunHandlerInFreeThread(coroutine.yield());
    end;
end;

function u1.new() -- Line: 36
    -- upvalues: u1 (copy)
    return setmetatable({
        _active = true,
        onInvoke = nil,
        OnInvoke = nil
    }, u1);
end;

function u1.Is(p7) -- Line: 44
    -- upvalues: u1 (copy)
    local v8;

    if typeof(p7) == "table" then
        v8 = getmetatable(p7) == u1;
    else
        v8 = false;
    end;

    return v8;
end;

function u1.IsActive(p9) -- Line: 48
    return p9._active == true;
end;

function u1.Invoke(p10, ...) -- Line: 52
    -- upvalues: u2 (ref), CreateFreeThread (copy)
    if p10._active ~= true then
        error("ScriptFunction destroyed", 2);
    end;

    local v11 = p10.onInvoke or p10.OnInvoke;

    if v11 == nil then
        error("ScriptFunction callback not set", 2);
    end;

    if u2 == nil then
        task.spawn(CreateFreeThread);
    end;

    local v12 = {
        completed = false,
        yielded = false,
        results = nil
    };
    task.spawn(u2, coroutine.running(), v12, v11, p10, ...);

    if not v12.completed then
        v12.yielded = true;
        coroutine.yield();
    end;

    return table.unpack(v12.results, 1, v12.results.n);
end;

function u1.Destroy(p13) -- Line: 82
    if p13._active ~= true then
        return;
    end;

    p13._active = false;
    p13.onInvoke = nil;
    p13.OnInvoke = nil;
end;

return u1;