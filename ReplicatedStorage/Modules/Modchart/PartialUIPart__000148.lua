-- Decompiled with Potassium's decompiler.

local u1 = {
    MagicNumberX = 0.7535,
    MagicNumberY = 0.7535
};
local math_rad = math.rad;
local math_tan = math.tan;
local _ = math.abs;
local _ = math.max;
local CFrame_new = CFrame.new;
local Vector3_new = Vector3.new;
local Vector2_new = Vector2.new;
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local math_round = math.round;

function vectorToRatio(p2, p3: number)
    -- upvalues: math_round (copy), Vector2_new (copy)
    local X = p2.X;
    local Y = p2.Y;
    local v4 = math_round(Y * p3);

    if X <= v4 then
        return Vector2_new(X, (math_round(X / p3)));
    end;

    return Vector2_new(v4, Y);
end;

function updatePart(p5: userdata, p6: userdata, p7, p8: boolean?, p9, p10)
    -- upvalues: CFrame_new (copy), math_rad (copy), math_tan (copy), Vector2_new (copy), u1 (copy), Vector3_new (copy)
    local v11 = p7 or CFrame_new();
    local ViewportSize = p5.ViewportSize;
    local v12 = math_tan((math_rad(p5.FieldOfView / 2))) * 2 * 1;
    local v13 = ViewportSize.X / ViewportSize.Y * v12;
    local v14 = v13 * p9.X;
    local v15 = v12 * p9.Y;
    local v16 = (Vector2_new((v13 / 2 - v14 / 2) / v13, (v12 / 2 - v15 / 2) / v12) - p10) * 2;
    p6.CFrame = p5.CFrame * CFrame_new(-v16.X * v14 * u1.MagicNumberX, v16.Y * v15 * u1.MagicNumberY, -1) * v11;
    p6.Size = Vector3_new(v14, v15, 0.001);

    return p8 and ViewportSize and ViewportSize or math.max(ViewportSize.X, ViewportSize.Y) / math.max(v13, v12);
end;

function u1.create(p17: userdata, p18: boolean?) -- Line: 59
    -- upvalues: u1 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v19 = script.Part:Clone();
    local v20;

    if type(p17) == "table" then
        v20 = p17[1];
    else
        v20 = p17;
    end;

    local v21 = {
        Quality = 1,
        UseFixedSize = true,
        Size = Vector2.new(1, 1),
        Position = Vector2.new(0, 0),
        Connections = {},
        Part = v19,
        Frame = v20
    };
    local v22;

    if v20 then
        v22 = v20.Parent;
    else
        v22 = v20;
    end;

    v21.Parent = v22;
    v21.Surface = v19.SurfaceGui;
    v21.Offset = CFrame.new();
    v21.Camera = workspace_CurrentCamera;
    local u23 = setmetatable(v21, {
        __index = u1
    });

    if v20 then
        v20.Destroying:Once(function() -- Line: 83
            -- upvalues: u23 (copy)
            u23.Frame = nil;
        end);

        if type(p17) == "table" then
            for _, v in p17 do
                v.Parent = u23.Surface;
            end;
        else
            v20.Parent = u23.Surface;
        end;
    end;

    u23.Surface.SizingMode = u23.UseFixedSize and Enum.SurfaceGuiSizingMode.FixedSize or Enum.SurfaceGuiSizingMode.PixelsPerStud;
    u23.Surface.Adornee = v19;
    u23.Surface.Enabled = true;

    local function updateFunc() -- Line: 100
        -- upvalues: u23 (copy)
        u23:Update();
    end;

    if not p18 then
        local Connections = u23.Connections;
        local PropertyChangedSignal = workspace_CurrentCamera:GetPropertyChangedSignal("FieldOfView");
        table.insert(Connections, PropertyChangedSignal:Connect(updateFunc));
        local Connections2 = u23.Connections;
        local PropertyChangedSignal2 = workspace_CurrentCamera:GetPropertyChangedSignal("CFrame");
        table.insert(Connections2, PropertyChangedSignal2:Connect(updateFunc));
        local Connections3 = u23.Connections;
        local PropertyChangedSignal3 = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize");
        table.insert(Connections3, PropertyChangedSignal3:Connect(updateFunc));
    end;

    v19.Parent = workspace_CurrentCamera;
    u23:Update();

    return u23;
end;

function u1.SetSizingMode(p24, p25) -- Line: 118
    p24.Surface.SizingMode = p25;
    p24.UseFixedSize = p25 == Enum.SurfaceGuiSizingMode.FixedSize;
end;

function u1.Update(p26) -- Line: 123
    local UseFixedSize = p26.UseFixedSize;
    p26.Surface[UseFixedSize and "CanvasSize" or "PixelsPerStud"] = updatePart(p26.Camera, p26.Part, p26.Offset, UseFixedSize, p26.Size, p26.Position) * p26.Quality;
end;

function u1.RenderOnPlrGui(p27) -- Line: 132
    -- upvalues: PlayerGui (copy)
    p27.Surface.Parent = PlayerGui;
end;

function u1.RenderOnPart(p28) -- Line: 136
    p28.Surface.Parent = p28.Part;
end;

function u1.Clear(u29) -- Line: 140
    if u29.Connections then
        for _, v in u29.Connections do
            pcall(function() -- Line: 143
                -- upvalues: v (copy)
                v:Disconnect();
            end);
        end;
    end;

    if u29.Frame then
        u29.Frame.Parent = u29.Parent;
    end;

    pcall(function() -- Line: 155
        -- upvalues: u29 (copy)
        u29.Surface:Destroy();
    end);
    pcall(function() -- Line: 156
        -- upvalues: u29 (copy)
        u29.Part:Destroy();
    end);
    table.clear(u29);
end;

u1.Destroy = u1.Clear;

return u1;