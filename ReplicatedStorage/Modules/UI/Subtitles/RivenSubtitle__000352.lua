-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TextService = game:GetService("TextService");
local u1 = {};
u1.__index = u1;
local u2 = {};
local Vector2_new_ret = Vector2.new(10000, 10000);

function u1.new(u3) -- Line: 12
    -- upvalues: u1 (copy), Players (copy), TextService (copy), Vector2_new_ret (copy), u2 (copy), TweenService (copy), RunService (copy)
    local u4 = setmetatable({}, u1);
    u4.Text = u3.Text or "";
    u4.Timeout = u3.Timeout or 1;
    u4.YPosition = u3.YPosition or 0.75;
    u4.Pool = u3.Pool or "Default";
    u4.TypeArgs = u3.TypeAnimationArgs or {
        IsEnabled = false
    };
    u4.SeparatedLetters = u3.SeparatedLetters or false;
    u4.Labels = {};
    u4.StartTime = os.clock();
    local Parent = u3.Parent;

    if not Parent then
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("SubtitleGui");

        if not Parent then
            Parent = Instance.new("ScreenGui", Players.LocalPlayer.PlayerGui);
            Parent.Name = "SubtitleGui";
        end;
    end;

    local v5 = script.SubtitleTemplate:Clone();
    v5.Position = UDim2.fromScale(0.5, u4.YPosition);
    v5.Parent = Parent;

    if u3.Icon then
        v5:FindFirstChild("Icon").Image = u3.Icon;
    else
        v5:FindFirstChild("Icon").Visible = false;
    end;

    local Subtitle = v5:FindFirstChild("Subtitle");

    if u3.Font then
        Subtitle.Font = u3.Font;
    end;

    if u3.TextSize then
        Subtitle.TextSize = u3.TextSize;
    end;

    if u4.SeparatedLetters or u4.TypeArgs.IsEnabled and u4.TypeArgs.LabelPerLetter then
        Subtitle.Visible = false;
        local v6 = v5:FindFirstChildWhichIsA("UIListLayout");

        if v6 then
            v6:Destroy();
        end;

        local TextSize = Subtitle.TextSize;
        local Font = Subtitle.Font;
        local Text = u4.Text;
        local v7 = 0;
        local v8 = {};
        local v9 = 0;

        for i = 1, #Text do
            v9 = TextService:GetTextSize(string.sub(Text, 1, i), TextSize, Font, Vector2_new_ret).X;
            table.insert(v8, v9 - v7);
            v7 = v9;
            local _ = i;
        end;

        local v10 = -v9 / 2;

        for i = 1, #Text do
            local v11 = Subtitle:Clone();
            v11.Text = string.sub(Text, i, i);
            v11.Visible = true;
            v11.LayoutOrder = i;
            v11.TextTransparency = u4.TypeArgs.IsEnabled and 1 or (u3.TextTransparency or 0);
            v11.Size = UDim2.new(0, v8[i], Subtitle.Size.Y.Scale, Subtitle.Size.Y.Offset);
            v11.Position = UDim2.new(0.5, v10, Subtitle.Position.Y.Scale, Subtitle.Position.Y.Offset);
            v11.AnchorPoint = Vector2.new(0, Subtitle.AnchorPoint.Y);
            v11.TextXAlignment = Enum.TextXAlignment.Center;
            v11.Parent = v5;
            table.insert(u4.Labels, v11);
            v10 = v10 + v8[i];
            local _ = i;
        end;

        if u4.TypeArgs.IsEnabled then
            task.spawn(function() -- Line: 96
                -- upvalues: u4 (copy), u3 (copy)
                for _, v in u4.Labels do
                    v.TextTransparency = u3.TextTransparency or 0;
                    task.wait(u4.TypeArgs.TypeSpeed or 0.05);
                end;
            end);
        end;
    else
        Subtitle.Text = u4.Text;
        Subtitle.TextTransparency = u3.TextTransparency or 0;
        table.insert(u4.Labels, Subtitle);
    end;

    if not u2[u4.Pool] then
        u2[u4.Pool] = {};
    end;

    for _, v in u2[u4.Pool] do
        if math.abs(v.YPosition - u4.YPosition) < 0.01 then
            local v12 = v.Container.Position - UDim2.fromScale(0, 0.05);
            TweenService:Create(v.Container, TweenInfo.new(0.3), {
                Position = v12
            }):Play();
        end;
    end;

    u4.Container = v5;
    table.insert(u2[u4.Pool], u4);

    if u3.onUpdate then
        u4.UpdateConnection = RunService.RenderStepped:Connect(function() -- Line: 121
            -- upvalues: u3 (copy), u4 (copy)
            u3.onUpdate(u4, os.clock() - u4.StartTime);
        end);
    end;

    setmetatable(u4, {
        __index = function(p13, p14) -- Line: 127, Name: __index
            -- upvalues: u4 (copy), u1 (ref)
            if type(p14) == "number" then
                return u4.Labels[p14];
            end;

            return u1[p14];
        end
    });

    if u3.onCreate then
        u3.onCreate(u4);
    end;

    task.delay(u4.Timeout, function() -- Line: 139
        -- upvalues: u3 (copy), u4 (copy), u2 (ref)
        if u3.onTimeout then
            u3.onTimeout(u4);
        else
            u4:Destroy();
        end;

        local v15 = u2[u4.Pool];

        if v15 then
            for i, v in v15 do
                if v == u4 then
                    table.remove(v15, i);

                    return;
                end;
            end;
        end;
    end);

    return u4;
end;

function u1.Destroy(p16) -- Line: 160
    if p16.UpdateConnection then
        p16.UpdateConnection:Disconnect();
        p16.UpdateConnection = nil;
    end;

    if p16.Container then
        p16.Container:Destroy();
    end;

    p16.Labels = {};
end;

return u1;