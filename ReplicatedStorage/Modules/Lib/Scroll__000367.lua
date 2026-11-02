-- Decompiled with Potassium's decompiler.

local u1 = {
    __minz = true
};
debug.setmemorycategory("Scroll");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Signal = require(ReplicatedStorage.Modules.Lib.Signal);

local function roundToGrid(p2: number) -- Line: 13
    return math.round(p2 / 50) * 50;
end;

local function floorToGrid(p3: number) -- Line: 16
    return math.floor(p3 / 50) * 50;
end;

local function ceilToGrid(p4: number) -- Line: 19
    return math.ceil(p4 / 50) * 50;
end;

local function udimToVector(p5, p6) -- Line: 23
    return Vector2.new(p5.X.Scale, p5.Y.Scale) * p6 + Vector2.new(p5.X.Offset, p5.Y.Offset);
end;

local function toRatio(p7, p8: number) -- Line: 28
    local X = p7.X;
    local Y = p7.Y;
    local math_round_ret = math.round(Y * p8);

    if X <= math_round_ret then
        return Vector2.new(X, (math.round(X / p8)));
    end;

    return Vector2.new(math_round_ret, Y);
end;

function returnComponents(p9)
    return p9.X, p9.Y;
end;

function hasScaleComponent(p10)
    return p10.X.Scale ~= 0 and true or p10.Y.Scale ~= 0;
end;

local u11 = {
    Size = UDim2.fromOffset(0, 0)
};

function u1.new(u12: userdata, p13: userdata?, p14: string) -- Line: 53
    -- upvalues: Signal (copy), u1 (copy)
    local v15 = p14 or "Pooled";
    local v16 = {
        alive = true,
        isDirty = false,
        unloadOnHide = true,
        xGrid = 50,
        yGrid = 50,
        frame = u12,
        isScroll = u12:IsA("ScrollingFrame"),
        isVisible = u12.Visible,
        types = {},
        items = {},
        sorts = {},
        scrollType = v15,
        canvasPosition = Vector2.zero,
        _setItemsFinished = Signal.new()
    };
    local u17 = setmetatable(v16, {
        __index = u1
    });
    local u18 = p13 or u17.isScroll and u12;

    if u18 == u17.frame then
        if v15 == "Pooled" then
            u17.render = u1.renderScrolledPooled;
        else
            u17.render = u1.renderScrolledCulled;
        end;
    elseif v15 == "Pooled" then
        u17.render = u1.renderPooled;
    else
        u17.render = u1.renderCulled;
    end;

    u17.cachedFrameSize = u12.AbsoluteSize;
    u17.viewportChanged = u12:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 98
        -- upvalues: u17 (copy), u12 (copy)
        u17.cachedFrameSize = u12.AbsoluteSize;

        if u17.isVisible then
            u17:setItems(u17.items or {});

            return;
        end;

        u17.isDirty = true;
    end);
    u17:setLayout({});

    if u18 then
        u17.canvasMoved = u18:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 107
            -- upvalues: u18 (ref), u17 (copy)
            local CanvasPosition = u18.CanvasPosition;

            if u17.canvasPosition == CanvasPosition then
                return;
            end;

            local CanvasSize = u18.CanvasSize;
            local cachedFrameSize = u17.cachedFrameSize;
            u17.canvasPosition = CanvasPosition:Min(Vector2.new(CanvasSize.X.Scale, CanvasSize.Y.Scale) * cachedFrameSize + Vector2.new(CanvasSize.X.Offset, CanvasSize.Y.Offset) - u17.cachedFrameSize):Max(Vector2.zero);
            u17:render();
        end);
        u17.linkedScroll = u18;
    end;

    return u17;
end;

function u1.destroy(p19) -- Line: 122
    if p19.viewportChanged then
        p19.viewportChanged:Disconnect();
        p19.viewportChanged = nil;
    end;

    if p19.canvasMoved then
        p19.canvasMoved:Disconnect();
        p19.canvasMoved = nil;
    end;

    p19:setTypes({});
    table.clear(p19);
    p19.alive = false;
end;

function u1.setVisible(p20, p21) -- Line: 132
    local isVisible = p20.isVisible;
    p20.isVisible = p21;

    if p21 and (p20.isDirty or p20.unloadOnHide and not isVisible) then
        p20:setItems(p20.items or {});

        return;
    end;

    if not p21 and p20.unloadOnHide then
        p20:unRender();
    end;
end;

function u1.unRender(p22) -- Line: 147
    for i, _ in p22.alreadyRendered or {} do
        p22.alreadyRendered[i] = nil;

        if p22.scrollType == "Pooled" then
            local curObj = i.curObj;
            i.curObj = nil;
            i.pool[#i.pool + 1] = curObj;
            curObj.Visible = false;
            i.onUnload(i.item, curObj, i.pooledFuncData, i);
        else
            i.curObj.Visible = false;
        end;
    end;
end;

function u1.renderCulled(p23) -- Line: 171
    local _ = p23.frame;
    local cachedFrameSize = p23.cachedFrameSize;
    local canvasPosition = p23.canvasPosition;
    local UDim2_fromOffset_ret = UDim2.fromOffset(canvasPosition.X, canvasPosition.Y);
    local v24 = math.floor(canvasPosition.X / 50) * 50 / 50;
    local v25 = math.ceil((canvasPosition.X + cachedFrameSize.X) / 50) * 50 / 50;
    local v26 = math.floor(canvasPosition.Y / 50) * 50 / 50;
    local v27 = math.ceil((canvasPosition.Y + cachedFrameSize.Y) / 50) * 50 / 50;

    if p23.isList then
        if p23.fillDir == Enum.FillDirection.Vertical then
            v24 = 0;
            v25 = 0;
        else
            v26 = 0;
            v27 = 0;
        end;
    end;

    local sorts = p23.sorts;
    local v28 = p23.alreadyRendered or {};
    local v29 = {};

    for i = v24, v25 do
        local v30 = sorts[i];
        local v31;

        if v30 then
            v31 = i;

            for i2 = v26, v27 do
                local v32 = v30[i2];
                local v33;

                if v32 then
                    v33 = i2;

                    for i3, _ in v32 do
                        if v28[i3] then
                            i3.curObj.Position = i3.rawPos - UDim2_fromOffset_ret;
                            v29[i3] = v28[i3];
                            v28[i3] = nil;
                        elseif not v29[i3] then
                            local curObj = i3.curObj;
                            v29[i3] = curObj;
                            curObj.Position = i3.rawPos - UDim2_fromOffset_ret;
                            curObj.Visible = true;
                        end;
                    end;
                else
                    v33 = i2;
                end;
            end;
        else
            v31 = i;
        end;
    end;

    p23:unRender();
    p23.alreadyRendered = v29;
end;

function u1.renderPooled(p34) -- Line: 230
    local frame = p34.frame;
    local cachedFrameSize = p34.cachedFrameSize;
    local canvasPosition = p34.canvasPosition;
    local UDim2_fromOffset_ret = UDim2.fromOffset(canvasPosition.X, canvasPosition.Y);
    local v35 = math.floor(canvasPosition.X / 50) * 50 / 50;
    local v36 = math.ceil((canvasPosition.X + cachedFrameSize.X) / 50) * 50 / 50;
    local v37 = math.floor(canvasPosition.Y / 50) * 50 / 50;
    local v38 = math.ceil((canvasPosition.Y + cachedFrameSize.Y) / 50) * 50 / 50;

    if p34.isList then
        if p34.fillDir == Enum.FillDirection.Vertical then
            v35 = 0;
            v36 = 0;
        else
            v37 = 0;
            v38 = 0;
        end;
    end;

    local sorts = p34.sorts;
    local forcedRatio = p34.forcedRatio;
    local v39 = p34.alreadyRendered or {};
    local v40 = {};
    local v41 = 0;

    for i = v35, v36 do
        local v42 = sorts[i];
        local v43;

        if v42 then
            v43 = i;

            for i2 = v37, v38 do
                local v44 = v42[i2];
                local v45;

                if v44 then
                    v45 = i2;

                    for i3, _ in v44 do
                        if v39[i3] then
                            i3.curObj.Position = i3.rawPos - UDim2_fromOffset_ret;
                            v40[i3] = v39[i3];
                            v39[i3] = nil;
                        elseif not v40[i3] then
                            local u46 = i3.pool[1];

                            if u46 then
                                table.remove(i3.pool, 1);
                            else
                                u46 = i3.template:Clone();
                                local v47 = p34.forcedSize or i3.size;
                                local v48 = Vector2.new(v47.X.Scale, v47.Y.Scale) * cachedFrameSize + Vector2.new(v47.X.Offset, v47.Y.Offset);

                                if i3.minSize then
                                    v48 = v48:Max(i3.minSize);
                                end;

                                if i3.maxSize then
                                    v48 = v48:Min(i3.maxSize);
                                end;

                                if forcedRatio or i3.ratio then
                                    local v49 = forcedRatio or i3.ratio;
                                    local X = v48.X;
                                    local Y = v48.Y;
                                    local math_round_ret = math.round(Y * v49);

                                    if X <= math_round_ret then
                                        v48 = Vector2.new(X, (math.round(X / v49)));
                                    else
                                        v48 = Vector2.new(math_round_ret, Y);
                                    end;
                                end;

                                u46.Size = UDim2.fromOffset(v48.X, v48.Y);
                                task.defer(function() -- Line: 287
                                    -- upvalues: u46 (ref), frame (copy)
                                    u46.Parent = frame;
                                end);
                            end;

                            i3.onLoad(i3.item, u46, i3.pooledFuncData, i3);
                            v40[i3] = u46;
                            u46.Position = i3.rawPos - UDim2_fromOffset_ret;
                            u46.Visible = true;
                            i3.curObj = u46;
                            v41 = v41 + 1;
                        end;
                    end;
                else
                    v45 = i2;
                end;
            end;
        else
            v43 = i;
        end;
    end;

    p34:unRender();
    p34.alreadyRendered = v40;
end;

function u1.renderScrolledCulled(p50) -- Line: 314
    local _ = p50.frame;
    local cachedFrameSize = p50.cachedFrameSize;
    local canvasPosition = p50.canvasPosition;
    local v51 = math.floor(canvasPosition.X / 50) * 50 / 50;
    local v52 = math.ceil((canvasPosition.X + cachedFrameSize.X) / 50) * 50 / 50;
    local v53 = math.floor(canvasPosition.Y / 50) * 50 / 50;
    local v54 = math.ceil((canvasPosition.Y + cachedFrameSize.Y) / 50) * 50 / 50;

    if p50.isList then
        if p50.fillDir == Enum.FillDirection.Vertical then
            v51 = 0;
            v52 = 0;
        else
            v53 = 0;
            v54 = 0;
        end;
    end;

    local sorts = p50.sorts;
    local v55 = p50.alreadyRendered or {};
    local v56 = {};

    for i = v51, v52 do
        local v57 = sorts[i];
        local v58;

        if v57 then
            v58 = i;

            for i2 = v53, v54 do
                local v59 = v57[i2];
                local v60;

                if v59 then
                    v60 = i2;

                    for i3, _ in v59 do
                        if v55[i3] then
                            v56[i3] = v55[i3];
                            v55[i3] = nil;
                        elseif not v56[i3] then
                            local curObj = i3.curObj;
                            v56[i3] = curObj;
                            curObj.Position = i3.rawPos;
                            curObj.Visible = true;
                        end;
                    end;
                else
                    v60 = i2;
                end;
            end;
        else
            v58 = i;
        end;
    end;

    p50:unRender();
    p50.alreadyRendered = v56;
end;

function u1.renderScrolledPooled(p61) -- Line: 370
    local frame = p61.frame;
    local cachedFrameSize = p61.cachedFrameSize;
    local canvasPosition = p61.canvasPosition;
    local v62 = math.floor(canvasPosition.X / 50) * 50 / 50;
    local v63 = math.ceil((canvasPosition.X + cachedFrameSize.X) / 50) * 50 / 50;
    local v64 = math.floor(canvasPosition.Y / 50) * 50 / 50;
    local v65 = math.ceil((canvasPosition.Y + cachedFrameSize.Y) / 50) * 50 / 50;

    if p61.isList then
        if p61.fillDir == Enum.FillDirection.Vertical then
            v62 = 0;
            v63 = 0;
        else
            v64 = 0;
            v65 = 0;
        end;
    end;

    local sorts = p61.sorts;
    local forcedRatio = p61.forcedRatio;
    local v66 = p61.alreadyRendered or {};
    local v67 = {};
    local v68 = 0;

    for i = v62, v63 do
        local v69 = sorts[i];
        local v70;

        if v69 then
            v70 = i;

            for i2 = v64, v65 do
                local v71 = v69[i2];
                local v72;

                if v71 then
                    v72 = i2;

                    for i3, _ in v71 do
                        if v66[i3] then
                            v67[i3] = v66[i3];
                            v66[i3] = nil;
                        elseif not v67[i3] then
                            local u73 = i3.pool[1];

                            if u73 then
                                table.remove(i3.pool, 1);
                            else
                                u73 = i3.template:Clone();
                                local v74 = p61.forcedSize or i3.size;
                                local v75 = Vector2.new(v74.X.Scale, v74.Y.Scale) * cachedFrameSize + Vector2.new(v74.X.Offset, v74.Y.Offset);

                                if i3.minSize then
                                    v75 = v75:Max(i3.minSize);
                                end;

                                if i3.maxSize then
                                    v75 = v75:Min(i3.maxSize);
                                end;

                                if forcedRatio or i3.ratio then
                                    local v76 = forcedRatio or i3.ratio;
                                    local X = v75.X;
                                    local Y = v75.Y;
                                    local math_round_ret = math.round(Y * v76);

                                    if X <= math_round_ret then
                                        v75 = Vector2.new(X, (math.round(X / v76)));
                                    else
                                        v75 = Vector2.new(math_round_ret, Y);
                                    end;
                                end;

                                u73.Size = UDim2.fromOffset(v75.X, v75.Y);
                                task.defer(function() -- Line: 424
                                    -- upvalues: u73 (ref), frame (copy)
                                    u73.Parent = frame;
                                end);
                            end;

                            v67[i3] = u73;
                            i3.onLoad(i3.item, u73, i3.pooledFuncData, i3);
                            u73.Position = i3.rawPos;
                            u73.Visible = true;
                            i3.curObj = u73;
                            v68 = v68 + 1;
                        end;
                    end;
                else
                    v72 = i2;
                end;
            end;
        else
            v70 = i;
        end;
    end;

    p61:unRender();
    p61.alreadyRendered = v67;
end;

function u1.setTypes(p77: table, p78: table) -- Line: 449
    -- upvalues: u11 (copy)
    p78.__RowBreak = u11;

    for i, v in p77.types do
        if (not p78[i] or v.Template ~= p78[i].Template) and v.Pool then
            local v79 = v;

            for _, v2 in v.Pool do
                v2:Destroy();
            end;

            table.clear(v79.Pool);
            setmetatable(v79.Pool, {
                __newindex = function(p80, p81, p82) -- Line: 461, Name: __newindex
                    task.delay(1, p82.Destroy, p82);
                end
            });
        end;
    end;

    local cachedFrameSize = p77.cachedFrameSize;
    local forcedRatio = p77.forcedRatio;

    for i, v in p78 do
        if i ~= "__RowBreak" then
            local v83;

            if p77.types[i] then
                if p77.types[i] == v then
                    v83 = v;
                else
                    v83 = table.clone(v);
                    p78[i] = v83;
                end;
            else
                v83 = table.clone(v);
                p78[i] = v83;
            end;

            if v83.Template then
                v83.Size = v83.Size or v83.Template.Size;
                v83.Anchor = v83.Anchor or v83.Template.AnchorPoint;
                local v84 = v83.Pool or {};
                local v85 = p77.forcedSize or v83.Size;
                local v86 = Vector2.new(v85.X.Scale, v85.Y.Scale) * cachedFrameSize + Vector2.new(v85.X.Offset, v85.Y.Offset);

                if v83.MinSize then
                    v86 = v86:Max(v83.MinSize);
                end;

                if v83.MaxSize then
                    v86 = v86:Min(v83.MaxSize);
                end;

                if forcedRatio or v83.Ratio then
                    local v87 = forcedRatio or v83.Ratio;
                    local X = v86.X;
                    local Y = v86.Y;
                    local math_round_ret = math.round(Y * v87);

                    if X <= math_round_ret then
                        v86 = Vector2.new(X, (math.round(X / v87)));
                    else
                        v86 = Vector2.new(math_round_ret, Y);
                    end;
                end;

                local UDim2_fromOffset_ret = UDim2.fromOffset(v86.X, v86.Y);

                for _, v2 in v84 do
                    v2.Size = UDim2_fromOffset_ret;
                end;

                v83.OnLoaded = v83.OnLoaded or function() -- Line: 502
                end;
                v83.OnUnloaded = v83.OnUnloaded or function() -- Line: 503
                end;
                v83.Template.Size = UDim2_fromOffset_ret;
                v83.Template.AnchorPoint = v83.Anchor;
                v83.Template.Archivable = true;

                for i2 = 1, v83.StartPool or 0 do
                    local v88 = v83.Template:Clone();
                    v88.Visible = false;
                    v88.Parent = p77.frame;
                    v84[i2] = v88;
                    local _ = i2;
                end;

                v83.Pool = v84;
            else
                warn("No template on virtualized scroll!");
                p78[i] = nil;
            end;
        end;
    end;

    p77.types = p78;
    p77:setItems(p77.items or {}, true);
end;

function u1.setTypesAndItems(p89, p90, p91) -- Line: 523
    local isVisible = p89.isVisible;
    p89.isVisible = false;
    p89:setTypes(p90);
    p89.isVisible = isVisible;
    p89:setItems(p91);
end;

function u1.setCanvasPosAndItems(p92: table, p93, p94: any) -- Line: 534
    p92.canvasPosition = p93;
    p92:setItems(p94);

    if p92.linkedScroll then
        p92.linkedScroll.CanvasPosition = p92.canvasPosition;
    end;
end;

function u1.setLayout(p95: table, p96: table) -- Line: 542
    local v97 = p96.padding or UDim2.new(0, 0, 0, 0);
    local v98 = p96.fillDirection or Enum.FillDirection.Vertical;

    if typeof(v97) == "UDim" then
        if v98 == Enum.FillDirection.Vertical then
            v97 = UDim2.new(0, 0, v97.Scale, v97.Offset);
        else
            v97 = UDim2.new(v97.Scale, v97.Offset, 0, 0);
        end;
    end;

    p95.padding = v97;
    p95.fillDir = v98;
    p95.forcedSize = p96.cellSize or nil;
    p95.maxCells = p96.maxCells or (1 / 0);

    if p95.maxCells <= 0 then
        p95.maxCells = (1 / 0);
    end;

    p95.isList = p96.isList or false;
    p95.wraps = p96.wraps or (not p96.isList or false);
    p95.forcedRatio = p96.ratio or nil;
    p95.alignment = {
        x = p96.horizontalAlignment and p96.horizontalAlignment == Enum.HorizontalAlignment.Right and 1 or (p96.horizontalAlignment == Enum.HorizontalAlignment.Center and 0.5 or 0),
        y = p96.verticalAlignment and p96.verticalAlignment == Enum.VerticalAlignment.Bottom and 1 or (p96.verticalAlignment == Enum.VerticalAlignment.Center and 0.5 or 0)
    };
    p95:setItems(p95.items or {}, true);
end;

function u1.reRenderItem(p99, p100) -- Line: 576
    local v101 = (p99.alreadyRendered or {})[p100];

    if not v101 then
        return;
    end;

    p100.onUnload(p100.item, v101, p100.pooledFuncData, p100);
    p100.onLoad(p100.item, v101, p100.pooledFuncData, p100);
end;

function u1.GetPositionFromItem(p102, p103) -- Line: 586
    if not p102.reversedItemList then
        return;
    end;

    local v104 = p102.reversedItemList[p103];

    if not v104 then
        return;
    end;

    if v104 then
        return v104.topLeftPos;
    end;
end;

function u1.setItems(u105: table, u106: table, p107: any) -- Line: 597
    local coroutine_running_ret = coroutine.running();

    local function v108() -- Line: 601
        -- upvalues: u105 (copy), coroutine_running_ret (copy)
        u105.runningSetItems = false;

        if u105.setItemsQueue == coroutine_running_ret then
            u105.setItemsQueue = nil;
        end;
    end;

    if u105.runningSetItems then
        warn("[Scroll] Already running :setItems, yielding thread", (tostring(coroutine_running_ret)));
        u105.setItemsQueue = coroutine_running_ret;
        u105._setItemsFinished:Wait();

        if u105.setItemsQueue ~= coroutine_running_ret then
            return u105._setItemsFinished:Wait();
        end;

        warn("[Scroll] Yield broken", (tostring(coroutine_running_ret)));
    end;

    u105.runningSetItems = true;
    local cachedFrameSize = u105.cachedFrameSize;
    local v109 = p107 and true or ((u105.items ~= u106 or u105.prevAbsSize ~= cachedFrameSize) and true or u105.dirtyRemap);

    if not u105.isVisible and v109 then
        u105.isDirty = true;
        u105.dirtyRemap = true;
        u105.items = u106;

        return v108();
    end;

    local forcedRatio = u105.forcedRatio;
    local forcedSize = u105.forcedSize;

    if v109 then
        u105:unRender();

        if cachedFrameSize ~= u105.prevAbsSize then
            for _, v in u105.types do
                local v110 = v.Pool or {};
                local v111 = u105.forcedSize or v.Size;
                local v112 = Vector2.new(v111.X.Scale, v111.Y.Scale) * cachedFrameSize + Vector2.new(v111.X.Offset, v111.Y.Offset);

                if v.MinSize then
                    v112 = v112:Max(v.MinSize);
                end;

                if v.MaxSize then
                    v112 = v112:Min(v.MaxSize);
                end;

                if forcedRatio or v.Ratio then
                    local v113 = forcedRatio or v.Ratio;
                    local X = v112.X;
                    local Y = v112.Y;
                    local math_round_ret = math.round(Y * v113);

                    if X <= math_round_ret then
                        v112 = Vector2.new(X, (math.round(X / v113)));
                    else
                        v112 = Vector2.new(math_round_ret, Y);
                    end;
                end;

                local UDim2_fromOffset_ret = UDim2.fromOffset(v112.X, v112.Y);

                for _, v2 in v110 do
                    v2.Size = UDim2_fromOffset_ret;
                end;
            end;
        end;
    end;

    u105.dirtyRemap = false;

    if not (v109 or u105.isDirty) then
        if not u105.setItemsQueue then
            u105:render();
        end;

        return v108();
    end;

    local v114 = {};
    u105.items = u106;
    u105.reversedItemList = v114;
    u105.prevAbsSize = cachedFrameSize;
    local v115 = {};
    u105.sorts = v115;
    local Vector2_new_ret = Vector2.new();
    local u116 = 0;
    local Vector2_new_ret2 = Vector2.new();
    local padding = u105.padding;
    local v117 = Vector2.new(padding.X.Scale, padding.Y.Scale) * cachedFrameSize + Vector2.new(padding.X.Offset, padding.Y.Offset);
    local maxCells = u105.maxCells;
    local wraps = u105.wraps;
    local x = u105.alignment.x;
    local y = u105.alignment.y;
    local _ = cachedFrameSize.X * x;
    local v118 = u105.scrollType == "Pooled";
    local v119 = u105.fillDir == Enum.FillDirection.Vertical;
    local Vector2_zero = Vector2.zero;
    local _ = #u106;
    local u120 = {};

    local function closeCurrentRow(p121) -- Line: 704
        -- upvalues: u106 (copy), u116 (ref), u120 (copy)
        local v122 = p121 and p121 - 1 or #u106;
        local v123 = {};

        for i = math.max(v122 - u116 + 1, 0), v122 do
            local v124;

            if u106[i].noRender then
                v124 = i;
            else
                table.insert(v123, u106[i]);
                v124 = i;
            end;
        end;

        if #v123 == 0 then
            return;
        end;

        table.insert(u120, {
            items = v123,
            totalItems = #v123
        });
    end;

    local v125 = 1;
    local v126 = {};
    local v127 = not v118;

    for i, v in ipairs(u106) do
        local v128;

        if v118 then
            v128 = u105.types[v.type] or nil;
        else
            v128 = nil;
        end;

        if v128 or not v118 then
            local v129, v130;
            local Vector2_zero, Vector2_new_ret2, v129, v130, u116, v125;
            local v131 = 0;

            while true do
                if v131 == 0 then
                    v131 = -1;
                    local v132 = v127 and v.Size or (forcedSize or v128.Size);
                    v130 = Vector2.new(v132.X.Scale, v132.Y.Scale) * cachedFrameSize + Vector2.new(v132.X.Offset, v132.Y.Offset);

                    if v128.MinSize then
                        v130 = v130:Max(v128.MinSize);
                    end;

                    if v128.MaxSize then
                        v130 = v130:Min(v128.MaxSize);
                    end;

                    if forcedRatio or v128.Ratio then
                        local v133 = forcedRatio or v128.Ratio;
                        local X = v130.X;
                        local Y = v130.Y;
                        local math_round_ret = math.round(Y * v133);

                        if X <= math_round_ret then
                            v130 = Vector2.new(X, (math.round(X / v133)));
                        else
                            v130 = Vector2.new(math_round_ret, Y);
                        end;
                    end;

                    local Vector2_new_ret3 = Vector2.new(v130.X, 0);
                    local Vector2_new_ret4 = Vector2.new(0, v130.Y);
                    v129 = v119 and Vector2_new_ret4 and Vector2_new_ret4 or Vector2_new_ret3;
                    Vector2_new_ret2 = (Vector2_new_ret2 + v129):Max(v119 and Vector2_new_ret3 and Vector2_new_ret3 or Vector2_new_ret4);
                    local v134;

                    if v118 then
                        v134 = v.type == "__RowBreak";
                    else
                        v134 = v118;
                    end;

                    if ((not wraps or (not v119 or Vector2_new_ret2.Y + v117.Y * u116 <= cachedFrameSize.Y) and (v119 or Vector2_new_ret2.X + v117.X * u116 <= cachedFrameSize.X)) and maxCells > u116 or v125 == 1 and u116 == 0) and not v134 then
                        v131 = 1;
                        continue;
                    end;

                    Vector2_zero = Vector2_zero + (v126[v125] or Vector2.zero);
                    closeCurrentRow(i);
                    v125 = v125 + 1;
                    u116 = 0;

                    if not v134 then
                        if v119 then
                            Vector2_new_ret4 = Vector2_new_ret3 or Vector2_new_ret4;
                        end;

                        Vector2_new_ret2 = v129:Max(Vector2_new_ret4);
                        v131 = 1;
                        continue;
                    end;

                    u106[i] = {
                        noRender = true,
                        type = "__RowBreak"
                    };
                    Vector2_new_ret2 = Vector2.zero;
                    v131 = 2;
                    continue;
                elseif v131 == 1 then
                    v131 = -1;
                    local v135 = v119 and UDim2.fromOffset(Vector2_zero.X + v117.X * (v125 - 1), (Vector2_new_ret2 - v129).Y + v117.Y * u116) or UDim2.fromOffset((Vector2_new_ret2 - v129).X + v117.X * u116, Vector2_zero.Y + v117.Y * (v125 - 1));
                    local v136 = Vector2.new(v135.X.Scale, v135.Y.Scale) * cachedFrameSize + Vector2.new(v135.X.Offset, v135.Y.Offset);
                    local UDim2_fromOffset_ret = UDim2.fromOffset(v136.X, v136.Y);
                    local v137;

                    if v118 then
                        v.topLeftPos = v136;
                        v.rawPos = UDim2_fromOffset_ret + UDim2.fromOffset(returnComponents(v130 * (v127 and v.AnchorPoint or v128.Anchor)));
                        v.ind = i;
                        v.onLoad = v128.OnLoaded;
                        v.onUnload = v128.OnUnloaded;
                        v.pool = v128.Pool;
                        v.template = v128.Template;
                        v.size = v128.Size;
                        v.ratio = v128.Ratio;
                        v.minSize = v128.MinSize;
                        v.maxSize = v128.MaxSize;
                        v.itemSize = v130;
                        v.pooledFuncData = {};
                        v137 = v;
                    else
                        u106[i] = {
                            topLeftPos = v136,
                            rawPos = UDim2_fromOffset_ret + UDim2.fromOffset(returnComponents(v130 * (v127 and v.AnchorPoint or v128.Anchor))),
                            curObj = v,
                            ind = i,
                            itemSize = v130
                        };
                        v137 = u106[i];
                    end;

                    v114[v137.curObj or v137.item] = v137;
                    v126[v125] = Vector2_new_ret2;
                    Vector2_new_ret = Vector2_new_ret:Max(v136 + v130);
                    u116 = u116 + 1;
                    v131 = 2;
                    continue;
                elseif v131 == 2 then
                    v131 = -1;
                    break;
                else
                    break;
                end;
            end;
        else
            warn("No type found!", v.type);
        end;
    end;

    closeCurrentRow();
    local math_max_ret = math.max(Vector2_new_ret.X, cachedFrameSize.X);
    local math_max_ret2 = math.max(Vector2_new_ret.Y, cachedFrameSize.Y);

    if v119 then
        for _, v in u120 do
            local v138 = v.items[v.totalItems];
            local v139 = (math_max_ret2 - (v138.topLeftPos.Y + v138.itemSize.Y - v.items[1].topLeftPos.Y)) * y;
            local UDim2_fromOffset_ret = UDim2.fromOffset(0, v139);
            local Vector2_new_ret3 = Vector2.new(0, v139);

            for _, v2 in v.items do
                v2.rawPos = v2.rawPos + UDim2_fromOffset_ret;
                v2.topLeftPos = v2.topLeftPos + Vector2_new_ret3;
            end;
        end;

        local v140 = (math_max_ret - Vector2_new_ret.X) * x;
        local UDim2_fromOffset_ret = UDim2.fromOffset(v140, 0);
        local Vector2_new_ret3 = Vector2.new(v140, 0);

        for _, v in ipairs(u106) do
            if not v.noRender then
                v.rawPos = v.rawPos + UDim2_fromOffset_ret;
                v.topLeftPos = v.topLeftPos + Vector2_new_ret3;
            end;
        end;
    else
        for _, v in u120 do
            local v141 = v.items[v.totalItems];
            local v142 = (math_max_ret - (v141.topLeftPos.X + v141.itemSize.X - v.items[1].topLeftPos.X)) * x;
            local UDim2_fromOffset_ret = UDim2.fromOffset(v142, 0);
            local Vector2_new_ret3 = Vector2.new(v142, 0);

            for _, v2 in v.items do
                v2.rawPos = v2.rawPos + UDim2_fromOffset_ret;
                v2.topLeftPos = v2.topLeftPos + Vector2_new_ret3;
            end;
        end;

        local v143 = (math_max_ret2 - Vector2_new_ret.Y) * y;
        local UDim2_fromOffset_ret = UDim2.fromOffset(0, v143);
        local Vector2_new_ret3 = Vector2.new(0, v143);

        for _, v in ipairs(u106) do
            if not v.noRender then
                v.rawPos = v.rawPos + UDim2_fromOffset_ret;
                v.topLeftPos = v.topLeftPos + Vector2_new_ret3;
            end;
        end;
    end;

    for _, v in ipairs(u106) do
        if not v.noRender then
            local topLeftPos = v.topLeftPos;
            local itemSize = v.itemSize;
            local v144 = math.floor(topLeftPos.X / 50) * 50 / 50;
            local v145 = math.floor(topLeftPos.Y / 50) * 50 / 50;
            local v146 = math.ceil((topLeftPos.X + itemSize.X) / 50) * 50 / 50;
            local v147 = math.ceil((topLeftPos.Y + itemSize.Y) / 50) * 50 / 50;

            if not wraps then
                if v119 then
                    v144 = 0;
                    v146 = 0;
                else
                    v145 = 0;
                    v147 = 0;
                end;
            end;

            local v148 = v;

            for i = v144, v146 do
                local v149 = v115[i] or {};
                v115[i] = v149;
                local _ = i;

                for i2 = v145, v147 do
                    local v150 = v149[i2] or {};
                    v149[i2] = v150;
                    v150[v148] = true;
                    local _ = i2;
                end;
            end;
        end;
    end;

    if u105.linkedScroll then
        u105.linkedScroll.CanvasSize = UDim2.fromOffset(Vector2_new_ret.X, Vector2_new_ret.Y);
        u105.canvasPosition = u105.canvasPosition:Min(Vector2_new_ret - cachedFrameSize):Max(Vector2.zero);
    end;

    u105.isDirty = false;
    u105:render();
    u105.runningSetItems = false;

    if u105.setItemsQueue == coroutine_running_ret then
        u105.setItemsQueue = nil;
    end;
end;

return u1;