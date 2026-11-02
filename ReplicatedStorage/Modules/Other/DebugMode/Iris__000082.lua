-- Decompiled with Potassium's decompiler.

require(script.Types);
local u1 = {};
local u2 = require(script.Internal)(u1);
u1.Disabled = false;
u1.Args = {};
u1.Events = {};

function u1.Init(p3: userdata?, u4: any) -- Line: 72
    -- upvalues: u2 (copy), u1 (copy)
    if u2._started then
        return u1;
    end;

    assert(u2._shutdown == false, "Iris.Init() cannot be called once shutdown.");

    if p3 == nil then
        p3 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
    end;

    if u4 == nil then
        u4 = game:GetService("RunService").Heartbeat;
    end;

    u2.parentInstance = p3;
    u2._started = true;
    u2._generateRootInstance();
    u2._generateSelectionImageObject();

    for _, v in u2._initFunctions do
        v();
    end;

    task.spawn(function() -- Line: 95
        -- upvalues: u4 (ref), u2 (ref)
        if typeof(u4) == "function" then
            while u2._started do
                local v5 = u4();
                u2._cycle(v5);
            end;
        elseif u4 ~= nil and u4 ~= false then
            u2._eventConnection = u4:Connect(function(...) -- Line: 102
                -- upvalues: u2 (ref)
                u2._cycle(...);
            end);
        end;
    end);

    return u1;
end;

function u1.Shutdown() -- Line: 117
    -- upvalues: u2 (copy)
    u2._started = false;
    u2._shutdown = true;

    if u2._eventConnection then
        u2._eventConnection:Disconnect();
    end;

    u2._eventConnection = nil;

    if u2._rootWidget then
        if u2._rootWidget.Instance then
            u2._widgets.Root.Discard(u2._rootWidget);
        end;

        u2._rootInstance = nil;
    end;

    if u2.SelectionImageObject then
        u2.SelectionImageObject:Destroy();
    end;

    for _, v in u2._connections do
        v:Disconnect();
    end;
end;

function u1.Connect(p6: table, p7: function) -- Line: 154
    -- upvalues: u2 (copy)
    if u2._started == false then
        warn("Iris:Connect() was called before calling Iris.Init(); always initialise Iris first.");
    end;

    local u8 = #u2._connectedFunctions + 1;
    u2._connectedFunctions[u8] = p7;

    return function() -- Line: 160
        -- upvalues: u2 (ref), u8 (copy)
        u2._connectedFunctions[u8] = nil;
    end;
end;

function u1.Append(p9: userdata) -- Line: 175
    -- upvalues: u2 (copy)
    local v10 = u2._GetParentWidget();
    local v11;

    if u2._config.Parent then
        v11 = u2._config.Parent;
    else
        v11 = u2._widgets[v10.type].ChildAdded(v10, {
            type = "userInstance"
        });
    end;

    p9.Parent = v11;
end;

function u1.End() -- Line: 213
    -- upvalues: u2 (copy)
    if u2._stackIndex == 1 then
        error("Too many calls to Iris.End().", 2);
    end;

    u2._IDStack[u2._stackIndex] = nil;
    local v12 = u2;
    v12._stackIndex = v12._stackIndex - 1;
end;

function u1.ForceRefresh() -- Line: 238
    -- upvalues: u2 (copy)
    u2._globalRefreshRequested = true;
end;

function u1.UpdateGlobalConfig(p13: table) -- Line: 260
    -- upvalues: u2 (copy), u1 (copy)
    for i, v in p13 do
        u2._rootConfig[i] = v;
    end;

    u1.ForceRefresh();
end;

function u1.PushConfig(p14: table) -- Line: 285
    -- upvalues: u1 (copy), u2 (copy)
    local v15 = u1.State(-1);

    if v15.value == -1 then
        v15:set(p14);
    elseif u2._deepCompare(v15:get(), p14) == false then
        u2._localRefreshActive = true;
        v15:set(p14);
    end;

    u2._config = setmetatable(p14, {
        __index = u2._config
    });
end;

function u1.PopConfig() -- Line: 311
    -- upvalues: u2 (copy)
    u2._localRefreshActive = false;
    u2._config = getmetatable(u2._config).__index;
end;

u1.TemplateConfig = require(script.config);
u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
u1.UpdateGlobalConfig(u1.TemplateConfig.utilityDefault);
u2._globalRefreshRequested = false;

function u1.PushId(p16) -- Line: 341
    -- upvalues: u2 (copy)
    local v17 = typeof(p16) == "string";
    assert(v17, "The ID argument to Iris.PushId() to be a string.");
    u2._pushedId = tostring(p16);
end;

function u1.PopId() -- Line: 353
    -- upvalues: u2 (copy)
    u2._pushedId = nil;
end;

function u1.SetNextWidgetID(p18) -- Line: 379
    -- upvalues: u2 (copy)
    u2._nextWidgetId = p18;
end;

function u1.State(p19) -- Line: 421
    -- upvalues: u2 (copy), u1 (copy)
    local v20 = u2._getID(2);

    if u2._states[v20] then
        return u2._states[v20];
    end;

    u2._states[v20] = {
        ID = v20,
        value = p19,
        lastChangeTick = u1.Internal._cycleTick,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(u2._states[v20], u2.StateClass);

    return u2._states[v20];
end;

function u1.WeakState(p21) -- Line: 446
    -- upvalues: u2 (copy), u1 (copy)
    local v22 = u2._getID(2);

    if u2._states[v22] then
        if next(u2._states[v22].ConnectedWidgets) ~= nil then
            return u2._states[v22];
        end;

        u2._states[v22] = nil;
    end;

    u2._states[v22] = {
        ID = v22,
        value = p21,
        lastChangeTick = u1.Internal._cycleTick,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(u2._states[v22], u2.StateClass);

    return u2._states[v22];
end;

function u1.VariableState(p23: any, p24: function) -- Line: 504
    -- upvalues: u2 (copy), u1 (copy)
    local v25 = u2._getID(2);
    local v26 = u2._states[v25];

    if v26 then
        if p23 ~= v26.value then
            v26:set(p23);
        end;

        return v26;
    end;

    local v27 = {
        ID = v25,
        value = p23,
        lastChangeTick = u1.Internal._cycleTick,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(v27, u2.StateClass);
    u2._states[v25] = v27;
    v27:onChange(p24);

    return v27;
end;

function u1.TableState(u28: table, u29: any, u30: function?) -- Line: 584
    -- upvalues: u2 (copy), u1 (copy)
    local v31 = u28[u29];
    local v32 = u2._getID(2);
    local v33 = u2._states[v32];

    if v33 then
        if v31 ~= v33.value then
            v33:set(v31);
        end;

        return v33;
    end;

    local u34 = {
        ID = v32,
        value = v31,
        lastChangeTick = u1.Internal._cycleTick,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(u34, u2.StateClass);
    u2._states[v32] = u34;
    u34:onChange(function() -- Line: 608
        -- upvalues: u30 (copy), u34 (copy), u28 (copy), u29 (copy)
        if u30 == nil then
            u28[u29] = u34.value;
        elseif u30(u34.value) then
            u28[u29] = u34.value;
        end;
    end);

    return u34;
end;

function u1.ComputedState(p35: any, u36: function) -- Line: 637
    -- upvalues: u2 (copy), u1 (copy)
    local u37 = u2._getID(2);

    if u2._states[u37] then
        return u2._states[u37];
    end;

    u2._states[u37] = {
        ID = u37,
        value = u36(p35.value),
        lastChangeTick = u1.Internal._cycleTick,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    p35:onChange(function(p38: userdata) -- Line: 650
        -- upvalues: u2 (ref), u37 (copy), u36 (copy)
        u2._states[u37]:set(u36(p38));
    end);
    setmetatable(u2._states[u37], u2.StateClass);

    return u2._states[u37];
end;

u1.ShowDemoWindow = require(script.demoWindow)(u1);
require(script.widgets)(u2);
require(script.API)(u1);

return u1;