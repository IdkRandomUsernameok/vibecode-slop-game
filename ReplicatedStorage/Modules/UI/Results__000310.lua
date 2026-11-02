-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local CaptureService = game:GetService("CaptureService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local TopbarIcon = require(Modules.UI.TopbarIcon);
local Ratings = require(Modules.Main.Ratings);
local VirtualCursorManager = require(Modules.Other.VirtualCursorManager);
local Results = Modules.Assets.Results;
local ResultsDOF = game.Lighting.ResultsDOF;
local u1 = {
    P = "rbxassetid://15280044994",
    S = "rbxassetid://15280045177",
    A = "rbxassetid://15280045422",
    B = "rbxassetid://15280045610",
    C = "rbxassetid://15280045857",
    D = "rbxassetid://15280046061",
    F = "rbxassetid://15280046280"
};
local u2 = VirtualCursorManager.new();

function judgementRating(p3)
    return p3.Miss == 0 and "FC" or (p3.Ok < 10 and p3.Bad == 0 and "SDB" or (p3.Ok == 0 and p3.Bad == 0 and "GFC" or (p3.Good < 10 and (p3.Ok == 0 and p3.Bad == 0) and "SDG" or (p3.Good == 0 and (p3.Ok == 0 and p3.Bad == 0) and "PFC" or (p3.Sick < 10 and (p3.Good == 0 and (p3.Ok == 0 and p3.Bad == 0)) and "SDP" or (p3.Sick == 0 and (p3.Good == 0 and (p3.Ok == 0 and p3.Bad == 0)) and "MFC" or (p3.Miss > 0 and p3.Miss < 10 and "SDCB" or (p3.Miss >= 10 and "CLEAR" or ""))))))));
end;

function generateRatingIcon(p4: number)
    -- upvalues: Ratings (copy), u1 (copy)
    return u1[Ratings.getRatingLetter(p4)] or "rbxassetid://15280046280";
end;

local u5 = {
    Marvelous = Color3.new(1, 1, 1),
    Sick = Color3.new(0.968627, 1, 0.352941),
    Good = Color3.new(0.243137, 1, 0.243137),
    Ok = Color3.new(0.313725, 0.529412, 1),
    Bad = Color3.new(0.631373, 0.396078, 0.160784),
    Miss = Color3.new(1, 0, 0)
};

function generateHitgraph(p6, p7)
    -- upvalues: u5 (copy)
    if p7.hitData and p7.timings then
        table.sort(p7.timings, function(p8, p9) -- Line: 74
            return p8.ratingWindow < p9.ratingWindow;
        end);
        local ratingWindow = p7.timings[#p7.timings].ratingWindow;
        p6.Parent.Late.Text = "Early (" .. -ratingWindow .. "ms)";
        p6.Parent.Early.Text = "Late (" .. ratingWindow .. "ms)";

        for _, v in p7.timings do
            local v10 = p6.Parent.LineExample:Clone();
            local v11 = p6.Parent.LineExample:Clone();
            local v12 = v.ratingWindow / ratingWindow / 2;
            v10.BackgroundColor3 = u5[v.name];
            v11.BackgroundColor3 = u5[v.name];
            v10.Position = UDim2.fromScale(0.5, 0.5 + v12);
            v11.Position = UDim2.fromScale(0.5, 0.5 - v12);
            v10.Visible = true;
            v11.Visible = true;
            v10.Parent = p6.Lines;
            v11.Parent = p6.Lines;
        end;

        if type(p7.hitData) ~= "table" or #p7.hitData == 0 then
            return;
        end;

        table.sort(p7.hitData, function(p13, p14) -- Line: 105
            return p13.strumTime < p14.strumTime;
        end);
        local strumTime = p7.hitData[#p7.hitData].strumTime;

        for _, v in p7.hitData do
            local v15 = v.strumTime / strumTime;
            local math_clamp_ret = math.clamp(v.offset, -ratingWindow, ratingWindow);
            local v16 = math.abs(math_clamp_ret) / ratingWindow / 2;
            local v17 = p6.GraphPlaceholder:Clone();
            v17.BackgroundColor3 = u5[v.name];
            v17.Position = UDim2.fromScale(v15, 0.5 + v16 * (math_clamp_ret < 0 and -1 or 1));
            v17.Visible = true;
            v17.Parent = p6.GraphAssets;
        end;
    end;
end;

function loadModifiers(p18, p19)
    -- upvalues: Modules (copy)
    local ModifierList = p18.Modifiers.ModifierList;

    for _, v in p19.modifiers do
        local v20 = Modules.Engine.VSRG.GameplayModifiers:FindFirstChild(v);

        if v20 then
            local v21 = ModifierList.ModifierIcon:Clone();
            v21.Name = v;
            v21.Image = v20:GetAttribute("Icon") or "rbxassetid://17670220064";
            v21.Visible = true;
            v21.Parent = ModifierList;
        end;
    end;
end;

return {
    create = function(p22, p23) -- Line: 143, Name: create
        -- upvalues: Results (copy), TweenService (copy), ResultsDOF (copy), TopbarIcon (copy), GuiService (copy), u2 (copy), CaptureService (copy)
        local u24 = Results:Clone();
        local CaptureStuff = u24.CaptureStuff;
        local Main = u24.Main;
        local Data = u24.Stats.Data;
        Main.ModName.Text = `{p23.modName}`;
        Main.SongName.Text = `{p23.songName}\n({p23.difficulty}) ({p23.playbackRate}x)`;
        Main.ClearLabel.Text = `{p23.cleared and "Cleared!" or "Failed!"}\n· {judgementRating(p23.judgements)}`;
        Data.ModchartInfo.Text = `· Modcharts: {p23.modcharts and "✅" or "❌"}\n· Special notes: {p23.specialNotes and "✅" or "❌"}`;
        Data.Judgements.Text = `· <font color="rgb(255,255,140)">Marvelous</font>: {p23.judgements.Marvelous}\n· <font color="rgb(90,220,255)">Sick</font>: {p23.judgements.Sick}\n· <font color="rgb(90,255,90)">Good</font>: {p23.judgements.Good}\n· <font color="rgb(255,210,0)">Okay</font>: {p23.judgements.Ok}\n· <font color="rgb(165,65,235)">Bad</font>: {p23.judgements.Bad}\n\n· Highest Combo: {p23.topCombo}\n· Score: {p23.score} ({p23.fakeScore})\n· Accuracy: {p23.accuracy}%\n· Misses: {p23.judgements.Miss}\n\n· MA: {p23.ma}\n· PA: {p23.pa}\n· Mean: {p23.mean}`;
        u24.Ranking.Image = generateRatingIcon(p23.accuracy);
        loadModifiers(u24, p23);
        generateHitgraph(u24.GraphUI.Graph, p23);
        u24.Parent = p22;
        TweenService:Create(u24, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.5)
        }):Play();
        TweenService:Create(ResultsDOF, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            NearIntensity = 1
        }):Play();

        if game.UserInputService.GamepadEnabled then
            TopbarIcon.highlightKey = false;
            GuiService.SelectedObject = nil;
            task.delay(0.5, function() -- Line: 169
                -- upvalues: TopbarIcon (ref), GuiService (ref), u2 (ref), Main (copy)
                TopbarIcon.highlightKey = false;
                GuiService.SelectedObject = nil;
                u2:Enable(Main);
                TopbarIcon.canResetCursor = false;
            end);
        end;

        u24.Continue.MouseButton1Click:Connect(function() -- Line: 177
            -- upvalues: u2 (ref), TopbarIcon (ref), TweenService (ref), ResultsDOF (ref), u24 (copy)
            u2:Disable();
            TopbarIcon.canResetCursor = true;
            TopbarIcon.highlightKey = TopbarIcon.defaultHighlightKey;
            TweenService:Create(ResultsDOF, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                NearIntensity = 0
            }):Play();
            TweenService:Create(u24, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 2.5)
            }):Play();
            task.delay(1.1, function() -- Line: 183
                -- upvalues: u24 (ref)
                u24:Destroy();
            end);
        end);
        local u25 = true;
        u24.Screenshot.MouseButton1Click:Connect(function() -- Line: 189
            -- upvalues: u25 (ref), CaptureService (ref), CaptureStuff (copy), TweenService (ref)
            if not u25 then
                return;
            end;

            CaptureService:CaptureScreenshot(function(p26) -- Line: 191
                -- upvalues: u25 (ref), CaptureStuff (ref), TweenService (ref), CaptureService (ref)
                u25 = false;
                CaptureStuff.ShutterSound:Play();
                CaptureStuff.CaptureOverlay.BackgroundTransparency = 0;
                local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                task.wait();
                TweenService:Create(CaptureStuff.CaptureOverlay, TweenInfo_new_ret, {
                    BackgroundTransparency = 1
                }):Play();
                task.wait(TweenInfo_new_ret.Time + 0.1);
                CaptureService:PromptSaveCapturesToGallery({ p26 }, function() -- Line: 203
                    -- upvalues: u25 (ref)
                    u25 = true;
                end);
            end);
        end);

        return u24;
    end,

    clearUp = function(u27) -- Line: 212, Name: clearUp
        -- upvalues: TweenService (copy), ResultsDOF (copy)
        TweenService:Create(ResultsDOF, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            NearIntensity = 0
        }):Play();
        TweenService:Create(u27, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 2.5)
        }):Play();
        task.delay(1.1, function() -- Line: 216
            -- upvalues: u27 (copy)
            u27:Destroy();
        end);
    end
};