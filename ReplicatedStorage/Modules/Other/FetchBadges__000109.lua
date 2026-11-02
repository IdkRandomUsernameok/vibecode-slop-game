-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};

return function(u2) -- Line: 8
    -- upvalues: RunService (copy), ReplicatedStorage (copy), u1 (copy), HttpService (copy)
    if RunService:IsClient() then
        return ReplicatedStorage:WaitForChild("Events").RequestBadgeData:InvokeServer(u2);
    end;

    local v3 = u1[u2];

    if v3 == nil then
        local success, result = pcall(function() -- Line: 15
            -- upvalues: HttpService (ref), u2 (copy)
            return HttpService:JSONDecode(HttpService:GetAsync((`https://badges.roproxy.com/v1/universes/{u2}/badges?limit=100&sortOrder=Asc`)));
        end);

        if success then
            u1[u2] = result;

            return result;
        end;

        warn((`[FetchBadges] Failed to fetch badges for universeID: {u2}.`));
        v3 = {};
    end;

    return v3;
end;