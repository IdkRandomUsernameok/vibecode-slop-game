-- Decompiled with Potassium's decompiler.

local u1 = game:FindService("ReplicatedStorage");
local RunService = game:GetService("RunService");

return function(p2, p3, p4, u5) -- Line: 4
    -- upvalues: RunService (copy), u1 (copy)
    local TopbarIcon = require(p3.UI.TopbarIcon);
    local u6 = RunService:IsStudio();
    local u7 = TopbarIcon.new():setOrder(p4.Order):align(p4.Position):setEnabled(true):setName("Server Info"):modifyTheme({
        { "IconLabel", "FontFace", Font.fromName("Montserrat", Enum.FontWeight.Bold, Enum.FontStyle.Normal) },
        { "IconLabel", "TextXAlignment", Enum.TextXAlignment.Right },
        { "IconLabel", "Position", UDim2.fromScale(1, 0) },
        { "IconLabel", "AnchorPoint", Vector2.new(1, 0) },
        { "IconLabel", "TextSize", 13 },
        { "IconLabel", "RichText", true }
    }):bindEvent("viewingStarted", function() -- Line: 23
        -- upvalues: u5 (copy)
        u5:Play("Topbar/Hover");
    end):oneClick(true):setLabel("Server Uptime: --\nServer Region: --"):lock();

    local function formatTime(p8) -- Line: 30
        return `{math.floor(p8 / 86400)}d {math.floor(p8 / 3600 % 24)}h {math.floor(p8 / 60 % 60)}m `;
    end;

    local function updateText() -- Line: 34
        -- upvalues: u1 (ref), u7 (copy), u6 (copy)
        local v9 = u1:GetAttribute("ServerUptime") or 0;
        local v10 = v9 < 60000 and "22FF00" or (v9 < 120000 and "FFF500" or "FF0000");

        if 180000 - v9 >= 18000 then
            u7:setLabel((`Uptime: <font color="#{v10}">{`{math.floor(v9 / 86400)}d {math.floor(v9 / 3600 % 24)}h {math.floor(v9 / 60 % 60)}m `}</font>\nRegion: {u6 and "Studio Playtest" or u1:GetAttribute("ServerRegion")}`));

            return;
        end;

        local math_floor_ret = math.floor(180000 - v9);
        local v11 = math_floor_ret >= 3600 and `{math.floor(math_floor_ret / 3600)}h` or `{math.floor(math_floor_ret / 60)}m`;
        u7:setLabel((`Uptime: <font color="#{v10}">{`{math.floor(v9 / 86400)}d {math.floor(v9 / 3600 % 24)}h {math.floor(v9 / 60 % 60)}m `}</font>\nServer will close in <font color="#{v10}">{v11}</font>`));
    end;

    u1:GetAttributeChangedSignal("ServerUptime"):Connect(updateText);
    u1:GetAttributeChangedSignal("ServerRegion"):Connect(updateText);
    updateText();

    return {
        setEnabled = function(p12, p13) -- Line: 52, Name: setEnabled
            -- upvalues: u7 (copy)
            u7:setEnabled(p13);
        end,

        deselect = function() -- Line: 55, Name: deselect
            -- upvalues: u7 (copy)
            u7:deselect();
        end,

        icon = u7
    };
end;