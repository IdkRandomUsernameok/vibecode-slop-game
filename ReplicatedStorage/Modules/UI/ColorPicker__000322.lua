-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Signal = require(Modules.Lib.Signal);
local Height = GuiService.TopbarInset.Height;
local Vector2_new_ret = Vector2.new(0.5, 0.5);
GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 20
    -- upvalues: Height (ref), GuiService (copy)
    Height = GuiService.TopbarInset.Height;
end);

function isMouseInside(p2)
    -- upvalues: UserInputService (copy), Height (ref), Vector2_new_ret (copy)
    local MouseLocation = UserInputService:GetMouseLocation();
    local v3 = (Vector2.new(MouseLocation.X, MouseLocation.Y - Height) - p2.AbsolutePosition) / p2.AbsoluteSize;
    local v4 = v3 - Vector2_new_ret;

    return v3, v4, v4.Magnitude <= 0.5;
end;

function round(p5, p6)
    local v7 = 10 ^ (p6 or 0);

    return math.floor(p5 * v7 + 0.5) / v7;
end;

function u1.new(p8) -- Line: 45
    -- upvalues: Signal (copy), u1 (copy)
    local v9 = p8:FindFirstChild("Content") and p8 and p8 or nil;
    local v10;

    if v9 then
        v10 = v9:FindFirstChild("BGSinking") or nil;
    else
        v10 = nil;
    end;

    if v9 then
        p8 = p8.Content;
    end;

    local v11 = {
        visible = false,
        wheelDragging = false,
        barDragging = false,
        fadeUi = v9,
        sinkUi = v10,
        ui = p8,
        color = Color3.new(1, 1, 1),
        currentColor = Color3.new(1, 1, 1),
        onColorChanged = Signal.new(),
        onColorFinish = Signal.new(),
        onConfirm = Signal.new(),
        onCancel = Signal.new(),
        wheelPointer = p8.Main.Wheel.WheelBG.Pointer,
        barPointer = p8.Main.WheelValueBar.Pointer,
        properties = {
            Hex = p8.Main.Properties.HEX.Selectors.HEX,
            RGB = p8.Main.Properties.RGB.Selectors,
            HSV = p8.Main.Properties.HSV.Selectors
        }
    };
    local u12 = setmetatable(v11, u1);
    u12.properties.RGB.R.FocusLost:Connect(function() -- Line: 81
        -- upvalues: u12 (copy)
        local Text = u12.properties.RGB.R.Text;

        if not tonumber(Text) then
            return u12:updateRGB();
        end;

        local Color3_new = Color3.new;
        local v13 = tonumber(Text) / 255;
        u12:_setColor(Color3_new(math.clamp(v13, 0, 1), u12.currentColor.G, u12.currentColor.B));
        u12.onColorFinish:Fire(u12.currentColor);
    end);
    u12.properties.RGB.G.FocusLost:Connect(function() -- Line: 89
        -- upvalues: u12 (copy)
        local Text = u12.properties.RGB.G.Text;

        if not tonumber(Text) then
            return u12:updateRGB();
        end;

        local Color3_new = Color3.new;
        local R = u12.currentColor.R;
        local v14 = tonumber(Text) / 255;
        u12:_setColor(Color3_new(R, math.clamp(v14, 0, 1), u12.currentColor.B));
        u12.onColorFinish:Fire(u12.currentColor);
    end);
    u12.properties.RGB.B.FocusLost:Connect(function() -- Line: 97
        -- upvalues: u12 (copy)
        local Text = u12.properties.RGB.B.Text;

        if not tonumber(Text) then
            return u12:updateRGB();
        end;

        local Color3_new = Color3.new;
        local R = u12.currentColor.R;
        local G = u12.currentColor.G;
        local v15 = tonumber(Text) / 255;
        u12:_setColor(Color3_new(R, G, (math.clamp(v15, 0, 1))));
        u12.onColorFinish:Fire(u12.currentColor);
    end);
    u12.properties.HSV.H.FocusLost:Connect(function() -- Line: 107
        -- upvalues: u12 (copy)
        local Text = u12.properties.HSV.H.Text;

        if not tonumber(Text) then
            return u12:updateHSV();
        end;

        local _, v16, v17 = u12.currentColor:ToHSV();
        local Color3_fromHSV = Color3.fromHSV;
        local v18 = tonumber(Text) % 360 / 360;
        u12:_setColor(Color3_fromHSV(math.clamp(v18, 0, 1), v16, v17));
        u12.onColorFinish:Fire(u12.currentColor);
    end);
    u12.properties.HSV.S.FocusLost:Connect(function() -- Line: 117
        -- upvalues: u12 (copy)
        local Text = u12.properties.HSV.S.Text;

        if not tonumber(Text) then
            return u12:updateHSV();
        end;

        local v19, _, v20 = u12.currentColor:ToHSV();
        local Color3_fromHSV = Color3.fromHSV;
        local v21 = tonumber(Text) / 255;
        u12:_setColor(Color3_fromHSV(v19, math.clamp(v21, 0, 1), v20));
        u12.onColorFinish:Fire(u12.currentColor);
    end);
    u12.properties.HSV.V.FocusLost:Connect(function() -- Line: 127
        -- upvalues: u12 (copy)
        local Text = u12.properties.HSV.V.Text;

        if not tonumber(Text) then
            return u12:updateHSV();
        end;

        local v22, v23, _ = u12.currentColor:ToHSV();
        local Color3_fromHSV = Color3.fromHSV;
        local v24 = tonumber(Text) / 255;
        u12:_setColor(Color3_fromHSV(v22, v23, (math.clamp(v24, 0, 1))));
        u12.onColorFinish:Fire(u12.currentColor);
    end);
    u12.properties.Hex.FocusLost:Connect(function() -- Line: 139
        -- upvalues: u12 (copy)
        local success, result = pcall(Color3.fromHex, u12.properties.Hex.Text);

        if not (success and result) then
            u12:updateHex();

            return;
        end;

        u12:_setColor(result);
        u12.onColorFinish:Fire(u12.currentColor);
    end);
    p8.CloseButton.MouseButton1Click:Connect(function() -- Line: 151
        -- upvalues: u12 (copy)
        if not u12.visible then
            return;
        end;

        u12:hide();
        u12.onCancel:Fire(u12.color);
    end);
    p8.ResetButton.MouseButton1Click:Connect(function() -- Line: 158
        -- upvalues: u12 (copy)
        if not u12.visible then
            return;
        end;

        u12:_setColor(u12.color);
    end);
    p8.ConfirmButton.MouseButton1Click:Connect(function() -- Line: 164
        -- upvalues: u12 (copy)
        if not u12.visible then
            return;
        end;

        u12:hide();
        u12.onConfirm:Fire(u12.currentColor);
    end);
    u12:updatePreviews();

    return u12;
end;

function u1.updateValueBarDrag(p25) -- Line: 176
    -- upvalues: UserInputService (copy)
    if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or p25.wheelDragging then
        if p25.barDragging and not p25.wheelDragging then
            p25.onColorFinish:Fire(p25.currentColor);
        end;

        p25.barDragging = false;

        return;
    end;

    local v26, _, v27 = isMouseInside(p25.ui.Main.WheelValueBar);

    if not (v27 or p25.barDragging) then
        return;
    end;

    p25.barDragging = true;
    local math_clamp_ret = math.clamp(v26.Y, 0, 1);
    p25.barPointer.Position = UDim2.fromScale(0.5, math_clamp_ret);
    local v28, v29, _ = p25.currentColor:ToHSV();
    p25:_setColor(Color3.fromHSV(v28, v29, 1 - math_clamp_ret));
end;

function u1.updateWheelDrag(p30) -- Line: 196
    -- upvalues: UserInputService (copy), Vector2_new_ret (copy)
    if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or p30.barDragging then
        if p30.wheelDragging and not p30.barDragging then
            p30.onColorFinish:Fire(p30.currentColor);
        end;

        p30.wheelDragging = false;

        return;
    end;

    local v31, v32, v33 = isMouseInside(p30.ui.Main.Wheel);

    if not (v33 or (p30.wheelDragging or p30.barDragging)) then
        return;
    end;

    p30.wheelDragging = true;

    if v32.Magnitude > 0.5 then
        v32 = v32.Unit * 0.5;
        v31 = v32 + Vector2_new_ret;
    end;

    local math_clamp_ret = math.clamp(v32.Magnitude * 2, 0, 1);
    p30.wheelPointer.Position = UDim2.fromScale(v31.X, v31.Y);
    local math_atan2_ret = math.atan2(v32.Y, -v32.X);
    local math_deg_ret = math.deg(math_atan2_ret);

    if math_deg_ret < 0 then
        math_deg_ret = math_deg_ret + 360;
    end;

    local _, _, v34 = p30.currentColor:ToHSV();
    p30:_setColor(Color3.fromHSV(math_deg_ret / 360, math_clamp_ret, v34));
end;

function u1.updateValueBar(p35) -- Line: 228
    if p35.barDragging then
        return;
    end;

    local _, _, v36 = p35.currentColor:ToHSV();
    p35.barPointer.Position = UDim2.fromScale(0.5, 1 - v36);
end;

function u1.updateWheel(p37) -- Line: 235
    if p37.wheelDragging then
        return;
    end;

    local v38, v39, _ = p37.currentColor:ToHSV();
    local v40 = v38 * 2 * 3.141592653589793;
    local v41 = -math.cos(v40) * v39;
    local v42 = math.sin(v40) * v39;
    local math_map_ret = math.map(v41, -1, 1, 0, 1);
    local math_map_ret2 = math.map(v42, -1, 1, 0, 1);
    p37.wheelPointer.Position = UDim2.fromScale(math_map_ret, math_map_ret2);
end;

function u1.updateHex(p43) -- Line: 250
    p43.properties.Hex.Text = p43.currentColor:ToHex():upper();
end;

function u1.updateRGB(p44) -- Line: 254
    local R = p44.properties.RGB.R;
    local math_round_ret = math.round(p44.currentColor.R * 255);
    local math_clamp_ret = math.clamp(math_round_ret, 0, 255);
    R.Text = tostring(math_clamp_ret);
    local G = p44.properties.RGB.G;
    local math_round_ret2 = math.round(p44.currentColor.G * 255);
    local math_clamp_ret2 = math.clamp(math_round_ret2, 0, 255);
    G.Text = tostring(math_clamp_ret2);
    local B = p44.properties.RGB.B;
    local math_round_ret3 = math.round(p44.currentColor.B * 255);
    local math_clamp_ret3 = math.clamp(math_round_ret3, 0, 255);
    B.Text = tostring(math_clamp_ret3);
end;

function u1.updateHSV(p45) -- Line: 260
    local v46, v47, v48 = p45.currentColor:ToHSV();
    local H = p45.properties.HSV.H;
    local math_round_ret = math.round(v46 * 360 % 360);
    local math_clamp_ret = math.clamp(math_round_ret, 0, 360);
    H.Text = tostring(math_clamp_ret);
    local S = p45.properties.HSV.S;
    local math_round_ret2 = math.round(v47 * 255);
    local math_clamp_ret2 = math.clamp(math_round_ret2, 0, 255);
    S.Text = tostring(math_clamp_ret2);
    local V = p45.properties.HSV.V;
    local math_round_ret3 = math.round(v48 * 255);
    local math_clamp_ret3 = math.clamp(math_round_ret3, 0, 255);
    V.Text = tostring(math_clamp_ret3);
end;

function u1.updatePreviews(p49) -- Line: 267
    p49:updateWheel();
    p49:updateHex();
    p49:updateRGB();
    p49:updateHSV();
    p49:updateValueBar();
    local _, _, v50 = p49.currentColor:ToHSV();
    p49.ui.Main.Wheel.WheelBG.ImageColor3 = Color3.new(v50, v50, v50);
    p49.ui.ColorLabel.Frame.BackgroundColor3 = p49.currentColor;
end;

function u1.update(p51) -- Line: 280
    p51:updateWheelDrag();
    p51:updateValueBarDrag();
end;

function u1.setColor(p52: table, p53, p54: boolean) -- Line: 285
    p52.color = p53;

    if not p54 then
        p52:_setColor(p53);

        return;
    end;

    p52.currentColor = p53;
    p52:updatePreviews();
end;

function u1._setColor(p55: table, p56) -- Line: 297
    p55.currentColor = p56;
    p55:updatePreviews();
    p55.onColorChanged:Fire(p56);
end;

function u1.show(u57) -- Line: 304
    -- upvalues: TweenService (copy), RunService (copy)
    if u57.fadeUi then
        TweenService:Create(u57.fadeUi, TweenInfo.new(0.25), {
            BackgroundTransparency = 0.2
        }):Play();
    end;

    u57.visible = true;
    u57.ui.Visible = true;

    if u57.sinkUi then
        u57.sinkUi.Visible = true;
    end;

    u57.updateCon = RunService.RenderStepped:Connect(function() -- Line: 315
        -- upvalues: u57 (copy)
        u57:update();
    end);
end;

function u1.hide(p58) -- Line: 320
    -- upvalues: TweenService (copy)
    if p58.updateCon then
        p58.updateCon:Disconnect();
        p58.updateCon = nil;
    end;

    if p58.fadeUi then
        TweenService:Create(p58.fadeUi, TweenInfo.new(0.25), {
            BackgroundTransparency = 1
        }):Play();
    end;

    if p58.sinkUi then
        p58.sinkUi.Visible = false;
    end;

    p58.visible = false;
    p58.ui.Visible = false;
end;

return u1;