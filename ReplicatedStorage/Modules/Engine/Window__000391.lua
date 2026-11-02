-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local Modules = ReplicatedStorage:WaitForChild("Modules");
Modules:WaitForChild("Assets");
local Main = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main");
local u1 = RunService:IsStudio();
local BloxstrapRPC = require(Modules.Engine.BloxstrapRPC);
local LocalSignals = require(Modules.Signals.LocalSignals);
local DataManager = require(Modules.Data.DataManager);
require(Modules.Other.Adapters);
local Data = DataManager:GetData();
local u2 = {
    enabled = false,
    simulated = false,
    onlySimulated = false,
    x = 0,
    y = 0,
    w = 1280,
    h = 720,
    scaleX = 1280,
    scaleY = 720,
    savedPos = {
        x = 0,
        y = 0,
        w = 1280,
        h = 720
    }
};
local u3 = nil;
local u4 = true;
local u5 = -1;
local u6 = {};
local SimulatedWindow = Main.SimulatedWindow;
local u7 = "Project: Afternight";
local u8 = nil;
local Vector2_new_ret = Vector2.new(1, 1);
local workspace_CurrentCamera = workspace.CurrentCamera;
LocalSignals.APILoaded:Once(function(p9) -- Line: 58
    -- upvalues: u8 (ref)
    u8 = p9;
end);

function resetWindowTable()
    -- upvalues: u2 (ref)
    u2 = {
        enabled = false,
        simulated = false,
        onlySimulated = false,
        x = 0,
        y = 0,
        w = 1280,
        h = 720,
        scaleX = 1280,
        scaleY = 720,
        savedPos = {
            x = 0,
            y = 0,
            w = 1280,
            h = 720
        }
    };
end;

function createWindow(p10, p11, p12, p13, p14, p15, p16, p17)
    -- upvalues: u5 (ref), u2 (ref), BloxstrapRPC (copy), Main (copy), u6 (copy)
    u5 = u5 + 1;

    if not u2.simulated then
        return BloxstrapRPC.CreateWindow({
            reset = false,
            x = p10,
            y = p11,
            width = p12,
            height = p13,
            scaleWidth = p14,
            scaleHeight = p15,
            windowId = p16,
            image = p17
        });
    end;

    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Image = "rbxassetid://" .. p17 or "";
    ImageLabel.Name = "FakeWindow";
    ImageLabel.Parent = Main;
    ImageLabel.ZIndex = 9;
    ImageLabel.Position = UDim2.fromScale(p10 / p14, p11 / p15);
    ImageLabel.Size = UDim2.fromScale(p12 / p14, p13 / p15);
    ImageLabel.BackgroundTransparency = 0.5;
    u6[u5] = ImageLabel;

    return u5;
end;

function destroyWindow(p18)
    -- upvalues: u6 (copy)
    if typeof(p18) == "Instance" then
        p18:Destroy();

        return;
    end;

    if u6[p18] then
        u6[p18]:Destroy();
        table.remove(u6, p18);
    end;
end;

function updateSimWinTimer()
    -- upvalues: LocalPlayer (copy), SimulatedWindow (copy)
    local v19 = `{os.date("%H:%M")}\n{DateTime.now():FormatLocalTime("L", LocalPlayer.LocaleId)}`;
    SimulatedWindow.BG.Taskbar.Right.Clock.Text = v19;
    SimulatedWindow.BG2.Taskbar.Right.Clock.Text = v19;
end;

function spawnInfLoopTimerUpdate()
    -- upvalues: u8 (ref)
    updateSimWinTimer();
    u8.addToDelayedThreads(task.delay(60 - DateTime.now():ToLocalTime().Second, spawnInfLoopTimerUpdate));
end;

function initWindowMovement(p20: boolean)
    -- upvalues: BloxstrapRPC (copy), u1 (copy), u2 (ref), u8 (ref), u4 (ref), u7 (ref), SimulatedWindow (copy)
    resetWindowTable();
    updateBGGradients();
    BloxstrapRPC.CheckWindowPermission();
    local v21;

    if u1 or not BloxstrapRPC.IsGameAllowed then
        v21 = false;
    else
        v21 = settings.BloxstrapData.AllowWindowMove or false;
    end;

    u2.onlySimulated = not v21;
    u2.simulated = p20 or not v21;
    u8.windowOnlySimulated = u2.onlySimulated;
    u8.isSimulatedWindow = u2.simulated;
    u4 = true;
    BloxstrapRPC.StartWindow();

    if u2.simulated then
        spawnInfLoopTimerUpdate();
        setTitle(u7);
        SimulatedWindow.Visible = true;
    end;

    u2.enabled = true;
    setWallpaper();
end;

function setWindow(p22: number?, p23: number?, p24: number?, p25: number?, p26: number?, p27: number?, p28: number?, p29: number?)
    -- upvalues: u4 (ref), u2 (ref), BloxstrapRPC (copy), u6 (copy), u3 (ref)
    u4 = true;

    if not u2.simulated then
        return BloxstrapRPC.SetWindow({
            x = p22,
            y = p23,
            width = p24,
            height = p25,
            scaleWidth = p26,
            scaleHeight = p27,
            reset = p28
        });
    end;

    if p29 ~= nil then
        local v30 = u6[p29];

        if not v30 then
            return;
        end;

        v30.Position = UDim2.fromScale(p22 / p26, p23 / p27);
        v30.Size = UDim2.fromScale(p24 / p26, p25 / p27);

        return;
    end;

    u2.x = p22 or u2.x;
    u2.y = p23 or u2.y;
    u2.w = p24 or u2.w;
    u2.h = p25 or u2.h;
    u2.scaleX = p26 or u2.scaleX;
    u2.scaleY = p27 or u2.scaleY;
    updateBGGradients();

    if not u3 then
        return;
    end;

    local w = u2.w;
    local h = u2.h;
    local scaleX = u2.scaleX;
    local scaleY = u2.scaleY;

    if not u3 then
        return;
    end;

    u3.Position = UDim2.fromScale(u2.x / scaleX, u2.y / scaleY);
    u3.Size = UDim2.fromScale(w / scaleX, h / scaleY);
end;

function restoreWindow()
    -- upvalues: u2 (ref), BloxstrapRPC (copy), u3 (ref)
    if not u2.simulated then
        return BloxstrapRPC.ResetWindow();
    end;

    for i, v in u2.savedPos do
        u2[i] = v;
    end;

    updateBGGradients();

    if not u3 then
        return;
    end;

    u3.Position = UDim2.fromScale(0, 0);
    u3.Size = UDim2.fromScale(1, 1);
end;

function clearWindow()
    -- upvalues: u2 (ref), BloxstrapRPC (copy), u3 (ref), u6 (copy), SimulatedWindow (copy), u8 (ref)
    if not u2.enabled then
        return;
    end;

    BloxstrapRPC.StopWindow();
    setDesktopIconsVisible(true);
    setDesktopTaskbarVisible(true);
    setWallpaper();
    setTitle();
    setWindowBorderless();

    if u3 then
        u3:Destroy();
        u3 = nil;
    end;

    for _, v in u6 do
        destroyWindow(v);
    end;

    SimulatedWindow.Visible = false;
    table.clear(u6);
    updateBGGradients();
    u8.isSimulatedWindow = false;
    resetWindowTable();
end;

function setTitle(p31)
    -- upvalues: u7 (ref), u2 (ref), SimulatedWindow (copy), Data (copy), BloxstrapRPC (copy)
    u7 = p31 or "Project: Afternight";

    if u2.simulated then
        SimulatedWindow.TopBarContainer.Title.Text = u7;

        return;
    end;

    if Data.BloxstrapData.AllowWindowTitle then
        BloxstrapRPC.SetTitle(u7);
    end;
end;

function setWindowBorderless(p32)
    -- upvalues: BloxstrapRPC (copy), u2 (ref), SimulatedWindow (copy)
    if p32 == nil then
        p32 = false;
    end;

    BloxstrapRPC.SetWindowBorderless(p32);

    if u2.simulated then
        SimulatedWindow.TopBarContainer.Visible = not p32;
    end;
end;

function sendNotification(p33, p34, p35)
    -- upvalues: BloxstrapRPC (copy), u2 (ref), SimulatedWindow (copy)
    BloxstrapRPC.SendNotification(p33, p34, p35);

    if u2.simulated then
        local v36 = p33 or "[[MISSING TITLE]]";
        local v37 = p34 or "[[MISSING CAPTION]]";
        local u38 = SimulatedWindow.NotificationFrame:Clone();
        u38.Parent = SimulatedWindow;
        u38.NotificationTitle.Text = v36 or "";
        u38.NotificationMessage.Text = v37 or "";

        if not v36 then
            u38.NotificationTitle.Visible = false;
        end;

        if not v37 then
            u38.NotificationMessage.Visible = false;
        end;

        u38.Position = UDim2.new(1.3, -10, 1, -60);
        u38.Visible = true;
        u38:TweenPosition(UDim2.new(1, -10, 1, -60), "Out", "Sine", 0.35);
        task.delay((p35 or 5) + 0.35, function() -- Line: 292
            -- upvalues: u38 (copy)
            u38:TweenPosition(UDim2.new(1.3, -10, 1, -60), "Out", "Sine", 0.35, true, function() -- Line: 293
                -- upvalues: u38 (ref)
                u38:Destroy();
            end);
        end);
    end;
end;

function showPopup(p39, p40)
    -- upvalues: BloxstrapRPC (copy)
    BloxstrapRPC.ShowPopup(p39, p40);
end;

function showWindow(p41)
    -- upvalues: u4 (ref), BloxstrapRPC (copy)
    u4 = p41;
    BloxstrapRPC.ShowWindow(p41);
    updateBGGradients();
end;

function setWindowTransparency(p42, p43, p44)
    -- upvalues: BloxstrapRPC (copy)
    if settings.BloxstrapData.AllowWindowTransparency then
        BloxstrapRPC.SetTransparency({
            color = p42,
            transparency = p43,
            useAlpha = p44
        });
    end;
end;

function useLegacySimulation(p45: boolean)
    -- upvalues: u2 (ref), SimulatedWindow (copy)
    if not (u2.enabled and u2.simulated) then
        return;
    end;

    SimulatedWindow.Legacy.Visible = p45;
    SimulatedWindow.BG.Visible = not p45;
    SimulatedWindow.BG2.Visible = not p45;
end;

function makeTransparentSections(p46, p47)
    if p47 < p46 then
        local v48 = p47;
        p47 = p46;
        p46 = v48;
    end;

    local math_clamp_ret = math.clamp(p46, 0.0005, 1);
    local math_clamp_ret2 = math.clamp(p47, math_clamp_ret, 1);

    if math_clamp_ret == math_clamp_ret2 then
        return NumberSequence.new(0);
    end;

    local v49 = {
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(math_clamp_ret - 0.0005, 0),
        NumberSequenceKeypoint.new(math_clamp_ret, 1),
        NumberSequenceKeypoint.new(math_clamp_ret2 - 0.0005, 1),
        NumberSequenceKeypoint.new(math_clamp_ret2, 0),
        NumberSequenceKeypoint.new(1, 0)
    };

    if math_clamp_ret <= 0.0005 then
        table.remove(v49, 1);
    end;

    if math_clamp_ret2 == 1 then
        table.remove(v49, #v49);
    end;

    return NumberSequence.new(v49);
end;

function updateBGGradients()
    -- upvalues: u4 (ref), SimulatedWindow (copy), u2 (ref), Vector2_new_ret (ref), workspace_CurrentCamera (copy), u8 (ref)
    if u4 then
        SimulatedWindow.TopBarContainer.Size = UDim2.new((u2.x + u2.w) / u2.scaleX - u2.x / u2.scaleX, 0, 0, 29);
        SimulatedWindow.TopBarContainer.Position = UDim2.fromScale((u2.x + u2.w) / u2.scaleX, u2.y / u2.scaleY);
        SimulatedWindow.BG.Horizontal.Transparency = makeTransparentSections(u2.x / u2.scaleX, (u2.x + u2.w) / u2.scaleX);
        SimulatedWindow.BG2.Vertical.Transparency = makeTransparentSections(u2.y / u2.scaleY, (u2.y + u2.h) / u2.scaleY);
    else
        SimulatedWindow.TopBarContainer.Size = UDim2.fromScale(0, 0);
        SimulatedWindow.BG.Horizontal.Transparency = NumberSequence.new(0);
        SimulatedWindow.BG2.Vertical.Transparency = NumberSequence.new(0);
    end;

    SimulatedWindow.Legacy.BG.Horizontal.Transparency = SimulatedWindow.BG.Horizontal.Transparency;
    SimulatedWindow.Legacy.BG2.Vertical.Transparency = SimulatedWindow.BG2.Vertical.Transparency;
    local Vector2_new_ret2 = Vector2.new(u2.w / u2.scaleX, u2.h / u2.scaleY);

    if Vector2_new_ret == Vector2_new_ret2 then
        return;
    end;

    Vector2_new_ret = Vector2_new_ret2;
    local v50 = workspace_CurrentCamera.ViewportSize * Vector2_new_ret2;

    for _, v in u8.textItemsScaling do
        v(v50);
    end;
end;

function setWallpaper(p51: string?, p52)
    -- upvalues: u2 (ref), SimulatedWindow (copy)
    if not (u2.enabled and u2.simulated) then
        return;
    end;

    if p52 == nil then
        SimulatedWindow.BG.Background.Image = p51 or "rbxassetid://6279580198";
        SimulatedWindow.BG2.Background.Image = p51 or "rbxassetid://6279580198";
        SimulatedWindow.BG.Background.ImageTransparency = 0;
        SimulatedWindow.BG.Background.BackgroundTransparency = 1;
        SimulatedWindow.BG2.Background.ImageTransparency = 0;
        SimulatedWindow.BG2.Background.BackgroundTransparency = 1;
        SimulatedWindow.Legacy.BG.Image = p51 or "rbxassetid://3800050934";
        SimulatedWindow.Legacy.BG2.Image = p51 or "rbxassetid://3800050934";
        SimulatedWindow.Legacy.BG.ImageTransparency = 0;
        SimulatedWindow.Legacy.BG2.ImageTransparency = 0;

        return;
    end;

    SimulatedWindow.BG.Background.ImageTransparency = 1;
    SimulatedWindow.BG.Background.BackgroundTransparency = 0;
    SimulatedWindow.BG2.Background.ImageTransparency = 1;
    SimulatedWindow.BG2.Background.BackgroundTransparency = 0;
    SimulatedWindow.Legacy.BG.ImageTransparency = 1;
    SimulatedWindow.Legacy.BG2.ImageTransparency = 1;
    SimulatedWindow.BG.Background.BackgroundColor3 = p52;
    SimulatedWindow.BG2.Background.BackgroundColor3 = p52;
    SimulatedWindow.Legacy.BG.BackgroundColor3 = p52;
    SimulatedWindow.Legacy.BG2.BackgroundColor3 = p52;
end;

function setWindowColor(p53, p54, p55)
    -- upvalues: BloxstrapRPC (copy)
    if p55 then
        return BloxstrapRPC.SetWindowColor({
            reset = true
        });
    end;

    local v56 = {};

    if p53 then
        v56.caption = p53;
    end;

    if p54 then
        v56.border = p54;
    end;

    BloxstrapRPC.SetWindowColor(v56);
end;

function setDesktopTaskbarVisible(p57: boolean)
    -- upvalues: u2 (ref), SimulatedWindow (copy)
    if not (u2.enabled and u2.simulated) then
        return;
    end;

    local v58 = p57 == nil and true or p57;
    SimulatedWindow.BG.Taskbar.Visible = v58 or false;
    SimulatedWindow.BG2.Taskbar.Visible = v58 or false;
end;

function setDesktopIconsVisible(p59: boolean)
    -- upvalues: u2 (ref), SimulatedWindow (copy)
    if not (u2.enabled and u2.simulated) then
        return;
    end;

    local v60 = p59 == nil and true or p59;

    for _, child in SimulatedWindow.BG.Background:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = v60 or false;
        end;
    end;

    for _, child in SimulatedWindow.BG2.Background:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = v60 or false;
        end;
    end;
end;

return {
    windowData = u2,
    resetWindowTable = resetWindowTable,
    createWindow = createWindow,
    updateSimWinTimer = updateSimWinTimer,
    spawnInfLoopTimerUpdate = spawnInfLoopTimerUpdate,
    initWindowMovement = initWindowMovement,
    setWindow = setWindow,
    restoreWindow = restoreWindow,
    clearWindow = clearWindow,
    setTitle = setTitle,
    setWindowBorderless = setWindowBorderless,
    sendNotification = sendNotification,
    showPopup = showPopup,
    showWindow = showWindow,
    setWindowTransparency = setWindowTransparency,
    useLegacySimulation = useLegacySimulation,
    makeTransparentSections = makeTransparentSections,
    updateBGGradients = updateBGGradients,
    setWallpaper = setWallpaper,
    setWindowColor = setWindowColor,
    setDesktopTaskbarVisible = setDesktopTaskbarVisible,
    setDesktopIconsVisible = setDesktopIconsVisible,
    viewportScale = Vector2_new_ret
};