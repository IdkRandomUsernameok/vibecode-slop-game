-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = { "Left", "Right", "Up", "Down", "Idle" };
local u3 = { "ALT", "" };
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local Signal = require(Modules.Lib.Signal);
local DataManager = require(Modules.Data.DataManager);
local Data = DataManager:GetData();

local function setButtonState(p4, p5) -- Line: 21
    if p5 then
        p4.Cur.Text = "On";
        p4.BackgroundColor3 = Color3.fromRGB(0, 255, 0);
        p4.UIStroke.Color = Color3.fromRGB(0, 255, 0);

        return;
    end;

    p4.Cur.Text = "Off";
    p4.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
    p4.UIStroke.Color = Color3.fromRGB(255, 0, 0);
end;

function newSettingButton(u6, u7, u8)
    -- upvalues: Data (copy), setButtonState (copy), DataManager (copy)
    local u13 = {
        curVal = nil,

        updateValue = function(p9, p10) -- Line: 36, Name: updateValue
            -- upvalues: Data (ref), u7 (copy), setButtonState (ref), u6 (copy), u8 (copy)
            local v11 = Data[u7];
            setButtonState(u6, v11);
            local v12;

            if p9.curVal == nil then
                v12 = false;
            else
                v12 = p9.curVal ~= v11;
            end;

            if v12 and not p10 then
                u8(v11);
            end;

            p9.curVal = v11;

            return v12;
        end
    };
    u6.MouseButton1Click:Connect(function() -- Line: 51
        -- upvalues: u13 (copy), DataManager (ref), u7 (copy)
        DataManager:SetData(u7, not u13.curVal);
        u13:updateValue();
    end);
    u13:updateValue();

    return u13;
end;

function u1.new(p14) -- Line: 62
    -- upvalues: Signal (copy), u1 (copy)
    local v15 = {
        curRig = nil,
        side = "R",
        isAlt = false,
        rotation = 0,
        ui = p14,
        buttons = {},
        onRefresh = Signal.new(),
        onSimpleUpdate = Signal.new(),
        onPlayAnim = Signal.new()
    };
    local u16 = setmetatable(v15, u1);

    local function reRender() -- Line: 78
        -- upvalues: u16 (copy)
        if u16.curRig then
            u16.onRefresh:Fire(u16.curRig);
        end;
    end;

    local List = p14.AnimSettings.Settings.List;
    table.insert(u16.buttons, newSettingButton(List.Faces.Toggle, "UseFaces", reRender));
    table.insert(u16.buttons, newSettingButton(List.Props.Toggle, "UseProps", reRender));
    table.insert(u16.buttons, newSettingButton(List.Flashing.Toggle, "CameraFlash", reRender));
    table.insert(u16.buttons, newSettingButton(List.ReqProps.Toggle, "UseRequiredProps", reRender));
    local List2 = p14.AnimSettings.Preview.List;
    List2.PreviewAlt.Toggle.MouseButton1Click:Connect(function() -- Line: 93
        -- upvalues: u16 (copy)
        u16:setAlt(not u16.isAlt);
    end);
    local Toggle = List2.PreviewSide.Toggle;
    Toggle.MouseButton1Click:Connect(function() -- Line: 98
        -- upvalues: u16 (copy), Toggle (copy)
        u16.side = u16.side == "L" and "R" or "L";
        Toggle.Cur.Text = u16.side == "L" and "Left" or "Right";

        if u16.curRig then
            u16.onRefresh:Fire(u16.curRig);
        end;
    end);
    local SliderMarker = List2.PreviewAngle.Slider.SliderMarker;
    local UIDragDetector = SliderMarker.UIDragDetector;
    SliderMarker.Position = UDim2.fromScale(0.5, 0.5);
    UIDragDetector.DragContinue:Connect(function() -- Line: 113
        -- upvalues: u16 (copy), SliderMarker (copy)
        local rotation = u16.rotation;
        local v17 = math.map(SliderMarker.Position.X.Scale, 0, 1, -180, 180) // 15;
        local v18 = math.floor(v17) * 15;
        SliderMarker.Position = UDim2.fromScale(math.map(v18, -180, 180, 0, 1), 0.5);

        if v18 ~= rotation then
            u16.rotation = v18;

            if u16.curRig then
                u16.onSimpleUpdate:Fire(u16.curRig);
            end;
        end;
    end);

    return u16;
end;

function u1.setAlt(p19, p20) -- Line: 128
    -- upvalues: setButtonState (copy)
    local Toggle = p19.ui.AnimSettings.Preview.List.PreviewAlt.Toggle;
    p19.isAlt = p20;
    setButtonState(Toggle, p20);

    if p19.curRig then
        p19.onSimpleUpdate:Fire(p19.curRig);
    end;
end;

local function isSameAnim(p21, p22) -- Line: 141
    if typeof(p21) ~= typeof(p22) then
        return false;
    end;

    if typeof(p21) ~= "table" or typeof(p22) ~= "table" then
        return p21 == p22;
    end;

    if #p21.tracks ~= #p22.tracks then
        return false;
    end;

    for i, v in p21.tracks do
        if v ~= p22.tracks[i] then
            return false;
        end;
    end;

    return true;
end;

function u1.renderAnims(u23) -- Line: 163
    -- upvalues: u3 (copy), u2 (copy), isSameAnim (copy)
    local curRig = u23.curRig;
    local v24 = u23.prevAnims or {};

    for _, v in v24 do
        v:Destroy();
    end;

    table.clear(v24);

    if not curRig then
        return;
    end;

    local v25 = {};
    u23.prevAnims = v25;
    local AnimScroll = u23.ui.Animations.List.AnimScroll;
    local Template = AnimScroll.Template;

    for i, v in curRig.animations do
        local v26 = v;
        local u27 = i;
        local v28 = true;

        for _, v2 in u3 do
            local v29 = v2;

            for _, v3 in u2 do
                if u27 == v3 .. v29 or isSameAnim(v26, curRig.animations[v3]) then
                    v28 = false;
                    break;
                end;
            end;
        end;

        if v28 then
            local v30 = Template:Clone();
            v30.Name = u27;
            v30.Text = u27;
            v30.MouseButton1Click:Connect(function() -- Line: 199
                -- upvalues: u23 (copy), u27 (copy)
                u23.onPlayAnim:Fire(u27);
            end);
            v30.Visible = true;
            v30.Parent = AnimScroll;
            table.insert(v25, v30);
        end;
    end;

    u23.ui.Animations.Visible = #v25 > 0;
end;

function u1.setRig(u31, p32) -- Line: 212
    local _ = u31.curRig;
    u31.curRig = p32;
    u31.ui.AnimSettings.Preview.List.PreviewAngle.Slider.SliderMarker.Position = UDim2.fromScale(0.5, 0.5);
    u31.rotation = 0;

    if u31.animLoaded then
        u31.animLoaded:Disconnect();
        u31.animLoaded = nil;
    end;

    if not p32 then
        return;
    end;

    u31.animLoaded = p32.animationLoaded:Connect(function() -- Line: 222
        -- upvalues: u31 (copy)
        u31:renderAnims();
    end);
end;

function u1.updateSettings(p33) -- Line: 227
    local v34 = false;

    for _, v in p33.buttons do
        v34 = v:updateValue(true) or v34;
    end;

    if v34 and p33.curRig then
        p33.onRefresh:Fire(p33.curRig);
    end;
end;

function u1.show(p35) -- Line: 238
    p35.visible = true;
    p35.ui.Visible = true;
    p35:updateSettings();
end;

function u1.hide(p36) -- Line: 244
    p36.visible = false;
    p36.ui.Visible = false;
end;

return u1;