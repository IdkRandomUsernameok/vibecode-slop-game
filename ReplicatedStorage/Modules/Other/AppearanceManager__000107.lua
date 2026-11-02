-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Modules = ReplicatedStorage:WaitForChild("Modules");
require(Modules.Lib.Signal);
local DataManager = require(Modules.Data.DataManager);
local Serializer = require(Modules.Other.Serializer);
local u1 = game:GetService("RunService"):IsClient() and (Players.LocalPlayer.UserId or 1) or 1;
local u2 = {};
local u3 = game:GetService("RunService"):IsServer();
Players.PlayerRemoving:Connect(function(p4) -- Line: 16
    -- upvalues: u2 (copy)
    u2[p4.UserId] = nil;
end);

function pageIterate(u5)
    return coroutine.wrap(function() -- Line: 22
        -- upvalues: u5 (copy)
        local v6 = 1;

        while true do
            for _, v in ipairs(u5:GetCurrentPage()) do
                coroutine.yield(v, v6);
            end;

            if u5.IsFinished or not pcall(u5.AdvanceToNextPageAsync, u5) then
                return;
            end;

            v6 = v6 + 1;
        end;
    end);
end;

function getRandomFriend(p7: boolean?, p8: number?)
    -- upvalues: u1 (copy), u2 (copy), Players (copy)
    local v9 = tonumber(p8) or u1;

    if u2[v9] then
        return #u2[v9] > 0 and u2[v9][math.random(#u2[v9])] or 1;
    end;

    local success, result = pcall(Players.GetFriendsAsync, Players, v9);

    if not (success and result) then
        warn("Players:GetFriendsAsync failed for user", v9, ":", result);

        return 1;
    end;

    local v10 = {};

    for i, _ in pageIterate(result) do
        table.insert(v10, i.Id);
    end;

    u2[v9] = #v10 > 0 and v10 and v10 or nil;

    return #v10 > 0 and v10[math.random(#v10)] or 1;
end;

if not u3 then
    task.spawn(function() -- Line: 63
        getRandomFriend();
    end);
end;

function getExtraDataFrom(p11: any, u12: number?, p13: string)
    -- upvalues: u3 (copy), DataManager (copy)
    if not p11 then
        if u3 then
            return nil;
        end;

        p11 = DataManager:GetData();
    end;

    local v14 = (not p13 or p13 == "Anim") and "" or p13;
    local v15 = {};

    for _, v in { "Duo", "Trio" } do
        local v16 = p11[`{v}{v14}UserID`];
        local v17 = p11[`{v}{v14}UserType`];

        if (tonumber(v16) or v17 == "Username") and tonumber(v16) ~= 0 then
            table.insert(v15, {
                id = v16,
                type = v17
            });
        else
            local v18 = {
                type = "User ID",
                id = getRandomFriend(false, u12)
            };
            table.insert(v15, v18);
        end;
    end;

    setmetatable(v15, {
        __index = function(p19, p20) -- Line: 99, Name: __index
            -- upvalues: u12 (copy)
            p19[p20] = {
                type = "User ID",
                id = getRandomFriend(false, u12)
            };

            return p19[p20];
        end
    });

    return {
        useFaces = p11.UseFaces,
        useProps = p11.UseProps,
        useReqProps = p11.UseRequiredProps,
        extraIds = v15
    };
end;

local RequestFilteredHumanoidDescription = ReplicatedStorage:WaitForChild("Events").RequestFilteredHumanoidDescription;
local u21 = {};
local u22 = {};

function getDescription(p23: any, p24: string?, p25: boolean?, p26: boolean?)
    -- upvalues: u3 (copy), RequestFilteredHumanoidDescription (copy), Serializer (copy), u21 (copy), Players (copy), u22 (copy)
    local u27 = p23 or 0;
    local v28 = p24 or "User ID";

    if u27 == 0 then
        u27 = getRandomFriend();
    end;

    if typeof(u27) == "Instance" then
        return u27;
    end;

    local u29 = `{u27}|{v28}`;

    if not (u3 or p26) then
        local v30 = RequestFilteredHumanoidDescription:InvokeServer(u27, v28);

        if v30 then
            v30 = Serializer.deserialize(v30);
        end;

        u21[u29] = v30 or u21[u29];

        return v30;
    end;

    local v31 = u21[u29];

    if v31 and not p25 then
        return v31;
    end;

    local u32 = nil;
    local v33 = nil;
    local v34 = nil;

    if v28 == "User ID" then
        v33, v34 = pcall(function() -- Line: 152
            -- upvalues: u32 (ref), Players (ref), u27 (ref)
            u32 = Players:GetHumanoidDescriptionFromUserId(u27);
        end);
    elseif v28 == "Username" then
        v33, v34 = pcall(function() -- Line: 156
            -- upvalues: Players (ref), u27 (ref), u32 (ref)
            u32 = Players:GetHumanoidDescriptionFromUserId((Players:GetUserIdFromNameAsync(u27)));
        end);
    elseif v28 == "Outfit ID" then
        v33, v34 = pcall(function() -- Line: 161
            -- upvalues: u32 (ref), Players (ref), u27 (ref)
            u32 = Players:GetHumanoidDescriptionFromOutfitId(u27);
        end);
    end;

    if not v33 and u27 ~= 1 then
        warn("Roblox failed to load the avatar\'s appearance!", v34);

        return getDescription(1, "User ID", false);
    end;

    if u32 then
        if u22[u29] then
            task.cancel(u22[u29]);
        end;

        u22[u29] = task.delay(180, function() -- Line: 178
            -- upvalues: u22 (ref), u29 (copy), u21 (ref), u32 (ref)
            u22[u29] = nil;
            u21[u29] = nil;
            u32:Destroy();
        end);

        if u3 and (not p26 and shared.filterHumanoidDescription) then
            u32 = shared.filterHumanoidDescription(u32);
        end;

        u21[u29] = u32;

        return u32;
    end;
end;

if game:GetService("RunService"):IsServer() then
    function RequestFilteredHumanoidDescription.OnServerInvoke(p35: userdata, p36: any, p37: string?) -- Line: 199
        -- upvalues: Serializer (copy)
        local v38 = getDescription(p36, p37, false, true);

        if not v38 then
            return nil;
        end;

        if shared.filterHumanoidDescription then
            v38 = shared.filterHumanoidDescription(v38);
        end;

        return Serializer.serialize(v38);
    end;
end;

return {
    cachedFriends = u2,
    getRandomFriend = getRandomFriend,
    getExtraDataFrom = getExtraDataFrom,
    getDescription = getDescription
};