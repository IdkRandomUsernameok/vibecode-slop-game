-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();

local function jesus() -- Line: 3
    -- upvalues: Api (copy)
    task.spawn(function() -- Line: 7
        -- upvalues: Api (ref)
        Api.playSound("rbxassetid://15045883529");
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Image = "rbxassetid://12427705637";
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Size = UDim2.fromScale(1, 1);
        ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
        ImageLabel.Parent = Api.Overlay;
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        local v1 = game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(0.55), {
            ImageTransparency = 1
        });
        task.wait(0.25);
        v1:Play();
        v1.Completed:Wait();
        ImageLabel:Destroy();
    end);
end;

return {
    onNoteMiss = function(p2) -- Line: 27, Name: onNoteMiss
        -- upvalues: Api (copy)
        if Api.RNG:NextInteger(1, 25) == 1 then
            task.spawn(function() -- Line: 7
                -- upvalues: Api (ref)
                Api.playSound("rbxassetid://15045883529");
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Image = "rbxassetid://12427705637";
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.Size = UDim2.fromScale(1, 1);
                ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
                ImageLabel.Parent = Api.Overlay;
                ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
                local v3 = game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(0.55), {
                    ImageTransparency = 1
                });
                task.wait(0.25);
                v3:Play();
                v3.Completed:Wait();
                ImageLabel:Destroy();
            end);
        end;
    end
};