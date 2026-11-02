-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");

local function ApplyOverview(p1, p2) -- Line: 5
    local OverviewUI = p1.OverviewUI;
    OverviewUI.Version:SetDescription(p2.Version);
    OverviewUI.Players:SetDescription(string.format("%d / %d", p2.Players, p2.MaxPlayers));
    OverviewUI.ErrorsCount:SetDescription(p2.ErrorsCount);

    return true;
end;

local function RefreshOverview(u3) -- Line: 15
    local OverviewUI = u3.OverviewUI;

    if not OverviewUI or OverviewUI.Requesting then
        return;
    end;

    OverviewUI.Requesting = true;
    OverviewUI.Refresh.Text = "Refreshing...";
    OverviewUI.Refresh.AutoButtonColor = false;
    local success, result = pcall(function() -- Line: 24
        -- upvalues: u3 (copy)
        local v4 = u3:Request("GetOverview");
        local OverviewUI2 = u3.OverviewUI;
        OverviewUI2.Version:SetDescription(v4.Version);
        OverviewUI2.Players:SetDescription(string.format("%d / %d", v4.Players, v4.MaxPlayers));
        OverviewUI2.ErrorsCount:SetDescription(v4.ErrorsCount);

        return true;
    end);
    OverviewUI.Requesting = false;

    if u3.OverviewUI ~= OverviewUI or (u3.Destroyed or not u3.UI) then
        return;
    end;

    if not success then
        warn(result);
    end;

    OverviewUI.Refresh.Text = "Refresh";
    OverviewUI.Refresh.AutoButtonColor = true;
end;

return {
    AppletId = "_HomePage",
    Level = 0,
    Dependencies = {},
    AppletClient = {
        LazyLoad = false,
        HasTab = true,
        Icon = "rbxassetid://130068439240504",
        AppletName = "Home",
        LayoutPriority = 50,
        OnSwitch = {
            SwitchedIn = function(p5, p6) -- Line: 53, Name: SwitchedIn
                -- upvalues: RefreshOverview (copy)
                RefreshOverview(p6);
            end,

            SwitchedOut = function(p7, p8) -- Line: 56, Name: SwitchedOut
            end
        },
        Updates = {
            Overview = function(p9, p10, p11) -- Line: 64, Name: Overview
                local OverviewUI = p10.OverviewUI;
                OverviewUI.Version:SetDescription(p11.Version);
                OverviewUI.Players:SetDescription(string.format("%d / %d", p11.Players, p11.MaxPlayers));
                OverviewUI.ErrorsCount:SetDescription(p11.ErrorsCount);
            end
        },

        AppletLoad = function(p12, u13) -- Line: 69, Name: AppletLoad
            -- upvalues: RefreshOverview (copy)
            local u14 = p12.GUITools.Matte.Page(u13.UI);
            local v15 = u14:Banner();
            v15.Instance.LayoutOrder = 1;
            v15:SetTitle("Codename:Red");
            v15:SetDescription("Server Overview");

            local function Field(p16, p17) -- Line: 76
                -- upvalues: u14 (copy)
                local v18 = u14:TextFrame();
                v18.Instance.LayoutOrder = p17;
                v18:SetTitle(p16);
                v18:SetDescription("Loading...");

                return v18;
            end;

            local v19 = {
                Requesting = false
            };
            local v20 = u14:TextFrame();
            v20.Instance.LayoutOrder = 2;
            v20:SetTitle("Codename:Red Version");
            v20:SetDescription("Loading...");
            v19.Version = v20;
            local v21 = u14:TextFrame();
            v21.Instance.LayoutOrder = 3;
            v21:SetTitle("Players");
            v21:SetDescription("Loading...");
            v19.Players = v21;
            local v22 = u14:TextFrame();
            v22.Instance.LayoutOrder = 4;
            v22:SetTitle("Amount of Errors");
            v22:SetDescription("Loading...");
            v19.ErrorsCount = v22;
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "RefreshOverview";
            TextButton.Size = UDim2.new(1, 0, 0, 34);
            TextButton.LayoutOrder = 6;
            TextButton.BackgroundColor3 = Color3.fromRGB(0, 65, 194);
            TextButton.TextColor3 = Color3.fromRGB(255, 255, 255);
            TextButton.FontFace = Font.fromName("Ubuntu");
            TextButton.TextSize = 14;
            TextButton.Text = "Refresh";
            TextButton.BorderSizePixel = 0;
            TextButton.Parent = u14.Instance;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0, 5);
            UICorner.Parent = TextButton;
            v19.Refresh = TextButton;
            u13.OverviewUI = v19;
            u13:Connect(TextButton.Activated, function() -- Line: 110
                -- upvalues: RefreshOverview (ref), u13 (copy)
                RefreshOverview(u13);
            end);
            task.defer(RefreshOverview, u13);
        end
    },
    AppletServer = {
        RequestsMetadata = {
            GetOverview = {
                RequiredLevel = 0
            }
        },
        Requests = {
            GetOverview = function(p23, p24, p25) -- Line: 123, Name: GetOverview
                -- upvalues: Players (copy)
                return {
                    Version = `{tostring(p23.NxEngine.CodenameRedVersion or "Unknown")} (BuildID {tostring(p23.NxEngine.BuildId or "Unknown")})`,
                    Players = #Players:GetPlayers(),
                    MaxPlayers = Players.MaxPlayers,
                    ErrorsCount = #p23.GetLogs("Errors")
                };
            end
        }
    }
};