-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Attribute = workspace:GetAttribute("MajorUpdateName");
local Attribute2 = workspace:GetAttribute("UpdateVersion");
local u1 = game.PlaceId == 13042495892;
local u2 = game.PlaceId == 13042469490 and true or game.PlaceId == 114917403233671;
local u3 = RunService:IsStudio();
local u4 = RunService:IsClient();

return {
    IsStudio = function() -- Line: 17, Name: IsStudio
        -- upvalues: u3 (copy)
        return u3;
    end,

    IsClient = function() -- Line: 21, Name: IsClient
        -- upvalues: u4 (copy)
        return u4;
    end,

    IsMainGame = function() -- Line: 25, Name: IsMainGame
        -- upvalues: u1 (copy)
        return u1;
    end,

    IsIndev = function() -- Line: 29, Name: IsIndev
        -- upvalues: u2 (copy)
        return u2;
    end,

    IsGenuine = function() -- Line: 33, Name: IsGenuine
        -- upvalues: u1 (copy), u2 (copy)
        return u1 or u2;
    end,

    GetGameVersion = function() -- Line: 37, Name: GetGameVersion
        -- upvalues: Attribute2 (copy)
        return Attribute2;
    end,

    GetEngineVersion = function() -- Line: 41, Name: GetEngineVersion
        return "1.9.1";
    end,

    GetMajorUpdateName = function() -- Line: 45, Name: GetMajorUpdateName
        -- upvalues: Attribute (copy)
        return Attribute;
    end,

    GetCurrentLock = function() -- Line: 49, Name: GetCurrentLock
        return 1;
    end,

    GetEngineString = function() -- Line: 53, Name: GetEngineString
        -- upvalues: u2 (copy)
        return `After Engine v1.9.1 {u2 and "[INDEV BRANCH]" or ""}`;
    end
};