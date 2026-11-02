-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = game:GetService("RunService"):IsStudio();
local StarterPlayerScripts = game:GetService("StarterPlayer").StarterPlayerScripts;
local Client = require(StarterPlayerScripts.SocialSDK.Client);
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Signal = require(Modules.Lib.Signal);
local Translator = require(Modules.Main.Translator);
local u2 = {};
local u3 = `rbxasset://bloxstrap/{game.GameId}.png`;
local u4 = {
    Fill = true,
    Fit = true,
    Stretch = true,
    Tile = true,
    Center = true,
    Span = true
};

function GetAssetId(p5)
    if type(p5) == "number" then
        return p5;
    end;

    if type(p5) == "string" then
        return tonumber(string.match(p5, "%d+"));
    end;

    if typeof(p5) == "Content" then
        return p5.Uri and tonumber(string.match(p5.Uri, "%d+")) or nil;
    end;

    return nil;
end;

function ToUInt32(p6)
    local v7 = p6:ToHex();

    return "0x" .. string.sub(v7, 5, 6) .. string.sub(v7, 3, 4) .. string.sub(v7, 1, 2);
end;

function makeDiff(p8, p9)
    local v10 = {};

    for i, v in p9 do
        v10[i] = v;
    end;

    for i, v in p8 do
        if v10[i] == v then
            v10[i] = nil;
        end;
    end;

    return v10;
end;

function u2.SendMessage(p11: string, p12: any) -- Line: 187
    -- upvalues: u1 (copy), HttpService (copy)
    if u1 then
        return;
    end;

    local v13 = HttpService:JSONEncode({
        command = p11,
        data = p12
    });
    print("[BloxstrapRPC] " .. v13);
end;

local u14 = -1;
local u15 = false;
local u16 = {};

local function addImgChanges(p17: string, p18: table) -- Line: 203
    -- upvalues: u16 (ref)
    local v19 = p18[p17];
    local v20 = u16[p17];

    if v19 then
        if v20 then
            if v19.assetId then
                v20.clear = false;
                v20.assetId = v19.assetId;
            end;

            v20.hoverText = v19.hoverText;

            if v19.reset then
                v20.reset = true;
                v20.hoverText = nil;
                v20.assetId = nil;
            end;

            if v19.clear then
                v20.clear = true;
                v20.assetId = nil;
            end;
        else
            u16[p17] = v19;
        end;
    end;
end;

function u2.SetRichPresence(p21: table) -- Line: 227
    -- upvalues: u14 (ref), u15 (ref), u16 (ref), u2 (copy)
    if p21.timeStart ~= nil then
        p21.timeStart = math.round(p21.timeStart);
    end;

    if p21.timeEnd ~= nil then
        p21.timeEnd = math.round(p21.timeEnd);
    end;

    if p21.smallImage ~= nil then
        p21.smallImage.assetId = GetAssetId(p21.smallImage.assetId);
    end;

    if p21.largeImage ~= nil then
        p21.largeImage.assetId = GetAssetId(p21.largeImage.assetId);
    end;

    local v22 = tick();

    if v22 - u14 >= 1.25 then
        u14 = v22;
        u2.SendMessage("SetRichPresence", p21);

        return;
    end;

    if not u15 then
        task.delay(1, function() -- Line: 247
            -- upvalues: u16 (ref), u2 (ref), u15 (ref)
            if next(u16) then
                u2.SetRichPresence(u16);
                u16 = {};
                u15 = false;
            end;
        end);
    end;

    u15 = true;
    local smallImage = p21.smallImage;
    local smallImage2 = u16.smallImage;

    if smallImage then
        if smallImage2 then
            if smallImage.assetId then
                smallImage2.clear = false;
                smallImage2.assetId = smallImage.assetId;
            end;

            smallImage2.hoverText = smallImage.hoverText;

            if smallImage.reset then
                smallImage2.reset = true;
                smallImage2.hoverText = nil;
                smallImage2.assetId = nil;
            end;

            if smallImage.clear then
                smallImage2.clear = true;
                smallImage2.assetId = nil;
            end;
        else
            u16.smallImage = smallImage;
        end;
    end;

    local largeImage = p21.largeImage;
    local largeImage2 = u16.largeImage;

    if largeImage then
        if largeImage2 then
            if largeImage.assetId then
                largeImage2.clear = false;
                largeImage2.assetId = largeImage.assetId;
            end;

            largeImage2.hoverText = largeImage.hoverText;

            if largeImage.reset then
                largeImage2.reset = true;
                largeImage2.hoverText = nil;
                largeImage2.assetId = nil;
            end;

            if largeImage.clear then
                largeImage2.clear = true;
                largeImage2.assetId = nil;
            end;
        else
            u16.largeImage = largeImage;
        end;
    end;

    for i, v in p21 do
        if i ~= "smallImage" and i ~= "largeImage" then
            u16[i] = v;
        end;
    end;
end;

function u2.ResetRPC() -- Line: 279
    -- upvalues: u2 (copy), Translator (copy)
    u2.SetRichPresence({
        details = "Project: Afternight",
        state = Translator.Get("RPC.InGame")
    });
end;

function u2.SetLaunchData(p23: string) -- Line: 296
    -- upvalues: u2 (copy)
    u2.SendMessage("SetLaunchData", p23);
end;

local function onGameAllowed() -- Line: 300
    -- upvalues: u3 (copy), u2 (copy), HttpService (copy)
    local u24 = nil;
    local u25 = nil;
    pcall(function() -- Line: 304
        -- upvalues: u24 (ref), u3 (ref), u25 (ref)
        u24 = game:GetService("AssetService"):CreateEditableImageAsync(Content.fromUri(u3));

        if u24 then
            u25 = u24:ReadPixelsBuffer(Vector2.zero, Vector2.new(6, 1));
        end;
    end);

    if u25 then
        pcall(function() -- Line: 310
            -- upvalues: u2 (ref), u25 (ref), HttpService (ref)
            u2.ExposedSettings = table.freeze({
                WindowControl = buffer.readu8(u25, 3) == 255,
                WindowTitle = buffer.readu8(u25, 7) == 255,
                WindowTransparency = buffer.readu8(u25, 11) == 255,
                WindowColor = buffer.readu8(u25, 15) == 255,
                WallpaperControl = buffer.readu8(u25, 19) == 255,
                DesktopControl = buffer.readu8(u25, 23) == 255
            });
            print("[Debug] Imported settings from Funkstrap", HttpService:JSONEncode(u2.ExposedSettings));
        end);
        u24:Destroy();
        u24 = nil;
    end;
end;

ContentProvider:PreloadAsync({ "rbxasset://bloxstrap/enabled.png", u3 });
ContentProvider:Preload("rbxasset://bloxstrap/enabled.png");
ContentProvider:Preload(u3);
u2.UsesBloxstrap = ContentProvider:GetAssetFetchStatus("rbxasset://bloxstrap/enabled.png") == Enum.AssetFetchStatus.Success;
local v26 = u2.UsesBloxstrap and ContentProvider:GetAssetFetchStatus(u3) == Enum.AssetFetchStatus.Success;
u2.IsGameAllowed = v26;
u2.WindowStarted = false;
u2.OnWindowAllowed = Signal.new();
u2.ExposedSettings = table.freeze({});

if u2.UsesBloxstrap then
    print("[Bloxstrap] Bloxstrap is enabled");

    if u2.IsGameAllowed then
        onGameAllowed();
    else
        local u27 = nil;
        u27 = ContentProvider:GetAssetFetchStatusChangedSignal(u3):Connect(function(p28) -- Line: 349
            -- upvalues: u27 (ref), u2 (copy), onGameAllowed (copy)
            if p28 == Enum.AssetFetchStatus.Success then
                u27:Disconnect();
                u27 = nil;
                u2.IsGameAllowed = true;
                print("[Bloxstrap] Game is allowed");
                onGameAllowed();
                u2.OnWindowAllowed:Fire();
            end;
        end);
    end;
end;

function u2.CheckWindowPermission() -- Line: 369
    -- upvalues: u2 (copy), ContentProvider (copy), u3 (copy)
    if not u2.UsesBloxstrap or u2.IsGameAllowed then
        return;
    end;

    ContentProvider:Preload(u3);
end;

function u2.RequestWindowPermission() -- Line: 380
    -- upvalues: u2 (copy)
    if not u2.UsesBloxstrap or u2.IsGameAllowed then
        return;
    end;

    u2.SendMessage("RequestWindowPermission", nil);
end;

local u29 = {};
local u30 = {};

function u2.StartWindow() -- Line: 400
    -- upvalues: u2 (copy), u29 (ref)
    u2.WindowStarted = true;
    u2.SendMessage("StartWindow", nil);
    u29 = {};
end;

function u2.StopWindow() -- Line: 410
    -- upvalues: u2 (copy), u29 (ref)
    u2.WindowStarted = false;
    u2.SendMessage("StopWindow", nil);
    u29 = {};
end;

function u2.SetWindow(p31: table) -- Line: 422
    -- upvalues: u2 (copy), u29 (ref)
    if not u2.IsGameAllowed then
        return;
    end;

    if p31.reset then
        u2.ResetWindow();

        return;
    end;

    p31.reset = nil;

    for i, v in p31 do
        p31[i] = math.round(v);
    end;

    local v32 = makeDiff(u29, p31);

    if not next(v32) then
        return;
    end;

    for i, v in v32 do
        u29[i] = v;
    end;

    u2.SendMessage("SetWindow", v32);
end;

function u2.ResetWindow() -- Line: 450
    -- upvalues: u2 (copy), u29 (ref)
    if not u2.IsGameAllowed then
        return;
    end;

    u2.SendMessage("ResetWindow");
    u29 = {};
end;

function u2.SetTitle(p33: string?) -- Line: 462
    -- upvalues: u2 (copy)
    if not p33 then
        return u2.ResetTitle();
    end;

    u2.SendMessage("SetWindowTitle", p33 or "Project: Afternight");
end;

function u2.ResetTitle() -- Line: 472
    -- upvalues: u2 (copy)
    u2.SendMessage("SetWindowTitle", "Project: Afternight");
end;

function u2.SetTransparency(p34: table) -- Line: 485
    -- upvalues: u2 (copy), u30 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    local v35 = makeDiff(u30, p34);

    if not next(v35) then
        return;
    end;

    if typeof(v35.color) == "Color3" then
        v35.color = ToUInt32(v35.color);
    end;

    for i, v in v35 do
        u30[i] = v;
    end;

    u2.SendMessage("SetWindowTransparency", v35);
end;

function u2.ResetTransparency() -- Line: 506
    -- upvalues: u2 (copy), u30 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    u2.SendMessage("SetWindowTransparency", {
        transparency = 1
    });
    u30.transparency = 1;
end;

function u2.SetWindowBorderless(p36: boolean) -- Line: 519
    -- upvalues: u2 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    u2.SendMessage("SetWindowBorderless", p36 or false);
end;

function u2.SendNotification(p37: table) -- Line: 528
    -- upvalues: u2 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    u2.SendMessage("SendNotification", p37);
end;

function u2.SetWindowColor(p38: table) -- Line: 537
    -- upvalues: u2 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    if p38.reset then
        u2.ResetWindowColor();

        return;
    end;

    p38.reset = nil;

    if typeof(p38.border) == "Color3" then
        p38.border = ToUInt32(p38.border);
    end;

    if typeof(p38.caption) == "Color3" then
        p38.caption = ToUInt32(p38.caption);
    end;

    u2.SendMessage("SetWindowColor", p38);
end;

function u2.ResetWindowColor() -- Line: 561
    -- upvalues: u2 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    u2.SendMessage("SetWindowColor", {
        reset = true
    });
end;

function u2.CacheWallpaper(p39) -- Line: 570
    -- upvalues: u2 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    local v40 = GetAssetId(p39);

    if not v40 then
        return;
    end;

    u2.SendMessage("CacheWallpaper", v40);
end;

function u2.SetWallpaper(p41: table) -- Line: 582
    -- upvalues: u2 (copy), u4 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    p41.assetId = GetAssetId(p41.assetId);

    if p41.reset or not p41.assetId then
        u2.ResetWallpaper();

        return;
    end;

    p41.reset = nil;

    if not u4[p41.style or -1] then
        p41.style = "Fill";
    end;

    u2.SendMessage("SetWallpaper", p41);
end;

function u2.ResetWallpaper() -- Line: 604
    -- upvalues: u2 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    u2.SendMessage("SetWallpaper", {
        reset = true
    });
end;

function u2.SetDesktopVisibility(p42: table) -- Line: 612
    -- upvalues: u2 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    if p42.reset then
        u2.ResetDesktopVisibility();

        return;
    end;

    p42.reset = nil;

    if next(p42) then
        u2.SendMessage("SetDesktopVisibility", p42);
    end;
end;

function u2.ResetDesktopVisibility() -- Line: 630
    -- upvalues: u2 (copy)
    if not u2.IsGameAllowed then
        return;
    end;

    u2.SendMessage("SetDesktopVisibility", {
        reset = true
    });
end;

for _, v in { "ShowPopup", "RemoveWindows", "CreateWindow", "SetWindowDefault", "ShowWindow" } do
    u2[v] = function() -- Line: 637
        -- upvalues: v (copy)
        warn((`[FunkstrapSDK :: {v}] This function is not functional yet`));
    end;
end;

u2.UseDiscordSDK = nil;
local u43 = nil;

function useBloxstrapRPC()
    -- upvalues: u2 (copy), u43 (ref), ReplicatedStorage (copy), Client (copy)
    if u2.UseDiscordSDK == nil then
        if not u43 then
            u43 = ReplicatedStorage.Events.ServerRequests.IsRPCEnabled;
        end;

        u2.UseDiscordSDK = u43:InvokeServer();
    end;

    return u2.UseDiscordSDK == false and true or (Client == nil and true or not Client.isReady());
end;

u2.RestoreWindow = u2.ResetWindow;
u2.ResetTitle();
task.spawn(u2.ResetRPC);

return u2;