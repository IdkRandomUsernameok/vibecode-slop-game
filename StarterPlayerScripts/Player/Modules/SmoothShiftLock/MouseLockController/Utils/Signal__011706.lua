-- Decompiled with Potassium's decompiler.

local u1 = setmetatable({}, {
    __mode = "kv"
});

local function acquireRunnerThreadAndCallEventHandler(p2, p3, ...) -- Line: 54
    -- upvalues: u1 (copy)
    local v4 = u1[p2];
    u1[p2] = nil;
    p3(...);
    u1[p2] = v4;
end;

local function runEventHandlerInFreeThread(p5) -- Line: 65
    -- upvalues: acquireRunnerThreadAndCallEventHandler (copy)
    if #p5 == 0 then
        debug.setmemorycategory("signal_unknown");
    else
        debug.setmemorycategory(p5);
    end;

    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u6 = {
    ClassName = "Connection"
};
u6.__index = u6;

function u6.new(p7, p8) -- Line: 87
    -- upvalues: u6 (copy)
    local v9 = {
        _memoryCategory = debug.getmemorycategory(),
        _signal = p7,
        _fn = p8
    };

    return setmetatable(v9, u6);
end;

function u6.IsConnected(p10) -- Line: 96
    return rawget(p10, "_signal") ~= nil;
end;

function u6.Disconnect(p11) -- Line: 100
    local v12 = rawget(p11, "_signal");

    if not v12 then
        return;
    end;

    local v13 = rawget(p11, "_next");

    if v12._handlerListHead == p11 then
        v12._handlerListHead = v13 or false;
    else
        local _handlerListHead = v12._handlerListHead;

        while _handlerListHead and rawget(_handlerListHead, "_next") ~= p11 do
            _handlerListHead = rawget(_handlerListHead, "_next");
        end;

        if _handlerListHead then
            rawset(_handlerListHead, "_next", v13);
        end;
    end;

    table.clear(p11);
end;

u6.Destroy = u6.Disconnect;
setmetatable(u6, {
    __index = function(p14, p15) -- Line: 135, Name: __index
        error(string.format("Attempt to get Connection::%s (not a valid member)", (tostring(p15))), 2);
    end,

    __newindex = function(p16, p17, p18) -- Line: 138, Name: __newindex
        error(string.format("Attempt to set Connection::%s (not a valid member)", (tostring(p17))), 2);
    end
});
local u19 = {
    ClassName = "Signal"
};
u19.__index = u19;

function u19.new() -- Line: 152
    -- upvalues: u19 (copy)
    return setmetatable({
        _handlerListHead = false
    }, u19);
end;

function u19.isSignal(p20) -- Line: 164
    -- upvalues: u19 (copy)
    local v21;

    if type(p20) == "table" then
        v21 = getmetatable(p20) == u19;
    else
        v21 = false;
    end;

    return v21;
end;

function u19.Connect(p22, p23) -- Line: 175
    -- upvalues: u6 (copy)
    local v24 = u6.new(p22, p23);

    if not p22._handlerListHead then
        p22._handlerListHead = v24;

        return v24;
    end;

    rawset(v24, "_next", p22._handlerListHead);
    p22._handlerListHead = v24;

    return v24;
end;

function u19.DisconnectAll(p25) -- Line: 194
    p25._handlerListHead = false;
end;

function u19.Fire(p26, ...) -- Line: 210
    -- upvalues: u1 (copy), runEventHandlerInFreeThread (copy)
    local _handlerListHead = p26._handlerListHead;

    while _handlerListHead do
        local v27 = rawget(_handlerListHead, "_next");

        if rawget(_handlerListHead, "_signal") == nil then
            _handlerListHead = v27;
        else
            local _memoryCategory = _handlerListHead._memoryCategory;

            if not u1[_memoryCategory] then
                u1[_memoryCategory] = coroutine.create(runEventHandlerInFreeThread);
                coroutine.resume(u1[_memoryCategory], _memoryCategory);
            end;

            task.spawn(u1[_memoryCategory], _memoryCategory, _handlerListHead._fn, ...);
            _handlerListHead = v27;
        end;
    end;
end;

function u19.Wait(p28) -- Line: 245
    local coroutine_running_ret = coroutine.running();
    local u29 = nil;
    u29 = p28:Connect(function(...) -- Line: 249
        -- upvalues: u29 (ref), coroutine_running_ret (copy)
        u29:Disconnect();
        task.spawn(coroutine_running_ret, ...);
    end);

    return coroutine.yield();
end;

function u19.Once(p30, u31) -- Line: 268
    local u32 = nil;
    u32 = p30:Connect(function(...) -- Line: 270
        -- upvalues: u32 (ref), u31 (copy)
        u32:Disconnect();
        u31(...);
    end);

    return u32;
end;

u19.Destroy = u19.DisconnectAll;
setmetatable(u19, {
    __index = function(p33, p34) -- Line: 287, Name: __index
        error(string.format("Attempt to get Signal::%s (not a valid member)", (tostring(p34))), 2);
    end,

    __newindex = function(p35, p36, p37) -- Line: 290, Name: __newindex
        error(string.format("Attempt to set Signal::%s (not a valid member)", (tostring(p36))), 2);
    end
});

return u19;