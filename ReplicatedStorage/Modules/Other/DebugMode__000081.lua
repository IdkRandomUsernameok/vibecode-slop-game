-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
local u1 = require(script.Iris).Init();
require(script.Iris.Types);
local Signal = require(game:GetService("ReplicatedStorage").Modules.Lib.Signal);
local PartialUIPart = require(game:GetService("ReplicatedStorage").Modules.Modchart.PartialUIPart);
local u2 = {
    showEventLines = true,
    showNoteTypes = true,
    showActualHitboxStrumline = false,
    showNoteMs = false,
    showNoteHitbox = false,
    simulateInputOffset = false,
    ppuixaxis = PartialUIPart.MagicNumberX,
    ppuiyaxis = PartialUIPart.MagicNumberY
};
local u3 = {};

for i, _ in u2 do
    u3[i] = Signal.new();
end;

function ezState(u4)
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    return u1.VariableState(u2[u4], function(p5) -- Line: 26
        -- upvalues: u2 (ref), u4 (copy), u3 (ref)
        u2[u4] = p5;
        u3[u4]:Fire(p5);
    end);
end;

u3.ppuixaxis:Connect(function(p6) -- Line: 32
    -- upvalues: PartialUIPart (copy)
    PartialUIPart.MagicNumberX = p6;
    print(p6, "X");
end);
u3.ppuiyaxis:Connect(function(p7) -- Line: 37
    -- upvalues: PartialUIPart (copy)
    PartialUIPart.MagicNumberY = p7;
    print(p7, "Y");
end);
local Frame = Instance.new("Frame");
Frame.AnchorPoint = Vector2.new(0, 0.5);
Frame.Position = UDim2.fromScale(0, 0.5);
Frame.Size = UDim2.new(1, 0, 0, 5);
Frame.BackgroundColor3 = Color3.new(1, 1, 1);
Frame.BorderSizePixel = 0;
Frame.Visible = false;
Frame.ZIndex = 100;
u3.showActualHitboxStrumline:Connect(function() -- Line: 52
    -- upvalues: u2 (copy), Api (copy), Frame (ref)
    if u2.showActualHitboxStrumline then
        local v8 = (Api.Settings.Downscroll and 615.75 or 104.25) + Api.Settings.LaneHeight + Api.getYPosAt(Api.Conductor.SongPosition - Api.Settings.InputOffset) * (Api.Settings.Downscroll and -1 or 1);
        print(v8);
        Frame.Position = UDim2.fromScale(0, v8 / 720);
    end;

    Frame.Visible = u2.showActualHitboxStrumline;
end);
local u9 = {};

function attachEventLine(p10, p11)
    -- upvalues: Api (copy)
    local v12 = p10.strumLine and p10.strumLine.KeyCount or Api.getKeyData().playerKeyCount;
    local Frame2 = Instance.new("Frame");
    Frame2.AnchorPoint = Vector2.new(0, 0.5);
    Frame2.Position = UDim2.fromScale(0, 0.5);
    Frame2.Size = UDim2.new(1 * v12, 0, 0, 3);
    Frame2.BackgroundColor3 = Color3.new(0, 0.9, 0);
    Frame2.BorderSizePixel = 0;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.TextScaled = true;
    TextLabel.AnchorPoint = Vector2.new(0, 1);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "";
    TextLabel.TextColor3 = Color3.new(0, 0.9, 0);
    TextLabel.TextStrokeTransparency = 0;
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;

    for i, v in p11 do
        TextLabel.Text = TextLabel.Text .. string.format("%.3f - %s - %s - %s", v.StrumTime, v.Name, tostring(v.Value1), (tostring(v.Value2))) .. (i == #p11 and "" or "\n");

        if v.Name:lower() == "debug highlight" then
            TextLabel.TextColor3 = Color3.new(1, 1, 0);
            Frame2.BackgroundColor3 = Color3.new(1, 1, 0);
        end;
    end;

    TextLabel.Size = UDim2.fromScale(1, #p11 * 10);
    TextLabel.Parent = Frame2;
    Frame2.Parent = p10.Obj;

    return Frame2;
end;

function renderIris()
    -- upvalues: u1 (copy), Api (copy)
    u1.Window({
        [u1.Args.Window.Title] = "Debug Menu"
    }, {
        size = u1.State(Vector2.new(400, 500)),
        position = u1.State(Vector2.new(0, 0)),
        isUncollapsed = u1.State(false)
    });
    u1.SeparatorText("Render Options");
    u1.Checkbox({ "Show Event Lines" }, {
        isChecked = ezState("showEventLines")
    });
    u1.Checkbox({ "Show Note Types" }, {
        isChecked = ezState("showNoteTypes")
    });
    u1.SeparatorText("Offset Tests");
    u1.Checkbox({ "Simulate Input Offset (only for negatives)" }, {
        isChecked = ezState("simulateInputOffset")
    });
    u1.Checkbox({ "Show General Hitbox Line" }, {
        isChecked = ezState("showActualHitboxStrumline")
    });
    u1.Checkbox({ "Show Individual Note Hitbox" }, {
        isChecked = ezState("showNoteHitbox")
    });
    u1.Checkbox({ "Show Note MS Distance" }, {
        isChecked = ezState("showNoteMs")
    });
    u1.SeparatorText("Partial Part UI Magic Numbers 🔥🔥🔥🔥");
    u1.InputNum({
        [u1.Args.InputNum.Text] = "X Axis",
        [u1.Args.InputNum.Min] = 1e-8
    }, {
        number = ezState("ppuixaxis")
    });
    u1.InputNum({
        [u1.Args.InputNum.Text] = "Y Axis",
        [u1.Args.InputNum.Min] = 1e-8
    }, {
        number = ezState("ppuiyaxis")
    });
    local LuaDebugStats = Api.getLuaDebugStats();
    u1.SeparatorText("Lua Debug");
    u1.Text((`Loaded / Initialized: {LuaDebugStats.Loaded and "✅" or "❌"}`));
    u1.Text((`Modchart Amount: {LuaDebugStats.Modcharts}`));
    u1.Text((`Note Groups Amount: {LuaDebugStats.NoteGroups}`));
    u1.End();
end;

function round(p13, p14)
    local v15 = 10 ^ (p14 or 0);

    return math.floor(p13 * v15 + 0.5) / v15;
end;

return {
    onCreate = function() -- Line: 141, Name: onCreate
        -- upvalues: Api (copy), Frame (ref)
        Api.setNoteSpawnTime(14);
        Frame.Parent = Api.Game;
    end,

    onSpawnNote = function(u16) -- Line: 146, Name: onSpawnNote
        -- upvalues: u2 (copy), u3 (copy), Api (copy)
        if not (u16.alive and u16.Obj) then
            return;
        end;

        local u17 = {};
        local u18 = {};

        if u16.rawData[4] == "event line" then
            local u19 = attachEventLine(u16, u16.eventData);
            u19.Visible = u2.showEventLines;
            table.insert(u17, u3.showEventLines:Connect(function(p20) -- Line: 159
                -- upvalues: u19 (copy)
                u19.Visible = p20;
            end));
            table.insert(u18, u19);
        elseif u16.rawData[4] and tostring(u16.rawData[4]) ~= "0" then
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BackgroundTransparency = 0.8;
            TextLabel.BackgroundColor3 = Color3.new(0);
            TextLabel.Size = UDim2.fromScale(1, 0.3);
            TextLabel.AnchorPoint = Vector2.new(0, 1);
            TextLabel.Position = UDim2.new(0, 1);
            TextLabel.TextColor3 = Color3.new(0, 0.9, 0);
            TextLabel.TextScaled = true;
            TextLabel.Visible = u2.showNoteTypes;
            TextLabel.Text = tostring(u16.rawData[4]);
            TextLabel.Parent = u16.Obj;
            table.insert(u17, u3.showNoteTypes:Connect(function(p21) -- Line: 178
                -- upvalues: TextLabel (copy)
                TextLabel.Visible = p21;
            end));
            table.insert(u18, TextLabel);
        end;

        if u2.showNoteMs then
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BackgroundTransparency = 0.8;
            TextLabel.BackgroundColor3 = Color3.new(0);
            TextLabel.Size = UDim2.fromScale(1, 0.3);
            TextLabel.AnchorPoint = Vector2.new(0, 1);
            TextLabel.Position = UDim2.new(0, 1);
            TextLabel.TextColor3 = Color3.new(0, 0.9, 0);
            TextLabel.TextScaled = true;
            TextLabel.Text = round(Api.Conductor.SongPosition - u16.strumTime + Api.Settings.InputOffset, 2);
            TextLabel.Parent = u16.Obj;
            table.insert(u18, TextLabel);
            local RenderStepped = game:GetService("RunService").RenderStepped;
            table.insert(u17, RenderStepped:Connect(function() -- Line: 200
                -- upvalues: TextLabel (copy), Api (ref), u16 (copy)
                TextLabel.Text = round(Api.Conductor.SongPosition - u16.strumTime + Api.Settings.InputOffset, 2);
            end));
        end;

        if u2.showNoteHitbox and not u16.sustainNote then
            local Frame2 = Instance.new("Frame");
            Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame2.Position = UDim2.fromScale(0, 0.5);
            Frame2.Size = UDim2.new(0, 120, 0, 5);
            Frame2.BackgroundColor3 = Color3.new(1, 1, 1);
            Frame2.BorderSizePixel = 0;
            Frame2.Visible = true;
            Frame2.ZIndex = 100;
            Frame2.Parent = Api.Game;
            local RenderStepped = game:GetService("RunService").RenderStepped;
            table.insert(u17, RenderStepped:Connect(function() -- Line: 216
                -- upvalues: Api (ref), u16 (copy), Frame2 (copy)
                local v22 = (Api.Settings.Downscroll and 615.75 or 104.25) + Api.Settings.LaneHeight - Api.getYPosAt(u16.strumTime - Api.Settings.InputOffset) * (Api.Settings.Downscroll and -1 or 1);
                Frame2.Position = UDim2.fromScale(u16:GetProperty("x") / 1280, v22 / 720);
            end));
            table.insert(u18, Frame2);
        end;

        if next(u18) or next(u17) then
            local Destroy = u16.Destroy;

            function u16.Destroy(p23, ...) -- Line: 229
                -- upvalues: Destroy (copy), u18 (copy), u17 (copy)
                local _ = p23.Obj;
                Destroy(p23, ...);

                if not p23.alive then
                    for _, v in u18 do
                        v:Destroy();
                    end;

                    for _, v in u17 do
                        v:Disconnect();
                    end;

                    table.clear(u18);
                    table.clear(u17);
                end;
            end;
        end;
    end,

    onUpdatePost = function() -- Line: 245, Name: onUpdatePost
        renderIris();
    end,

    onKeyDown = function() -- Line: 249, Name: onKeyDown
        -- upvalues: u2 (copy), Api (copy)
        if u2.simulateInputOffset and Api.Settings.InputOffset < 0 then
            task.wait(-Api.Settings.InputOffset / 1000);
        end;
    end,

    onKeyUp = function() -- Line: 255, Name: onKeyUp
        -- upvalues: u2 (copy), Api (copy)
        if u2.simulateInputOffset and Api.Settings.InputOffset < 0 then
            task.wait(-Api.Settings.InputOffset / 1000);
        end;
    end,

    onEventAdded = function(p24) -- Line: 261, Name: onEventAdded
        -- upvalues: u9 (copy), Api (copy)
        local StrumTime = p24.StrumTime;

        if u9[StrumTime] then
            table.insert(u9[StrumTime], p24);

            return;
        end;

        local v25 = Api.createNote({
            StrumTime,
            0,
            0,
            "event line"
        }, {
            mustHitSection = Api.Side == "R"
        });
        local v26 = { p24 };
        v25.eventData = v26;
        v25.ignoreNote = true;
        v25.hitCausesMiss = false;
        v25.shouldBeHitted = false;
        v25.hitbox = 0;
        v25.hitHealth = 0;
        v25.missHealth = 0;
        v25.shareAlpha = false;
        v25.alpha = 0.001;
        v25.multSpeed = p24.Name:lower() == "debug highlight" and 0.25 or 0.5;
        u9[StrumTime] = v26;
    end,

    clearUp = function() -- Line: 297, Name: clearUp
        -- upvalues: Frame (ref), u1 (copy)
        if Frame then
            Frame:Destroy();
            Frame = nil;
        end;

        u1.Shutdown();
    end
};