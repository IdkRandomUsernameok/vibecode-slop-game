-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ServerStorage = game:GetService("ServerStorage");
local RequestEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Engine"):WaitForChild("RequestEvent");
local v1 = {};

if RunService:IsServer() then
    local u2 = {};

    local function getContainer(p3, p4) -- Line: 23
        local PlayerGui = p3:FindFirstChild("PlayerGui");

        if not PlayerGui then
            return nil;
        end;

        local __AssetContainer = PlayerGui:FindFirstChild("__AssetContainer");

        if not __AssetContainer then
            __AssetContainer = Instance.new("ScreenGui");
            __AssetContainer.Name = "__AssetContainer";
            __AssetContainer.ResetOnSpawn = false;
            __AssetContainer.Parent = PlayerGui;
        end;

        local v5 = __AssetContainer:FindFirstChild(p4);

        if not v5 then
            v5 = Instance.new("Folder");
            v5.Name = p4;
            v5.Parent = __AssetContainer;
        end;

        return v5;
    end;

    RequestEvent.OnServerEvent:Connect(function(p6, p7, p8, p9) -- Line: 45
        -- upvalues: ServerStorage (copy), RequestEvent (copy), u2 (copy), getContainer (copy)
        if typeof(p7) ~= "string" then
            return;
        end;

        local v10 = typeof(p8) ~= "string";
        local v11 = typeof(p8) == "string" and p8 and p8 or nil;
        local v12 = typeof(p8) == "table" and p8 and p8 or (typeof(p9) == "table" and p9 and p9 or {
            persistentInstance = true
        });
        local v13 = ServerStorage.ReplicableAssets:FindFirstChild(p7);

        if not v13 then
            RequestEvent:FireClient(p6, p7, v11, false);

            return;
        end;

        local UserId = p6.UserId;
        u2[UserId] = u2[UserId] or {};
        local v14 = getContainer(p6, p7);

        if not v14 then
            return;
        end;

        if v10 then
            for _, child in v13:GetChildren() do
                local u15 = `{p7}/{child.Name}`;
                local v16 = u2[UserId][u15];

                if v16 then
                    if v16.Parent ~= v14 then
                        v16.Parent = v14;
                    end;
                else
                    local u17 = child:Clone();

                    if v12.persistentInstance ~= false then
                        u2[UserId][u15] = u17;
                        u17.Destroying:Connect(function() -- Line: 72
                            -- upvalues: u2 (ref), UserId (copy), u15 (copy)
                            if u2[UserId] then
                                u2[UserId][u15] = nil;
                            end;
                        end);
                    end;

                    u17.Parent = v14;

                    if v12.persistentInstance == false then
                        task.defer(function() -- Line: 80
                            -- upvalues: u17 (copy)
                            u17:Destroy();
                        end);
                    end;
                end;
            end;

            RequestEvent:FireClient(p6, p7, nil, true);

            return;
        end;

        local v18 = v13:FindFirstChild(v11);

        if not v18 then
            RequestEvent:FireClient(p6, p7, v11, false);

            return;
        end;

        local u19 = `{p7}/{v11}`;
        local v20 = u2[UserId][u19];

        if v20 then
            if v20.Parent ~= v14 then
                v20.Parent = v14;
            end;

            RequestEvent:FireClient(p6, p7, v11, true);

            return;
        end;

        local u21 = v18:Clone();

        if v12.persistentInstance ~= false then
            u2[UserId][u19] = u21;
            u21.Destroying:Connect(function() -- Line: 113
                -- upvalues: u2 (ref), UserId (copy), u19 (copy)
                if u2[UserId] then
                    u2[UserId][u19] = nil;
                end;
            end);
        end;

        u21.Parent = v14;
        RequestEvent:FireClient(p6, p7, v11, true);

        if v12.persistentInstance == false then
            task.defer(function() -- Line: 124
                -- upvalues: u21 (copy)
                u21:Destroy();
            end);
        end;
    end);
    Players.PlayerRemoving:Connect(function(p22) -- Line: 131
        -- upvalues: u2 (copy)
        u2[p22.UserId] = nil;
    end);

    return nil;
end;

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local u23 = {};
local u24 = {};

local function getAssetKey(p25, p26) -- Line: 142
    if typeof(p26) == "string" then
        p25 = `{p25}/{p26}` or p25;
    end;

    return p25;
end;

RequestEvent.OnClientEvent:Connect(function(p27, p28, p29) -- Line: 146
    -- upvalues: u24 (copy), u23 (copy), PlayerGui (copy)
    local v30 = typeof(p28) ~= "string";

    if p29 and v30 then
        u24[p27] = true;
    end;

    local v31;

    if typeof(p28) == "string" then
        v31 = `{p27}/{p28}` or p27;
    else
        v31 = p27;
    end;

    local v32 = u23[v31];

    if v32 then
        if not p29 then
            for _, v in v32 do
                task.spawn(v, nil);
            end;

            u23[v31] = nil;

            return;
        end;

        local __AssetContainer = PlayerGui:WaitForChild("__AssetContainer", 5);
        local v33 = __AssetContainer and __AssetContainer:WaitForChild(p27, 5) or nil;
        local v34 = nil;

        if v30 then
            v34 = v33;
        elseif v33 then
            v34 = v33:WaitForChild(p28, 5);
        end;

        for _, v in v32 do
            task.spawn(v, v34);
        end;

        u23[v31] = nil;
    end;
end);

function v1.getAsset(p35: string, p36: any, p37: any) -- Line: 181
    -- upvalues: PlayerGui (copy), u24 (copy), u23 (copy), RequestEvent (copy)
    local v38 = typeof(p36) ~= "string";
    local v39 = typeof(p36) == "string" and p36 and p36 or nil;
    local v40 = typeof(p36) == "table" and p36 and p36 or (typeof(p37) == "table" and p37 and p37 or {});
    local v41 = v40.yieldTimeout or 5;
    local __AssetContainer = PlayerGui:FindFirstChild("__AssetContainer");
    local v42;

    if __AssetContainer then
        v42 = __AssetContainer:FindFirstChild(p35) or nil;
    else
        v42 = nil;
    end;

    if not (v38 and (u24[p35] and v42)) then
        if v42 then
            v42 = v42:FindFirstChild(v39) or nil;
        else
            v42 = nil;
        end;
    end;

    if v42 then
        return v42;
    end;

    local u43;

    if typeof(v39) == "string" then
        u43 = `{p35}/{v39}` or p35;
    else
        u43 = p35;
    end;

    if not u23[u43] then
        u23[u43] = {};
        RequestEvent:FireServer(p35, v39, v40);
    end;

    local coroutine_running_ret = coroutine.running();
    table.insert(u23[u43], coroutine_running_ret);
    task.delay(v41, function() -- Line: 201
        -- upvalues: u23 (ref), u43 (copy), coroutine_running_ret (copy)
        local v44 = u23[u43];

        if v44 then
            for i, v in v44 do
                if v == coroutine_running_ret then
                    table.remove(v44, i);
                    task.spawn(coroutine_running_ret, nil);

                    return;
                end;
            end;
        end;
    end);

    return coroutine.yield();
end;

function v1.getAssetAsync(p45: string, p46: any, p47: any) -- Line: 217
    -- upvalues: PlayerGui (copy), u24 (copy), u23 (copy), RequestEvent (copy)
    local v48 = typeof(p46) ~= "string";
    local v49 = typeof(p46) == "string" and p46 and p46 or nil;
    local v50 = typeof(p46) == "table" and p46 and p46 or (typeof(p47) == "table" and p47 and p47 or {});
    local __AssetContainer = PlayerGui:FindFirstChild("__AssetContainer");
    local v51;

    if __AssetContainer then
        v51 = __AssetContainer:FindFirstChild(p45) or nil;
    else
        v51 = nil;
    end;

    if not (v48 and (u24[p45] and v51)) then
        if v51 then
            v51 = v51:FindFirstChild(v49) or nil;
        else
            v51 = nil;
        end;
    end;

    if v51 then
        return v51, true;
    end;

    local v52;

    if typeof(v49) == "string" then
        v52 = `{p45}/{v49}` or p45;
    else
        v52 = p45;
    end;

    if not u23[v52] then
        u23[v52] = {};
        RequestEvent:FireServer(p45, v49, v50);
    end;

    return nil, false;
end;

return v1;