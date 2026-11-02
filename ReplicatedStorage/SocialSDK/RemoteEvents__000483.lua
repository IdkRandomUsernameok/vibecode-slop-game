-- Decompiled with Potassium's decompiler.

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local u2 = nil;

local function resolveFolder() -- Line: 11
    -- upvalues: u2 (ref), RunService (copy), ReplicatedStorage (copy)
    if u2 then
        return u2;
    end;

    if RunService:IsServer() then
        local SocialSDK = ReplicatedStorage:FindFirstChild("SocialSDK");

        if not SocialSDK then
            SocialSDK = Instance.new("Folder");
            SocialSDK.Name = "SocialSDK";
            SocialSDK.Parent = ReplicatedStorage;
        end;

        u2 = SocialSDK;
    else
        u2 = ReplicatedStorage:WaitForChild("SocialSDK");
    end;

    return u2;
end;

function v1.getOrCreate(p3, p4) -- Line: 36
    -- upvalues: RunService (copy), resolveFolder (copy)
    local v5 = RunService:IsServer();
    assert(v5, "RemoteEvents.getOrCreate is server-only");
    local v6 = resolveFolder();
    local v7 = v6:FindFirstChild(p3);

    if v7 then
        return v7;
    end;

    local Instance_new_ret = Instance.new(p4 or "RemoteEvent");
    Instance_new_ret.Name = p3;
    Instance_new_ret.Parent = v6;

    return Instance_new_ret;
end;

function v1.waitFor(p8) -- Line: 54
    -- upvalues: resolveFolder (copy)
    return resolveFolder():WaitForChild(p8, 5);
end;

function v1.tryGet(p9, p10) -- Line: 61
    -- upvalues: resolveFolder (copy)
    return resolveFolder():WaitForChild(p9, p10 or 10);
end;

return v1;