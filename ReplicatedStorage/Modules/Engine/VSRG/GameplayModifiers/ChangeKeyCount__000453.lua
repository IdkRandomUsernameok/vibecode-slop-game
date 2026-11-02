-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();

return {
    onCreate = function() -- Line: 5, Name: onCreate
        -- upvalues: Api (copy)
        local KeyData = Api.getKeyData();
        KeyData.playerKeyCount = 6;
        local v1 = shared.currentDevice == "Console" and Api.Settings.ConsoleKeybinds or Api.Settings.Keybinds;
        Api.changeKeybinds(v1[tostring(6)] or (v1["4"] or {}));

        for _, v in Api.Strumlines do
            v.KeyCount = 6;
            v.StartPoint = v:getStartingPoint(6);
            v:regenerateStrums();
        end;

        if Api.Settings.Middlescroll and KeyData.chartPlayers == 2 then
            Api.doMiddlescroll(Api.Settings.ShowOpponentOnMiddlescroll);
        end;

        require(game:GetService("ReplicatedStorage").Modules.Engine.VSRG.GameplayModifiers.RandomizeChart:Clone()).onCreate();

        for _, v in Api.Strumlines do
            v:updateAnchorOffsets();
        end;

        Api.loadNoteskin();
    end
};