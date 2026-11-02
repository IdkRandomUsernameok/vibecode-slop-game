-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");

return {
    Get = function(p1) -- Line: 6, Name: Get
        -- upvalues: RunService (copy), HttpService (copy)
        if RunService:IsClient() then
            return game.ReplicatedStorage.Events.RequestRuleData:InvokeServer();
        end;

        local u2 = nil;
        pcall(function() -- Line: 12
            -- upvalues: u2 (ref), HttpService (ref)
            u2 = HttpService:GetAsync("https://furoyt.xyz/files/afnrules.json") or {
                error = "Failed to get rules data"
            };
        end);

        return HttpService:JSONDecode(u2);
    end
};