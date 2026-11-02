-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local DataManager = require(Modules.Data.DataManager);
local BloxstrapRPC = require(Modules.Engine.BloxstrapRPC);

return function(p1, p2, p3) -- Line: 7
    -- upvalues: DataManager (copy), BloxstrapRPC (copy)
    local Data = DataManager:GetData();

    if not BloxstrapRPC.UsesBloxstrap or (BloxstrapRPC.IsGameAllowed or Data.hasSeenBloxstrapDialog) then
        return;
    end;

    local BloxstrapDialog = p1.Parent:WaitForChild("BloxstrapDialog");
    local Main = BloxstrapDialog:WaitForChild("Main");
    Main.Buttons.GivePerms.MouseButton1Click:Connect(function() -- Line: 17
        -- upvalues: DataManager (ref), BloxstrapRPC (ref), Main (copy), BloxstrapDialog (copy)
        DataManager:SetData("hasSeenBloxstrapDialog", true);
        BloxstrapRPC.RequestWindowPermission();
        Main.Visible = false;
        BloxstrapDialog:Destroy();
    end);
    Main.Buttons.NotNow.MouseButton1Click:Connect(function() -- Line: 25
        -- upvalues: DataManager (ref), Main (copy), BloxstrapDialog (copy)
        DataManager:SetData("hasSeenBloxstrapDialog", true);
        Main.Visible = false;
        BloxstrapDialog:Destroy();
    end);
    Main.Visible = true;
end;