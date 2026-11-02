-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");

return function(p1, p2) -- Line: 3
    -- upvalues: UserInputService (copy)
    local LeaderboardV3 = require(p1:WaitForChild("UI"):WaitForChild("LeaderboardV3"));
    LeaderboardV3:Init();
    local Data = p2.DataManager:GetData();
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 12
        -- upvalues: UserInputService (ref), LeaderboardV3 (copy)
        if UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
            LeaderboardV3.DisableOpenLeaderboardButton();

            return;
        end;

        LeaderboardV3.EnableOpenLeaderboardButton();
    end);

    if UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
        LeaderboardV3.DisableOpenLeaderboardButton();
    else
        LeaderboardV3.EnableOpenLeaderboardButton();
    end;

    p2.DataManager.DataChanged:Connect(function(p3) -- Line: 28
        -- upvalues: LeaderboardV3 (copy), Data (copy)
        if p3 == "Keybinds/Miscellaneous/LeaderboardKeybind" or p3 == "ConsoleKeybinds/Miscellaneous/LeaderboardKeybind" then
            LeaderboardV3.ToggleKeybinds = { Data.Keybinds.Miscellaneous.LeaderboardKeybind, Data.ConsoleKeybinds.Miscellaneous.LeaderboardKeybind };
        end;
    end);

    if Data then
        LeaderboardV3.ToggleKeybinds = { Data.Keybinds.Miscellaneous.LeaderboardKeybind, Data.ConsoleKeybinds.Miscellaneous.LeaderboardKeybind };
    end;

    p2.LocalSignals.PlayingRound:Connect(function(p4) -- Line: 39
        -- upvalues: Data (copy), LeaderboardV3 (copy)
        if Data.DisableLeaderboardOnGameplay then
            if p4 then
                if LeaderboardV3.LeaderboardEnabled then
                    LeaderboardV3:DisableLeaderboard();
                end;
            elseif not LeaderboardV3.LeaderboardEnabled and Data.LeaderboardEnabled then
                LeaderboardV3:EnableLeaderboard();
            end;
        end;
    end);
end;