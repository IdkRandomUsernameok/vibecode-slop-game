-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local NumberValue = Instance.new("NumberValue");
local NumberValue2 = Instance.new("NumberValue");
local NumberValue3 = Instance.new("NumberValue");
task.spawn(function() -- Line: 7
    -- upvalues: NumberValue (copy), NumberValue3 (copy), NumberValue2 (copy), TweenService (copy)
    NumberValue.Changed:Connect(function(p1) -- Line: 8
        -- upvalues: NumberValue3 (ref), NumberValue (ref), NumberValue2 (ref)
        script.Parent.UIStroke.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue3.Value, 0), NumberSequenceKeypoint.new(NumberValue.Value, NumberValue2.Value, 0), NumberSequenceKeypoint.new(1, NumberValue2.Value, 0) });
        script.Parent.UIGradient.Transparency = script.Parent.UIStroke.UIGradient.Transparency;
    end);
    NumberValue2.Changed:Connect(function(p2) -- Line: 13
        -- upvalues: NumberValue3 (ref), NumberValue (ref), NumberValue2 (ref)
        script.Parent.UIStroke.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue3.Value, 0), NumberSequenceKeypoint.new(NumberValue.Value, NumberValue2.Value, 0), NumberSequenceKeypoint.new(1, NumberValue2.Value, 0) });
        script.Parent.UIGradient.Transparency = script.Parent.UIStroke.UIGradient.Transparency;
    end);
    NumberValue3.Changed:Connect(function(p3) -- Line: 18
        -- upvalues: NumberValue3 (ref), NumberValue (ref), NumberValue2 (ref)
        script.Parent.UIStroke.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue3.Value, 0), NumberSequenceKeypoint.new(NumberValue.Value, NumberValue2.Value, 0), NumberSequenceKeypoint.new(1, NumberValue2.Value, 0) });
        script.Parent.UIGradient.Transparency = script.Parent.UIStroke.UIGradient.Transparency;
    end);
    NumberValue3.Value = 1;
    NumberValue2.Value = 1;
    NumberValue.Value = 0.99;
    task.spawn(function() -- Line: 27
        local BadgeInfoAsync = game.BadgeService:GetBadgeInfoAsync(script.Parent.BadgeID.Value);
        script.Parent.Badge.Text = BadgeInfoAsync.DisplayName;
        script.Parent.Icon.Image = "rbxassetid://" .. BadgeInfoAsync.IconImageId;
    end);
    script.Parent.Sound:Play();
    TweenService:Create(NumberValue2, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    TweenService:Create(NumberValue, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 0.5
    }):Play();
    task.wait(0.3);
    TweenService:Create(NumberValue2, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Value = 0.7
    }):Play();
    TweenService:Create(NumberValue, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Value = 0.8
    }):Play();
    task.wait(0.4);
    TweenService:Create(NumberValue, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0.01
    }):Play();
    TweenService:Create(NumberValue2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    TweenService:Create(NumberValue3, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    task.wait(0.15);
    script.Parent.Flash.Transparency = 0;
    script.Parent.Icon.ImageTransparency = 0;
    script.Parent.Title.TextTransparency = 0;
    script.Parent.Badge.TextTransparency = 0;
    TweenService:Create(script.Parent.Flash, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    task.wait(7);
    TweenService:Create(script.Parent, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 10)
    }):Play();
    task.wait(2);
    script.Parent.Parent:Destroy();
end);