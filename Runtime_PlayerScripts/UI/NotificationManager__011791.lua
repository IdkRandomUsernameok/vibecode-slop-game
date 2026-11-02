-- Decompiled with Potassium's decompiler.

local u1 = {};

if game:GetService("RunService"):IsServer() then
    return u1;
end;

local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalSignals = require(ReplicatedStorage:WaitForChild("Modules").Signals.LocalSignals);
local u2 = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main"):WaitForChild("ErrorOverlayV2"):WaitForChild("i guess bro");
local HeaderTemplate = u2:WaitForChild("HeaderTemplate");
local ContentTemplate = u2:WaitForChild("ContentTemplate");
local u3 = "R";
local u4 = {};

local function recalculateLayout() -- Line: 25
    -- upvalues: u4 (copy)
    local v5 = 1;

    for i = #u4, 1, -1 do
        local v6 = u4[i];
        local v7;

        if v6.isActive then
            v6.headerFrame.LayoutOrder = v5;
            v5 = v5 + 1;

            if v6.contentFrame then
                if v6.contentVisible then
                    v6.contentFrame.Visible = true;
                    v6.contentFrame.LayoutOrder = v5;
                    v5 = v5 + 1;
                    v7 = i;
                else
                    v6.contentFrame.Visible = false;
                    v7 = i;
                end;
            else
                v7 = i;
            end;
        else
            v7 = i;
        end;
    end;
end;

local function removeNotification(p8: string) -- Line: 46
    -- upvalues: u4 (copy), TweenService (copy), recalculateLayout (copy)
    local v9 = nil;

    for i, v in u4 do
        if v.id == p8 then
            v.isActive = false;
            v9 = i;

            for _, v2 in { v.headerFrame, v.contentFrame } do
                if v2 then
                    local v10 = TweenService:Create(v2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 1
                    });
                    local u11 = v2;

                    for _, descendant in v2:GetDescendants() do
                        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
                            TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                TextTransparency = 1
                            }):Play();
                        elseif descendant:IsA("ImageLabel") then
                            TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ImageTransparency = 1
                            }):Play();
                        end;
                    end;

                    v10:Play();
                    v10.Completed:Connect(function() -- Line: 67
                        -- upvalues: u11 (copy)
                        u11:Destroy();
                    end);
                end;
            end;

            break;
        end;
    end;

    if v9 then
        table.remove(u4, v9);
        recalculateLayout();
    end;
end;

local function toggleHeader(p12: string) -- Line: 81
    -- upvalues: u4 (copy), recalculateLayout (copy)
    for _, v in u4 do
        if v.id == p12 and v.contentFrame then
            v.contentVisible = not v.contentVisible;
            break;
        end;
    end;

    recalculateLayout();
end;

local function darkenColor(p13, p14: number) -- Line: 91
    local v15, v16, v17 = p13:ToHSV();

    return Color3.fromHSV(v15, v16, (math.clamp(v17 * p14, 0, 1)));
end;

local function updateGraphicSide(p18: userdata) -- Line: 96
    -- upvalues: u3 (ref)
    local Graphic = p18:FindFirstChild("Graphic");
    local Container = p18:FindFirstChild("Container");

    if not (Graphic and Container) then
        return;
    end;

    local v19 = u3 == "R";
    Graphic.Position = v19 and UDim2.new(1, 0, 0, 0) or UDim2.new(0, 0, 0, 0);
    Graphic.AnchorPoint = v19 and Vector2.new(1, 0) or Vector2.new(0, 0);
    Container.Position = v19 and UDim2.new(0, 0, 0, 0) or UDim2.new(1, 0, 0, 0);
    Container.AnchorPoint = v19 and Vector2.new(0, 0) or Vector2.new(1, 0);
    local ImageLabel = Graphic:FindFirstChild("ImageLabel");

    if ImageLabel then
        ImageLabel.Rotation = v19 and 0 or 180;
    end;

    local v20 = Container:FindFirstChild("TextButton") or Container:FindFirstChild("TextLabel");

    if v20 then
        v20.TextXAlignment = v19 and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left;
    end;
end;

local function cloneTemplate(p21: any, p22, p23: string) -- Line: 120
    -- upvalues: HeaderTemplate (copy), ContentTemplate (copy), u2 (copy), updateGraphicSide (copy)
    local v24 = p21 == "Header" and HeaderTemplate:Clone() or ContentTemplate:Clone();
    v24.Parent = u2;
    v24.Name = p21 .. p23;
    local Graphic = v24:FindFirstChild("Graphic");
    local v25 = Graphic and Graphic:FindFirstChild("ImageLabel");

    if v25 then
        local v26, v27, v28 = p22:ToHSV();
        v25.ImageColor3 = Color3.fromHSV(v26, v27, (math.clamp(v28 * 0.8, 0, 1)));
    end;

    updateGraphicSide(v24);
    local Container = v24:FindFirstChild("Container");
    local v29 = Container and (p21 == "Header" and Container:FindFirstChild("TextButton") or Container:FindFirstChild("TextLabel"));

    if v29 then
        v29.TextColor3 = p22;
    end;

    return v24;
end;

function u1.SetSide(p30: string) -- Line: 144
    -- upvalues: u3 (ref), u2 (copy), u4 (copy), updateGraphicSide (copy)
    u3 = p30;
    u2.UIListLayout.HorizontalAlignment = p30 == "R" and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left;

    for _, v in u4 do
        if v.headerFrame then
            updateGraphicSide(v.headerFrame);
        end;

        if v.contentFrame then
            updateGraphicSide(v.contentFrame);
        end;
    end;
end;

function u1.Notify(p31: table) -- Line: 158
    -- upvalues: u4 (copy), removeNotification (copy), HttpService (copy), cloneTemplate (copy), toggleHeader (copy), recalculateLayout (copy)
    local v32 = p31.color or Color3.fromRGB(255, 255, 255);

    for _, v in u4 do
        if v.isActive and (v.headerText == p31.header and (v.contentText == p31.content and v.color == v32)) then
            v.count = v.count + 1;
            v.headerLabel.Text = `{v.headerText} (x{v.count})`;

            if v.currentDelay then
                task.cancel(v.currentDelay);
            end;

            if p31.timeout and p31.timeout > 0 then
                v.currentDelay = task.delay(p31.timeout, function() -- Line: 171
                    -- upvalues: removeNotification (ref), v (copy)
                    removeNotification(v.id);
                end);
            end;

            return;
        end;
    end;

    local u33 = HttpService:GenerateGUID(false):sub(1, 8);
    local v34 = cloneTemplate("Header", v32, u33);
    v34.Visible = true;
    local v35 = v34.Container:FindFirstChild("TextButton") or v34.Container:FindFirstChild("TextLabel");
    v35.Text = p31.header or "";
    local v36 = nil;
    local v37 = nil;

    if p31.content and p31.content ~= "" then
        local v38 = p31.content:gsub("\n%s*\n", "\n"):gsub("^%s+", ""):gsub("%s+$", "");

        if v38 ~= "" then
            v36 = cloneTemplate("Content", v32, u33);
            v37 = v36.Container:FindFirstChild("TextLabel");
            v37.Text = v38;
            local _, v39 = v38:gsub("\n", "");
            v36.Size = UDim2.new(v36.Size.X.Scale, v36.Size.X.Offset, 0, (v39 + 1) * 20);
        end;
    end;

    local v40 = {
        isActive = true,
        count = 1,
        currentDelay = nil,
        id = u33,
        headerText = p31.header,
        contentText = p31.content,
        color = v32,
        headerFrame = v34,
        headerLabel = v35,
        contentFrame = v36,
        contentLabel = v37,
        contentVisible = not p31.contentHiddenByDefault
    };

    if v35:IsA("TextButton") then
        v35.MouseButton1Click:Connect(function() -- Line: 219
            -- upvalues: toggleHeader (ref), u33 (copy)
            toggleHeader(u33);
        end);
    end;

    table.insert(u4, v40);
    recalculateLayout();

    if p31.timeout and p31.timeout > 0 then
        v40.currentDelay = task.delay(p31.timeout, function() -- Line: 228
            -- upvalues: removeNotification (ref), u33 (copy)
            removeNotification(u33);
        end);
    end;
end;

LocalSignals.SendNotification:Connect(function(p41: table) -- Line: 242
    -- upvalues: u1 (copy)
    u1.Notify({
        header = p41.header or "",
        content = p41.content or "",
        contentHiddenByDefault = p41.contentHiddenByDefault or true,
        color = p41.color or Color3.new(1, 1, 1),
        timeout = p41.timeout or 1
    });
end);
LocalSignals.SetNotificationSide:Connect(function(p42) -- Line: 252
    -- upvalues: u1 (copy)
    u1.SetSide(p42);
end);

return u1;