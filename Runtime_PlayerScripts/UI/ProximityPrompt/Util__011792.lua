-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local u1 = {
    [Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
    [Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
    [Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
    [Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
    [Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
    [Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
    [Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
    [Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
    [Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxView.png",
    [Enum.KeyCode.ButtonStart] = "rbxasset://textures/ui/Controls/xboxmenu.png",
    [Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLB.png",
    [Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRB.png",
    [Enum.KeyCode.ButtonL2] = "rbxasset://textures/ui/Controls/xboxLT.png",
    [Enum.KeyCode.ButtonR2] = "rbxasset://textures/ui/Controls/xboxRT.png",
    [Enum.KeyCode.ButtonL3] = "rbxasset://textures/ui/Controls/xboxLS.png",
    [Enum.KeyCode.ButtonR3] = "rbxasset://textures/ui/Controls/xboxRS.png",
    [Enum.KeyCode.Thumbstick1] = "rbxasset://textures/ui/Controls/xboxLSDirectional.png",
    [Enum.KeyCode.Thumbstick2] = "rbxasset://textures/ui/Controls/xboxRSDirectional.png"
};
local u2 = {
    ButtonIcons = {
        ["\'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
        [","] = "rbxasset://textures/ui/Controls/comma.png",
        ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
        ["."] = "rbxasset://textures/ui/Controls/period.png",
        [" "] = "rbxasset://textures/ui/Controls/spacebar.png"
    },
    ButtonImage = {
        [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
        [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
        [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
        [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
        [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
    },
    KeyCodes = {
        [Enum.KeyCode.LeftControl] = "Ctrl",
        [Enum.KeyCode.RightControl] = "Ctrl",
        [Enum.KeyCode.LeftAlt] = "Alt",
        [Enum.KeyCode.RightAlt] = "Alt",
        [Enum.KeyCode.F1] = "F1",
        [Enum.KeyCode.F2] = "F2",
        [Enum.KeyCode.F3] = "F3",
        [Enum.KeyCode.F4] = "F4",
        [Enum.KeyCode.F5] = "F5",
        [Enum.KeyCode.F6] = "F6",
        [Enum.KeyCode.F7] = "F7",
        [Enum.KeyCode.F8] = "F8",
        [Enum.KeyCode.F9] = "F9",
        [Enum.KeyCode.F10] = "F10",
        [Enum.KeyCode.F11] = "F11",
        [Enum.KeyCode.F12] = "F12"
    }
};

local function createProgressBarGradient(p3, p4) -- Line: 62
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(0.5, 1);
    Frame.Position = UDim2.fromScale(p4 and 0 or 0.5, 0);
    Frame.BackgroundTransparency = 1;
    Frame.ClipsDescendants = true;
    Frame.Parent = p3;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromScale(2, 1);
    ImageLabel.Position = UDim2.fromScale(p4 and 0 or -1, 0);
    ImageLabel.Image = "rbxasset://textures/ui/Controls/RadialFill.png";
    ImageLabel.Parent = Frame;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.4999, 0),
        NumberSequenceKeypoint.new(0.5, 1),
        NumberSequenceKeypoint.new(1, 1)
    });
    UIGradient.Rotation = p4 and 180 or 0;
    UIGradient.Parent = ImageLabel;

    return UIGradient;
end;

local function createCircularProgressBar(p5) -- Line: 90
    -- upvalues: createProgressBarGradient (copy)
    local CircularProgressBar = p5.CircularProgressBar;
    local u6 = createProgressBarGradient(CircularProgressBar, true);
    local u7 = createProgressBarGradient(CircularProgressBar, false);
    CircularProgressBar.Progress.Changed:Connect(function(p8) -- Line: 97
        -- upvalues: u6 (copy), u7 (copy)
        local math_clamp_ret = math.clamp(p8 * 360, 0, 360);
        u6.Rotation = math.clamp(math_clamp_ret, 180, 360);
        u7.Rotation = math.clamp(math_clamp_ret, 0, 180);
    end);

    return CircularProgressBar;
end;

return {
    createPrompt = function(u9, p10, p11) -- Line: 107, Name: createPrompt
        -- upvalues: TweenService (copy), u1 (copy), UserInputService (copy), u2 (copy), createProgressBarGradient (copy)
        local u12 = {};
        local u13 = {};
        local u14 = {};
        local u15 = {};
        local v16 = {};
        local TweenInfo_new_ret = TweenInfo.new(u9.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
        local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local TweenInfo_new_ret3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local TweenInfo_new_ret4 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
        local u17 = script.Parent.Prompt:Clone();
        local Frame = u17.Frame;
        local Frame2 = Frame.InputFrame.Frame;
        local UIScale = Frame2.UIScale;
        local v18 = u9:FindFirstChild("GuiObject") or Instance.new("ObjectValue");
        v18.Name = "GuiObject";
        v18.Parent = u9;
        v18.Value = u17;
        table.insert(u12, TweenService:Create(UIScale, TweenInfo_new_ret3, {
            Scale = p10 == Enum.ProximityPromptInputType.Touch and 2 or 1.6
        }));
        table.insert(u13, TweenService:Create(UIScale, TweenInfo_new_ret3, {
            Scale = 1
        }));
        table.insert(u14, TweenService:Create(UIScale, TweenInfo_new_ret3, {
            Scale = 1
        }));
        local ActionText = Frame.ActionText;
        local v19 = {
            TextTransparency = 1,
            Size = UDim2.fromScale(1, 0)
        };
        table.insert(u12, TweenService:Create(ActionText, TweenInfo_new_ret3, v19));
        local v20 = {
            TextTransparency = 0,
            Size = UDim2.fromScale(1, 0.22)
        };
        table.insert(u13, TweenService:Create(ActionText, TweenInfo_new_ret3, v20));
        local v21 = {
            TextTransparency = 0,
            Size = UDim2.fromScale(1, 0.22)
        };
        table.insert(u14, TweenService:Create(ActionText, TweenInfo_new_ret3, v21));
        table.insert(u15, TweenService:Create(ActionText, TweenInfo_new_ret3, {
            TextTransparency = 1
        }));
        table.insert(v16, TweenService:Create(ActionText, TweenInfo_new_ret3, {
            TextTransparency = 0
        }));
        local ObjectText = Frame.ObjectText;
        local v22 = {
            TextTransparency = 1,
            Size = UDim2.fromScale(1, 0)
        };
        table.insert(u12, TweenService:Create(ObjectText, TweenInfo_new_ret3, v22));
        local v23 = {
            TextTransparency = 0,
            Size = UDim2.fromScale(1, 0.18)
        };
        table.insert(u13, TweenService:Create(ObjectText, TweenInfo_new_ret3, v23));
        local v24 = {
            TextTransparency = 0,
            Size = UDim2.fromScale(1, 0.18)
        };
        table.insert(u14, TweenService:Create(ObjectText, TweenInfo_new_ret3, v24));
        table.insert(u15, TweenService:Create(ObjectText, TweenInfo_new_ret3, {
            TextTransparency = 1
        }));
        table.insert(v16, TweenService:Create(ObjectText, TweenInfo_new_ret3, {
            TextTransparency = 0
        }));
        table.insert(u12, TweenService:Create(Frame, TweenInfo_new_ret3, {
            BackgroundTransparency = 1
        }));
        table.insert(u13, TweenService:Create(Frame, TweenInfo_new_ret3, {
            BackgroundTransparency = 0.2
        }));
        table.insert(u14, TweenService:Create(Frame, TweenInfo_new_ret3, {
            BackgroundTransparency = 0.2
        }));
        local v25 = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(0.85, 0.85)
        };
        table.insert(u15, TweenService:Create(Frame, TweenInfo_new_ret3, v25));
        local v26 = {
            BackgroundTransparency = 0.2,
            Size = UDim2.fromScale(1, 1)
        };
        table.insert(v16, TweenService:Create(Frame, TweenInfo_new_ret3, v26));
        local RoundFrame = Frame2.RoundFrame;
        table.insert(u15, TweenService:Create(RoundFrame, TweenInfo_new_ret4, {
            BackgroundTransparency = 1
        }));
        table.insert(v16, TweenService:Create(RoundFrame, TweenInfo_new_ret4, {
            BackgroundTransparency = 0.5
        }));
        local v27 = {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        };
        table.insert(u12, TweenService:Create(RoundFrame, TweenInfo_new_ret4, v27));
        local v28 = {
            BackgroundColor3 = Color3.fromRGB(163, 162, 165)
        };
        table.insert(u13, TweenService:Create(RoundFrame, TweenInfo_new_ret4, v28));
        local v29 = {
            BackgroundColor3 = Color3.fromRGB(163, 162, 165)
        };
        table.insert(u14, TweenService:Create(RoundFrame, TweenInfo_new_ret4, v29));
        local ButtonImage = Frame2.ButtonImage;
        local ButtonText = ButtonImage.ButtonText;
        ButtonText.TextTransparency = 1;

        if p10 == Enum.ProximityPromptInputType.Gamepad then
            if u1[u9.GamepadKeyCode] then
                ButtonImage.Image = u1[u9.GamepadKeyCode];
                table.insert(u15, TweenService:Create(ButtonImage, TweenInfo_new_ret4, {
                    ImageTransparency = 1
                }));
                table.insert(v16, TweenService:Create(ButtonImage, TweenInfo_new_ret4, {
                    ImageTransparency = 0
                }));
            end;
        elseif p10 == Enum.ProximityPromptInputType.Touch then
            ButtonImage.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png";
            table.insert(u15, TweenService:Create(ButtonImage, TweenInfo_new_ret4, {
                ImageTransparency = 1
            }));
            table.insert(v16, TweenService:Create(ButtonImage, TweenInfo_new_ret4, {
                ImageTransparency = 0
            }));
        else
            ButtonImage.Image = "rbxasset://textures/ui/Controls/key_single.png";
            table.insert(u15, TweenService:Create(ButtonImage, TweenInfo_new_ret4, {
                ImageTransparency = 1
            }));
            table.insert(v16, TweenService:Create(ButtonImage, TweenInfo_new_ret4, {
                ImageTransparency = 0
            }));
            local StringForKeyCode = UserInputService:GetStringForKeyCode(u9.KeyboardKeyCode);
            local v30 = u2.ButtonImage[u9.KeyboardKeyCode];

            if v30 == nil then
                v30 = u2.ButtonIcons[StringForKeyCode];
            end;

            if v30 == nil then
                StringForKeyCode = u2.KeyCodes[u9.KeyboardKeyCode] or StringForKeyCode;
            end;

            if v30 then
                ButtonImage.Image = v30;
                table.insert(u15, TweenService:Create(ButtonImage, TweenInfo_new_ret4, {
                    ImageTransparency = 1
                }));
                table.insert(v16, TweenService:Create(ButtonImage, TweenInfo_new_ret4, {
                    ImageTransparency = 0
                }));
            elseif StringForKeyCode == nil or StringForKeyCode == "" then
                error("ProximityPrompt \'" .. u9.Name .. "\' has an unsupported keycode for rendering UI: " .. tostring(u9.KeyboardKeyCode));
            else
                ButtonText.Text = StringForKeyCode;
                ButtonText.TextTransparency = 0;
                table.insert(u15, TweenService:Create(ButtonText, TweenInfo_new_ret4, {
                    TextTransparency = 1
                }));
                table.insert(v16, TweenService:Create(ButtonText, TweenInfo_new_ret4, {
                    TextTransparency = 0
                }));
            end;
        end;

        if p10 == Enum.ProximityPromptInputType.Touch or u9.ClickablePrompt then
            local TextButton = u17.TextButton;
            local u31 = false;
            TextButton.InputBegan:Connect(function(p32) -- Line: 213
                -- upvalues: u9 (copy), u31 (ref)
                if (p32.UserInputType == Enum.UserInputType.Touch or p32.UserInputType == Enum.UserInputType.MouseButton1) and p32.UserInputState ~= Enum.UserInputState.Change then
                    u9:InputHoldBegin();
                    u31 = true;
                end;
            end);
            TextButton.InputEnded:Connect(function(p33) -- Line: 219
                -- upvalues: u31 (ref), u9 (copy)
                if (p33.UserInputType == Enum.UserInputType.Touch or p33.UserInputType == Enum.UserInputType.MouseButton1) and u31 then
                    u31 = false;
                    u9:InputHoldEnd();
                end;
            end);
            u17.Active = true;
        end;

        if u9.HoldDuration > 0 then
            local CircularProgressBar = Frame2.CircularProgressBar;
            local u34 = createProgressBarGradient(CircularProgressBar, true);
            local u35 = createProgressBarGradient(CircularProgressBar, false);
            CircularProgressBar.Progress.Changed:Connect(function(p36) -- Line: 97
                -- upvalues: u34 (copy), u35 (copy)
                local math_clamp_ret = math.clamp(p36 * 360, 0, 360);
                u34.Rotation = math.clamp(math_clamp_ret, 180, 360);
                u35.Rotation = math.clamp(math_clamp_ret, 0, 180);
            end);
            table.insert(u12, TweenService:Create(CircularProgressBar.Progress, TweenInfo_new_ret, {
                Value = 1
            }));
            table.insert(u13, TweenService:Create(CircularProgressBar.Progress, TweenInfo_new_ret2, {
                Value = 0
            }));
            local Progress = CircularProgressBar.Progress;
            local TweenInfo_new_ret5 = TweenInfo.new(0.001);
            table.insert(u14, TweenService:Create(Progress, TweenInfo_new_ret5, {
                Value = 0
            }));
        end;

        local u37, u38;

        if u9.HoldDuration > 0 then
            u37 = u9.PromptButtonHoldBegan:Connect(function() -- Line: 247
                -- upvalues: u12 (copy)
                for _, v in ipairs(u12) do
                    v:Play();
                end;
            end);
            u38 = u9.PromptButtonHoldEnded:Connect(function() -- Line: 253
                -- upvalues: u13 (copy)
                for _, v in ipairs(u13) do
                    v:Play();
                end;
            end);
        else
            u37 = nil;
            u38 = nil;
        end;

        local u39 = u9.Triggered:Connect(function() -- Line: 260
            -- upvalues: u14 (copy), TweenService (ref), Frame (copy), TweenInfo_new_ret2 (copy)
            for _, v in ipairs(u14) do
                v:Play();
            end;

            task.delay(0.1, function() -- Line: 264
                -- upvalues: TweenService (ref), Frame (ref), TweenInfo_new_ret2 (ref)
                TweenService:Create(Frame, TweenInfo_new_ret2, {
                    BackgroundColor3 = Color3.fromRGB(17, 17, 17)
                }):Play();
            end);
            Frame.BackgroundColor3 = Color3.fromRGB(1, 44, 0);
        end);
        local u40 = u9.TriggerEnded:Connect(function() -- Line: 270
        end);
        local u41 = u9.Changed:Connect(function() -- Line: 274, Name: updateUIFromPrompt
            -- upvalues: u9 (copy), ObjectText (copy), ActionText (copy)
            if u9.ObjectText == nil or u9.ObjectText == "" then
                ObjectText.Visible = false;
            else
                ObjectText.Visible = true;
            end;

            ActionText.Text = u9.ActionText;
            ObjectText.Text = u9.ObjectText;
            ActionText.AutoLocalize = u9.AutoLocalize;
            ActionText.RootLocalizationTable = u9.RootLocalizationTable;
            ObjectText.AutoLocalize = u9.AutoLocalize;
            ObjectText.RootLocalizationTable = u9.RootLocalizationTable;
        end);

        if u9.ObjectText == nil or u9.ObjectText == "" then
            ObjectText.Visible = false;
        else
            ObjectText.Visible = true;
        end;

        ActionText.Text = u9.ActionText;
        ObjectText.Text = u9.ObjectText;
        ActionText.AutoLocalize = u9.AutoLocalize;
        ActionText.RootLocalizationTable = u9.RootLocalizationTable;
        ObjectText.AutoLocalize = u9.AutoLocalize;
        ObjectText.RootLocalizationTable = u9.RootLocalizationTable;
        u17.Adornee = u9.Parent;
        u17.Parent = p11;

        for _, v in ipairs(v16) do
            v:Play();
        end;

        return function() -- Line: 300, Name: cleanup
            -- upvalues: u37 (ref), u38 (ref), u39 (ref), u40 (ref), u41 (copy), u15 (copy), u17 (copy)
            if u37 then
                u37:Disconnect();
            end;

            if u38 then
                u38:Disconnect();
            end;

            u39:Disconnect();
            u40:Disconnect();
            u41:Disconnect();

            for _, v in ipairs(u15) do
                v:Play();
            end;

            task.delay(0.2, function() -- Line: 317
                -- upvalues: u17 (ref)
                u17.Parent = nil;
            end);
        end;
    end
};