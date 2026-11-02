-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();

local function jesus() -- Line: 3
    -- upvalues: Api (copy)
    task.spawn(function() -- Line: 7
        -- upvalues: Api (ref)
        Api.playSound("rbxassetid://81365298804299");
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Image = "rbxassetid://17154974149";
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Size = UDim2.fromScale(1, 1);
        ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
        ImageLabel.Parent = Api.Overlay;
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        local v1 = game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(0.25), {
            ImageTransparency = 1
        });
        task.wait(0.25);
        v1:Play();
        v1.Completed:Wait();
        ImageLabel:Destroy();
    end);
end;

return {
    onPlayerNoteHit = function(p2, p3) -- Line: 27, Name: onPlayerNoteHit
        -- upvalues: Api (copy)
        if p2.sustainNote then
            return;
        end;

        if string.lower(p3.name) == "bad" then
            task.spawn(function() -- Line: 7
                -- upvalues: Api (ref)
                Api.playSound("rbxassetid://81365298804299");
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Image = "rbxassetid://17154974149";
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.Size = UDim2.fromScale(1, 1);
                ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
                ImageLabel.Parent = Api.Overlay;
                ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
                local v4 = game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(0.25), {
                    ImageTransparency = 1
                });
                task.wait(0.25);
                v4:Play();
                v4.Completed:Wait();
                ImageLabel:Destroy();
            end);
        end;
    end,

    onNoteMiss = function(p5) -- Line: 36, Name: onNoteMiss
        -- upvalues: Api (copy)
        task.spawn(function() -- Line: 7
            -- upvalues: Api (ref)
            Api.playSound("rbxassetid://81365298804299");
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Image = "rbxassetid://17154974149";
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel.Parent = Api.Overlay;
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            local v6 = game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(0.25), {
                ImageTransparency = 1
            });
            task.wait(0.25);
            v6:Play();
            v6.Completed:Wait();
            ImageLabel:Destroy();
        end);
    end
};