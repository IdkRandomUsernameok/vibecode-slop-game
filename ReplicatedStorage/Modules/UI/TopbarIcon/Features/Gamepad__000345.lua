-- Decompiled with Potassium's decompiler.

local GamepadService = game:GetService("GamepadService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local DPadUp = Enum.KeyCode.DPadUp;
local Gamepad = Enum.PreferredInput.Gamepad;
local u1 = {};
local u2 = nil;

function u1.start(p3) -- Line: 26
    -- upvalues: u2 (ref), DPadUp (copy), GuiService (copy), UserInputService (copy), Gamepad (copy), u1 (copy)
    u2 = p3;
    local v4;

    if u2.highlightKey == nil then
        v4 = DPadUp;
    else
        v4 = u2.highlightKey;
    end;

    u2.highlightKey = v4;
    u2.highlightIcon = false;
    u2.canResetCursor = true;
    task.delay(1, function() -- Line: 36
        -- upvalues: u2 (ref), GuiService (ref), DPadUp (ref), UserInputService (ref), Gamepad (ref), u1 (ref)
        local iconsDictionary = u2.iconsDictionary;

        local function getIconFromSelectedObject() -- Line: 39
            -- upvalues: GuiService (ref), iconsDictionary (copy)
            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            return SelectedObject;
        end;

        local u5 = nil;
        local u6 = DPadUp ~= u2.highlightKey;
        local u7 = DPadUp ~= u2.highlightKey;
        local Selection = require(script.Parent.Parent.Elements.Selection);

        local function updateSelectedObject() -- Line: 51
            -- upvalues: GuiService (ref), iconsDictionary (copy), UserInputService (ref), Gamepad (ref), Selection (copy), u2 (ref), u5 (ref), u7 (ref), u6 (ref), u1 (ref)
            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            local v8 = UserInputService.PreferredInput == Gamepad;

            if not SelectedObject then
                local v9;

                if v8 and not u6 then
                    v9 = u2.highlightKey;
                else
                    v9 = nil;
                end;

                if not u5 then
                    u5 = u1.getIconToHighlight();
                end;

                if v9 == u2.highlightKey then
                    u6 = true;
                end;

                if u5 then
                    u5:setIndicator(v9);
                end;

                return;
            end;

            if v8 then
                local Instance = SelectedObject:getInstance("ClickRegion");
                local selection = SelectedObject.selection;

                if not selection then
                    selection = SelectedObject.janitor:add(Selection(u2));
                    selection:SetAttribute("IgnoreVisibilityUpdater", true);
                    selection.Parent = SelectedObject.widget;
                    SelectedObject.selection = selection;
                    SelectedObject:refreshAppearance(selection);
                end;

                Instance.SelectionImageObject = selection.Selection;
            end;

            if u5 and u5 ~= SelectedObject then
                u5:setIndicator();
            end;

            local v10;

            if v8 and not (u7 or SelectedObject.parentIconUID) then
                v10 = Enum.KeyCode.ButtonB;
            else
                v10 = nil;
            end;

            u5 = SelectedObject;
            u2.lastHighlightedIcon = SelectedObject;
            SelectedObject:setIndicator(v10);
        end;

        GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(updateSelectedObject);

        local function preferredInputChanged() -- Line: 92
            -- upvalues: UserInputService (ref), Gamepad (ref), u6 (ref), u7 (ref), updateSelectedObject (copy)
            if UserInputService.PreferredInput ~= Gamepad then
                u6 = false;
                u7 = false;
            end;

            updateSelectedObject();
        end;

        UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(preferredInputChanged);

        if UserInputService.PreferredInput ~= Gamepad then
            u6 = false;
            u7 = false;
        end;

        updateSelectedObject();
        UserInputService.InputBegan:Connect(function(p11, p12) -- Line: 108
            -- upvalues: GuiService (ref), iconsDictionary (copy), u2 (ref), u1 (ref)
            if p11.UserInputType ~= Enum.UserInputType.MouseButton1 then
                if p11.KeyCode ~= u2.highlightKey then
                    return;
                end;

                local IconToHighlight = u1.getIconToHighlight();

                if IconToHighlight then
                    GuiService.SelectedObject = IconToHighlight:getInstance("ClickRegion");
                end;

                return;
            end;

            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            if SelectedObject then
                GuiService.SelectedObject = nil;
            end;
        end);
    end);
end;

function u1.getIconToHighlight() -- Line: 131
    -- upvalues: u2 (ref)
    local iconsDictionary = u2.iconsDictionary;
    local v13 = u2.highlightIcon or u2.lastHighlightedIcon;

    if not v13 then
        local v14 = nil;

        for _, v in pairs(iconsDictionary) do
            if not (v.parentIconUID or v14 and v.widget.AbsolutePosition.X >= v14) then
                v14 = v.widget.AbsolutePosition.X;
                v13 = v;
            end;
        end;
    end;

    return v13;
end;

function u1.registerButton(u15) -- Line: 153
    -- upvalues: UserInputService (copy), u2 (ref), GamepadService (copy), GuiService (copy)
    local u16 = false;
    u15.InputBegan:Connect(function(p17) -- Line: 159
        -- upvalues: u16 (ref)
        u16 = true;
        task.wait();
        task.wait();
        u16 = false;
    end);
    local u21 = UserInputService.InputBegan:Connect(function(p18) -- Line: 168
        -- upvalues: u16 (ref), u2 (ref), GamepadService (ref), GuiService (ref), u15 (copy)
        if p18.KeyCode == Enum.KeyCode.ButtonA and (u16 and u2.canResetCursor) then
            task.wait(0.2);
            GamepadService:DisableGamepadCursor();
            GuiService.SelectedObject = u15;

            return;
        end;

        local v19 = GuiService.SelectedObject == u15;
        local v20 = { "ButtonB", "ButtonSelect" };
        local Name = p18.KeyCode.Name;

        if p18.KeyCode == Enum.KeyCode.ButtonSelect and (u2.highlightKey == false and v19) then
            GuiService.SelectedObject = nil;

            return;
        end;

        if table.find(v20, Name) and (v19 and (Name ~= "ButtonSelect" or GamepadService.GamepadCursorEnabled)) then
            GuiService.SelectedObject = nil;
        end;
    end);
    u15.Destroying:Once(function() -- Line: 194
        -- upvalues: u21 (copy)
        u21:Disconnect();
    end);
end;

return u1;