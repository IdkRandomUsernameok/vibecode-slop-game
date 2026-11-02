-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");

return {
    ExamineAvatar = {
        Text = "Examine Avatar",
        Icon = "rbxassetid://17449420345",
        CollapseLeaderboardOnTrigger = false,
        CollapsePlayerViewerOnTrigger = true,
        UpdateInspectorOnTrigger = false,

        TriggerFunction = function(p1) -- Line: 47, Name: TriggerFunction
            local Value = script:WaitForChild("AvatarExaminerPointer").Value;

            if Value then
                Value:WaitForChild("Viewer").Data.SelectedPlayer.Value = p1;
                Value.Enabled = true;
            end;
        end
    },
    AddFriend = {
        Text = "Add Friend",
        Icon = "rbxassetid://17449420190",
        CollapseLeaderboardOnTrigger = false,
        CollapsePlayerViewerOnTrigger = true,
        UpdateInspectorOnTrigger = true,
        VisibleOnYourself = false,
        ShowIfFriends = false,

        TriggerFunction = function(p2) -- Line: 69, Name: TriggerFunction
            -- upvalues: StarterGui (copy)
            StarterGui:SetCore("PromptSendFriendRequest", p2);
        end
    },
    RemoveFriend = {
        Text = "Unfriend",
        Icon = "rbxassetid://17449420483",
        CollapseLeaderboardOnTrigger = false,
        CollapsePlayerViewerOnTrigger = true,
        UpdateInspectorOnTrigger = true,
        VisibleOnYourself = false,
        ShowIfFriends = true,

        TriggerFunction = function(p3) -- Line: 85, Name: TriggerFunction
            -- upvalues: StarterGui (copy)
            StarterGui:SetCore("PromptUnfriend", p3);
        end
    }
};