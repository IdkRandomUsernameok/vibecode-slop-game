-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
require(game:GetService("ReplicatedStorage").Modules.Main.VarTweener);

function doJumpscare()
    -- upvalues: Api (copy)
    local JumpscareImage = Api.Settings.JumpscareImage;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Image = "rbxassetid://" .. ((JumpscareImage == nil or JumpscareImage == "") and "7084794697" or JumpscareImage);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 1;
    UIScale.Parent = ImageLabel;
    ImageLabel.Parent = Api.GUI;
    game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.5), {
        Scale = 1.2
    }):Play();
    game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(0.5), {
        ImageTransparency = 1
    }):Play();
    task.delay(0.5, function() -- Line: 25
        -- upvalues: ImageLabel (copy)
        ImageLabel:Destroy();
    end);
end;

return {
    onNoteMiss = doJumpscare
};