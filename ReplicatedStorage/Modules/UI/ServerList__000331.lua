-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RequestServerList = ReplicatedStorage.Events.RequestServerList;
local JoinServer = ReplicatedStorage.Events.JoinServer;
require(ReplicatedStorage.Modules.Types);
local script_ServerChip = script.ServerChip;
local script_SelectedUIStroke = script.SelectedUIStroke;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 21
    -- upvalues: script_SelectedUIStroke (copy), u1 (copy), TweenService (copy), JoinServer (copy)
    local v3 = {
        pageIndex = 1,
        selectedServer = nil,
        refreshDebounce = false,
        ui = p2,
        selectionUIStroke = script_SelectedUIStroke:Clone(),
        servers = {},
        filteredServerIds = {}
    };
    local u4 = setmetatable(v3, u1);
    TweenService:Create(u4.ui.Background.RotatedBackground.Tile, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Position = UDim2.fromOffset(100, 0)
    }):Play();
    u4.ui.Main.Top.Controls.Refresh.MouseButton1Click:Connect(function() -- Line: 40
        -- upvalues: u4 (copy)
        if u4.refreshDebounce then
            return;
        end;

        u4.refreshDebounce = true;
        u4:refreshServers();
        u4.refreshDebounce = false;
    end);
    u4.ui.Main.Top.Controls.PageControl.Left.MouseButton1Click:Connect(function() -- Line: 52
        -- upvalues: u4 (copy)
        u4:offsetPage(-1);
    end);
    u4.ui.Main.Top.Controls.PageControl.Right.MouseButton1Click:Connect(function() -- Line: 56
        -- upvalues: u4 (copy)
        u4:offsetPage(1);
    end);
    u4.ui.Main.Top.Controls.PageControl.Page.FocusLost:Connect(function(p5) -- Line: 60
        -- upvalues: u4 (copy)
        if not p5 then
            return;
        end;

        local v6 = tonumber(u4.ui.Main.Top.Controls.PageControl.Page.Text);
        local v7;

        if v6 then
            local math_round_ret = math.round(v6);
            v7 = math.clamp(math_round_ret, 1, u4:getMaxPageIndex());
        else
            v7 = 1;
        end;

        u4:setPage(v7);
    end);
    u4.ui.Main.Top.Search:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 72
        -- upvalues: u4 (copy)
        u4:filterServers(u4.ui.Main.Top.Search.Text);
    end);
    u4.ui.Main.Servers.Join.MouseButton1Click:Connect(function() -- Line: 78
        -- upvalues: u4 (copy), JoinServer (ref)
        if not u4.selectedServer then
            return;
        end;

        JoinServer:FireServer(u4.selectedServer.id);
    end);
    u4.ui.Main.Servers.CopyId.MouseButton1Click:Connect(function() -- Line: 86
        -- upvalues: u4 (copy)
        if u4.selectedServer then
        end;
    end);

    return u4;
end;

function u1.setVisibility(p8: any, p9: boolean) -- Line: 98
    p8.ui.Visible = p9;
end;

function u1.hydrateServerListingUi(p10) -- Line: 104
    p10.ui.Main.Top.Controls.PageControl.Page.Text = p10.pageIndex;

    for i, v in p10.servers do
        local table_find_ret = table.find(p10.filteredServerIds, i);

        if table_find_ret then
            local v11 = math.ceil(table_find_ret / 25) == p10.pageIndex;
            v.chip.Visible = v11;
        else
            v.chip.Visible = false;
        end;
    end;
end;

function u1.addServer(u12: any, u13: string, p14: any) -- Line: 122
    -- upvalues: script_ServerChip (copy)
    local v15 = not u12.servers[u13];
    local v16 = `server with id "{u13}" is already added`;
    assert(v15, v16);
    local v17 = script_ServerChip:Clone();
    v17.Inner.TopInfo.ServerName.Text = p14.name;
    v17.Inner.TopInfo.ServerRegion.Text = p14.region;
    v17.Inner.TopInfo.PlayerCount.Text = `{p14.playerCount}/40 Players`;
    v17.Inner.BottomInfo.ServerId.Text = u13;
    v17.MouseButton1Click:Connect(function() -- Line: 133
        -- upvalues: u12 (copy), u13 (copy)
        u12:selectServer(u13);
    end);
    v17.Visible = false;
    v17.Parent = u12.ui.Main.Servers.Inner.ScrollingFrame;
    u12.servers[u13] = {
        name = p14.name,
        region = p14.region,
        playerCount = p14.playerCount,
        chip = v17
    };
end;

function u1.setServers(p18: any, p19: table) -- Line: 149
    p18:selectServer(nil);

    for i, v in p18.servers do
        v.chip:Destroy();
        p18.servers[i] = nil;
    end;

    for i, v in p19 do
        p18:addServer(i, v);
    end;

    p18.filteredServerIds = p18:getFilteredServerIds("");
    p18:setPage(1);
    p18:hydrateServerListingUi();
end;

function u1.refreshServers(p20) -- Line: 169
    -- upvalues: RequestServerList (copy)
    local v21, v22 = RequestServerList:InvokeServer();

    if v21 then
        p20:setServers(v22);

        return;
    end;

    warn("failed to update");
end;

function u1.selectServer(p23: any, p24: string?) -- Line: 189
    -- upvalues: TweenService (copy)
    if p23.selectedServer and p23.selectedServer.id == p24 then
        return;
    end;

    if not p24 then
        p23.selectedServer = nil;
        p23.selectionUIStroke.Parent = nil;
        TweenService:Create(p23.ui.Main.Servers.Join.DisabledOverlay, TweenInfo.new(0.25), {
            BackgroundTransparency = 0.25
        }):Play();
        TweenService:Create(p23.ui.Main.Servers.CopyId.DisabledOverlay, TweenInfo.new(0.25), {
            BackgroundTransparency = 0.25
        }):Play();

        return;
    end;

    local v25 = p23.servers[p24];
    local v26 = `unknown server id "{p24}"`;
    assert(v25, v26);
    p23.selectedServer = {
        id = p24,
        chip = v25.chip
    };
    p23.selectionUIStroke.Parent = v25.chip;
    TweenService:Create(p23.ui.Main.Servers.Join.DisabledOverlay, TweenInfo.new(0.25), {
        BackgroundTransparency = 1
    }):Play();
    TweenService:Create(p23.ui.Main.Servers.CopyId.DisabledOverlay, TweenInfo.new(0.25), {
        BackgroundTransparency = 1
    }):Play();
end;

function u1.getFilteredServerIds(p27: any, p28: string) -- Line: 217
    local v29 = {};

    for i, v in p27.servers do
        if v.name:find(p28) or i:find(p28) then
            table.insert(v29, i);
        end;
    end;

    return v29;
end;

function u1.filterServers(p30: any, p31: string) -- Line: 229
    p30.filteredServerIds = p30:getFilteredServerIds(p31);
    p30.pageIndex = math.clamp(p30.pageIndex, 1, p30:getMaxPageIndex());
    p30:hydrateServerListingUi();
end;

function u1.getMaxPageIndex(p32) -- Line: 237
    local math_ceil_ret = math.ceil(#p32.filteredServerIds / 25);

    return math_ceil_ret <= 0 and 1 or math_ceil_ret;
end;

function u1.setPage(p33: any, p34: number) -- Line: 243
    local MaxPageIndex = p33:getMaxPageIndex();
    p33.pageIndex = math.clamp(p34, 1, MaxPageIndex);
    p33:hydrateServerListingUi();
end;

function u1.offsetPage(p35: any, p36: number) -- Line: 251
    p35:setPage(p35.pageIndex + p36);
end;

return u1;