-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local CaptureService = game:GetService("CaptureService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local TopbarIcon = require(Modules.UI.TopbarIcon);
local Ratings = require(Modules.Main.Ratings);
local Signal = require(Modules.Lib.Signal);
local SoundLib = require(Modules.Audio.SoundLib);
local VirtualCursorManager = require(Modules.Other.VirtualCursorManager);
local ResultsRework = Modules.Assets.ResultsRework;
local ResultsBlur = game.Lighting.ResultsBlur;
local u1 = Signal.new();
local u2 = VirtualCursorManager.new();

function generateRatingIcon(p3)
    return p3 <= 50 and "rbxassetid://15280046280" or (p3 <= 60 and "rbxassetid://15280046061" or (p3 <= 70 and "rbxassetid://15280045857" or (p3 <= 80 and "rbxassetid://15280045610" or (p3 <= 90 and "rbxassetid://15280045422" or (p3 < 100 and "rbxassetid://15280045177" or "rbxassetid://15280044994")))));
end;

local u4 = {};

for _, v in Ratings.Data do
    u4[v.name] = v.color;
end;

function formatNumber(p5)
    local math_floor_ret = math.floor(p5);
    local v6 = tostring(math_floor_ret);
    local v7;

    repeat
        v6, v7 = v6:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v7 == 0;

    return v6;
end;

function round(p8, p9)
    local v10 = 10 ^ (p9 or 0);

    return math.floor(p8 * v10 + 0.5) / v10;
end;

local function darkenHSV(p11, p12: number) -- Line: 65
    local v13, v14, v15 = p11:ToHSV();

    return Color3.fromHSV(v13, v14, v15 * p12);
end;

local function calculateStdDev(p16) -- Line: 70
    local v17 = #p16;

    if v17 == 0 then
        return 0;
    end;

    local v18 = 0;

    for _, v in p16 do
        v18 = v18 + v.offset;
    end;

    local v19 = v18 / v17;
    local v20 = 0;

    for _, v in p16 do
        v20 = v20 + (v.offset - v19) ^ 2;
    end;

    return round(math.sqrt(v20 / v17), 1);
end;

function generateHitgraph(p21, p22)
    -- upvalues: u4 (copy)
    if p22.hitData and p22.timings then
        table.sort(p22.timings, function(p23, p24) -- Line: 91
            return p23.ratingWindow < p24.ratingWindow;
        end);
        local ratingWindow = p22.timings[#p22.timings].ratingWindow;
        p21.Parent.Late.Text = "Early (" .. -ratingWindow .. "ms)";
        p21.Parent.Early.Text = "Late (" .. ratingWindow .. "ms)";

        for _, v in p22.timings do
            local v25 = p21.Parent.Line:Clone();
            local v26 = p21.Parent.Line:Clone();
            local v27 = v.ratingWindow / ratingWindow / 2;
            v25.BackgroundColor3 = u4[v.name];
            v26.BackgroundColor3 = u4[v.name];
            v25.Position = UDim2.fromScale(0.5, 0.5 + v27);
            v26.Position = UDim2.fromScale(0.5, 0.5 - v27);
            v25.Visible = true;
            v26.Visible = true;
            v25.Parent = p21.Lines;
            v26.Parent = p21.Lines;
        end;

        if type(p22.hitData) ~= "table" or #p22.hitData == 0 then
            return;
        end;

        table.sort(p22.hitData, function(p28, p29) -- Line: 122
            return p28.strumTime < p29.strumTime;
        end);
        local strumTime = p22.hitData[#p22.hitData].strumTime;

        for _, v in p22.hitData do
            local v30 = v.strumTime / strumTime;
            local math_clamp_ret = math.clamp(v.offset, -ratingWindow, ratingWindow);
            local v31 = math.abs(math_clamp_ret) / ratingWindow / 2;
            local v32 = p21.GraphPlaceholder:Clone();
            v32.BackgroundColor3 = u4[v.name];
            v32.Position = UDim2.fromScale(v30, 0.5 + v31 * (math_clamp_ret < 0 and -1 or 1));
            v32.Visible = true;
            v32.Parent = p21.GraphAssets;
        end;
    end;
end;

function loadJudgements(p33, p34)
    -- upvalues: Ratings (copy), u4 (copy)
    local Judgement = p33.Judgements.Judgement;
    Judgement.Visible = false;
    local v35 = 0;

    for _, v in Ratings.Keys do
        v35 = v35 + (p34.judgements[v] or 0);
    end;

    for _, v in Ratings.Keys do
        local v36 = Judgement:Clone();
        local v37 = p34.judgements[v] or 0;
        local v38 = v35 > 0 and (v37 / v35 * 100 or 0) or 0;
        local v39 = u4[v] or v36.Fill.BackgroundColor3;
        local v40, v41, v42 = v39:ToHSV();
        v36.BackgroundColor3 = Color3.fromHSV(v40, v41, v42 * 0.75);
        v36.Rating.Text = v;
        v36.Amount.Text = `{v37} ({string.format("%.1f", v38)}%)`;
        v36.Fill.Size = UDim2.fromScale(v38 / 100, 1);
        v36.Fill.BackgroundColor3 = v39;
        v36.Visible = true;
        v36.Parent = p33.Judgements;
    end;

    p33.Judgements.UIGridLayout.CellSize = UDim2.fromScale(1, 1 / #Ratings.Keys);
end;

function loadModifiers(p43, p44)
    -- upvalues: Modules (copy)
    local Modifiers = p43.Ranking.Modifiers;

    for _, v in p44.modifiers do
        local v45 = Modules.Engine.VSRG.GameplayModifiers:FindFirstChild(v);

        if v45 then
            local v46 = Modifiers.ModifierIcon:Clone();
            v46.Name = v;
            v46.Image = v45:GetAttribute("Icon") or "rbxassetid://17670220064";
            v46.Visible = true;
            v46.Parent = Modifiers;
        end;
    end;

    p43.Ranking.Sprite.Size = UDim2.fromScale(1 - math.clamp(#p44.modifiers, 0, 3) * 0.1, 1);
end;

return {
    create = function(p47, u48) -- Line: 190, Name: create
        -- upvalues: ResultsRework (copy), GuiService (copy), calculateStdDev (copy), Ratings (copy), SoundLib (copy), u1 (copy), TweenService (copy), ResultsBlur (copy), TopbarIcon (copy), u2 (copy), CaptureService (copy)
        local u49 = ResultsRework:Clone();
        u49.SongName.Text = `{u48.songName} ({u48.difficulty}) [{u48.playbackRate}x]`;
        u49.ModName.Text = `{u48.modName}`;
        u49.DatePlayed.Text = u48.datePlayed or os.date("%m/%d/%Y");
        u49.TimePlayed.Text = u48.timePlayed or os.date("%H:%M:%S");
        local TopbarInset = GuiService.TopbarInset;
        local DatePlayed = u49.DatePlayed;
        DatePlayed.Position = DatePlayed.Position + UDim2.fromOffset(0, TopbarInset.Height);
        local TimePlayed = u49.TimePlayed;
        TimePlayed.Position = TimePlayed.Position + UDim2.fromOffset(0, TopbarInset.Height);
        local SongName = u49.SongName;
        SongName.Position = SongName.Position + UDim2.fromOffset(0, TopbarInset.Height);
        local ModName = u49.ModName;
        ModName.Position = ModName.Position + UDim2.fromOffset(0, TopbarInset.Height);
        u49.PlayInfo.Combo.Text = `Top Combo: {u48.topCombo or 0}`;
        u49.PlayInfo.Keys.Text = `Keys: {u48.keyCount or 4}`;
        u49.PlayInfo.Modcharts.Text = `Modcharts: {u48.modcharts and "✅" or "❌"}`;
        u49.PlayInfo.SpecialNotes.Text = `Special notes: {u48.specialNotes and "✅" or "❌"}`;
        u49.AccuracyStats.MA.Text = `MA: {u48.ma or 0}`;
        u49.AccuracyStats.PA.Text = `PA: {u48.pa or 0}`;
        u49.AccuracyStats.Mean.Text = `Mean: {u48.mean or 0}ms`;
        u49.AccuracyStats.Deviation.Text = `Std. Dev: {calculateStdDev(u48.hitData)}ms`;
        u49.ScoreInfo.Score.Text = formatNumber(u48.score);
        u49.ScoreInfo.Accuracy.Text = string.format("%.2f%%", u48.accuracy);
        u49.ScoreInfo.Ranking.Text = `{Ratings.getJudgementTitle(u48.judgements)}{u48.cleared and "" or " (Died/Reset)"}`;
        u49.Ranking.Sprite.Image = generateRatingIcon(u48.accuracy);
        local u50 = u48.favorited or false;

        local function updateFavoriteVisual() -- Line: 221
            -- upvalues: u49 (copy), u50 (ref)
            u49.Favorite.Text = u50 and "Unfavorite" or "Favorite";
        end;

        u49.Favorite.Text = u50 and "Unfavorite" or "Favorite";
        u49.Favorite.MouseButton1Click:Connect(function() -- Line: 227
            -- upvalues: u50 (ref), u49 (copy), SoundLib (ref), u1 (ref), u48 (copy)
            u50 = not u50;
            u49.Favorite.Text = u50 and "Unfavorite" or "Favorite";

            if u50 then
                SoundLib:Play("SongSelect/FavoriteAdded");
            else
                SoundLib:Play("SongSelect/FavoriteRemoved");
            end;

            u1:Fire(u48.modName, u48.songName, u50);
        end);
        loadJudgements(u49, u48);
        loadModifiers(u49, u48);
        generateHitgraph(u49.Graph.Data, u48);
        u49.Position = UDim2.fromScale(0.5, -1.5);
        u49.Parent = p47;
        TweenService:Create(u49, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.5)
        }):Play();
        TweenService:Create(ResultsBlur, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = 32
        }):Play();

        if game.UserInputService.GamepadEnabled then
            TopbarIcon.highlightKey = false;
            GuiService.SelectedObject = nil;
            task.delay(0.5, function() -- Line: 253
                -- upvalues: TopbarIcon (ref), GuiService (ref), u2 (ref), u49 (copy)
                TopbarIcon.highlightKey = false;
                GuiService.SelectedObject = nil;
                u2:Enable(u49);
                TopbarIcon.canResetCursor = false;
            end);
        end;

        u49.Continue.MouseButton1Click:Connect(function() -- Line: 261
            -- upvalues: u2 (ref), TopbarIcon (ref), TweenService (ref), ResultsBlur (ref), u49 (copy)
            u2:Disable();
            TopbarIcon.canResetCursor = true;
            TopbarIcon.highlightKey = TopbarIcon.defaultHighlightKey;
            TweenService:Create(ResultsBlur, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            TweenService:Create(u49, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 2.5)
            }):Play();
            task.delay(1.1, function() -- Line: 267
                -- upvalues: u49 (ref)
                u49:Destroy();
            end);
        end);
        local u51 = true;
        u49.Screenshot.MouseButton1Click:Connect(function() -- Line: 273
            -- upvalues: u51 (ref), CaptureService (ref), u49 (copy), TweenService (ref)
            if not u51 then
                return;
            end;

            CaptureService:CaptureScreenshot(function(p52) -- Line: 275
                -- upvalues: u51 (ref), u49 (ref), TweenService (ref), CaptureService (ref)
                u51 = false;
                u49.CaptureStuff.ShutterSound:Play();
                u49.CaptureStuff.CaptureOverlay.BackgroundTransparency = 0;
                local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                task.wait();
                TweenService:Create(u49.CaptureStuff.CaptureOverlay, TweenInfo_new_ret, {
                    BackgroundTransparency = 1
                }):Play();
                task.wait(TweenInfo_new_ret.Time + 0.1);
                CaptureService:PromptSaveCapturesToGallery({ p52 }, function() -- Line: 288
                    -- upvalues: u51 (ref)
                    u51 = true;
                end);
            end);
        end);

        return u49;
    end,

    clearUp = function(u53) -- Line: 297, Name: clearUp
        -- upvalues: TweenService (copy), ResultsBlur (copy)
        TweenService:Create(ResultsBlur, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        TweenService:Create(u53, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 2.5)
        }):Play();
        task.delay(1.1, function() -- Line: 301
            -- upvalues: u53 (copy)
            u53:Destroy();
        end);
    end,

    favoriteToggled = u1
};