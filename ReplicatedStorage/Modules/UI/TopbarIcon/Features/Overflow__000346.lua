-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local u3 = {};
local u4 = nil;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u5 = {};
local u6 = {};
local Utility = require(script.Parent.Parent.Utility);
local u7 = false;
local u8 = false;
local u9 = nil;

function u1.start(p10) -- Line: 25
    -- upvalues: u9 (ref), u4 (ref), u2 (copy), Utility (copy), u1 (copy), u7 (ref), workspace_CurrentCamera (copy)
    u9 = p10;
    u4 = u9.iconsDictionary;
    local v11 = nil;

    for _, v in pairs(u9.container) do
        if v11 == nil then
            if v.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
                v11 = v;
            end;
        end;

        for _, child in pairs(v.Holders:GetChildren()) do
            if child:GetAttribute("IsAHolder") then
                u2[child.Name] = child;
            end;
        end;
    end;

    local u12 = false;
    local u14 = Utility.createStagger(0.1, function(p13) -- Line: 43
        -- upvalues: u12 (ref), u1 (ref)
        if not u12 then
            return;
        end;

        if not p13 then
            u1.updateAvailableIcons("Center");
        end;

        u1.updateBoundary("Left");
        u1.updateBoundary("Right");
    end);
    task.delay(0.5, function() -- Line: 53
        -- upvalues: u12 (ref), u14 (copy)
        u12 = true;
        u14();
    end);
    task.delay(2, function() -- Line: 57
        -- upvalues: u7 (ref), u14 (copy)
        u7 = true;
        u14();
    end);
    u9.iconAdded:Connect(u14);
    u9.iconRemoved:Connect(u14);
    u9.iconChanged:Connect(u14);
    workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 67
        -- upvalues: u14 (copy)
        u14(true);
    end);
    v11:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 70
        -- upvalues: u14 (copy)
        u14(true);
    end);
end;

function u1.getWidth(p15) -- Line: 75
    local widget = p15.widget;

    return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X;
end;

function u1.getAvailableIcons(p16) -- Line: 80
    -- upvalues: u3 (copy), u1 (copy)
    return u3[p16] or u1.updateAvailableIcons(p16);
end;

function u1.updateAvailableIcons(p17) -- Line: 88
    -- upvalues: u4 (ref), u6 (copy), u3 (copy)
    local v18 = 0;
    local v19 = {};

    for _, v in pairs(u4) do
        local parentIconUID = v.parentIconUID;

        if (not parentIconUID or u6[parentIconUID]) and (v.alignment == p17 and (not u6[v.UID] and v.isEnabled)) then
            table.insert(v19, v);
            v18 = v18 + 1;
        end;
    end;

    if v18 <= 0 then
        return {};
    end;

    table.sort(v19, function(p20, p21) -- Line: 110
        local LayoutOrder = p20.widget.LayoutOrder;
        local LayoutOrder2 = p21.widget.LayoutOrder;
        local parentIconUID = p20.parentIconUID;
        local parentIconUID2 = p21.parentIconUID;

        if parentIconUID ~= parentIconUID2 then
            if parentIconUID2 then
                return false;
            end;

            return parentIconUID and true or nil;
        end;

        if LayoutOrder < LayoutOrder2 then
            return true;
        end;

        if LayoutOrder2 < LayoutOrder then
            return false;
        end;

        return p20.widget.AbsolutePosition.X < p21.widget.AbsolutePosition.X;
    end);
    u3[p17] = v19;

    return v19;
end;

function u1.getRealXPositions(p22, p23) -- Line: 137
    -- upvalues: u2 (copy), Utility (copy), u1 (copy)
    local v24 = p22 == "Left";
    local v25 = u2[p22];
    local X = v25.AbsolutePosition.X;
    local Offset = v25.UIListLayout.Padding.Offset;
    local v26 = v24 and X and X or X + v25.AbsoluteSize.X;
    local v27 = {};

    if v24 then
        Utility.reverseTable(p23);
    end;

    for i = #p23, 1, -1 do
        local v28 = p23[i];
        local Width = u1.getWidth(v28);

        if not v24 then
            v26 = v26 - Width;
        end;

        v27[v28.UID] = v26;

        if v24 then
            v26 = v26 + Width;
        end;

        v26 = v26 + (v24 and Offset and Offset or -Offset);
        local _ = i;
    end;

    return v27;
end;

function u1.updateBoundary(u29) -- Line: 166
    -- upvalues: u2 (copy), u1 (copy), u5 (copy), u9 (ref), u6 (copy), u8 (ref), u7 (ref), Utility (copy)
    local v30 = u2[u29];
    local UIListLayout = v30.UIListLayout;
    local X = v30.AbsolutePosition.X;
    local X2 = v30.AbsoluteSize.X;
    local Offset = UIListLayout.Padding.Offset;
    local Offset2 = UIListLayout.Padding.Offset;
    local u31 = u1.updateAvailableIcons(u29);
    local v32 = 0;
    local v33 = 0;

    for _, v in pairs(u31) do
        v32 = v32 + (u1.getWidth(v) + Offset2);
        v33 = v33 + 1;
    end;

    if v33 <= 0 then
        return;
    end;

    local u34 = u29 == "Left";
    local u35 = not u34;
    local v36 = u5[u29];

    if not (v36 or (u29 == "Center" or #u31 <= 0)) then
        v36 = u9.new();
        v36:setImage(6069276526, "Deselected");
        v36:setName("Overflow" .. u29);
        v36:setOrder(u34 and -9999999 or 9999999);
        v36:setAlignment(u29);
        v36:autoDeselect(false);
        v36.isAnOverflow = true;
        v36:select("OverflowStart", v36);
        v36:setEnabled(false);
        u5[u29] = v36;
        u6[v36.UID] = true;

        if not u9.closeableOverflowMenus then
            v36:getInstance("IconSpot").Visible = false;
        end;
    end;

    local v37 = u29 == "Left" and "Right" or "Left";
    local v38 = u1.updateAvailableIcons(v37);
    local v39 = u34 and v38[1];

    if not v39 then
        if u35 then
            v39 = v38[#v38];
        else
            v39 = u35;
        end;
    end;

    local v40 = u5[v37];
    local v41;

    if u34 then
        v41 = X + X2 or X;
    else
        v41 = X;
    end;

    if v39 then
        local v42 = u1.getRealXPositions(v37, v38)[v39.UID];
        local Width = u1.getWidth(v39);
        v41 = u34 and v42 - Offset or v42 + Width + Offset;
    end;

    local u43 = 0;

    local function checkToShiftCentralIcon() -- Line: 233
        -- upvalues: u1 (ref), u34 (copy), u8 (ref), u29 (copy), u31 (copy), u35 (copy), Offset (copy), u7 (ref), u43 (ref), checkToShiftCentralIcon (copy)
        local AvailableIcons = u1.getAvailableIcons("Center");
        local v44 = AvailableIcons[u34 and 1 or #AvailableIcons];

        local function secondaryCheck() -- Line: 237
            -- upvalues: u8 (ref), u1 (ref), u29 (ref)
            if not u8 then
                u8 = true;
                task.delay(3, u1.updateBoundary, u29);
            end;
        end;

        if v44 and not v44.hasRelocatedInOverflow then
            local v45 = u34 and u31[#u31] or u35 and u31[1];
            local X3 = v44.widget.AbsolutePosition.X;
            local X4 = v45.widget.AbsolutePosition.X;
            local Width = u1.getWidth(v45);
            local v46 = u34 and X3 - Offset or X3 + u1.getWidth(v44) + Offset;

            if u34 then
                X4 = X4 + Width or X4;
            end;

            local v47 = false;

            if u34 then
                if v46 < X4 then
                    if not u7 then
                        if not u8 then
                            u8 = true;
                            task.delay(3, u1.updateBoundary, u29);
                        end;

                        return;
                    end;

                    v44:align("Left");
                    v44.hasRelocatedInOverflow = true;
                    v47 = true;
                end;
            elseif u35 and X4 < v46 then
                if not u7 or X4 < 0 then
                    if not u8 then
                        u8 = true;
                        task.delay(3, u1.updateBoundary, u29);
                    end;

                    return;
                end;

                v44:align("Right");
                v44.hasRelocatedInOverflow = true;
                v47 = true;
            end;

            if v47 then
                u43 = u43 + 1;

                if u43 <= 4 then
                    u1.updateAvailableIcons("Center");
                    checkToShiftCentralIcon();
                end;
            end;
        end;
    end;

    checkToShiftCentralIcon();

    if v36 then
        local Instance = v36:getInstance("Menu");
        local v48 = X + X2;

        if Instance and v40 then
            local X3 = v40.widget.AbsolutePosition.X;
            local Width = u1.getWidth(v40);
            local v49 = u34 and X3 - Offset or X3 + Width + Offset;
            local Instance2 = v40:getInstance("Menu");
            local v50 = X + X2 / 2;
            local v51 = u34 and v50 - Offset / 2 or v50 + Offset / 2;

            if Instance.AbsoluteCanvasSize.X >= Instance2.AbsoluteCanvasSize.X then
                v51 = v49;
            end;

            X2 = u34 and v51 - X or v48 - v51;
        end;

        local v52;

        if Instance then
            v52 = Instance:GetAttribute("MaxWidth");
        else
            v52 = Instance;
        end;

        local v53 = Utility.round(X2);

        if Instance and v52 ~= v53 then
            Instance:SetAttribute("MaxWidth", v53);
        end;
    end;

    local RealXPositions = u1.getRealXPositions(u29, u31);
    local v54 = false;

    for i = #u31, 1, -1 do
        local v55 = u31[i];
        local Width = u1.getWidth(v55);
        local v56 = RealXPositions[v55.UID];
        local v57;

        if u34 and v41 <= v56 + Width or u35 and v56 <= v41 then
            v57 = i;
            v54 = true;
        else
            v57 = i;
        end;
    end;

    for i = #u31, 1, -1 do
        local v58 = u31[i];
        local v59;

        if u6[v58.UID] then
            v59 = i;
        elseif v54 and not v58.parentIconUID then
            v58:joinMenu(v36);
            v59 = i;
        elseif v54 or not v58.parentIconUID then
            v59 = i;
        else
            v58:leave();
            v59 = i;
        end;
    end;

    if v36.isEnabled ~= v54 then
        v36:setEnabled(v54);
    end;

    if v36.isEnabled and not v36.overflowAlreadyOpened then
        v36.overflowAlreadyOpened = true;
        v36:select();
    end;
end;

return u1;