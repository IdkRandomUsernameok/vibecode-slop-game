-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");

local function isValidUnlockCondition(p1) -- Line: 5
    return p1.UnlockCondition ~= true and (p1.UnlockCondition ~= false and p1.UnlockCondition ~= nil);
end;

function getEmoteData()
    -- upvalues: ReplicatedStorage (copy)
    local Children = ReplicatedStorage.Assets:WaitForChild("Emotes"):GetChildren();
    tick();
    local v2 = 100;
    local v3 = {};

    for _, v in Children do
        if v:FindFirstChild("Metadata") then
            local Metadata = require(v.Metadata);

            if Metadata.UnlockCondition ~= true and (Metadata.UnlockCondition ~= false and Metadata.UnlockCondition ~= nil) then
                local v4 = {
                    Mod = Metadata.UnlockCondition.Mod,
                    Song = Metadata.UnlockCondition.Song,
                    Difficulty = Metadata.UnlockCondition.Difficulty,
                    Name = v.Name,
                    Icon = Metadata.Asset or Metadata.Icon,
                    IconPack = Metadata.IconPack,
                    IsPack = v:GetAttribute("Pack") and true or false
                };
                table.insert(v3, v4);
                v2 = v2 - 1;

                if v2 == 0 then
                    task.wait();
                    v2 = 100;
                end;
            end;
        elseif v2 == 0 then
            task.wait();
            v2 = 100;
        end;
    end;

    return v3;
end;

function getAnimationData()
    -- upvalues: ReplicatedStorage (copy)
    local Children = ReplicatedStorage.Assets:WaitForChild("Animations"):GetChildren();
    tick();
    local v5 = 100;
    local v6 = {};

    for _, v in Children do
        if v:FindFirstChild("Metadata") then
            local Metadata = require(v.Metadata);

            if Metadata.UnlockCondition ~= true and (Metadata.UnlockCondition ~= false and Metadata.UnlockCondition ~= nil) then
                local v7 = {
                    Mod = Metadata.UnlockCondition.Mod,
                    Song = Metadata.UnlockCondition.Song,
                    Difficulty = Metadata.UnlockCondition.Difficulty,
                    Name = v.Name,
                    Icon = Metadata.Asset or Metadata.Icon,
                    IconPack = Metadata.IconPack,
                    IsPack = v:GetAttribute("Pack") and true or false
                };
                table.insert(v6, v7);
                v5 = v5 - 1;

                if v5 == 0 then
                    task.wait();
                    v5 = 100;
                end;
            end;
        elseif v5 == 0 then
            task.wait();
            v5 = 100;
        end;
    end;

    return v6;
end;

function getIconData()
    -- upvalues: ReplicatedStorage (copy)
    local Children = ReplicatedStorage.Assets:WaitForChild("Icons"):GetChildren();
    tick();
    local v8 = 100;
    local v9 = {};

    for _, v in Children do
        if v:FindFirstChild("Metadata") then
            local Metadata = require(v.Metadata);

            if Metadata.UnlockCondition ~= true and (Metadata.UnlockCondition ~= false and Metadata.UnlockCondition ~= nil) then
                local v10 = {
                    Mod = Metadata.UnlockCondition.Mod,
                    Song = Metadata.UnlockCondition.Song,
                    Difficulty = Metadata.UnlockCondition.Difficulty,
                    Name = v.Name,
                    Icon = Metadata.Asset or Metadata.Icon,
                    IconPack = Metadata.IconPack,
                    IsPack = v:GetAttribute("Pack") and true or false
                };
                table.insert(v9, v10);
                v8 = v8 - 1;

                if v8 == 0 then
                    task.wait();
                    v8 = 100;
                end;
            end;
        elseif v8 == 0 then
            task.wait();
            v8 = 100;
        end;
    end;

    return v9;
end;

function getNoteskinData()
    -- upvalues: ReplicatedStorage (copy)
    local Children = ReplicatedStorage.Assets:WaitForChild("Noteskins"):GetChildren();
    tick();
    local v11 = 100;
    local v12 = {};

    for _, v in Children do
        if v:FindFirstChild("Metadata") then
            local Metadata = require(v.Metadata);

            if Metadata.UnlockCondition ~= true and (Metadata.UnlockCondition ~= false and Metadata.UnlockCondition ~= nil) then
                local v13 = {
                    Mod = Metadata.UnlockCondition.Mod,
                    Song = Metadata.UnlockCondition.Song,
                    Difficulty = Metadata.UnlockCondition.Difficulty,
                    Name = v.Name,
                    Icon = Metadata.Asset or Metadata.Icon,
                    IconPack = Metadata.IconPack,
                    IsPack = v:GetAttribute("Pack") and true or false
                };
                table.insert(v12, v13);
                v11 = v11 - 1;

                if v11 == 0 then
                    task.wait();
                    v11 = 100;
                end;
            end;
        elseif v11 == 0 then
            task.wait();
            v11 = 100;
        end;
    end;

    return v12;
end;

function getNotesplashData()
    -- upvalues: ReplicatedStorage (copy)
    local Children = ReplicatedStorage.Assets:WaitForChild("Notesplashes"):GetChildren();
    tick();
    local v14 = 100;
    local v15 = {};

    for _, v in Children do
        if v:FindFirstChild("Metadata") then
            local Metadata = require(v.Metadata);

            if Metadata.UnlockCondition ~= true and (Metadata.UnlockCondition ~= false and Metadata.UnlockCondition ~= nil) then
                local v16 = {
                    Mod = Metadata.UnlockCondition.Mod,
                    Song = Metadata.UnlockCondition.Song,
                    Difficulty = Metadata.UnlockCondition.Difficulty,
                    Name = v.Name,
                    Icon = Metadata.Asset or Metadata.Icon,
                    IconPack = Metadata.IconPack,
                    IsPack = v:GetAttribute("Pack") and true or false
                };
                table.insert(v15, v16);
                v14 = v14 - 1;

                if v14 == 0 then
                    task.wait();
                    v14 = 100;
                end;
            end;
        elseif v14 == 0 then
            task.wait();
            v14 = 100;
        end;
    end;

    return v15;
end;

function getHoldsplashData()
    -- upvalues: ServerStorage (copy)
    local Children = ServerStorage.ReplicableAssets.Holdsplashes:GetChildren();
    tick();
    local v17 = 100;
    local v18 = {};

    for _, v in Children do
        if v:FindFirstChild("Metadata") then
            local Metadata = require(v.Metadata);

            if Metadata.UnlockCondition ~= true and (Metadata.UnlockCondition ~= false and Metadata.UnlockCondition ~= nil) then
                local v19 = {
                    Mod = Metadata.UnlockCondition.Mod,
                    Song = Metadata.UnlockCondition.Song,
                    Difficulty = Metadata.UnlockCondition.Difficulty,
                    Name = v.Name,
                    Icon = Metadata.Asset or Metadata.Icon,
                    IconPack = Metadata.IconPack,
                    IsPack = v:GetAttribute("Pack") and true or false
                };
                table.insert(v18, v19);
                v17 = v17 - 1;

                if v17 == 0 then
                    task.wait();
                    v17 = 100;
                end;
            end;
        elseif v17 == 0 then
            task.wait();
            v17 = 100;
        end;
    end;

    return v18;
end;

function getTagData()
    -- upvalues: ServerStorage (copy)
    local Children = ServerStorage.ReplicableAssets:WaitForChild("Tags"):GetChildren();
    tick();
    local v20 = 100;
    local v21 = {};

    for _, v in Children do
        if v:FindFirstChild("Metadata") then
            local Metadata = require(v.Metadata);

            if Metadata.UnlockCondition ~= true and (Metadata.UnlockCondition ~= false and Metadata.UnlockCondition ~= nil) then
                local v22 = {
                    Mod = Metadata.UnlockCondition.Mod,
                    Song = Metadata.UnlockCondition.Song,
                    Difficulty = Metadata.UnlockCondition.Difficulty,
                    Tag = Metadata.Tag,
                    Name = v.Name,
                    Icon = Metadata.Asset or Metadata.Icon,
                    IconPack = Metadata.IconPack,
                    IsPack = v:GetAttribute("Pack") and true or false,
                    Chance = Metadata.Chance or nil
                };
                table.insert(v21, v22);
                v20 = v20 - 1;

                if v20 == 0 then
                    task.wait();
                    v20 = 100;
                end;
            end;
        elseif v20 == 0 then
            task.wait();
            v20 = 100;
        end;
    end;

    return v21;
end;

function getBannerData()
    -- upvalues: ServerStorage (copy)
    local Children = ServerStorage.ReplicableAssets:WaitForChild("Banners"):GetChildren();
    tick();
    local v23 = 100;
    local v24 = {};

    for _, v in Children do
        if v:FindFirstChild("Metadata") then
            local Metadata = require(v.Metadata);

            if Metadata.UnlockCondition ~= true and (Metadata.UnlockCondition ~= false and Metadata.UnlockCondition ~= nil) then
                local v25 = {
                    Mod = Metadata.UnlockCondition.Mod,
                    Song = Metadata.UnlockCondition.Song,
                    Difficulty = Metadata.UnlockCondition.Difficulty,
                    Tag = Metadata.Tag,
                    Name = v.Name,
                    Icon = Metadata.Asset or Metadata.Icon,
                    IconPack = Metadata.IconPack,
                    IsPack = v:GetAttribute("Pack") and true or false,
                    Chance = Metadata.Chance or nil
                };
                table.insert(v24, v25);
                v23 = v23 - 1;

                if v23 == 0 then
                    task.wait();
                    v23 = 100;
                end;
            end;
        elseif v23 == 0 then
            task.wait();
            v23 = 100;
        end;
    end;

    return v24;
end;

function getDailyUnlockables()
    -- upvalues: ReplicatedStorage (copy), ServerStorage (copy)
    tick();
    local Assets = ReplicatedStorage.Assets;
    local v26 = {};
    local v27 = {};
    local v28 = 100;

    for _, v in {
        Assets:WaitForChild("Animations"),
        ServerStorage.ReplicableAssets.Banners,
        Assets:WaitForChild("Emotes"),
        ServerStorage.ReplicableAssets.Holdsplashes,
        Assets:WaitForChild("Icons"),
        Assets:WaitForChild("Noteskins"),
        Assets:WaitForChild("Notesplashes"),
        ServerStorage.ReplicableAssets.Tags
    } do
        local v29 = v;

        for _, child in v:GetChildren() do
            local v30;

            if child:FindFirstChild("Metadata") then
                v30 = require(child.Metadata);
            else
                v30 = nil;
            end;

            if v30 then
                if v30.UnlockCondition == "DailyQuest" then
                    local v31 = v29.Name .. "::" .. child.Name .. "::" .. tostring(child:GetAttribute("Pack"));

                    if v26[v31] then
                        warn("[DAILY UNLOCK] Duplicate skipped:", v31);
                    else
                        v26[v31] = true;
                        local v32 = {
                            Name = child.Name,
                            IsPack = child:GetAttribute("Pack") and true or false,
                            Icon = v30.Asset or v30.Icon,
                            Type = v29.Name,
                            Metadata = v30
                        };
                        table.insert(v27, v32);
                        v28 = v28 - 1;

                        if v28 == 0 then
                            task.wait();
                            v28 = 100;
                        end;
                    end;
                end;
            else
                warn("[DAILY UNLOCK] No data found for:", child.Name);
            end;
        end;
    end;

    return v27;
end;

debug.info(2, "s");

return {
    NoteSplashes = getNotesplashData(),
    HoldSplashes = getHoldsplashData(),
    Animations = getAnimationData(),
    Noteskins = getNoteskinData(),
    Emotes = getEmoteData(),
    Icons = getIconData(),
    Tags = getTagData(),
    Banners = getBannerData(),
    DailyUnlocks = getDailyUnlockables()
};