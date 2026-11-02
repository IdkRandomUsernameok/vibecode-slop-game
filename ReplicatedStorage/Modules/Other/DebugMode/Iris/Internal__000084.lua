-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
require(script.Parent.Types);

return function(u1) -- Line: 5
    -- upvalues: HttpService (copy)
    local u2 = {
        _version = " 2.4.1 ",
        _started = false,
        _shutdown = false,
        _cycleTick = 0,
        _deltaTime = 0,
        _globalRefreshRequested = false,
        _localRefreshActive = false,
        _widgets = {},
        _stackIndex = 1,
        _rootInstance = nil
    };
    u2._rootWidget = {
        ID = "R",
        type = "Root",
        ZIndex = 0,
        ZOffset = 0,
        Instance = u2._rootInstance
    };
    u2._lastWidget = u2._rootWidget;
    u2._rootConfig = {};
    u2._config = u2._rootConfig;
    u2._IDStack = { "R" };
    u2._usedIDs = {};
    u2._pushedId = nil;
    u2._nextWidgetId = nil;
    u2._states = {};
    u2._postCycleCallbacks = {};
    u2._connectedFunctions = {};
    u2._connections = {};
    u2._initFunctions = {};
    u2._fullErrorTracebacks = game:GetService("RunService"):IsStudio();
    u2._cycleCoroutine = coroutine.create(function() -- Line: 72
        -- upvalues: u2 (copy)
        while u2._started do
            for _, v in u2._connectedFunctions do
                debug.profilebegin("Iris/Connection");
                local success, result = pcall(v);
                debug.profileend();

                if not success then
                    u2._stackIndex = 1;
                    coroutine.yield(false, result);
                end;
            end;

            coroutine.yield(true);
        end;
    end);
    local v3 = {};
    v3.__index = v3;

    function v3.get(p4) -- Line: 130
        return p4.value;
    end;

    function v3.set(p5: table, p6: any, p7: boolean?) -- Line: 143
        -- upvalues: u1 (copy), u2 (copy)
        if p6 == p5.value and p7 ~= true then
            return p5.value;
        end;

        p5.value = p6;
        p5.lastChangeTick = u1.Internal._cycleTick;

        for _, v in p5.ConnectedWidgets do
            u2._widgets[v.type].UpdateState(v);
        end;

        for _, v in p5.ConnectedFunctions do
            v(p6);
        end;

        return p5.value;
    end;

    function v3.onChange(u8: table, p9: function) -- Line: 173
        local u10 = #u8.ConnectedFunctions + 1;
        u8.ConnectedFunctions[u10] = p9;

        return function() -- Line: 176
            -- upvalues: u8 (copy), u10 (copy)
            u8.ConnectedFunctions[u10] = nil;
        end;
    end;

    function v3.changed(p11) -- Line: 188
        -- upvalues: u2 (copy)
        return p11.lastChangeTick + 1 == u2._cycleTick;
    end;

    u2.StateClass = v3;

    function u2._cycle(p12: number) -- Line: 206
        -- upvalues: u1 (copy), u2 (copy)
        if u1.Disabled then
            return;
        end;

        u2._rootWidget.lastCycleTick = u2._cycleTick;

        if u2._rootInstance == nil or u2._rootInstance.Parent == nil then
            u1.ForceRefresh();
        end;

        for _, v in u2._lastVDOM do
            if v.lastCycleTick ~= u2._cycleTick and v.lastCycleTick ~= -1 then
                u2._DiscardWidget(v);
            end;
        end;

        setmetatable(u2._lastVDOM, {
            __mode = "kv"
        });
        u2._lastVDOM = u2._VDOM;
        u2._VDOM = u2._generateEmptyVDOM();
        task.spawn(function() -- Line: 232
            -- upvalues: u2 (ref)
            for _, v in u2._postCycleCallbacks do
                v();
            end;
        end);

        if u2._globalRefreshRequested then
            u2._generateSelectionImageObject();
            u2._globalRefreshRequested = false;

            for _, v in u2._lastVDOM do
                u2._DiscardWidget(v);
            end;

            u2._generateRootInstance();
            u2._lastVDOM = u2._generateEmptyVDOM();
        end;

        local v13 = u2;
        v13._cycleTick = v13._cycleTick + 1;
        u2._deltaTime = p12;
        table.clear(u2._usedIDs);

        if (u2.parentInstance:IsA("GuiBase2d") or u2.parentInstance:IsA("CoreGui") or (u2.parentInstance:IsA("PluginGui") or u2.parentInstance:IsA("PlayerGui"))) == false then
            error("The Iris parent instance will not display any GUIs.");
        end;

        if u2._fullErrorTracebacks then
            for _, v in u2._connectedFunctions do
                v();
            end;
        else
            local coroutine_status_ret = coroutine.status(u2._cycleCoroutine);

            if coroutine_status_ret == "suspended" then
                local _, v14, v15 = coroutine.resume(u2._cycleCoroutine);

                if v14 == false then
                    error(v15, 0);
                end;
            elseif coroutine_status_ret == "running" then
                error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.");
            else
                error("unrecoverable state");
            end;
        end;

        if u2._stackIndex ~= 1 then
            u2._stackIndex = 1;
            error("Too few calls to Iris.End().", 0);
        end;
    end;

    function u2._NoOp() -- Line: 310
    end;

    function u2.WidgetConstructor(p16: string, p17: any) -- Line: 324
        -- upvalues: u2 (copy), u1 (copy)
        local v18 = {
            All = {
                Required = { "Generate", "Discard", "Update", "Args", "Events", "hasChildren", "hasState" },
                Optional = {}
            },
            IfState = {
                Required = { "GenerateState", "UpdateState" },
                Optional = {}
            },
            IfChildren = {
                Required = { "ChildAdded" },
                Optional = { "ChildDiscarded" }
            }
        };
        local v19 = {};

        for _, v in v18.All.Required do
            local v20 = p17[v] ~= nil;
            local v21 = `field {v} is missing from widget {p16}, it is required for all widgets`;
            assert(v20, v21);
            v19[v] = p17[v];
        end;

        for _, v in v18.All.Optional do
            if p17[v] == nil then
                v19[v] = u2._NoOp;
            else
                v19[v] = p17[v];
            end;
        end;

        if p17.hasState then
            for _, v in v18.IfState.Required do
                local v22 = p17[v] ~= nil;
                local v23 = `field {v} is missing from widget {p16}, it is required for all widgets with state`;
                assert(v22, v23);
                v19[v] = p17[v];
            end;

            for _, v in v18.IfState.Optional do
                if p17[v] == nil then
                    v19[v] = u2._NoOp;
                else
                    v19[v] = p17[v];
                end;
            end;
        end;

        if p17.hasChildren then
            for _, v in v18.IfChildren.Required do
                local v24 = p17[v] ~= nil;
                local v25 = `field {v} is missing from widget {p16}, it is required for all widgets with children`;
                assert(v24, v25);
                v19[v] = p17[v];
            end;

            for _, v in v18.IfChildren.Optional do
                if p17[v] == nil then
                    v19[v] = u2._NoOp;
                else
                    v19[v] = p17[v];
                end;
            end;
        end;

        u2._widgets[p16] = v19;
        u1.Args[p16] = v19.Args;
        local v26 = {};

        for i, v in v19.Args do
            v26[v] = i;
        end;

        v19.ArgNames = v26;

        for i, _ in v19.Events do
            if u1.Events[i] == nil then
                u1.Events[i] = function() -- Line: 415
                    -- upvalues: u2 (ref), i (copy)
                    return u2._EventCall(u2._lastWidget, i);
                end;
            end;
        end;
    end;

    function u2._Insert(p27: string, p28: any, p29: any) -- Line: 433
        -- upvalues: u2 (copy)
        local v30 = u2._getID(3);
        local v31 = u2._widgets[p27];

        if u2._VDOM[v30] then
            return u2._ContinueWidget(v30, p27);
        end;

        local v32 = {};

        if p28 ~= nil then
            for i, v in type(p28) ~= "table" and { p28 } or p28 do
                local v33 = `Widget Arguments must be a positive number, not {i} of type {typeof(i)} for {v}.`;
                assert(i > 0, v33);
                v32[v31.ArgNames[i]] = v;
            end;
        end;

        table.freeze(v32);
        local v34 = u2._lastVDOM[v30];

        if v34 and (p27 == v34.type and u2._localRefreshActive) then
            u2._DiscardWidget(v34);
            v34 = nil;
        end;

        if v34 == nil then
            v34 = u2._GenNewWidget(p27, v32, p29, v30);
        end;

        local parentWidget = v34.parentWidget;

        if v34.type ~= "Window" and v34.type ~= "Tooltip" then
            if v34.ZIndex ~= parentWidget.ZOffset then
                parentWidget.ZUpdate = true;
            end;

            if parentWidget.ZUpdate then
                v34.ZIndex = parentWidget.ZOffset;

                if v34.Instance then
                    v34.Instance.ZIndex = v34.ZIndex;
                    v34.Instance.LayoutOrder = v34.ZIndex;
                end;
            end;
        end;

        if u2._deepCompare(v34.providedArguments, v32) == false then
            v34.arguments = u2._deepCopy(v32);
            v34.providedArguments = v32;
            v31.Update(v34);
        end;

        v34.lastCycleTick = u2._cycleTick;
        parentWidget.ZOffset = parentWidget.ZOffset + 1;

        if v31.hasChildren then
            v34.ZOffset = 0;
            v34.ZUpdate = false;
            local v35 = u2;
            v35._stackIndex = v35._stackIndex + 1;
            u2._IDStack[u2._stackIndex] = v34.ID;
        end;

        u2._VDOM[v30] = v34;
        u2._lastWidget = v34;

        return v34;
    end;

    function u2._GenNewWidget(p36: string, p37: any, p38: any, p39: any) -- Line: 528
        -- upvalues: u2 (copy), HttpService (ref)
        local v40 = u2._VDOM[u2._IDStack[u2._stackIndex]];
        local v41 = u2._widgets[p36];
        local u42 = {};
        setmetatable(u42, u42);
        u42.ID = p39;
        u42.type = p36;
        u42.parentWidget = v40;
        u42.trackedEvents = {};
        u42.UID = HttpService:GenerateGUID(false):sub(0, 8);
        u42.ZIndex = v40.ZOffset;
        u42.Instance = v41.Generate(u42);
        local parentWidget = u42.parentWidget;

        if u2._config.Parent then
            u42.Instance.Parent = u2._config.Parent;
        else
            u42.Instance.Parent = u2._widgets[parentWidget.type].ChildAdded(parentWidget, u42);
        end;

        u42.providedArguments = p37;
        u42.arguments = u2._deepCopy(p37);
        v41.Update(u42);
        local v43;

        if v41.hasState then
            if p38 then
                for i, v in p38 do
                    if type(v) ~= "table" or getmetatable(v) ~= u2.StateClass then
                        p38[i] = u2._widgetState(u42, i, v);
                    end;

                    p38[i].lastChangeTick = u2._cycleTick;
                end;

                u42.state = p38;

                for _, v in p38 do
                    v.ConnectedWidgets[u42.ID] = u42;
                end;
            else
                u42.state = {};
            end;

            v41.GenerateState(u42);
            v41.UpdateState(u42);
            u42.stateMT = {};
            setmetatable(u42.state, u42.stateMT);
            u42.__index = u42.state;
            v43 = u42.stateMT;
        else
            v43 = u42;
        end;

        function v43.__index(p44: any, u45: string) -- Line: 594
            -- upvalues: u2 (ref), u42 (copy)
            return function() -- Line: 595
                -- upvalues: u2 (ref), u42 (ref), u45 (copy)
                return u2._EventCall(u42, u45);
            end;
        end;

        return u42;
    end;

    function u2._ContinueWidget(p46: any, p47: string) -- Line: 613
        -- upvalues: u2 (copy)
        local v48 = u2._VDOM[p46];

        if u2._widgets[p47].hasChildren then
            local v49 = u2;
            v49._stackIndex = v49._stackIndex + 1;
            u2._IDStack[u2._stackIndex] = v48.ID;
        end;

        u2._lastWidget = v48;

        return v48;
    end;

    function u2._DiscardWidget(p50) -- Line: 636
        -- upvalues: u2 (copy)
        local parentWidget = p50.parentWidget;

        if parentWidget then
            u2._widgets[parentWidget.type].ChildDiscarded(parentWidget, p50);
        end;

        u2._widgets[p50.type].Discard(p50);
        p50.lastCycleTick = -1;
    end;

    function u2._widgetState(p51: any, p52: string, p53: any) -- Line: 661
        -- upvalues: u2 (copy)
        local v54 = p51.ID .. p52;

        if u2._states[v54] then
            u2._states[v54].ConnectedWidgets[p51.ID] = p51;
            u2._states[v54].lastChangeTick = u2._cycleTick;

            return u2._states[v54];
        end;

        u2._states[v54] = {
            ID = v54,
            value = p53,
            lastChangeTick = u2._cycleTick,
            ConnectedWidgets = {
                [p51.ID] = p51
            },
            ConnectedFunctions = {}
        };
        setmetatable(u2._states[v54], u2.StateClass);

        return u2._states[v54];
    end;

    function u2._EventCall(p55: any, p56: string) -- Line: 690
        -- upvalues: u2 (copy)
        local v57 = u2._widgets[p55.type].Events[p56];
        local v58 = `widget {p55.type} has no event of name {p56}`;
        assert(v57 ~= nil, v58);

        if p55.trackedEvents[p56] == nil then
            v57.Init(p55);
            p55.trackedEvents[p56] = true;
        end;

        return v57.Get(p55);
    end;

    function u2._GetParentWidget() -- Line: 709
        -- upvalues: u2 (copy)
        return u2._VDOM[u2._IDStack[u2._stackIndex]];
    end;

    function u2._generateEmptyVDOM() -- Line: 723
        -- upvalues: u2 (copy)
        return {
            R = u2._rootWidget
        };
    end;

    function u2._generateRootInstance() -- Line: 736
        -- upvalues: u2 (copy)
        u2._rootInstance = u2._widgets.Root.Generate(u2._widgets.Root);
        u2._rootInstance.Parent = u2.parentInstance;
        u2._rootWidget.Instance = u2._rootInstance;
    end;

    function u2._generateSelectionImageObject() -- Line: 750
        -- upvalues: u2 (copy)
        if u2.SelectionImageObject then
            u2.SelectionImageObject:Destroy();
        end;

        local Frame = Instance.new("Frame");
        Frame.Position = UDim2.fromOffset(-1, -1);
        Frame.Size = UDim2.new(1, 2, 1, 2);
        Frame.BackgroundColor3 = u2._config.SelectionImageObjectColor;
        Frame.BackgroundTransparency = u2._config.SelectionImageObjectTransparency;
        Frame.BorderSizePixel = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Thickness = 1;
        UIStroke.Color = u2._config.SelectionImageObjectBorderColor;
        UIStroke.Transparency = u2._config.SelectionImageObjectBorderTransparency;
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Parent = Frame;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 2);
        UICorner.Parent = Frame;
        u2.SelectionImageObject = Frame;
    end;

    function u2._getID(p59: number) -- Line: 791
        -- upvalues: u2 (copy)
        if u2._nextWidgetId then
            local _nextWidgetId = u2._nextWidgetId;
            u2._nextWidgetId = nil;

            return _nextWidgetId;
        end;

        local v60 = 1 + (p59 or 1);
        local debug_info_ret = debug.info(v60, "l");
        local v61 = "";

        while debug_info_ret ~= -1 and debug_info_ret ~= nil do
            v61 = v61 .. "+" .. debug_info_ret;
            v60 = v60 + 1;
            debug_info_ret = debug.info(v60, "l");
        end;

        if u2._usedIDs[v61] then
            local _usedIDs = u2._usedIDs;
            _usedIDs[v61] = _usedIDs[v61] + 1;
        else
            u2._usedIDs[v61] = 1;
        end;

        local v62;

        if u2._pushedId then
            v62 = u2._pushedId;
        else
            v62 = u2._usedIDs[v61];
        end;

        return v61 .. ":" .. v62;
    end;

    function u2._deepCompare(p63: table, p64: table) -- Line: 830
        -- upvalues: u2 (copy)
        for i, v in p63 do
            local v65 = p64[i];

            if type(v) == "table" then
                if not v65 or type(v65) ~= "table" then
                    return false;
                end;

                if u2._deepCompare(v, v65) == false then
                    return false;
                end;
            elseif type(v) ~= type(v65) or v ~= v65 then
                return false;
            end;
        end;

        return true;
    end;

    function u2._deepCopy(p66: table) -- Line: 861
        -- upvalues: u2 (copy)
        local table_clone_ret = table.clone(p66);

        for i, v in pairs(p66) do
            if type(v) == "table" then
                table_clone_ret[i] = u2._deepCopy(v);
            end;
        end;

        return table_clone_ret;
    end;

    u2._lastVDOM = u2._generateEmptyVDOM();
    u2._VDOM = u2._generateEmptyVDOM();
    u1.Internal = u2;
    u1._config = u2._config;

    return u2;
end;