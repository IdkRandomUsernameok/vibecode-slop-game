-- Decompiled with Potassium's decompiler.

local TeleportService = game:GetService("TeleportService");
local Players = game:GetService("Players");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local LocalPlayerTeleportData = TeleportService:GetLocalPlayerTeleportData();

if LocalPlayerTeleportData and type(LocalPlayerTeleportData) == "table" then
    if LocalPlayerTeleportData.isSoftShutdownReserveServer then
        LocalPlayerTeleportData.isServerRestarting = true;
        LocalPlayerTeleportData.TeleportBackOptions = {
            FinishedUpdate = true
        };
    end;

    if LocalPlayerTeleportData.isServerRestarting == true or LocalPlayerTeleportData.FinishedUpdate == true then
        ReplicatedFirst:RemoveDefaultLoadingScreen();
    end;

    if LocalPlayerTeleportData.isServerRestarting == true then
        ReplicatedFirst:RemoveDefaultLoadingScreen();
        local v1 = script.UpdateWaiting:Clone();
        v1.Enabled = true;
        v1.Screen.RestartServer.Info.RandomText.Text = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Data"):WaitForChild("UpdateTexts"))(false);
        v1.Parent = LocalPlayer.PlayerGui;
        TeleportService:SetTeleportGui(v1);
        task.wait(3);
        TeleportService:Teleport(game.PlaceId, LocalPlayer, LocalPlayerTeleportData.TeleportBackOptions, LocalPlayer.PlayerGui:FindFirstChild(v1.Name));

        return;
    end;

    if LocalPlayerTeleportData.FinishedUpdate == true then
        ReplicatedFirst:RemoveDefaultLoadingScreen();
        local v2 = script.FinishedUpdate:Clone();
        v2.Enabled = true;
        v2.Parent = LocalPlayer.PlayerGui;
        TeleportService:SetTeleportGui(v2);

        if not game:IsLoaded() then
            game.Loaded:Wait();
        end;
    end;
end;