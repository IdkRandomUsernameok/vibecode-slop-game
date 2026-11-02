-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 9
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4.Container = script:FindFirstChild("TVEffectV3"):Clone();
    v4.ScanlineContainer = v4.Container.ScanlineContainer;
    v4.ScanlineContainer.Parent = p2;
    v4.Vignette = v4.Container.Vignette;
    v4.Vignette.Parent = p3;
    v4.Tween = nil;

    return v4;
end;

function u1.ToggleVCRShaderV3Movement(p5, p6) -- Line: 23
    -- upvalues: TweenService (copy)
    if not p6 then
        if p5.Tween then
            p5.Tween:Cancel();
            p5.Tween = nil;
        end;

        return;
    end;

    local TweenInfo_new_ret = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1);
    p5.Tween = TweenService:Create(p5.ScanlineContainer, TweenInfo_new_ret, {
        Position = UDim2.fromScale(0.5, 0.45)
    });
    p5.Tween:Play();
end;

function u1.SetVisibility(p7, p8) -- Line: 34
    p7.ScanlineContainer.Visible = p8;
    p7.Vignette.Visible = p8;
end;

function u1.Destroy(p9) -- Line: 39
    if p9.Tween then
        p9.Tween:Cancel();
    end;

    p9.Container:Destroy();
    p9.ScanlineContainer:Destroy();
    p9.Vignette:Destroy();
end;

return u1;