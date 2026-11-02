-- Decompiled with Potassium's decompiler.

local u1 = {};
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

function updatePart(p5: userdata, p6: userdata, p7, p8: boolean?)
    -- upvalues: CFrame_new (copy), math_rad (copy), math_tan (copy), Vector3_new (copy)
    local v9 = p7 or CFrame_new();
    local ViewportSize = p5.ViewportSize;
    local v10 = math_tan((math_rad(p5.FieldOfView / 2))) * 2 * 1;
    local v11 = ViewportSize.X / ViewportSize.Y * v10;
    p6.CFrame = p5.CFrame * CFrame_new(0, 0, -1) * v9;
    p6.Size = Vector3_new(v11, v10, 0.001);

    return p8 and ViewportSize and ViewportSize or math.max(ViewportSize.X, ViewportSize.Y) / math.max(v11, v10);
end;

function u1.create(p12: userdata, p13: boolean?) -- Line: 64
    -- upvalues: u1 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v14 = script.Part:Clone();
    v14.Name = "UIPart";
    local v15;

    if type(p12) == "table" then
        v15 = p12[1];
    else
        v15 = p12;
    end;

    local v16 = {
        Quality = 1,
        UseFixedSize = true,
        Connections = {},
        Part = v14,
        Frame = v15,
        Parent = v15.Parent,
        Surface = v14.SurfaceGui,
        Offset = CFrame.new(),
        Camera = workspace_CurrentCamera
    };
    local u17 = setmetatable(v16, {
        __index = u1
    });
    v15.Destroying:Once(function() -- Line: 86
        -- upvalues: u17 (copy)
        u17.Frame = nil;
    end);

    if type(p12) == "table" then
        for _, v in p12 do
            v.Parent = u17.Surface;
        end;
    else
        v15.Parent = u17.Surface;
    end;

    u17.Surface.SizingMode = u17.UseFixedSize and Enum.SurfaceGuiSizingMode.FixedSize or Enum.SurfaceGuiSizingMode.PixelsPerStud;
    u17.Surface.Adornee = v14;
    u17.Surface.Enabled = true;

    local function updateFunc() -- Line: 102
        -- upvalues: u17 (copy)
        u17:Update();
    end;

    if not p13 then
        local Connections = u17.Connections;
        local PropertyChangedSignal = workspace_CurrentCamera:GetPropertyChangedSignal("FieldOfView");
        table.insert(Connections, PropertyChangedSignal:Connect(updateFunc));
        local Connections2 = u17.Connections;
        local PropertyChangedSignal2 = workspace_CurrentCamera:GetPropertyChangedSignal("CFrame");
        table.insert(Connections2, PropertyChangedSignal2:Connect(updateFunc));
        local Connections3 = u17.Connections;
        local PropertyChangedSignal3 = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize");
        table.insert(Connections3, PropertyChangedSignal3:Connect(updateFunc));
    end;

    v14.Parent = workspace_CurrentCamera;
    u17:Update();

    return u17;
end;

function u1.SetSizingMode(p18, p19) -- Line: 120
    p18.Surface.SizingMode = p19;
    p18.UseFixedSize = p19 == Enum.SurfaceGuiSizingMode.FixedSize;
end;

function u1.Update(p20) -- Line: 125
    if not p20.Frame then
        return;
    end;

    local UseFixedSize = p20.UseFixedSize;
    p20.Surface[UseFixedSize and "CanvasSize" or "PixelsPerStud"] = updatePart(p20.Camera, p20.Part, p20.Offset, UseFixedSize) * p20.Quality;
end;

function u1.RenderOnPlrGui(p21) -- Line: 134
    -- upvalues: PlayerGui (copy)
    p21.Surface.Parent = PlayerGui;
end;

function u1.RenderOnPart(p22) -- Line: 138
    p22.Surface.Parent = p22.Part;
end;

function u1.Clear(u23) -- Line: 142
    if u23.Connections then
        for _, v in u23.Connections do
            pcall(function() -- Line: 145
                -- upvalues: v (copy)
                v:Disconnect();
            end);
        end;
    end;

    if u23.Frame then
        u23.Frame.Parent = u23.Parent;
    end;

    pcall(function() -- Line: 157
        -- upvalues: u23 (copy)
        u23.Surface:Destroy();
    end);
    pcall(function() -- Line: 158
        -- upvalues: u23 (copy)
        u23.Part:Destroy();
    end);
    table.clear(u23);
end;

u1.Destroy = u1.Clear;

return u1;