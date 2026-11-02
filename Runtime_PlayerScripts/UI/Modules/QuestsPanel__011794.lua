-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local DataManager = require(Modules.Data:WaitForChild("DataManager"));
local AssetIcons = require(Modules.UI:WaitForChild("AssetIcons"));
local DailyQuestsPanel = workspace:WaitForChild("Map"):FindFirstChild("Volcano/Spawn"):WaitForChild("ChallengeBoard").Board.DailyQuestsPanel;
local AssetReplicator = require(Modules.Main:WaitForChild("AssetReplicator"));

local function getLastSundayOfMonth(p1: number, p2: number) -- Line: 18
    local day = os.date("!*t", os.time({
        day = 0,
        hour = 12,
        year = p1,
        month = p2 + 1
    })).day;
    local os_time_ret = os.time({
        hour = 12,
        year = p1,
        month = p2,
        day = day
    });

    return day - (os.date("!*t", os_time_ret).wday - 1);
end;

local function isBST(p3: number) -- Line: 25
    -- upvalues: getLastSundayOfMonth (copy)
    local year = os.date("!*t", p3).year;
    local v4 = getLastSundayOfMonth(year, 3);
    local v5 = getLastSundayOfMonth(year, 10);
    local os_time_ret = os.time({
        month = 3,
        hour = 1,
        min = 0,
        sec = 0,
        year = year,
        day = v4
    });
    local os_time_ret2 = os.time({
        month = 10,
        hour = 1,
        min = 0,
        sec = 0,
        year = year,
        day = v5
    });
    local v6;

    if os_time_ret <= p3 then
        v6 = p3 < os_time_ret2;
    else
        v6 = false;
    end;

    return v6;
end;

local function getNextUKMidnightUTC(p7: number?) -- Line: 36
    -- upvalues: isBST (copy)
    local v8 = p7 or os.time();
    local v9 = isBST(v8) and 3600 or 0;
    local os_date_ret = os.date("!*t", v8 + v9);
    local os_time_ret = os.time({
        hour = 0,
        min = 0,
        sec = 0,
        year = os_date_ret.year,
        month = os_date_ret.month,
        day = os_date_ret.day
    });
    local v10 = os_time_ret - v9;

    if v8 < v10 then
        return v10;
    end;

    local v11 = os_time_ret + 86400;

    return v11 - (isBST(v11 - v9) and 3600 or 0);
end;

return function(p12) -- Line: 55
    -- upvalues: DataManager (copy), DailyQuestsPanel (copy), ReplicatedStorage (copy), AssetReplicator (copy), AssetIcons (copy), getNextUKMidnightUTC (copy)
    local Data = DataManager:GetData();
    local u13 = DailyQuestsPanel;
    local ScrollingFrame = u13:FindFirstChild("ScrollingFrame");

    if ScrollingFrame then
        ScrollingFrame = ScrollingFrame:FindFirstChild("Template");
    end;

    if ScrollingFrame then
        ScrollingFrame.Parent = nil;
    end;

    local u14 = {};
    local u15 = Data and Data.DailyQuestData;

    local function getDescForQuest(p16) -- Line: 69
        if p16.Type == 1 then
            return `Play and finish "{p16.Data.Song}" from "{p16.Data.Mod}".`;
        end;

        if p16.Type == 2 then
            return "Participate in a 2v2+ match.";
        end;

        if p16.Type == 3 then
            return "Participate in any multiplayer match.";
        end;

        if p16.Type == 4 then
            return `Beat "{p16.Data.Song}" from "{p16.Data.Mod}" with a C rank or higher.`;
        end;

        if p16.Type == 5 then
            return `Play and finish any song from "{p16.Data.Mod}".`;
        end;

        return `whatever go my table memory address: {tostring(p16)}`;
    end;

    local function formatTime(p17) -- Line: 84
        local math_floor_ret = math.floor(p17 / 3600 % 24);
        local math_floor_ret2 = math.floor(p17 / 60 % 60);
        local v18 = "";

        if math_floor_ret > 0 then
            v18 = `{math_floor_ret}h {math_floor_ret2}m `;
        elseif math_floor_ret2 > 0 then
            v18 = `{math_floor_ret2}m `;
        end;

        return `{v18}{p17 % 60}s`;
    end;

    local function refreshQuests(p19) -- Line: 99
        -- upvalues: u13 (copy), ScrollingFrame (copy), u14 (copy), getDescForQuest (copy), ReplicatedStorage (ref), AssetReplicator (ref), AssetIcons (ref)
        if not (u13:FindFirstChild("ScrollingFrame") and ScrollingFrame) then
            return;
        end;

        for _, v in u14 do
            if v then
                v:Destroy();
            end;
        end;

        table.clear(u14);
        local Quests = p19.Quests;
        local v20 = 0;

        for _, v in Quests do
            if not v.Completed then
                v20 = v20 + 1;
            end;
        end;

        u13.Completed.Text = "Total Completed: " .. p19.TotalQuests;
        local NoMoreGaming = u13:FindFirstChild("NoMoreGaming");

        if v20 == 0 then
            if NoMoreGaming then
                NoMoreGaming.Visible = true;
            end;

            u13.ScrollingFrame.Visible = false;

            return;
        end;

        if NoMoreGaming then
            NoMoreGaming.Visible = false;
        end;

        u13.ScrollingFrame.Visible = true;

        for _, v in Quests do
            if not v.Completed then
                local _, _ = xpcall(function() -- Line: 130
                    -- upvalues: ScrollingFrame (ref), u13 (ref), v (copy), getDescForQuest (ref), ReplicatedStorage (ref), AssetReplicator (ref), AssetIcons (ref), u14 (ref)
                    local v21 = ScrollingFrame:Clone();
                    v21.Parent = u13.ScrollingFrame;
                    v21.LayoutOrder = v.ID;
                    v21.Content.Desc.Text = getDescForQuest(v);
                    v21.UnlockPreview.BannerLeft.Visible = false;
                    v21.UnlockPreview.BannerRight.Visible = false;
                    v21.UnlockPreview.Icon.Visible = false;

                    if v.Reward and v.Reward.Name then
                        v21.Content.Title.Text = v.Reward.DisplayName or v.Reward.Name;
                        local Assets = ReplicatedStorage:FindFirstChild("Assets");

                        if Assets then
                            Assets = Assets:FindFirstChild(v.Reward.Type);
                        end;

                        if Assets then
                            Assets = Assets:FindFirstChild(v.Reward.Name);
                        end;

                        local v22 = Assets or AssetReplicator.getAsset(v.Reward.Type, v.Reward.Name);

                        if v22 then
                            v21.UnlockPreview.Visible = true;
                            local v23 = AssetIcons:format(v.Reward.Type, v22);

                            if v.Reward.Type == "Banners" then
                                v21.UnlockPreview.BannerLeft.Visible = true;
                                v21.UnlockPreview.BannerRight.Visible = true;
                                local v24 = AssetIcons:render(v21.UnlockPreview.BannerLeft, v23, {
                                    scale = 2
                                });
                                local v25 = AssetIcons:render(v21.UnlockPreview.BannerRight, v23, {
                                    scale = 2
                                });
                                table.insert(u14, v24);
                                table.insert(u14, v25);
                            else
                                v21.UnlockPreview.Icon.Visible = true;
                                local v26 = AssetIcons:render(v21.UnlockPreview.Icon, v23);
                                table.insert(u14, v26);
                            end;
                        end;
                    else
                        v21.UnlockPreview.Visible = false;
                        v21.Content.Title.Text = "No Reward";
                    end;

                    table.insert(u14, v21);
                end, function(p27) -- Line: 174
                    -- upvalues: v (copy)
                    warn((`Error rendering quest {v.ID}: {p27}`));
                end);
            end;
        end;
    end;

    task.spawn(function() -- Line: 180
        -- upvalues: u15 (ref), u13 (copy), getNextUKMidnightUTC (ref)
        while task.wait(1) do
            local _, _ = xpcall(function() -- Line: 182
                -- upvalues: u15 (ref), u13 (ref), getNextUKMidnightUTC (ref)
                if not u15 then
                    return;
                end;

                local ResetTimer = u13:FindFirstChild("ResetTimer");

                if not ResetTimer then
                    return;
                end;

                local v28 = (u15.NextReset or getNextUKMidnightUTC()) - os.time();
                local math_max_ret = math.max(0, v28);
                local math_floor_ret = math.floor(math_max_ret / 3600 % 24);
                local math_floor_ret2 = math.floor(math_max_ret / 60 % 60);
                local v29 = "";

                if math_floor_ret > 0 then
                    v29 = `{math_floor_ret}h {math_floor_ret2}m `;
                elseif math_floor_ret2 > 0 then
                    v29 = `{math_floor_ret2}m `;
                end;

                local v30 = `{v29}{math_max_ret % 60}s`;
                ResetTimer.Text = `Resets in {v30}`;
                local NoMoreGaming = u13:FindFirstChild("NoMoreGaming");

                if NoMoreGaming and NoMoreGaming:FindFirstChild("Label") then
                    NoMoreGaming.Label.Text = `You did all quests for the day\nCome back in {v30} for new ones`;
                end;
            end, function(p31) -- Line: 199
                warn((`Error in Quests Loop: {p31}`));
            end);
        end;
    end);
    DataManager.DataChanged:Connect(function(p32, p33) -- Line: 205
        -- upvalues: u15 (ref), refreshQuests (copy)
        if p32 ~= "DailyQuestData" then
            return;
        end;

        u15 = p33;

        if u15 and u15.Quests then
            refreshQuests(u15);
        end;
    end);

    if u15 and u15.Quests then
        refreshQuests(u15);
    end;
end;