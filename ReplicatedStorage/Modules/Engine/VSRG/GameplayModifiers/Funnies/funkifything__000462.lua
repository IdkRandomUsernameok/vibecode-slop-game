-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = nil;
local u2 = nil;
local u3 = true;
local u4 = 0;
local u5 = 50;

local function DynamicFont() -- Line: 10
    -- upvalues: u5 (ref)
    u5 = u5 + 5;

    return u5;
end;

task.spawn(function() -- Line: 14
    -- upvalues: u3 (ref), u5 (ref)
    while task.wait(0.066) and u3 do
        u5 = math.clamp(u5 / 1.03, 50, 80);
    end;
end);

function Increment()
    -- upvalues: u4 (ref), u1 (ref), u5 (ref), TweenService (copy), u2 (ref)
    u4 = u4 + 1;

    if u4 < 20 then
        return;
    end;

    u1.Visible = true;
    u1.Text = u4;
    u1.TextColor3 = Color3.new(1, 1, (math.clamp((400 - u4) / 400, 0, 1)));
    u5 = u5 + 5;
    u1.TextSize = u5;
    TweenService:Create(u1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextSize = 50
    }):Play();

    if u4 % 50 == 0 then
        u2.TextTransparency = 0;
        u2.TextSize = 70;
        u2.Text = u4;
        game:GetService("TweenService"):Create(u2, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextSize = 100,
            TextTransparency = 1
        }):Play();
    end;
end;

function Miss()
    -- upvalues: TweenService (copy), u1 (ref)
    TweenService:Create(u1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextColor3 = Color3.new(1, 0, 0)
    }):Play();
    task.spawn(function() -- Line: 66
        -- upvalues: TweenService (ref), u1 (ref)
        task.wait(0.3);
        TweenService:Create(u1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play();
        task.wait(0.3);
        u1.Visible = false;
    end);
end;

return {
    onCreate = function() -- Line: 82, Name: onCreate
        -- upvalues: u1 (ref), u2 (ref)
        local Api = shared.getApi();
        u1 = Instance.new("TextLabel");
        u1.AnchorPoint = Vector2.new(0.5, 0.5);
        u1.Position = UDim2.fromScale(0.5, 0.5);
        u1.Parent = Api.Game;
        u1.BackgroundTransparency = 1;
        u1.TextColor3 = Color3.new(1, 1, 1);
        u1.TextStrokeColor3 = Color3.new(0, 0, 0);
        u1.TextStrokeTransparency = 0.5;
        u1.TextSize = 50;
        u1.Text = "0";
        u1.Font = Enum.Font.Arcade;
        u1.Visible = false;
        u2 = u1:Clone();
        u2.Visible = true;
        u2.Parent = u1;
        u2.TextStrokeTransparency = 1;
        u2.TextTransparency = 1;
    end,

    onPlayerNoteHit = function(p6, p7) -- Line: 104, Name: onPlayerNoteHit
        if not p6.sustainNote then
            Increment();
        end;
    end,

    ononNoteMiss = Miss,

    clearUp = function() -- Line: 110, Name: clearUp
        -- upvalues: u3 (ref), u1 (ref), u2 (ref), u4 (ref)
        u3 = false;
        u1:Destroy();
        u2:Destroy();
        u4 = 0;
    end
};