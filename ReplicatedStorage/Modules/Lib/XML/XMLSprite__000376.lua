-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
game:GetService("ReplicatedStorage");
script:FindFirstAncestor("Modules");
local XMLAnim = require(script.Parent.XMLAnim);
local u1 = {};
u1._ = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: XMLAnim (copy), u1 (copy), RunService (copy)
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromOffset(100, 100);
    ImageLabel.ScaleType = Enum.ScaleType.Stretch;
    ImageLabel.Name = "XMLSprite_ImageLabel";
    ImageLabel.BackgroundTransparency = 1;
    local v3 = {
        Destroyed = false,
        CanUpdate = true,
        UpdateConnection = nil,
        Position = Vector2.new(0, 0),
        Size = Vector2.new(1, 1),
        AnimationManager = XMLAnim.new(),
        ImageLabel = ImageLabel
    };
    local u4 = setmetatable(v3, u1);

    if p2 then
        u4.UpdateConnection = RunService.RenderStepped:Connect(function(p5) -- Line: 38
            -- upvalues: u4 (copy)
            u4:Update(p5);
        end);
    end;

    return u4;
end;

function u1.AddByPrefix(p6, p7, p8, p9, p10, p11, p12) -- Line: 47
    p6.AnimationManager:AddByPrefix(p7, p8, p9, p10, p11, p12);
end;

function u1.Play(p13, p14, p15) -- Line: 51
    p13.AnimationManager:Play(p13.ImageLabel, p14, p15);
end;

function u1.StopAll(p16) -- Line: 55
    p16.AnimationManager:StopAll();
end;

function u1.Update(p17, p18) -- Line: 59
    if p17.CanUpdate then
        p17.AnimationManager.Position = p17.Position;
        p17.AnimationManager.Size = p17.Size;
        p17.AnimationManager:Update(p18, p17.ImageLabel);
    end;
end;

function u1.Destroy(p19) -- Line: 68
    p19.CanUpdate = false;
    p19.Destroyed = true;

    if p19.UpdateConnection then
        p19.UpdateConnection:Disconnect();
    end;

    p19.ImageLabel:Destroy();
end;

return u1;