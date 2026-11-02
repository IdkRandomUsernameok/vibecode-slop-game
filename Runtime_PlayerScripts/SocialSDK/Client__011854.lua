-- Decompiled with Potassium's decompiler.

local SocialSDK = game:GetService("ReplicatedStorage"):WaitForChild("SocialSDK");
local RemoteEvents = require(SocialSDK:WaitForChild("RemoteEvents"));
local Logger = require(SocialSDK:WaitForChild("Logger"));
local Utils = require(SocialSDK:WaitForChild("Utils"));
local u1 = nil;
local u2 = false;
local u3 = false;

local function getDevice() -- Line: 16
    local UserInputService = game:GetService("UserInputService");

    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled and "mobile" or "desktop";
end;

local function updateActivity(p4) -- Line: 38
    -- upvalues: u3 (ref), u1 (ref), RemoteEvents (copy), Logger (copy)
    if not u3 then
        u1.updateActivity = RemoteEvents.tryGet("UpdateActivity", 2);
        u3 = true;
    end;

    if u1.updateActivity then
        u1.updateActivity:FireServer(p4);

        return true;
    end;

    Logger.error("NETWORK", "SocialSDKClient: updateActivity remote event not available");

    return false;
end;

task.spawn(function() -- Line: 26, Name: init
    -- upvalues: u1 (ref), RemoteEvents (copy), Logger (copy), u2 (ref)
    u1 = {
        updateDevice = RemoteEvents.waitFor("UpdateDevice")
    };

    if not u1.updateDevice then
        return;
    end;

    local updateDevice = u1.updateDevice;
    local UserInputService = game:GetService("UserInputService");
    updateDevice:FireServer(UserInputService.TouchEnabled and not UserInputService.MouseEnabled and "mobile" or "desktop");
    Logger.info("INIT", "SocialSDKClient: Ready");
    u2 = true;
end);

return {
    isReady = function() -- Line: 61, Name: isReady
        -- upvalues: u2 (ref)
        return u2;
    end,

    setActivity = function(p5, ...) -- Line: 72, Name: setActivity
        -- upvalues: Utils (copy), u3 (ref), u1 (ref), RemoteEvents (copy), Logger (copy)
        if type(p5) ~= "table" then
            local v6, v7, v8, v9, v10 = ...;
            p5 = {
                details = p5,
                state = v6,
                assets = v7,
                type = v8,
                party = v9,
                secret = v10
            };
        end;

        local v11 = Utils.createGameActivity(p5);

        if not u3 then
            u1.updateActivity = RemoteEvents.tryGet("UpdateActivity", 2);
            u3 = true;
        end;

        if u1.updateActivity then
            u1.updateActivity:FireServer(v11);

            return true;
        end;

        Logger.error("NETWORK", "SocialSDKClient: updateActivity remote event not available");

        return false;
    end
};