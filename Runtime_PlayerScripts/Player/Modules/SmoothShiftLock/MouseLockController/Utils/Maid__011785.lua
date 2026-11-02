-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.__newindex() -- Line: 11
    error("Assigning tasks by index is unsupported, please use Maid.GiveTask", 2);
end;

local u8 = {
    ["function"] = function(p2: function) -- Line: 17
        p2();
    end,

    Instance = function(p3: userdata) -- Line: 20
        p3:Destroy();
    end,

    RBXScriptConnection = function(p4: userdata) -- Line: 23
        p4:Disconnect();
    end,

    table = function(p5: table) -- Line: 26
        if type(p5.Destroy) == "function" then
            p5:Destroy();

            return;
        end;

        if type(p5.Disconnect) == "function" then
            p5:Disconnect();
        end;
    end,

    thread = function(u6: thread) -- Line: 33
        local v7;

        if coroutine.running() == u6 then
            v7 = nil;
        else
            v7 = pcall(function() -- Line: 36
                -- upvalues: u6 (copy)
                task.cancel(u6);
            end);
        end;

        if not v7 then
            task.defer(function() -- Line: 43
                -- upvalues: u6 (copy)
                task.cancel(u6);
            end);
        end;
    end
};

function u1.new() -- Line: 51
    -- upvalues: u1 (copy)
    return setmetatable({
        _tasks = {}
    }, u1);
end;

function u1.GiveTask(p9, p10) -- Line: 58
    table.insert(p9._tasks, p10);

    return p10;
end;

function u1.DoCleaning(p11) -- Line: 66
    -- upvalues: u8 (copy), u1 (copy)
    local _tasks = p11._tasks;
    p11._tasks = {};

    for i = 1, #_tasks do
        local v12 = _tasks[i];
        local v13 = u8[typeof(v12)];
        local v14;

        if v13 then
            xpcall(v13, warn, v12);
            v14 = i;
        else
            v14 = i;
        end;
    end;

    if #p11._tasks > 0 then
        u1.DoCleaning(p11);
    end;
end;

u1.Destroy = u1.DoCleaning;

return u1;