-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata) -- Line: 6
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.highlight = Instance.new("Highlight");
    v3.highlight:SetAttribute("DontTouch", true);
    v3.highlight.FillTransparency = 0.5;
    v3.highlight.OutlineTransparency = 0;
    v3.highlight.FillColor = Color3.fromRGB(255, 255, 255);
    v3.highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    v3.highlight.Parent = p2;
    v3.instance = p2;

    return v3;
end;

function u1.SetTransparency(p4: table, p5: number, p6: number) -- Line: 21
    p4.highlight.FillTransparency = p5 or p4.highlight.FillTransparency;
    p4.highlight.OutlineTransparency = p6 or p4.highlight.OutlineTransparency;
end;

function u1.SetColor(p7, p8, p9) -- Line: 26
    p7.highlight.FillColor = p8;
    p7.highlight.OutlineColor = p9;
end;

function u1.TweenSetTransparency(p10: table, p11: number, p12: number?, p13: number?, u14: function?) -- Line: 31
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v15 = {};

    if p12 then
        v15.FillTransparency = p12;
    end;

    if p13 then
        v15.OutlineTransparency = p13;
    end;

    local u16 = TweenService:Create(p10.highlight, TweenInfo_new_ret, v15);
    u16.Completed:Connect(function() -- Line: 38
        -- upvalues: u14 (copy), u16 (copy)
        if u14 then
            u14();
        end;

        u16:Destroy();
    end);
    u16:Play();
end;

function u1.TweenSetColor(p17: table, p18: number, p19, u20: function?) -- Line: 45
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local u21 = TweenService:Create(p17.highlight, TweenInfo_new_ret, {
        FillColor = p19,
        OutlineColor = p19
    });
    u21.Completed:Connect(function() -- Line: 51
        -- upvalues: u20 (copy), u21 (copy)
        if u20 then
            u20();
        end;

        u21:Destroy();
    end);
    u21:Play();
end;

function u1.Pulse(u22: table, p23: number, p24) -- Line: 58
    -- upvalues: TweenService (copy)
    local FillColor = u22.highlight.FillColor;
    local v25 = p24 or FillColor;
    u22.highlight.FillColor = v25;
    u22.highlight.OutlineColor = v25;
    local TweenInfo_new_ret = TweenInfo.new(p23 / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true);
    local u26 = TweenService:Create(u22.highlight, TweenInfo_new_ret, {
        OutlineTransparency = -1
    });
    u26.Completed:Connect(function() -- Line: 70
        -- upvalues: u22 (copy), FillColor (copy), u26 (copy)
        u22.highlight.FillColor = FillColor;
        u22.highlight.OutlineColor = FillColor;
        u26:Destroy();
    end);
    u26:Play();
end;

function u1.Destroy(p27) -- Line: 79
    if p27.highlight then
        p27.highlight:Destroy();
    end;

    setmetatable(p27, nil);
end;

return u1;