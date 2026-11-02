-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local ConfigService = game:GetService("ConfigService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Assets = ReplicatedStorage:WaitForChild("Assets");
require(Modules.UI.ShopV2.Enums);
local AssetIcons = require(Modules.UI.AssetIcons);
local UnlocksManager = require(Modules.Data.UnlocksManager);
require(Modules.Main.AssetReplicator);
local RigAssets = require(Modules.Main.RigAssets);
local u1 = {};
local success, result = pcall(function() -- Line: 17
    -- upvalues: ConfigService (copy), u1 (ref)
    u1 = ConfigService:GetConfigAsync():GetValue("unavailableShopItems") or {};
end);

if not success then
    warn("[ShopItems] Unavailable config failed to load: ", result);
end;

local function isUnavailable(p2: string, p3: string, p4: string?) -- Line: 27
    -- upvalues: u1 (ref)
    return table.find(u1, p2 .. "/" .. p3) and true or (p4 and table.find(u1, p2 .. "/" .. p3 .. "/" .. p4) and true or false);
end;

local function getAnimAttibs(p5: userdata, p6: any) -- Line: 33
    -- upvalues: RigAssets (copy)
    local v7 = p6 or {};
    local v8 = p5:GetAttribute("HugeAnim") or v7.IsLarge;

    for _, child in p5:GetChildren() do
        v8 = v8 or child:GetAttribute("HugeAnim");
    end;

    local v9 = {
        isHuge = v8,
        hasAlts = v7.HasAltAnims == true,
        hasEvents = v7.HasEventAnims == true,
        charAmmo = (p5:GetAttribute("ExtraChars") or 0) + 1
    };
    local v10 = {};

    if not p5:GetAttribute("Pack") then
        local Attribute = p5:GetAttribute("RigType");

        if Attribute then
            v10[Attribute:lower()] = true;
        elseif p5:GetAttribute("R6") then
            v10.r6 = true;
        else
            local v11 = RigAssets.get(p5);

            if v11 then
                local Attribute2 = p5:GetAttribute("Character");

                if Attribute2 then
                    local v12 = v11:FindFirstChild(Attribute2);

                    if v12 then
                        v12 = v12:FindFirstChildOfClass("Humanoid");
                    end;

                    if v12 then
                        v10[v12.RigType.Name:lower()] = true;
                    end;
                end;

                local v13 = { "L", "R", "Emote" };

                for i = 1, tonumber(p5:GetAttribute("ExtraChars")) or 0 do
                    local v14 = "L" .. tostring(i + 1);
                    table.insert(v13, v14);
                    local v15 = "R" .. tostring(i + 1);
                    table.insert(v13, v15);
                    local v16 = "Emote" .. tostring(i + 1);
                    table.insert(v13, v16);
                    local _ = i;
                end;

                for _, v in v13 do
                    local v17 = p5:FindFirstChild(v);

                    if v17 then
                        local Attribute3 = v17:GetAttribute("Character");

                        if Attribute3 then
                            local v18 = v11:FindFirstChild(Attribute3);

                            if v18 then
                                v18 = v18:FindFirstChildOfClass("Humanoid");
                            end;

                            if v18 then
                                v10[v18.RigType.Name:lower()] = true;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if not next(v10) then
        v10.r15 = true;
    end;

    for i, _ in v10 do
        v9[i] = true;
    end;

    return v9;
end;

local u19 = {
    Animations = getAnimAttibs,
    Emotes = getAnimAttibs
};

local function getAttributesFromItem(p20, p21, p22) -- Line: 124
    -- upvalues: u19 (copy)
    if u19[p21] then
        return u19[p21](p20, p22);
    end;
end;

local v23 = {};

for _, v in { "Animations", "Emotes", "Holdsplashes", "Icons", "Noteskins", "Notesplashes", "Tags", "Banners" } do
    local v24 = ServerStorage.ReplicableAssets:FindFirstChild(v) or Assets:FindFirstChild(v);

    if v24 and not v24:GetAttribute("IgnoreShopIndex") then
        local v25 = v;
        local v26 = {};

        for _, child in v24:GetChildren() do
            if not table.find(u1, v25 .. "/" .. child.Name) then
                local v27 = {
                    name = child.Name,
                    isPack = child:GetAttribute("Pack"),
                    isNew = child:GetAttribute("New"),
                    isUpdated = child:GetAttribute("Updated"),
                    sortPriority = child:GetAttribute("SortPriority")
                };
                local Metadata = child:FindFirstChild("Metadata");

                if Metadata then
                    local success2, result2 = pcall(require, Metadata);

                    if success2 and type(result2) == "table" then
                        local v28 = UnlocksManager.UnlocksByItem[child];

                        if v28 then
                            v27.unlockData = {
                                type = v28.UnlockType,
                                meta = v28.UnlockMeta
                            };
                        end;

                        v27.icon = AssetIcons:format(v25, child, result2);
                        v27.credits = result2.Credits;
                        v27.displayName = result2.Tag or nil;
                        local v29;

                        if u19[v25] then
                            v29 = u19[v25](child, result2);
                        else
                            v29 = nil;
                        end;

                        v27.attributes = v29;
                    else
                        warn("[ShopItems] Metadata is invalid", Metadata);
                        local v30;

                        if u19[v25] then
                            v30 = u19[v25](child, nil);
                        else
                            v30 = nil;
                        end;

                        v27.attributes = v30;
                    end;
                else
                    local v31;

                    if u19[v25] then
                        v31 = u19[v25](child, nil);
                    else
                        v31 = nil;
                    end;

                    v27.attributes = v31;
                end;

                if v27.isPack then
                    local v32 = child;
                    local v33 = {};

                    for _, child2 in child:GetChildren() do
                        if child2.Name ~= "Metadata" and v32:IsA("Folder") then
                            local Name = v32.Name;
                            local Name2 = child2.Name;

                            if not (table.find(u1, v25 .. "/" .. Name) or Name2 and table.find(u1, v25 .. "/" .. Name .. "/" .. Name2)) then
                                local v34 = {
                                    name = child2.Name,
                                    unlockData = v27.unlockData,
                                    icon = v27.icon,
                                    isNew = child2:GetAttribute("New"),
                                    isUpdated = child2:GetAttribute("Updated"),
                                    sortPriority = child2:GetAttribute("SortPriority")
                                };
                                local Metadata2 = child2:FindFirstChild("Metadata");

                                if Metadata2 then
                                    local success2, result2 = pcall(require, Metadata2);

                                    if success2 and type(result2) == "table" then
                                        local v35 = AssetIcons:format(v25, child2, result2);

                                        if v35 then
                                            v34.icon = v35;
                                        end;

                                        v34.credits = result2.Credits;
                                        v34.displayName = result2.Tag or nil;
                                        local v36;

                                        if u19[v25] then
                                            v36 = u19[v25](child2, result2);
                                        else
                                            v36 = nil;
                                        end;

                                        v34.attributes = v36;
                                    else
                                        warn("[ShopItems] Metadata is invalid", Metadata);
                                        local v37;

                                        if u19[v25] then
                                            v37 = u19[v25](child2, nil);
                                        else
                                            v37 = nil;
                                        end;

                                        v34.attributes = v37;
                                    end;
                                else
                                    local v38;

                                    if u19[v25] then
                                        v38 = u19[v25](child2, nil);
                                    else
                                        v38 = nil;
                                    end;

                                    v34.attributes = v38;
                                end;

                                table.insert(v33, v34);
                            end;
                        end;
                    end;

                    v27.subItems = v33;
                end;

                table.insert(v26, v27);
            end;
        end;

        v23[v25] = v26;
    else
        warn("[ShopItems] Category doesn\'t exist in RS!");
    end;
end;

return v23;