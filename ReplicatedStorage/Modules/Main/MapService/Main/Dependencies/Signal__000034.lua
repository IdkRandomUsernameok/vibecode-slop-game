-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = {};
u2.__index = u2;
local u3 = nil;

local function RunHandlerInFreeThread(p4, ...) -- Line: 50
    -- upvalues: u3 (ref)
    local v5 = u3;
    u3 = nil;
    p4(...);
    u3 = v5;
end;

local function CreateFreeThread() -- Line: 59
    -- upvalues: u3 (ref), RunHandlerInFreeThread (copy)
    u3 = coroutine.running();

    while true do
        RunHandlerInFreeThread(coroutine.yield());
    end;
end;

function u1.new() -- Line: 73
    -- upvalues: u1 (copy)
    return setmetatable({
        _active = true,
        _head = nil
    }, u1);
end;

function u1.Is(p6) -- Line: 95
    -- upvalues: u1 (copy)
    local v7;

    if typeof(p6) == "table" then
        v7 = getmetatable(p6) == u1;
    else
        v7 = false;
    end;

    return v7;
end;

function u1.IsActive(p8) -- Line: 112
    return p8._active == true;
end;

function u1.Connect(p9: table, p10: function) -- Line: 134
    -- upvalues: u2 (copy)
    local v11 = typeof(p10) == "function";
    assert(v11, "Must be function");

    if p9._active ~= true then
        return setmetatable({
            Connected = false,
            _node = nil
        }, u2);
    end;

    local _head = p9._head;
    local v12 = {
        _connection = nil,
        _prev = nil,
        _signal = p9,
        _handler = p10,
        _next = _head
    };

    if _head ~= nil then
        _head._prev = v12;
    end;

    p9._head = v12;
    local v13 = setmetatable({
        Connected = true,
        _node = v12
    }, u2);
    v12._connection = v13;

    return v13;
end;

function u1.ConnectOnce(p14: table, u15: function) -- Line: 195
    local v16 = typeof(u15) == "function";
    assert(v16, "Must be function");
    local u17 = nil;
    u17 = p14:Connect(function(...) -- Line: 204
        -- upvalues: u17 (ref), u15 (copy)
        u17:Disconnect();
        u15(...);
    end);
end;

u1.Once = u1.ConnectOnce;

function u1.Wait(p18) -- Line: 230
    local coroutine_running_ret = coroutine.running();
    local u19 = nil;
    u19 = p18:Connect(function(...) -- Line: 235
        -- upvalues: u19 (ref), coroutine_running_ret (ref)
        u19:Disconnect();
        task.spawn(coroutine_running_ret, ...);
    end);

    return coroutine.yield();
end;

function u1.Fire(p20, ...) -- Line: 260
    -- upvalues: u3 (ref), CreateFreeThread (copy)
    local _head = p20._head;

    while _head ~= nil do
        if _head._connection ~= nil then
            if u3 == nil then
                task.spawn(CreateFreeThread);
            end;

            task.spawn(u3, _head._handler, ...);
        end;

        _head = _head._next;
    end;
end;

function u1.DisconnectAll(p21) -- Line: 291
    local _head = p21._head;

    while _head ~= nil do
        local _connection = _head._connection;

        if _connection ~= nil then
            _connection.Connected = false;
            _connection._node = nil;
            _head._connection = nil;
        end;

        _head = _head._next;
    end;

    p21._head = nil;
end;

function u1.Destroy(p22) -- Line: 320
    if p22._active ~= true then
        return;
    end;

    p22:DisconnectAll();
    p22._active = false;
end;

function u2.Disconnect(p23) -- Line: 343
    if p23.Connected ~= true then
        return;
    end;

    p23.Connected = false;
    local _node = p23._node;
    local _prev = _node._prev;
    local _next = _node._next;

    if _next ~= nil then
        _next._prev = _prev;
    end;

    if _prev == nil then
        _node._signal._head = _next;
    else
        _prev._next = _next;
    end;

    _node._connection = nil;
    p23._node = nil;
end;

u2.destroy = u2.Disconnect;
u2.Destroy = u2.Disconnect;
u2.disconnect = u2.Disconnect;
u1.destroy = u1.Destroy;
u1.Disconnect = u1.Destroy;
u1.disconnect = u1.Destroy;
u1.connect = u1.Connect;
u1.wait = u1.Wait;
u1.fire = u1.Fire;

return u1;