-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: table, p4, p5: userdata, p6) -- Line: 4
    -- upvalues: u1 (copy)
    local _ = p2.AbsoluteSize;
    local v7 = {
        obj = p2,
        items = p3,
        uiPadding = UDim2.new(),
        padding = p4,
        visibleSize = {},
        itemSize = p6,
        canvasPos = {
            x = 50,
            y = 0
        },
        contentSize = Vector2.new(),
        itemData = {},
        prevVisible = {},
        visible = p2.Visible
    };

    return setmetatable(v7, u1):calculateVisibleSize():addUiPadding(p5):calculateItemsData():updateScroll();
end;

function u1.calculateVisibleSize(p8) -- Line: 22
    local v9;

    if p8.linkedFrame then
        v9 = p8.linkedFrame.AbsoluteWindowSize;
    else
        v9 = p8.obj.AbsoluteSize;
    end;

    p8.visibleSize = {
        x = math.ceil(v9.X),
        y = math.ceil(v9.Y)
    };

    return p8;
end;

function u1.recalculate(p10) -- Line: 35
    p10:calculateVisibleSize();
    p10:calculateItemsData();
    p10:updateScroll();

    return p10;
end;

function u1.getItems(p11) -- Line: 43
    return p11.items;
end;

function u1.changeItems(p12, p13) -- Line: 47
    p12.items = p13;

    return p12:recalculate();
end;

function u1.calculateItemsData(p14) -- Line: 52
    p14.itemData = {};
    local v15 = p14.items[1];

    if not v15 then
        return p14;
    end;

    local Vector2_new_ret = Vector2.new(0, 0);
    local UDim_new_ret = UDim.new();
    local itemSize = p14.itemSize;
    local _ = p14.uiPadding.Y.Scale * p14.visibleSize.y + p14.uiPadding.Y.Offset;

    if itemSize then
        Vector2.new(itemSize.X.Scale * p14.visibleSize.x + itemSize.X.Offset, itemSize.Y.Scale * p14.visibleSize.y + itemSize.Y.Offset);
    elseif v15.Parent == nil then
        v15.Parent = p14.obj;
        local _ = v15.AbsoluteSize;
        v15.Parent = nil;
    else
        local _ = v15.AbsoluteSize;
    end;

    for i = 1, #p14.items do
        local v16 = p14.items[i];
        local _ = UDim_new_ret.Offset;

        if p14.itemSize then
            v16.Size = p14.itemSize;
        end;

        local UDim2_fromScale_ret = UDim2.fromScale(0, (Vector2_new_ret.Y + UDim_new_ret.Offset) / p14.visibleSize.y + UDim_new_ret.Scale);
        Vector2_new_ret = Vector2_new_ret + v16.AbsoluteSize;
        UDim_new_ret = UDim_new_ret + UDim.new((p14.padding.Scale + p14.uiPadding.Y.Scale) / 2, (p14.padding.Offset + p14.uiPadding.Y.Offset) / 2);
        table.insert(p14.itemData, {
            item = v16,
            position = UDim2_fromScale_ret
        });
        local _ = i;
    end;

    p14.contentSize = Vector2_new_ret + Vector2.new(0, UDim_new_ret.Scale * p14.visibleSize.y + UDim_new_ret.Offset);
    p14.avgItemSize = p14.contentSize / #p14.items;
    p14.viewportSize = workspace.CurrentCamera.ViewportSize;

    return p14;
end;

function u1.updateScroll(p17) -- Line: 115
    if #p17.itemData == 0 or not p17.visible then
        return p17;
    end;

    if p17.viewportSize ~= workspace.CurrentCamera.ViewportSize then
        return p17:recalculate();
    end;

    local v18 = p17.canvasPos.y + p17.visibleSize.y;
    local v19 = p17.canvasPos.y / p17.visibleSize.y;
    local _ = v18 / p17.visibleSize.y;
    local Y = p17.avgItemSize.Y;
    local v20 = {};

    for i = math.floor(p17.canvasPos.y / Y), math.ceil(v18 / Y) do
        local v21 = p17.itemData[i];
        local v22;

        if v21 then
            v21.item.Parent = p17.obj;
            v20[v21] = true;
            v22 = i;
        else
            v22 = i;
        end;
    end;

    local prevVisible = p17.prevVisible;

    for i, _ in prevVisible do
        if not v20[i] then
            i.item.Parent = nil;
        end;
    end;

    for i, _ in v20 do
        if prevVisible[i] == nil then
            i.item.Parent = p17.obj;
        end;

        i.item.Position = i.position - UDim2.fromScale(0, v19);
    end;

    p17.prevVisible = v20;

    return p17;
end;

function u1.fromListLayout(p23: any, p24: any, p25: userdata, p26: any, p27: any) -- Line: 161
    -- upvalues: u1 (copy)
    return u1.new(p23, p24, p25.Padding, p26, p27);
end;

function u1.fromGridLayout(p28: any, p29: any, p30: userdata, p31: any) -- Line: 165
    -- upvalues: u1 (copy)
    return u1.new(p28, p29, p30.CellPadding.Y, p31, p30.CellSize);
end;

function u1.addUiPadding(p32: table, p33: userdata) -- Line: 169
    if not p33 then
        return p32;
    end;

    p32.uiPadding = p32.uiPadding + UDim2.new(p33.PaddingRight.Scale + p33.PaddingLeft.Scale, p33.PaddingRight.Offset + p33.PaddingLeft.Offset, p33.PaddingTop.Scale + p33.PaddingBottom.Scale, p33.PaddingTop.Offset + p33.PaddingBottom.Offset);

    if #p32.items > 0 then
        p32:recalculate();
    end;

    return p32;
end;

function u1.linkWith(u34: table, u35: userdata) -- Line: 187
    if u34.linkedCanvas then
        u34.linkedCanvas:Disconnect();
        u34.linkedCanvas = nil;
    end;

    u34.linkedFrame = u35;
    u34:recalculate();

    if u35 then
        u34.linkedCanvas = u35:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 197
            -- upvalues: u34 (copy), u35 (copy)
            u34.canvasPos.y = u35.CanvasPosition.Y;
            u34:updateScroll();
        end);

        return u34;
    end;
end;

return u1;