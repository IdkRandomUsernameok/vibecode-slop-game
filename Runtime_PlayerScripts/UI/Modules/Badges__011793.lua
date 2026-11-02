-- Decompiled with Potassium's decompiler.

local StarterGui = game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1) -- Line: 4
    -- upvalues: StarterGui (copy), ReplicatedStorage (copy)
    local Badges = script.BadgeTemplates.Badges;
    Badges.Parent = p1;
    local v2;

    repeat
        v2 = pcall(function() -- Line: 10
            -- upvalues: StarterGui (ref)
            StarterGui:SetCore("BadgesNotificationsActive", false);
        end);
        task.wait();
    until v2;

    ReplicatedStorage.Events.GetBadge.OnClientEvent:Connect(function(p3) -- Line: 16, Name: showBadge
        -- upvalues: Badges (copy)
        local v4 = Badges.Handle.Template:Clone();
        v4.Cool.BadgeID.Value = p3;
        v4.Visible = true;
        v4.Parent = Badges.Handle;
        v4.Cool.Animation.Enabled = true;
        v4.Size = UDim2.new();
        v4:TweenSize(Badges.Handle.Template.Size, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2);
    end);
end;