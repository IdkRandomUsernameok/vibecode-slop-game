-- Decompiled with Potassium's decompiler.

local ProximityPromptService = game:GetService("ProximityPromptService");
local Players = game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("HttpService");
game:GetService("TweenService");
local TextChatService = game:GetService("TextChatService");
game:GetService("UserInputService");
game:GetService("Chat");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Modules2 = script:WaitForChild("Modules");
local TopbarButtons = script:WaitForChild("TopbarButtons");
local u1 = {
    OwOify = require(Modules.Other.OwOify),
    LocalSignals = require(Modules.Signals.LocalSignals),
    SoundPlayer = require(Modules.Audio.SoundPlayer),
    DataManager = require(Modules.Data.DataManager),
    EngineVersion = require(Modules.Engine.EngineVersion),
    EngineData = require(Modules.Engine.EngineVersion),
    SoundLibrary = require(Modules.Audio.SoundLib),
    PlayerRanks = require(Modules.Other.PlayerRanks),
    Translator = require(Modules.Main.Translator),
    SettingsMenuModule = require(Modules.UI.SettingsV2),
    SettingsData = require(Modules.Data.SettingsDataRewrite),
    ProximityPromptUtil = require(script.ProximityPrompt.Util),
    NotificationManager = require(script.NotificationManager),
    DeviceManager = require(Modules.Main.DeviceManager)
};
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local Main = PlayerGui:WaitForChild("Main");
local SettingsV2 = Main:WaitForChild("SettingsV2");
local v2 = {
    {
        Modules2.Nametags,
        multiThreaded = true,
        args = { Modules }
    },
    {
        Modules2.Badges,
        multiThreaded = true,
        args = { Modules }
    },
    {
        Modules2.Leaderboard,
        multiThreaded = true,
        args = { Modules, u1 }
    },
    {
        Modules2.DebugWatermark,
        multiThreaded = true,
        args = { Main, LocalPlayer, u1 }
    },
    {
        Modules2.QuestsPanel,
        multiThreaded = false,
        args = { PlayerGui }
    },
    {
        Modules2.BloxstrapPrompt,
        multiThreaded = false,
        args = { Main, LocalPlayer, Modules }
    }
};
local v3 = {
    {
        TopbarButtons.ExperimentalFeatures,
        multiThreaded = true,
        args = {
            Main,
            Modules,
            {
                Position = "Right",
                Order = 5
            },
            u1.SoundLibrary
        }
    },
    {
        TopbarButtons.Changelog,
        multiThreaded = true,
        args = {
            Main,
            Modules,
            {
                Position = "Right",
                Order = 4
            },
            u1.SoundLibrary
        }
    },
    {
        TopbarButtons.Rules,
        multiThreaded = true,
        args = {
            Main,
            Modules,
            {
                Position = "Right",
                Order = 3
            },
            u1.SoundLibrary
        }
    },
    {
        TopbarButtons.ServerAge,
        multiThreaded = true,
        args = {
            Main,
            Modules,
            {
                Position = "Right",
                Order = 1
            },
            u1.SoundLibrary
        }
    },
    {
        TopbarButtons.ServerCreation,
        multiThreaded = true,
        args = {
            Main,
            Modules,
            {
                Position = "Center",
                Order = 4
            },
            u1.SoundLibrary
        }
    },
    {
        TopbarButtons.DevConsole,
        multiThreaded = true,
        args = {
            Main,
            Modules,
            {
                Position = "Center",
                Order = 5
            },
            u1.SoundLibrary
        }
    }
};
task.defer(function() -- Line: 54
    local StarterGui2 = game:GetService("StarterGui");

    for _, child in StarterGui2:GetChildren() do
        child:Destroy();
    end;

    StarterGui2.ChildAdded:Connect(function(p4) -- Line: 62
        p4:Destroy();
    end);
end);
u1.SoundLibrary:Pool("InviteReceived", 2, true);
u1.SoundLibrary:Pool("Topbar/Hover", 2, true);
u1.SoundLibrary:Pool("Topbar/Open", 2, true);
local TopbarButtons2 = Main.TopbarButtons;

local function runLoader(u5, u6) -- Line: 74
    local function load() -- Line: 75
        -- upvalues: u5 (copy), u6 (copy)
        xpcall(function() -- Line: 76
            -- upvalues: u5 (ref), u6 (ref)
            local v7 = require(u5[1])(unpack(u5.args));

            if u6 and v7 then
                u6(v7);
            end;
        end, function(p8) -- Line: 81
            warn((`[Module Error]: {p8}\n{debug.traceback()}`));
        end);
    end;

    if u5.multiThreaded then
        task.spawn(load);

        return;
    end;

    xpcall(function() -- Line: 76
        -- upvalues: u5 (copy), u6 (copy)
        local v9 = require(u5[1])(unpack(u5.args));

        if u6 and v9 then
            u6(v9);
        end;
    end, function(p10) -- Line: 81
        warn((`[Module Error]: {p10}\n{debug.traceback()}`));
    end);
end;

local u11 = {};

for _, v in v2 do
    local u12 = nil;

    local function v15() -- Line: 75
        -- upvalues: v (copy), u12 (copy)
        xpcall(function() -- Line: 76
            -- upvalues: v (ref), u12 (ref)
            local v13 = require(v[1])(unpack(v.args));

            if u12 and v13 then
                u12(v13);
            end;
        end, function(p14) -- Line: 81
            warn((`[Module Error]: {p14}\n{debug.traceback()}`));
        end);
    end;

    if v.multiThreaded then
        task.spawn(v15);
    else
        local u16 = nil;
        xpcall(function() -- Line: 76
            -- upvalues: v (copy), u16 (copy)
            local v17 = require(v[1])(unpack(v.args));

            if u16 and v17 then
                u16(v17);
            end;
        end, function(p18) -- Line: 81
            warn((`[Module Error]: {p18}\n{debug.traceback()}`));
        end);
    end;
end;

for _, v in v3 do
    local function u20(p19) -- Line: 98
        -- upvalues: u11 (copy), TopbarButtons2 (copy)
        table.insert(u11, p19);
        local Attribute = TopbarButtons2:GetAttribute("Disabled");
        p19:setEnabled(not Attribute);

        if Attribute then
            p19:deselect();
        end;
    end;

    local function v23() -- Line: 75
        -- upvalues: v (copy), u20 (copy)
        xpcall(function() -- Line: 76
            -- upvalues: v (ref), u20 (ref)
            local v21 = require(v[1])(unpack(v.args));

            if u20 and v21 then
                u20(v21);
            end;
        end, function(p22) -- Line: 81
            warn((`[Module Error]: {p22}\n{debug.traceback()}`));
        end);
    end;

    if v.multiThreaded then
        task.spawn(v23);
    else
        xpcall(function() -- Line: 76
            -- upvalues: v (copy), u20 (copy)
            local v24 = require(v[1])(unpack(v.args));

            if u20 and v24 then
                u20(v24);
            end;
        end, function(p25) -- Line: 81
            warn((`[Module Error]: {p25}\n{debug.traceback()}`));
        end);
    end;
end;

local function setButtonsStatus() -- Line: 108
    -- upvalues: TopbarButtons2 (copy), u11 (copy)
    local Attribute = TopbarButtons2:GetAttribute("Disabled");

    for _, v in u11 do
        v:setEnabled(not Attribute);

        if Attribute then
            v:deselect();
        end;
    end;
end;

TopbarButtons2:GetAttributeChangedSignal("Disabled"):Connect(setButtonsStatus);
u1.DeviceManager.inputDeviceChanged:Connect(setButtonsStatus);
SettingsV2.Visible = true;
SettingsV2.Settings.Visible = false;
local v26 = u1.SettingsMenuModule.new(SettingsV2);
v26:setCategories(u1.SettingsData);
v26:allowRender();
v26:makeTopbarIcon();
ReplicatedStorage.Events.Message.OnClientEvent:Connect(function(p27, p28) -- Line: 135
    -- upvalues: TextChatService (copy), StarterGui (copy)
    if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = p27,
            Color = p28
        });

        return;
    end;

    if p28 then
        p27 = `<font color='#{p28:ToHex()}'>{p27}</font>`;
    end;

    TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(p27);
end);
ProximityPromptService.PromptShown:Connect(function(p29, p30) -- Line: 149
    -- upvalues: PlayerGui (copy), u1 (copy)
    if p29.Style == Enum.ProximityPromptStyle.Custom then
        local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts");

        if ProximityPrompts == nil then
            ProximityPrompts = Instance.new("ScreenGui");
            ProximityPrompts.Name = "ProximityPrompts";
            ProximityPrompts.ResetOnSpawn = false;
            ProximityPrompts.Parent = PlayerGui;
        end;

        local v31 = u1.ProximityPromptUtil.createPrompt(p29, p30, ProximityPrompts);
        p29.PromptHidden:Wait();
        p29:FindFirstChild("GuiObject").Value = nil;
        v31();
    end;
end);