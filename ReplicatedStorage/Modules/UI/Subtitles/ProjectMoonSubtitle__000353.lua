-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;

local function _buildUI(p2, p3) -- Line: 7
    p2.holder = Instance.new("Part");
    p2.holder.Anchored = true;
    p2.holder.CanCollide = false;
    p2.holder.Transparency = 1;
    p2.holder.CFrame = p3;
    p2.holder.Name = "PMProjectMoonSubtitle_Holder";
    p2.holder.Parent = workspace;
    p2.billboard = Instance.new("BillboardGui");
    p2.billboard.AlwaysOnTop = true;
    p2.billboard.Size = UDim2.fromScale(30, 20);
    local billboard = p2.billboard;
    local math_random_ret = math.random(1, 6);
    local math_random_ret2 = math.random(-3, 3);
    billboard.ExtentsOffset = Vector3.new(math_random_ret, math_random_ret2, -3);
    p2.billboard.Parent = p2.holder;
    p2.frame = Instance.new("Frame");
    p2.frame.Size = UDim2.fromScale(1, 0.07);
    p2.frame.Position = UDim2.fromScale(0.5, 0.5);
    p2.frame.AnchorPoint = Vector2.new(0.5, 0.5);
    p2.frame.BackgroundTransparency = 1;
    p2.frame.Rotation = math.random(-4, 4);
    p2.frame.Parent = p2.billboard;
    p2.uilistlayout = Instance.new("UIListLayout");
    p2.uilistlayout.SortOrder = Enum.SortOrder.LayoutOrder;
    p2.uilistlayout.FillDirection = Enum.FillDirection.Horizontal;
    p2.uilistlayout.Padding = UDim.new(0, 0);
    p2.uilistlayout.Parent = p2.frame;
end;

function u1.new(p4, p5, p6, p7, p8) -- Line: 29
    -- upvalues: u1 (copy), _buildUI (copy), TweenService (copy)
    local u9 = setmetatable({}, u1);
    u9.text = p4 or "";
    u9.position = p5 or CFrame.new();
    u9.typespeed = p6 or 0.05;
    u9.timespan = p7 or 2;
    u9.playbackrate = p8 or 1;
    u9.textLabels = {};
    u9.activeTweens = {};
    u9.tweenInfo = TweenInfo.new(1 / u9.playbackrate, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
    _buildUI(u9, u9.position);

    for i = 1, string.len(u9.text) do
        local string_sub_ret = string.sub(u9.text, i, i);
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Size = UDim2.new(0, 20, 0.8, 0);
        TextLabel.Font = Enum.Font.SourceSansBold;
        TextLabel.Text = string_sub_ret;
        TextLabel.TextColor3 = Color3.new(1, 1, 1);
        TextLabel.TextScaled = true;
        TextLabel.TextSize = 24;
        TextLabel.Visible = false;
        TextLabel.LayoutOrder = i;
        TextLabel.Name = "Letter_" .. i;
        TextLabel.Parent = u9.frame;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(255, 215, 0);
        UIStroke.Thickness = 2;
        UIStroke.Parent = TextLabel;
        table.insert(u9.textLabels, TextLabel);
        local _ = i;
    end;

    task.spawn(function() -- Line: 69
        -- upvalues: u9 (copy), TweenService (ref)
        if not (u9.holder and u9.holder.Parent) then
            return;
        end;

        for _, v in ipairs(u9.textLabels) do
            if not (u9.holder and v.Parent) then
                return;
            end;

            v.Visible = true;
            task.wait(u9.typespeed / u9.playbackrate);
        end;

        task.wait(u9.timespan);

        if not (u9.holder and u9.holder.Parent) then
            return;
        end;

        local Time = u9.tweenInfo.Time;

        for _, v in ipairs(u9.textLabels) do
            if v.Parent then
                local v10 = TweenService:Create(v, u9.tweenInfo, {
                    TextTransparency = 1
                });
                local v11 = TweenService:Create(v.UIStroke, u9.tweenInfo, {
                    Transparency = 1
                });
                v10:Play();
                v11:Play();
                table.insert(u9.activeTweens, v10);
                table.insert(u9.activeTweens, v11);
            end;
        end;

        if u9.uilistlayout and u9.uilistlayout.Parent then
            local v12 = TweenService:Create(u9.uilistlayout, u9.tweenInfo, {
                Padding = UDim.new(-0.002, 0)
            });
            v12:Play();
            table.insert(u9.activeTweens, v12);
        end;

        task.wait(Time);
        u9:Destroy();
    end);

    return u9;
end;

function u1.Destroy(p13) -- Line: 106
    for _, v in ipairs(p13.activeTweens) do
        if v then
            v:Cancel();
        end;
    end;

    p13.activeTweens = {};

    if p13.holder then
        p13.holder:Destroy();
        p13.holder = nil;
    end;

    p13.textLabels = {};
    p13.billboard = nil;
    p13.frame = nil;
    p13.uilistlayout = nil;
end;

return u1;