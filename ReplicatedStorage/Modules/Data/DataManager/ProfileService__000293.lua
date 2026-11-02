-- Decompiled with Potassium's decompiler.

local u1 = {
    AutoSaveProfiles = 30,
    RobloxWriteCooldown = 7,
    ForceLoadMaxSteps = 8,
    AssumeDeadSessionLock = 1800,
    IssueCountForCriticalState = 5,
    IssueLast = 120,
    CriticalStateLast = 120,
    MetaTagsUpdatedValues = {
        ProfileCreateTime = true,
        SessionLoadCount = true,
        ActiveSession = true,
        ForceLoadSession = true,
        LastUpdate = true
    }
};
local v2 = {};
local u3 = nil;

local function AcquireRunnerThreadAndCallEventHandler(p4, ...) -- Line: 232
    -- upvalues: u3 (ref)
    local v5 = u3;
    u3 = nil;
    p4(...);
    u3 = v5;
end;

local function RunEventHandlerInFreeThread(...) -- Line: 239
    -- upvalues: AcquireRunnerThreadAndCallEventHandler (copy)
    AcquireRunnerThreadAndCallEventHandler(...);

    while true do
        AcquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u6 = {};
u6.__index = u6;

function u6.Disconnect(p7) -- Line: 261
    -- upvalues: u3 (ref), RunEventHandlerInFreeThread (copy)
    if p7._is_connected == false then
        return;
    end;

    p7._is_connected = false;
    local _script_signal = p7._script_signal;
    _script_signal._listener_count = _script_signal._listener_count - 1;

    if p7._script_signal._head == p7 then
        p7._script_signal._head = p7._next;
    else
        local _head = p7._script_signal._head;

        while _head ~= nil and _head._next ~= p7 do
            _head = _head._next;
        end;

        if _head ~= nil then
            _head._next = p7._next;
        end;
    end;

    if p7._disconnect_listener ~= nil then
        if not u3 then
            u3 = coroutine.create(RunEventHandlerInFreeThread);
        end;

        task.spawn(u3, p7._disconnect_listener, p7._disconnect_param);
        p7._disconnect_listener = nil;
    end;
end;

local u8 = {};
u8.__index = u8;

function u8.Connect(p9, p10, p11, p12) -- Line: 302
    -- upvalues: u6 (copy)
    local v13 = {
        _is_connected = true,
        _listener = p10,
        _script_signal = p9,
        _disconnect_listener = p11,
        _disconnect_param = p12,
        _next = p9._head
    };
    setmetatable(v13, u6);
    p9._head = v13;
    p9._listener_count = p9._listener_count + 1;

    return v13;
end;

function u8.GetListenerCount(p14) -- Line: 322
    return p14._listener_count;
end;

function u8.Fire(p15, ...) -- Line: 326
    -- upvalues: u3 (ref), RunEventHandlerInFreeThread (copy)
    local _head = p15._head;

    while _head ~= nil do
        if _head._is_connected == true then
            if not u3 then
                u3 = coroutine.create(RunEventHandlerInFreeThread);
            end;

            task.spawn(u3, _head._listener, ...);
        end;

        _head = _head._next;
    end;
end;

function u8.FireUntil(p16, p17, ...) -- Line: 339
    local _head = p16._head;

    while _head ~= nil do
        if _head._is_connected == true then
            _head._listener(...);

            if p17() ~= true then
                return;
            end;
        end;

        _head = _head._next;
    end;
end;

function v2.NewScriptSignal() -- Line: 352
    -- upvalues: u8 (copy)
    return {
        _head = nil,
        _listener_count = 0,
        Connect = u8.Connect,
        GetListenerCount = u8.GetListenerCount,
        Fire = u8.Fire,
        FireUntil = u8.FireUntil
    };
end;

local u20 = {
    NewScriptSignal = v2.NewScriptSignal,

    ConnectToOnClose = function(p18, p19) -- Line: 367, Name: ConnectToOnClose
        if game:GetService("RunService"):IsStudio() == false or p19 == true then
            game:BindToClose(p18);
        end;
    end
};
local u21 = {
    ServiceLocked = false,
    CriticalState = false,
    ServiceIssueCount = 0,
    _critical_state_start = 0,
    _use_mock_data_store = false,
    IssueSignal = u20.NewScriptSignal(),
    CorruptionSignal = u20.NewScriptSignal(),
    CriticalStateSignal = u20.NewScriptSignal(),
    _active_profile_stores = {},
    _auto_save_list = {},
    _issue_queue = {},
    _mock_data_store = {},
    _user_mock_data_store = {}
};
local _active_profile_stores = u21._active_profile_stores;
local _auto_save_list = u21._auto_save_list;
local _issue_queue = u21._issue_queue;
local DataStoreService = game:GetService("DataStoreService");
local RunService = game:GetService("RunService");
local game_PlaceId = game.PlaceId;
local game_JobId = game.JobId;
local u22 = 1;
local os_clock_ret = os.clock();
local u23 = 0;
local u24 = 0;
local u25 = 0;
local u26 = 0;
local v27 = RunService:IsStudio();
local u28 = false;
local u29 = false;
local _mock_data_store = u21._mock_data_store;
local _user_mock_data_store = u21._user_mock_data_store;
local u30 = {};
local u31 = {};

local function DeepCopyTable(p32) -- Line: 491
    -- upvalues: DeepCopyTable (copy)
    local v33 = {};

    for i, v in pairs(p32) do
        if type(v) == "table" then
            v33[i] = DeepCopyTable(v);
        else
            v33[i] = v;
        end;
    end;

    return v33;
end;

local function ReconcileTable(p34, p35) -- Line: 503
    -- upvalues: DeepCopyTable (copy), ReconcileTable (copy)
    for i, v in pairs(p35) do
        if type(i) == "string" then
            if p34[i] == nil then
                if type(v) == "table" then
                    p34[i] = DeepCopyTable(v);
                else
                    p34[i] = v;
                end;
            elseif type(p34[i]) == "table" and type(v) == "table" then
                ReconcileTable(p34[i], v);
            end;
        end;
    end;
end;

local function IdentifyProfile(p36, p37, p38) -- Line: 521
    return string.format("[Store:\"%s\";%sKey:\"%s\"]", p36, p37 == nil and "" or (string.format("Scope:\"%s\";", p37) or ""), p38);
end;

local function CustomWriteQueueCleanup(p39, p40) -- Line: 530
    -- upvalues: u31 (copy)
    if u31[p39] ~= nil then
        u31[p39][p40] = nil;

        if next(u31[p39]) == nil then
            u31[p39] = nil;
        end;
    end;
end;

local function CustomWriteQueueMarkForCleanup(u41, u42) -- Line: 539
    -- upvalues: u31 (copy), RunService (copy), u1 (copy)
    if u31[u41] ~= nil then
        if u31[u41][u42] == nil then
            if next(u31[u41]) == nil then
                u31[u41] = nil;
            end;
        else
            local u43 = u31[u41][u42];
            local Queue = u43.Queue;

            if u43.CleanupJob == nil then
                u43.CleanupJob = RunService.Heartbeat:Connect(function() -- Line: 548
                    -- upvalues: u43 (copy), u1 (ref), Queue (copy), u41 (copy), u42 (copy), u31 (ref)
                    if os.clock() - u43.LastWrite > u1.RobloxWriteCooldown and #Queue == 0 then
                        u43.CleanupJob:Disconnect();
                        local v44 = u41;
                        local v45 = u42;

                        if u31[v44] ~= nil then
                            u31[v44][v45] = nil;

                            if next(u31[v44]) == nil then
                                u31[v44] = nil;
                            end;
                        end;
                    end;
                end);
            end;
        end;
    end;
end;

local function CustomWriteQueueAsync(p46, p47, p48) -- Line: 563
    -- upvalues: u31 (copy), u1 (copy)
    if u31[p47] == nil then
        u31[p47] = {};
    end;

    if u31[p47][p48] == nil then
        u31[p47][p48] = {
            LastWrite = 0,
            CleanupJob = nil,
            Queue = {}
        };
    end;

    local v49 = u31[p47][p48];
    local Queue = v49.Queue;

    if v49.CleanupJob ~= nil then
        v49.CleanupJob:Disconnect();
        v49.CleanupJob = nil;
    end;

    if os.clock() - v49.LastWrite > u1.RobloxWriteCooldown and #Queue == 0 then
        v49.LastWrite = os.clock();

        return p46();
    end;

    table.insert(Queue, p46);

    while os.clock() - v49.LastWrite <= u1.RobloxWriteCooldown or Queue[1] ~= p46 do
        task.wait();
    end;

    table.remove(Queue, 1);
    v49.LastWrite = os.clock();

    return p46();
end;

local function IsCustomWriteQueueEmptyFor(p50, p51) -- Line: 601
    -- upvalues: u31 (copy)
    local v52 = u31[p50];

    if v52 == nil then
        return true;
    end;

    local v53 = v52[p51];

    return v53 == nil and true or #v53.Queue == 0;
end;

local function WaitForLiveAccessCheck() -- Line: 610
    -- upvalues: u28 (ref)
    while u28 == true do
        task.wait();
    end;
end;

local function WaitForPendingProfileStore(p54) -- Line: 616
    while p54._is_pending == true do
        task.wait();
    end;
end;

local function RegisterIssue(p55, p56, p57, p58) -- Line: 622
    -- upvalues: _issue_queue (copy), u21 (copy)
    warn("[ProfileService] DataStore API error " .. string.format("[Store:\"%s\";%sKey:\"%s\"]", p56, p57 == nil and "" or (string.format("Scope:\"%s\";", p57) or ""), p58) .. " - \"" .. tostring(p55) .. "\"");
    table.insert(_issue_queue, os.clock());
    u21.IssueSignal:Fire(tostring(p55), p56, p58);
end;

local function RegisterCorruption(p59, p60, p61) -- Line: 628
    -- upvalues: u21 (copy)
    warn("[ProfileService] Resolved profile corruption " .. string.format("[Store:\"%s\";%sKey:\"%s\"]", p59, p60 == nil and "" or (string.format("Scope:\"%s\";", p60) or ""), p61));
    u21.CorruptionSignal:Fire(p59, p61);
end;

local function NewMockDataStoreKeyInfo(p62) -- Line: 633
    -- upvalues: DeepCopyTable (copy)
    local v63 = tostring(p62.VersionId or 0);
    local u64 = p62.MetaData or {};
    local u65 = p62.UserIds or {};

    return {
        CreatedTime = p62.CreatedTime,
        UpdatedTime = p62.UpdatedTime,
        Version = string.rep("0", 16) .. "." .. string.rep("0", 10 - string.len(v63)) .. v63 .. "." .. string.rep("0", 16) .. ".01",

        GetMetadata = function() -- Line: 646, Name: GetMetadata
            -- upvalues: DeepCopyTable (ref), u64 (copy)
            return DeepCopyTable(u64);
        end,

        GetUserIds = function() -- Line: 650, Name: GetUserIds
            -- upvalues: DeepCopyTable (ref), u65 (copy)
            return DeepCopyTable(u65);
        end
    };
end;

local function MockUpdateAsync(p66, p67, p68, p69, p70) -- Line: 657
    -- upvalues: NewMockDataStoreKeyInfo (copy), DeepCopyTable (copy)
    local v71 = p66[p67];

    if v71 == nil then
        v71 = {};
        p66[p67] = v71;
    end;

    local v72 = os.time() * 1000;
    local math_floor_ret = math.floor(v72);
    local v73 = v71[p68];
    local v74;

    if v73 == nil then
        v74 = true;

        if p70 ~= true then
            v73 = {
                Data = nil,
                VersionId = 0,
                CreatedTime = math_floor_ret,
                UpdatedTime = math_floor_ret,
                UserIds = {},
                MetaData = {}
            };
            v71[p68] = v73;
        end;
    else
        v74 = false;
    end;

    local v75;

    if v74 == false then
        v75 = NewMockDataStoreKeyInfo(v73) or nil;
    else
        v75 = nil;
    end;

    local v76;

    if v73 then
        v76 = v73.Data;
    else
        v76 = v73;
    end;

    local v77, v78, v79 = p69(v76, v75);

    if v77 == nil then
        return nil;
    end;

    if v73 ~= nil and p70 ~= true then
        v73.Data = v77;
        v73.UserIds = DeepCopyTable(v78 or {});
        v73.MetaData = DeepCopyTable(v79 or {});
        v73.VersionId = v73.VersionId + 1;
        v73.UpdatedTime = math_floor_ret;
    end;

    local v80 = DeepCopyTable(v77);
    local v81;

    if v73 == nil then
        v81 = nil;
    else
        v81 = NewMockDataStoreKeyInfo(v73) or nil;
    end;

    return v80, v81;
end;

local function IsThisSession(p82) -- Line: 705
    -- upvalues: game_PlaceId (copy), game_JobId (copy)
    local v83;

    if p82[1] == game_PlaceId then
        v83 = p82[2] == game_JobId;
    else
        v83 = false;
    end;

    return v83;
end;

local function StandardProfileUpdateAsyncDataStore(u84, u85, u86, u87, u88, u89) -- Line: 716
    -- upvalues: MockUpdateAsync (copy), _user_mock_data_store (copy), u29 (ref), _mock_data_store (copy), CustomWriteQueueAsync (copy), u21 (copy), RegisterIssue (copy)
    local u90 = nil;
    local u91 = nil;
    local success, result = pcall(function() -- Line: 718
        -- upvalues: u86 (copy), u87 (copy), u90 (ref), u91 (ref), MockUpdateAsync (ref), _user_mock_data_store (ref), u84 (copy), u85 (copy), u88 (copy), u29 (ref), _mock_data_store (ref), CustomWriteQueueAsync (ref), u89 (copy)
        local function u96(p92) -- Line: 719
            -- upvalues: u86 (ref)
            local v93 = false;
            local v94 = false;
            local v95 = { 0, {} };

            if p92 == nil then
                v93 = true;
            elseif type(p92) ~= "table" then
                v93 = true;
                v94 = true;
            end;

            if type(p92) == "table" then
                if type(p92.Data) == "table" and (type(p92.MetaData) == "table" and type(p92.GlobalUpdates) == "table") then
                    p92.WasCorrupted = false;
                    v95 = p92.GlobalUpdates;

                    if u86.ExistingProfileHandle ~= nil then
                        u86.ExistingProfileHandle(p92);
                    end;
                elseif p92.Data == nil and (p92.MetaData == nil and type(p92.GlobalUpdates) == "table") then
                    p92.WasCorrupted = false;
                    v95 = p92.GlobalUpdates or v95;
                    v93 = true;
                else
                    v93 = true;
                    v94 = true;
                end;
            end;

            if v93 == true then
                p92 = {
                    GlobalUpdates = v95
                };

                if u86.MissingProfileHandle ~= nil then
                    u86.MissingProfileHandle(p92);
                end;
            end;

            if u86.EditProfile ~= nil then
                u86.EditProfile(p92);
            end;

            if v94 == true then
                p92.WasCorrupted = true;
            end;

            return p92, p92.UserIds, p92.RobloxMetaData;
        end;

        if u87 == true then
            local v97, v98 = MockUpdateAsync(_user_mock_data_store, u84._profile_store_lookup, u85, u96, u88);
            u90 = v97;
            u91 = v98;
            task.wait();

            return;
        end;

        if u29 ~= true then
            local v102, v103 = CustomWriteQueueAsync(function() -- Line: 789
                -- upvalues: u88 (ref), u89 (ref), u84 (ref), u85 (ref), u96 (copy)
                if u88 ~= true then
                    return u84._global_data_store:UpdateAsync(u85, u96);
                end;

                local u99 = nil;
                local u100 = nil;

                if u89 == nil then
                    u99, u100 = u84._global_data_store:GetAsync(u85);
                else
                    local success, result = pcall(function() -- Line: 793
                        -- upvalues: u99 (ref), u100 (ref), u84 (ref), u85 (ref), u89 (ref)
                        local VersionAsync, v101 = u84._global_data_store:GetVersionAsync(u85, u89);
                        u99 = VersionAsync;
                        u100 = v101;
                    end);

                    if success == false and (type(result) == "string" and string.find(result, "not valid") ~= nil) then
                        warn("[ProfileService] Passed version argument is not valid; Traceback:\n" .. debug.traceback());
                    end;
                end;

                return u96(u99), u100;
            end, u84._profile_store_lookup, u85);
            u90 = v102;
            u91 = v103;

            return;
        end;

        local v104, v105 = MockUpdateAsync(_mock_data_store, u84._profile_store_lookup, u85, u96, u88);
        u90 = v104;
        u91 = v105;
        task.wait();
    end);

    if success == true and type(u90) == "table" then
        if u90.WasCorrupted == true and u88 ~= true then
            local _profile_store_name = u84._profile_store_name;
            local _profile_store_scope = u84._profile_store_scope;
            warn("[ProfileService] Resolved profile corruption " .. string.format("[Store:\"%s\";%sKey:\"%s\"]", _profile_store_name, _profile_store_scope == nil and "" or (string.format("Scope:\"%s\";", _profile_store_scope) or ""), u85));
            u21.CorruptionSignal:Fire(_profile_store_name, u85);
        end;

        return u90, u91;
    end;

    RegisterIssue((result == nil or not result) and "Undefined error" or result, u84._profile_store_name, u84._profile_store_scope, u85);

    return nil;
end;

local function RemoveProfileFromAutoSave(p106) -- Line: 836
    -- upvalues: _auto_save_list (copy), u22 (ref)
    local table_find_ret = table.find(_auto_save_list, p106);

    if table_find_ret ~= nil then
        table.remove(_auto_save_list, table_find_ret);

        if table_find_ret < u22 then
            u22 = u22 - 1;
        end;

        if _auto_save_list[u22] == nil then
            u22 = 1;
        end;
    end;
end;

local function AddProfileToAutoSave(p107) -- Line: 849
    -- upvalues: _auto_save_list (copy), u22 (ref), os_clock_ret (ref)
    table.insert(_auto_save_list, u22, p107);

    if #_auto_save_list > 1 then
        u22 = u22 + 1;

        return;
    end;

    if #_auto_save_list == 1 then
        os_clock_ret = os.clock();
    end;
end;

local function ReleaseProfileInternally(p108) -- Line: 860
    -- upvalues: _active_profile_stores (copy), _auto_save_list (copy), u22 (ref)
    local _profile_store = p108._profile_store;
    (p108._is_user_mock == true and _profile_store._mock_loaded_profiles or _profile_store._loaded_profiles)[p108._profile_key] = nil;

    if next(_profile_store._loaded_profiles) == nil and next(_profile_store._mock_loaded_profiles) == nil then
        local table_find_ret = table.find(_active_profile_stores, _profile_store);

        if table_find_ret ~= nil then
            table.remove(_active_profile_stores, table_find_ret);
        end;
    end;

    local table_find_ret = table.find(_auto_save_list, p108);

    if table_find_ret ~= nil then
        table.remove(_auto_save_list, table_find_ret);

        if table_find_ret < u22 then
            u22 = u22 - 1;
        end;

        if _auto_save_list[u22] == nil then
            u22 = 1;
        end;
    end;

    local ActiveSession = p108.MetaData.ActiveSession;
    local v109, v110;

    if ActiveSession == nil then
        v109 = nil;
        v110 = nil;
    else
        v109 = ActiveSession[1];
        v110 = ActiveSession[2];
    end;

    p108._release_listeners:Fire(v109, v110);
end;

local function CheckForNewGlobalUpdates(p111, p112, p113) -- Line: 885
    local GlobalUpdates = p111.GlobalUpdates;
    local _pending_update_lock = GlobalUpdates._pending_update_lock;
    local _pending_update_clear = GlobalUpdates._pending_update_clear;

    for _, v in ipairs(p113[2]) do
        local u114 = v;
        local v115 = nil;

        for _, v3 in ipairs(p112[2]) do
            if v3[1] == u114[1] then
                v115 = v3;
                break;
            end;
        end;

        if (v115 == nil or (u114[2] > v115[2] or u114[3] ~= v115[3])) == true then
            if u114[3] == false then
                local v116 = false;

                for _, v3 in ipairs(_pending_update_lock) do
                    if u114[1] == v3 then
                        v116 = true;
                        break;
                    end;
                end;

                if v116 == false then
                    GlobalUpdates._new_active_update_listeners:Fire(u114[1], u114[4]);
                end;
            end;

            if u114[3] == true then
                local v117 = false;

                for _, v3 in ipairs(_pending_update_clear) do
                    if u114[1] == v3 then
                        v117 = true;
                        break;
                    end;
                end;

                if v117 == false then
                    GlobalUpdates._new_locked_update_listeners:FireUntil(function() -- Line: 934
                        -- upvalues: _pending_update_clear (copy), u114 (copy)
                        return table.find(_pending_update_clear, u114[1]) == nil;
                    end, u114[1], u114[4]);
                end;
            end;
        end;
    end;
end;

local function SaveProfileAsync(u118, u119, u120) -- Line: 950
    -- upvalues: u21 (copy), ReleaseProfileInternally (copy), u25 (ref), StandardProfileUpdateAsyncDataStore (copy), game_PlaceId (copy), game_JobId (copy), u1 (copy), CheckForNewGlobalUpdates (copy), CustomWriteQueueMarkForCleanup (copy)
    if type(u118.Data) ~= "table" then
        local _profile_store_name = u118._profile_store._profile_store_name;
        local _profile_store_scope = u118._profile_store._profile_store_scope;
        local _profile_key = u118._profile_key;
        warn("[ProfileService] Resolved profile corruption " .. string.format("[Store:\"%s\";%sKey:\"%s\"]", _profile_store_name, _profile_store_scope == nil and "" or (string.format("Scope:\"%s\";", _profile_store_scope) or ""), _profile_key));
        u21.CorruptionSignal:Fire(_profile_store_name, _profile_key);
        error("[ProfileService] PROFILE DATA CORRUPTED DURING RUNTIME! Profile: " .. u118:Identify());
    end;

    if u119 == true and u120 ~= true then
        ReleaseProfileInternally(u118);
    end;

    u25 = u25 + 1;
    local SessionLoadCount = u118.MetaData.SessionLoadCount;
    local v121 = true;

    while v121 == true do
        if u119 ~= true then
            v121 = false;
        end;

        local v129, v130 = StandardProfileUpdateAsyncDataStore(u118._profile_store, u118._profile_key, {
            ExistingProfileHandle = nil,
            MissingProfileHandle = nil,

            EditProfile = function(p122) -- Line: 976, Name: EditProfile
                -- upvalues: u120 (copy), game_PlaceId (ref), game_JobId (ref), SessionLoadCount (copy), u118 (copy), u119 (copy)
                local v123 = false;
                local v124 = false;

                if u120 == true then
                    v123 = true;
                else
                    local ActiveSession = p122.MetaData.ActiveSession;
                    local ForceLoadSession = p122.MetaData.ForceLoadSession;
                    local SessionLoadCount2 = p122.MetaData.SessionLoadCount;

                    if type(ActiveSession) == "table" then
                        if ActiveSession[1] == game_PlaceId then
                            v123 = ActiveSession[2] == game_JobId;
                        else
                            v123 = false;
                        end;

                        if v123 then
                            v123 = SessionLoadCount2 == SessionLoadCount;
                        end;
                    end;

                    if type(ForceLoadSession) == "table" then
                        local v125;

                        if ForceLoadSession[1] == game_PlaceId then
                            v125 = ForceLoadSession[2] == game_JobId;
                        else
                            v125 = false;
                        end;

                        v124 = not v125;
                    end;
                end;

                if v123 == true then
                    if u120 ~= true then
                        local v126 = p122.GlobalUpdates[2];
                        local GlobalUpdates = u118.GlobalUpdates;
                        local _pending_update_lock = GlobalUpdates._pending_update_lock;
                        local _pending_update_clear = GlobalUpdates._pending_update_clear;

                        for i = 1, #v126 do
                            local v127 = i;

                            for _, v in ipairs(_pending_update_lock) do
                                if v126[v127][1] == v then
                                    v126[v127][3] = true;
                                    break;
                                end;
                            end;
                        end;

                        for _, v in ipairs(_pending_update_clear) do
                            local v128 = v;

                            for i = 1, #v126 do
                                if v126[i][1] == v128 and v126[i][3] == true then
                                    table.remove(v126, i);
                                    break;
                                end;

                                local _ = i;
                            end;
                        end;
                    end;

                    p122.Data = u118.Data;
                    p122.RobloxMetaData = u118.RobloxMetaData;
                    p122.UserIds = u118.UserIds;

                    if u120 == true then
                        p122.MetaData = u118.MetaData;
                        p122.MetaData.ActiveSession = nil;
                        p122.MetaData.ForceLoadSession = nil;
                        p122.GlobalUpdates = u118.GlobalUpdates._updates_latest;
                    else
                        p122.MetaData.MetaTags = u118.MetaData.MetaTags;
                        p122.MetaData.LastUpdate = os.time();

                        if u119 == true or v124 == true then
                            p122.MetaData.ActiveSession = nil;
                        end;
                    end;
                end;
            end
        }, u118._is_user_mock);

        if v129 == nil or v130 == nil then
            if v121 == true then
                task.wait();
            end;
        else
            if u120 == true then
                break;
            end;

            u118.KeyInfo = v130;
            local GlobalUpdates = u118.GlobalUpdates;
            local _updates_latest = GlobalUpdates._updates_latest;
            local GlobalUpdates2 = v129.GlobalUpdates;
            GlobalUpdates._updates_latest = GlobalUpdates2;
            local MetaData = u118.MetaData;
            local MetaData2 = v129.MetaData;
            v121 = false;

            for i in pairs(u1.MetaTagsUpdatedValues) do
                MetaData[i] = MetaData2[i];
            end;

            MetaData.MetaTagsLatest = MetaData2.MetaTags;
            local ActiveSession = v129.MetaData.ActiveSession;
            local SessionLoadCount2 = v129.MetaData.SessionLoadCount;
            local v131;

            if type(ActiveSession) == "table" then
                if ActiveSession[1] == game_PlaceId then
                    v131 = ActiveSession[2] == game_JobId;
                else
                    v131 = false;
                end;

                if v131 then
                    v131 = SessionLoadCount2 == SessionLoadCount;
                end;
            else
                v131 = false;
            end;

            local v132 = u118:IsActive();

            if v131 == true then
                if v132 == true then
                    CheckForNewGlobalUpdates(u118, _updates_latest, GlobalUpdates2);
                end;
            else
                if v132 == true then
                    ReleaseProfileInternally(u118);
                end;

                CustomWriteQueueMarkForCleanup(u118._profile_store._profile_store_lookup, u118._profile_key);

                if u118._hop_ready == false then
                    u118._hop_ready = true;
                    u118._hop_ready_listeners:Fire();
                end;
            end;

            u118.MetaTagsUpdated:Fire(u118.MetaData.MetaTagsLatest);
            u118.KeyInfoUpdated:Fire(v130);
        end;
    end;

    u25 = u25 - 1;
end;

local u133 = {};
u133.__index = u133;

function u133.GetActiveUpdates(p134) -- Line: 1129
    local v135 = {};

    for _, v in ipairs(p134._updates_latest[2]) do
        if v[3] == false then
            local v136 = false;
            local v137;

            if p134._pending_update_lock == nil then
                v137 = v;
            else
                v137 = v;

                for _, v3 in ipairs(p134._pending_update_lock) do
                    if v137[1] == v3 then
                        v136 = true;
                        break;
                    end;
                end;
            end;

            if v136 == false then
                table.insert(v135, { v137[1], v137[4] });
            end;
        end;
    end;

    return v135;
end;

function u133.GetLockedUpdates(p138) -- Line: 1150
    local v139 = {};

    for _, v in ipairs(p138._updates_latest[2]) do
        if v[3] == true then
            local v140 = false;
            local v141;

            if p138._pending_update_clear == nil then
                v141 = v;
            else
                v141 = v;

                for _, v3 in ipairs(p138._pending_update_clear) do
                    if v141[1] == v3 then
                        v140 = true;
                        break;
                    end;
                end;
            end;

            if v140 == false then
                table.insert(v139, { v141[1], v141[4] });
            end;
        end;
    end;

    return v139;
end;

function u133.ListenToNewActiveUpdate(p142, p143) -- Line: 1172
    if type(p143) ~= "function" then
        error("[ProfileService] Only a function can be set as listener in GlobalUpdates:ListenToNewActiveUpdate()");
    end;

    local _profile = p142._profile;

    if p142._update_handler_mode == true then
        error("[ProfileService] Can\'t listen to new global updates in ProfileStore:GlobalUpdateProfileAsync()");
    elseif p142._new_active_update_listeners == nil then
        error("[ProfileService] Can\'t listen to new global updates in view mode");
    elseif _profile:IsActive() == false then
        return {
            Disconnect = function() -- Line: 1183, Name: Disconnect
            end
        };
    end;

    return p142._new_active_update_listeners:Connect(p143);
end;

function u133.ListenToNewLockedUpdate(p144, p145) -- Line: 1190
    if type(p145) ~= "function" then
        error("[ProfileService] Only a function can be set as listener in GlobalUpdates:ListenToNewLockedUpdate()");
    end;

    local _profile = p144._profile;

    if p144._update_handler_mode == true then
        error("[ProfileService] Can\'t listen to new global updates in ProfileStore:GlobalUpdateProfileAsync()");
    elseif p144._new_locked_update_listeners == nil then
        error("[ProfileService] Can\'t listen to new global updates in view mode");
    elseif _profile:IsActive() == false then
        return {
            Disconnect = function() -- Line: 1201, Name: Disconnect
            end
        };
    end;

    return p144._new_locked_update_listeners:Connect(p145);
end;

function u133.LockActiveUpdate(p146, p147) -- Line: 1208
    if type(p147) ~= "number" then
        error("[ProfileService] Invalid update_id");
    end;

    local _profile = p146._profile;

    if p146._update_handler_mode == true then
        error("[ProfileService] Can\'t lock active global updates in ProfileStore:GlobalUpdateProfileAsync()");
    elseif p146._pending_update_lock == nil then
        error("[ProfileService] Can\'t lock active global updates in view mode");
    elseif _profile:IsActive() == false then
        error("[ProfileService] PROFILE EXPIRED - Can\'t lock active global updates");
    end;

    local v148 = nil;

    for _, v in ipairs(p146._updates_latest[2]) do
        if v[1] == p147 then
            v148 = v;
            break;
        end;
    end;

    if v148 == nil then
        error("[ProfileService] Passed non-existant update_id");
    else
        local v149 = false;

        for _, v in ipairs(p146._pending_update_lock) do
            if p147 == v then
                v149 = true;
                break;
            end;
        end;

        if v149 == false and v148[3] == false then
            table.insert(p146._pending_update_lock, p147);
        end;
    end;
end;

function u133.ClearLockedUpdate(p150, p151) -- Line: 1244
    if type(p151) ~= "number" then
        error("[ProfileService] Invalid update_id");
    end;

    local _profile = p150._profile;

    if p150._update_handler_mode == true then
        error("[ProfileService] Can\'t clear locked global updates in ProfileStore:GlobalUpdateProfileAsync()");
    elseif p150._pending_update_clear == nil then
        error("[ProfileService] Can\'t clear locked global updates in view mode");
    elseif _profile:IsActive() == false then
        error("[ProfileService] PROFILE EXPIRED - Can\'t clear locked global updates");
    end;

    local v152 = nil;

    for _, v in ipairs(p150._updates_latest[2]) do
        if v[1] == p151 then
            v152 = v;
            break;
        end;
    end;

    if v152 == nil then
        error("[ProfileService] Passed non-existant update_id");
    else
        local v153 = false;

        for _, v in ipairs(p150._pending_update_clear) do
            if p151 == v then
                v153 = true;
                break;
            end;
        end;

        if v153 == false and v152[3] == true then
            table.insert(p150._pending_update_clear, p151);
        end;
    end;
end;

function u133.AddActiveUpdate(p154, p155) -- Line: 1281
    if type(p155) ~= "table" then
        error("[ProfileService] Invalid update_data");
    end;

    if p154._new_active_update_listeners == nil then
        if p154._update_handler_mode ~= true then
            error("[ProfileService] Can\'t add active global updates in view mode; Use ProfileStore:GlobalUpdateProfileAsync()");
        end;
    else
        error("[ProfileService] Can\'t add active global updates in loaded Profile; Use ProfileStore:GlobalUpdateProfileAsync()");
    end;

    local _updates_latest = p154._updates_latest;
    local v156 = _updates_latest[1] + 1;
    _updates_latest[1] = v156;
    table.insert(_updates_latest[2], {
        v156,
        1,
        false,
        p155
    });
end;

function u133.ChangeActiveUpdate(p157, p158, p159) -- Line: 1298
    if type(p158) ~= "number" then
        error("[ProfileService] Invalid update_id");
    end;

    if type(p159) ~= "table" then
        error("[ProfileService] Invalid update_data");
    end;

    if p157._new_active_update_listeners == nil then
        if p157._update_handler_mode ~= true then
            error("[ProfileService] Can\'t change active global updates in view mode; Use ProfileStore:GlobalUpdateProfileAsync()");
        end;
    else
        error("[ProfileService] Can\'t change active global updates in loaded Profile; Use ProfileStore:GlobalUpdateProfileAsync()");
    end;

    local v160 = nil;

    for _, v in ipairs(p157._updates_latest[2]) do
        if p158 == v[1] then
            v160 = v;
            break;
        end;
    end;

    if v160 == nil then
        error("[ProfileService] Passed non-existant update_id");

        return;
    end;

    if v160[3] == true then
        error("[ProfileService] Can\'t change locked global update");
    end;

    v160[2] = v160[2] + 1;
    v160[4] = p159;
end;

function u133.ClearActiveUpdate(p161, p162) -- Line: 1330
    if type(p162) ~= "number" then
        error("[ProfileService] Invalid update_id argument");
    end;

    if p161._new_active_update_listeners == nil then
        if p161._update_handler_mode ~= true then
            error("[ProfileService] Can\'t clear active global updates in view mode; Use ProfileStore:GlobalUpdateProfileAsync()");
        end;
    else
        error("[ProfileService] Can\'t clear active global updates in loaded Profile; Use ProfileStore:GlobalUpdateProfileAsync()");
    end;

    local _updates_latest = p161._updates_latest;
    local v163 = nil;
    local v164 = nil;

    for i, v in ipairs(_updates_latest[2]) do
        if p162 == v[1] then
            v164 = i;
            v163 = v;
            break;
        end;
    end;

    if v163 == nil then
        error("[ProfileService] Passed non-existant update_id");

        return;
    end;

    if v163[3] == true then
        error("[ProfileService] Can\'t clear locked global update");
    end;

    table.remove(_updates_latest[2], v164);
end;

local u165 = {};
u165.__index = u165;

function u165.IsActive(p166) -- Line: 1385
    return (p166._is_user_mock == true and p166._profile_store._mock_loaded_profiles or p166._profile_store._loaded_profiles)[p166._profile_key] == p166;
end;

function u165.GetMetaTag(p167, p168) -- Line: 1390
    if p167.MetaData == nil then
        return nil;
    end;

    return p167.MetaData.MetaTags[p168];
end;

function u165.SetMetaTag(p169, p170, p171) -- Line: 1399
    if type(p170) == "string" then
        if string.len(p170) == 0 then
            error("[ProfileService] Invalid tag_name");
        end;
    else
        error("[ProfileService] tag_name must be a string");
    end;

    p169.MetaData.MetaTags[p170] = p171;
end;

function u165.Reconcile(p172) -- Line: 1408
    -- upvalues: ReconcileTable (copy)
    ReconcileTable(p172.Data, p172._profile_store._profile_template);
end;

function u165.ListenToRelease(p173, p174) -- Line: 1412
    if type(p174) ~= "function" then
        error("[ProfileService] Only a function can be set as listener in Profile:ListenToRelease()");
    end;

    if p173._view_mode == true then
        return {
            Disconnect = function() -- Line: 1417, Name: Disconnect
            end
        };
    end;

    if p173:IsActive() ~= false then
        return p173._release_listeners:Connect(p174);
    end;

    local ActiveSession = p173.MetaData.ActiveSession;
    local v175, v176;

    if ActiveSession == nil then
        v175 = nil;
        v176 = nil;
    else
        v175 = ActiveSession[1];
        v176 = ActiveSession[2];
    end;

    p174(v175, v176);

    return {
        Disconnect = function() -- Line: 1429, Name: Disconnect
        end
    };
end;

function u165.Save(p177) -- Line: 1435
    -- upvalues: u31 (copy), _auto_save_list (copy), u22 (ref), os_clock_ret (ref), SaveProfileAsync (copy)
    if p177._view_mode == true then
        error("[ProfileService] Can\'t save Profile in view mode - Should you be calling :OverwriteAsync() instead?");
    end;

    if p177:IsActive() == false then
        warn("[ProfileService] Attempted saving an inactive profile " .. p177:Identify() .. "; Traceback:\n" .. debug.traceback());

        return;
    end;

    local _profile_key = p177._profile_key;
    local v178 = u31[p177._profile_store._profile_store_lookup];
    local v179;

    if v178 == nil then
        v179 = true;
    else
        local v180 = v178[_profile_key];
        v179 = v180 == nil and true or #v180.Queue == 0;
    end;

    if v179 == true then
        local table_find_ret = table.find(_auto_save_list, p177);

        if table_find_ret ~= nil then
            table.remove(_auto_save_list, table_find_ret);

            if table_find_ret < u22 then
                u22 = u22 - 1;
            end;

            if _auto_save_list[u22] == nil then
                u22 = 1;
            end;
        end;

        table.insert(_auto_save_list, u22, p177);

        if #_auto_save_list > 1 then
            u22 = u22 + 1;
        elseif #_auto_save_list == 1 then
            os_clock_ret = os.clock();
        end;

        task.spawn(SaveProfileAsync, p177);
    end;
end;

function u165.Release(p181) -- Line: 1455
    -- upvalues: SaveProfileAsync (copy)
    if p181._view_mode == true then
        return;
    end;

    if p181:IsActive() == true then
        task.spawn(SaveProfileAsync, p181, true);
    end;
end;

function u165.ListenToHopReady(p182, p183) -- Line: 1464
    if type(p183) ~= "function" then
        error("[ProfileService] Only a function can be set as listener in Profile:ListenToHopReady()");
    end;

    if p182._view_mode == true then
        return {
            Disconnect = function() -- Line: 1469, Name: Disconnect
            end
        };
    end;

    if p182._hop_ready ~= true then
        return p182._hop_ready_listeners:Connect(p183);
    end;

    task.spawn(p183);

    return {
        Disconnect = function() -- Line: 1473, Name: Disconnect
        end
    };
end;

function u165.AddUserId(p184, p185) -- Line: 1479
    -- upvalues: u29 (ref)
    if type(p185) ~= "number" or p185 % 1 ~= 0 then
        warn("[ProfileService] Invalid UserId argument for :AddUserId() (" .. tostring(p185) .. "); Traceback:\n" .. debug.traceback());

        return;
    end;

    if p185 < 0 and (p184._is_user_mock ~= true and u29 ~= true) then
        return;
    end;

    if table.find(p184.UserIds, p185) == nil then
        table.insert(p184.UserIds, p185);
    end;
end;

function u165.RemoveUserId(p186, p187) -- Line: 1497
    if type(p187) ~= "number" or p187 % 1 ~= 0 then
        warn("[ProfileService] Invalid UserId argument for :RemoveUserId() (" .. tostring(p187) .. "); Traceback:\n" .. debug.traceback());

        return;
    end;

    local table_find_ret = table.find(p186.UserIds, p187);

    if table_find_ret ~= nil then
        table.remove(p186.UserIds, table_find_ret);
    end;
end;

function u165.Identify(p188) -- Line: 1513
    -- upvalues: IdentifyProfile (copy)
    return IdentifyProfile(p188._profile_store._profile_store_name, p188._profile_store._profile_store_scope, p188._profile_key);
end;

function u165.ClearGlobalUpdates(p189) -- Line: 1521
    -- upvalues: u133 (copy)
    if p189._view_mode ~= true then
        error("[ProfileService] :ClearGlobalUpdates() can only be used in view mode");
    end;

    local v190 = {
        _updates_latest = { 0, {} },
        _profile = p189
    };
    setmetatable(v190, u133);
    p189.GlobalUpdates = v190;
end;

function u165.OverwriteAsync(p191) -- Line: 1537
    -- upvalues: SaveProfileAsync (copy)
    if p191._view_mode ~= true then
        error("[ProfileService] :OverwriteAsync() can only be used in view mode");
    end;

    SaveProfileAsync(p191, nil, true);
end;

local u192 = {};
u192.__index = u192;

function u192._MoveQueue(p193) -- Line: 1567
    while #p193._query_queue > 0 do
        local table_remove_ret = table.remove(p193._query_queue, 1);
        task.spawn(table_remove_ret);

        if p193._is_query_yielded == true then
            break;
        end;
    end;
end;

function u192.NextAsync(u194, p195) -- Line: 1577
    if u194._profile_store == nil then
        return nil;
    end;

    local u196 = nil;
    local u197 = false;

    local function query_job() -- Line: 1586
        -- upvalues: u194 (copy), u197 (ref), u196 (ref)
        if u194._query_failure == true then
            u197 = true;

            return;
        end;

        if u194._query_pages == nil then
            u194._is_query_yielded = true;
            task.spawn(function() -- Line: 1598
                -- upvalues: u196 (ref), u194 (ref), u197 (ref)
                u196 = u194:NextAsync(true);
                u197 = true;
            end);
            local success, result = pcall(function() -- Line: 1603
                -- upvalues: u194 (ref)
                u194._query_pages = u194._profile_store._global_data_store:ListVersionsAsync(u194._profile_key, u194._sort_direction, u194._min_date, u194._max_date);
                u194._query_index = 0;
            end);

            if success == false or u194._query_pages == nil then
                warn("[ProfileService] Version query fail - " .. tostring(result));
                u194._query_failure = true;
            end;

            u194._is_query_yielded = false;
            u194:_MoveQueue();

            return;
        end;

        local v198 = u194._query_pages:GetCurrentPage()[u194._query_index + 1];

        if u194._query_pages.IsFinished == true and v198 == nil then
            u197 = true;

            return;
        end;

        if v198 ~= nil then
            local v199 = u194;
            v199._query_index = v199._query_index + 1;
            u196 = u194._profile_store:ViewProfileAsync(u194._profile_key, v198.Version);
            u197 = true;

            return;
        end;

        u194._is_query_yielded = true;
        task.spawn(function() -- Line: 1640
            -- upvalues: u196 (ref), u194 (ref), u197 (ref)
            u196 = u194:NextAsync(true);
            u197 = true;
        end);

        if pcall(function() -- Line: 1645
            -- upvalues: u194 (ref)
            u194._query_pages:AdvanceToNextPageAsync();
            u194._query_index = 0;
        end) == false or #u194._query_pages:GetCurrentPage() == 0 then
            u194._query_failure = true;
        end;

        u194._is_query_yielded = false;
        u194:_MoveQueue();
    end;

    if u194._is_query_yielded == false then
        query_job();
    elseif p195 == true then
        table.insert(u194._query_queue, 1, query_job);
    else
        table.insert(u194._query_queue, query_job);
    end;

    while u197 == false do
        task.wait();
    end;

    return u196;
end;

local u200 = {};
u200.__index = u200;

function u200.LoadProfileAsync(u201, p202, p203, p204) -- Line: 1709
    -- upvalues: u21 (copy), u30 (copy), _active_profile_stores (copy), u24 (ref), u23 (ref), StandardProfileUpdateAsyncDataStore (copy), game_PlaceId (copy), game_JobId (copy), u1 (copy), DeepCopyTable (copy), u20 (ref), u133 (copy), u165 (copy), _auto_save_list (copy), u22 (ref), os_clock_ret (ref), SaveProfileAsync (copy)
    local v205 = p203 or "ForceLoad";

    if u201._profile_template == nil then
        error("[ProfileService] Profile template not set - ProfileStore:LoadProfileAsync() locked for this ProfileStore");
    end;

    if type(p202) == "string" then
        if string.len(p202) == 0 then
            error("[ProfileService] Invalid profile_key");
        end;
    else
        error("[ProfileService] profile_key must be a string");
    end;

    if type(v205) ~= "function" and (v205 ~= "ForceLoad" and v205 ~= "Steal") then
        error("[ProfileService] Invalid not_released_handler");
    end;

    if u21.ServiceLocked == true then
        return nil;
    end;

    while u201._is_pending == true do
        task.wait();
    end;

    local v206 = p204 == u30;

    for _, v in ipairs(_active_profile_stores) do
        if v._profile_store_lookup == u201._profile_store_lookup and (v206 == true and v._mock_loaded_profiles or v._loaded_profiles)[p202] ~= nil then
            local _profile_store_scope = u201._profile_store_scope;
            error("[ProfileService] Profile " .. string.format("[Store:\"%s\";%sKey:\"%s\"]", u201._profile_store_name, _profile_store_scope == nil and "" or (string.format("Scope:\"%s\";", _profile_store_scope) or ""), p202) .. " is already loaded in this session");
        end;
    end;

    u24 = u24 + 1;
    local v207 = v205 == "ForceLoad";
    local v208 = 0;
    local u209 = v207;
    local u210 = false;
    local u211;

    if v205 == "Steal" then
        u211 = true;
    else
        u211 = false;
    end;

    while u21.ServiceLocked == false do
        local v212 = v206 == true and u201._mock_profile_load_jobs or u201._profile_load_jobs;
        local v213 = u23 + 1;
        u23 = v213;
        local v214 = v212[p202];
        local v215, v216;

        if v214 == nil then
            local v217 = { v213, nil };
            v212[p202] = v217;
            v217[2] = table.pack(StandardProfileUpdateAsyncDataStore(u201, p202, {
                ExistingProfileHandle = function(p218) -- Line: 1779, Name: ExistingProfileHandle
                    -- upvalues: u21 (ref), game_PlaceId (ref), game_JobId (ref), u1 (ref), u210 (ref), u211 (ref), u209 (ref)
                    if u21.ServiceLocked == false then
                        local ActiveSession = p218.MetaData.ActiveSession;
                        local ForceLoadSession = p218.MetaData.ForceLoadSession;

                        if ActiveSession == nil then
                            p218.MetaData.ActiveSession = { game_PlaceId, game_JobId };
                            p218.MetaData.ForceLoadSession = nil;

                            return;
                        end;

                        if type(ActiveSession) == "table" then
                            local v219;

                            if ActiveSession[1] == game_PlaceId then
                                v219 = ActiveSession[2] == game_JobId;
                            else
                                v219 = false;
                            end;

                            if v219 == false then
                                local LastUpdate = p218.MetaData.LastUpdate;

                                if LastUpdate ~= nil and os.time() - LastUpdate > u1.AssumeDeadSessionLock then
                                    p218.MetaData.ActiveSession = { game_PlaceId, game_JobId };
                                    p218.MetaData.ForceLoadSession = nil;

                                    return;
                                end;

                                if u210 == true or u211 == true then
                                    local v220;

                                    if ForceLoadSession == nil or ForceLoadSession[1] ~= game_PlaceId then
                                        v220 = false;
                                    else
                                        v220 = ForceLoadSession[2] == game_JobId;
                                    end;

                                    if v220 == true or u211 == true then
                                        p218.MetaData.ActiveSession = { game_PlaceId, game_JobId };
                                        p218.MetaData.ForceLoadSession = nil;
                                    end;
                                elseif u209 == true then
                                    p218.MetaData.ForceLoadSession = { game_PlaceId, game_JobId };
                                end;
                            else
                                p218.MetaData.ForceLoadSession = nil;
                            end;
                        end;
                    end;
                end,

                MissingProfileHandle = function(p221) -- Line: 1815, Name: MissingProfileHandle
                    -- upvalues: DeepCopyTable (ref), u201 (copy), game_PlaceId (ref), game_JobId (ref)
                    p221.Data = DeepCopyTable(u201._profile_template);
                    p221.MetaData = {
                        SessionLoadCount = 0,
                        ForceLoadSession = nil,
                        ProfileCreateTime = os.time(),
                        ActiveSession = { game_PlaceId, game_JobId },
                        MetaTags = {}
                    };
                end,

                EditProfile = function(p222) -- Line: 1825, Name: EditProfile
                    -- upvalues: u21 (ref), game_PlaceId (ref), game_JobId (ref)
                    if u21.ServiceLocked == false then
                        local ActiveSession = p222.MetaData.ActiveSession;

                        if ActiveSession ~= nil then
                            local v223;

                            if ActiveSession[1] == game_PlaceId then
                                v223 = ActiveSession[2] == game_JobId;
                            else
                                v223 = false;
                            end;

                            if v223 == true then
                                p222.MetaData.SessionLoadCount = p222.MetaData.SessionLoadCount + 1;
                                p222.MetaData.LastUpdate = os.time();
                            end;
                        end;
                    end;
                end
            }, v206));

            if v217[1] ~= v213 then
                u24 = u24 - 1;

                return nil;
            end;

            v215, v216 = table.unpack(v217[2]);
            v212[p202] = nil;
        else
            v214[1] = v213;

            while v214[2] == nil do
                task.wait();
            end;

            if v214[1] ~= v213 then
                u24 = u24 - 1;

                return nil;
            end;

            v215, v216 = table.unpack(v214[2]);
            v212[p202] = nil;
        end;

        if v215 == nil or v216 == nil then
            task.wait();
        else
            local ActiveSession = v215.MetaData.ActiveSession;

            if type(ActiveSession) ~= "table" then
                u24 = u24 - 1;

                return nil;
            end;

            local v224;

            if ActiveSession[1] == game_PlaceId then
                v224 = ActiveSession[2] == game_JobId;
            else
                v224 = false;
            end;

            if v224 == true then
                v215.MetaData.MetaTagsLatest = DeepCopyTable(v215.MetaData.MetaTags);
                local v225 = {
                    _profile = nil,
                    _updates_latest = v215.GlobalUpdates,
                    _pending_update_lock = {},
                    _pending_update_clear = {},
                    _new_active_update_listeners = u20.NewScriptSignal(),
                    _new_locked_update_listeners = u20.NewScriptSignal()
                };
                setmetatable(v225, u133);
                local v226 = {
                    _hop_ready = false,
                    Data = v215.Data,
                    MetaData = v215.MetaData,
                    MetaTagsUpdated = u20.NewScriptSignal(),
                    RobloxMetaData = v215.RobloxMetaData or {},
                    UserIds = v215.UserIds or {},
                    KeyInfo = v216,
                    KeyInfoUpdated = u20.NewScriptSignal(),
                    GlobalUpdates = v225,
                    _profile_store = u201,
                    _profile_key = p202,
                    _release_listeners = u20.NewScriptSignal(),
                    _hop_ready_listeners = u20.NewScriptSignal(),
                    _load_timestamp = os.clock(),
                    _is_user_mock = v206
                };
                setmetatable(v226, u165);
                v225._profile = v226;

                if next(u201._loaded_profiles) == nil and next(u201._mock_loaded_profiles) == nil then
                    table.insert(_active_profile_stores, u201);
                end;

                if v206 == true then
                    u201._mock_loaded_profiles[p202] = v226;
                else
                    u201._loaded_profiles[p202] = v226;
                end;

                table.insert(_auto_save_list, u22, v226);

                if #_auto_save_list > 1 then
                    u22 = u22 + 1;
                elseif #_auto_save_list == 1 then
                    os_clock_ret = os.clock();
                end;

                if u21.ServiceLocked == true then
                    SaveProfileAsync(v226, true);
                    v226 = nil;
                end;

                u24 = u24 - 1;

                return v226;
            end;

            if v207 == true then
                local ForceLoadSession = v215.MetaData.ForceLoadSession;
                local v227;

                if ForceLoadSession == nil or ForceLoadSession[1] ~= game_PlaceId then
                    v227 = false;
                else
                    v227 = ForceLoadSession[2] == game_JobId;
                end;

                if v227 ~= true then
                    u24 = u24 - 1;

                    return nil;
                end;

                if u209 == false then
                    v208 = v208 + 1;

                    if v208 == u1.ForceLoadMaxSteps then
                        u210 = true;
                    end;
                end;

                task.wait();
                u209 = false;
            elseif u211 == true then
                task.wait();
            else
                local v228 = v205(ActiveSession[1], ActiveSession[2]);

                if v228 == "Repeat" then
                    task.wait();
                else
                    if v228 == "Cancel" then
                        u24 = u24 - 1;

                        return nil;
                    end;

                    if v228 == "ForceLoad" then
                        v207 = true;
                        u209 = true;
                        task.wait();
                    elseif v228 == "Steal" then
                        u211 = true;
                        task.wait();
                    else
                        local l_error = error;
                        local v229 = tostring(v228);
                        local v230 = type(v228);
                        local _profile_store_scope = u201._profile_store_scope;
                        l_error("[ProfileService] Invalid return from not_released_handler (\"" .. v229 .. "\")(" .. v230 .. ");" .. "\n" .. string.format("[Store:\"%s\";%sKey:\"%s\"]", u201._profile_store_name, _profile_store_scope == nil and "" or (string.format("Scope:\"%s\";", _profile_store_scope) or ""), p202) .. " Traceback:\n" .. debug.traceback());
                    end;
                end;
            end;
        end;
    end;

    u24 = u24 - 1;

    return nil;
end;

function u200.GlobalUpdateProfileAsync(p231, p232, u233, p234) -- Line: 1968
    -- upvalues: u21 (copy), StandardProfileUpdateAsyncDataStore (copy), u133 (copy), u30 (copy), CustomWriteQueueMarkForCleanup (copy)
    if type(p232) ~= "string" or string.len(p232) == 0 then
        error("[ProfileService] Invalid profile_key");
    end;

    if type(u233) ~= "function" then
        error("[ProfileService] Invalid update_handler");
    end;

    if u21.ServiceLocked == true then
        return nil;
    end;

    while p231._is_pending == true do
        task.wait();
    end;

    while u21.ServiceLocked == false do
        local v237 = StandardProfileUpdateAsyncDataStore(p231, p232, {
            ExistingProfileHandle = nil,
            MissingProfileHandle = nil,

            EditProfile = function(p235) -- Line: 1990, Name: EditProfile
                -- upvalues: u133 (ref), u233 (copy)
                local v236 = {
                    _update_handler_mode = true,
                    _updates_latest = p235.GlobalUpdates
                };
                setmetatable(v236, u133);
                u233(v236);
            end
        }, p234 == u30);
        CustomWriteQueueMarkForCleanup(p231._profile_store_lookup, p232);

        if v237 ~= nil then
            local v238 = {
                _updates_latest = v237.GlobalUpdates
            };
            setmetatable(v238, u133);

            return v238;
        end;

        task.wait();
    end;

    return nil;
end;

function u200.ViewProfileAsync(u239, p240, p241, p242) -- Line: 2018
    -- upvalues: u21 (copy), u30 (copy), u29 (ref), StandardProfileUpdateAsyncDataStore (copy), DeepCopyTable (copy), CustomWriteQueueMarkForCleanup (copy), u133 (copy), u20 (ref), u165 (copy)
    if type(p240) ~= "string" or string.len(p240) == 0 then
        error("[ProfileService] Invalid profile_key");
    end;

    if u21.ServiceLocked == true then
        return nil;
    end;

    while u239._is_pending == true do
        task.wait();
    end;

    if p241 ~= nil and (p242 == u30 or u29 == true) then
        return nil;
    end;

    while u21.ServiceLocked == false do
        local v244, v245 = StandardProfileUpdateAsyncDataStore(u239, p240, {
            ExistingProfileHandle = nil,
            EditProfile = nil,

            MissingProfileHandle = function(p243) -- Line: 2040, Name: MissingProfileHandle
                -- upvalues: DeepCopyTable (ref), u239 (copy)
                p243.Data = DeepCopyTable(u239._profile_template);
                p243.MetaData = {
                    SessionLoadCount = 0,
                    ActiveSession = nil,
                    ForceLoadSession = nil,
                    ProfileCreateTime = os.time(),
                    MetaTags = {}
                };
            end
        }, p242 == u30, true, p241);
        CustomWriteQueueMarkForCleanup(u239._profile_store_lookup, p240);

        if v244 ~= nil then
            if v245 == nil then
                return nil;
            end;

            local v246 = {
                _profile = nil,
                _updates_latest = v244.GlobalUpdates
            };
            setmetatable(v246, u133);
            local v247 = {
                _view_mode = true,
                Data = v244.Data,
                MetaData = v244.MetaData,
                MetaTagsUpdated = u20.NewScriptSignal(),
                RobloxMetaData = v244.RobloxMetaData or {},
                UserIds = v244.UserIds or {},
                KeyInfo = v245,
                KeyInfoUpdated = u20.NewScriptSignal(),
                GlobalUpdates = v246,
                _profile_store = u239,
                _profile_key = p240,
                _load_timestamp = os.clock()
            };
            setmetatable(v247, u165);
            v246._profile = v247;

            return v247;
        end;

        task.wait();
    end;

    return nil;
end;

function u200.ProfileVersionQuery(p248, p249, p250, p251, p252, p253) -- Line: 2098
    -- upvalues: u21 (copy), u192 (copy), u30 (copy), u29 (ref)
    if type(p249) ~= "string" or string.len(p249) == 0 then
        error("[ProfileService] Invalid profile_key");
    end;

    if u21.ServiceLocked == true then
        return setmetatable({}, u192);
    end;

    while p248._is_pending == true do
        task.wait();
    end;

    if p253 == u30 or u29 == true then
        error("[ProfileService] :ProfileVersionQuery() is not supported in mock mode");
    end;

    if p250 ~= nil and (typeof(p250) ~= "EnumItem" or p250.EnumType ~= Enum.SortDirection) then
        error("[ProfileService] Invalid sort_direction (" .. tostring(p250) .. ")");
    end;

    if p251 ~= nil and (typeof(p251) ~= "DateTime" and typeof(p251) ~= "number") then
        error("[ProfileService] Invalid min_date (" .. tostring(p251) .. ")");
    end;

    if p252 ~= nil and (typeof(p252) ~= "DateTime" and typeof(p252) ~= "number") then
        error("[ProfileService] Invalid max_date (" .. tostring(p252) .. ")");
    end;

    if typeof(p251) == "DateTime" then
        p251 = p251.UnixTimestampMillis or p251;
    end;

    if typeof(p252) == "DateTime" then
        p252 = p252.UnixTimestampMillis or p252;
    end;

    local v254 = {
        _query_pages = nil,
        _query_index = 0,
        _query_failure = false,
        _is_query_yielded = false,
        _profile_store = p248,
        _profile_key = p249,
        _sort_direction = p250,
        _min_date = p251,
        _max_date = p252,
        _query_queue = {}
    };
    setmetatable(v254, u192);

    return v254;
end;

function u200.WipeProfileAsync(u255, u256, p257) -- Line: 2150
    -- upvalues: u21 (copy), u30 (copy), _user_mock_data_store (copy), u29 (ref), _mock_data_store (copy), CustomWriteQueueMarkForCleanup (copy)
    if type(u256) ~= "string" or string.len(u256) == 0 then
        error("[ProfileService] Invalid profile_key");
    end;

    if u21.ServiceLocked == true then
        return false;
    end;

    while u255._is_pending == true do
        task.wait();
    end;

    local v258;

    if p257 == u30 then
        local v259 = _user_mock_data_store[u255._profile_store_lookup];

        if v259 ~= nil then
            v259[u256] = nil;
        end;

        task.wait();
        v258 = true;
    elseif u29 == true then
        local v260 = _mock_data_store[u255._profile_store_lookup];

        if v260 ~= nil then
            v260[u256] = nil;
        end;

        task.wait();
        v258 = true;
    else
        v258 = pcall(function() -- Line: 2178
            -- upvalues: u255 (copy), u256 (copy)
            u255._global_data_store:RemoveAsync(u256);
        end);
    end;

    CustomWriteQueueMarkForCleanup(u255._profile_store_lookup, u256);

    return v258;
end;

function u21.GetProfileStore(p261, p262) -- Line: 2190
    -- upvalues: u30 (copy), u200 (copy), u28 (ref), u29 (ref), DataStoreService (copy)
    local u263 = nil;
    local u264 = nil;

    if type(p261) == "string" then
        u263 = p261;
    elseif type(p261) == "table" then
        u263 = p261.Name;
        u264 = p261.Scope;
    else
        error("[ProfileService] Invalid or missing profile_store_index");
    end;

    if u263 == nil or type(u263) ~= "string" then
        error("[ProfileService] Missing or invalid \"Name\" parameter");
    elseif string.len(u263) == 0 then
        error("[ProfileService] ProfileStore name cannot be an empty string");
    end;

    if u264 ~= nil and (type(u264) ~= "string" or string.len(u264) == 0) then
        error("[ProfileService] Invalid \"Scope\" parameter");
    end;

    if type(p262) ~= "table" then
        error("[ProfileService] Invalid profile_template");
    end;

    local u265 = nil;
    u265 = {
        _global_data_store = nil,
        _is_pending = false,
        Mock = {
            LoadProfileAsync = function(p266, p267, p268) -- Line: 2225, Name: LoadProfileAsync
                -- upvalues: u265 (ref), u30 (ref)
                return u265:LoadProfileAsync(p267, p268, u30);
            end,

            GlobalUpdateProfileAsync = function(p269, p270, p271) -- Line: 2228, Name: GlobalUpdateProfileAsync
                -- upvalues: u265 (ref), u30 (ref)
                return u265:GlobalUpdateProfileAsync(p270, p271, u30);
            end,

            ViewProfileAsync = function(p272, p273, p274) -- Line: 2231, Name: ViewProfileAsync
                -- upvalues: u265 (ref), u30 (ref)
                return u265:ViewProfileAsync(p273, p274, u30);
            end,

            FindProfileVersionAsync = function(p275, p276, p277, p278, p279) -- Line: 2234, Name: FindProfileVersionAsync
                -- upvalues: u265 (ref), u30 (ref)
                return u265:FindProfileVersionAsync(p276, p277, p278, p279, u30);
            end,

            WipeProfileAsync = function(p280, p281) -- Line: 2237, Name: WipeProfileAsync
                -- upvalues: u265 (ref), u30 (ref)
                return u265:WipeProfileAsync(p281, u30);
            end
        },
        _profile_store_name = u263,
        _profile_store_scope = u264,
        _profile_store_lookup = u263 .. "\0" .. (u264 or ""),
        _profile_template = p262,
        _loaded_profiles = {},
        _profile_load_jobs = {},
        _mock_loaded_profiles = {},
        _mock_profile_load_jobs = {}
    };
    setmetatable(u265, u200);
    local DataStoreOptions = Instance.new("DataStoreOptions");
    DataStoreOptions:SetExperimentalFeatures({
        v2 = true
    });

    if u28 == true then
        u265._is_pending = true;
        task.spawn(function() -- Line: 2261
            -- upvalues: u28 (ref), u29 (ref), u265 (ref), DataStoreService (ref), u263 (ref), u264 (ref), DataStoreOptions (copy)
            while u28 == true do
                task.wait();
            end;

            if u29 == false then
                u265._global_data_store = DataStoreService:GetDataStore(u263, u264, DataStoreOptions);
            end;

            u265._is_pending = false;
        end);
    elseif u29 == false then
        u265._global_data_store = DataStoreService:GetDataStore(u263, u264, DataStoreOptions);
    end;

    return u265;
end;

function u21.IsLive() -- Line: 2277
    -- upvalues: u28 (ref), u29 (ref)
    while u28 == true do
        task.wait();
    end;

    local v282;

    if u29 == false then
        v282 = true;
    else
        v282 = false;
    end;

    return v282;
end;

if v27 == true then
    u28 = true;
    task.spawn(function() -- Line: 2289
        -- upvalues: DataStoreService (copy), u29 (ref), u21 (copy), u28 (ref)
        local success, result = pcall(function() -- Line: 2290
            -- upvalues: DataStoreService (ref)
            DataStoreService:GetDataStore("____PS"):SetAsync("____PS", os.time());
        end);
        local v283;

        if success == false then
            v283 = string.find(result, "ConnectFail", 1, true) ~= nil;
        else
            v283 = false;
        end;

        if v283 == true then
            warn("[ProfileService] No internet access - check your network connection");
        end;

        if success == false and (string.find(result, "403", 1, true) ~= nil or (string.find(result, "must publish", 1, true) ~= nil or v283 == true)) then
            u29 = true;
            u21._use_mock_data_store = true;
            print("[ProfileService] Roblox API services unavailable - data will not be saved");
        end;

        u28 = false;
    end);
end;

RunService.Heartbeat:Connect(function() -- Line: 2316
    -- upvalues: _auto_save_list (copy), u1 (copy), os_clock_ret (ref), u22 (ref), SaveProfileAsync (copy), u21 (copy), _issue_queue (copy), u26 (ref)
    local v284 = #_auto_save_list;

    if v284 > 0 then
        local v285 = u1.AutoSaveProfiles / v284;
        local os_clock_ret2 = os.clock();

        while v285 < os_clock_ret2 - os_clock_ret do
            os_clock_ret = os_clock_ret + v285;
            local v286 = _auto_save_list[u22];

            if os_clock_ret2 - v286._load_timestamp < u1.AutoSaveProfiles then
                v286 = nil;

                for i = 1, v284 - 1 do
                    u22 = u22 + 1;

                    if v284 < u22 then
                        u22 = 1;
                    end;

                    v286 = _auto_save_list[u22];

                    if os_clock_ret2 - v286._load_timestamp >= u1.AutoSaveProfiles then
                        break;
                    end;

                    local _ = i;
                    v286 = nil;
                end;
            end;

            u22 = u22 + 1;

            if v284 < u22 then
                u22 = 1;
            end;

            if v286 ~= nil then
                task.spawn(SaveProfileAsync, v286);
            end;
        end;
    end;

    if u21.CriticalState == false then
        if #_issue_queue >= u1.IssueCountForCriticalState then
            u21.CriticalState = true;
            u21.CriticalStateSignal:Fire(true);
            u26 = os.clock();
            warn("[ProfileService] Entered critical state");
        end;
    elseif #_issue_queue >= u1.IssueCountForCriticalState then
        u26 = os.clock();
    elseif os.clock() - u26 > u1.CriticalStateLast then
        u21.CriticalState = false;
        u21.CriticalStateSignal:Fire(false);
        warn("[ProfileService] Critical state ended");
    end;

    while true do
        local v287 = _issue_queue[1];

        if v287 == nil then
            break;
        end;

        if os.clock() - v287 <= u1.IssueLast then
            return;
        end;

        table.remove(_issue_queue, 1);
    end;
end);
task.spawn(function() -- Line: 2385
    -- upvalues: u28 (ref), u20 (ref), u21 (copy), _auto_save_list (copy), SaveProfileAsync (copy), u24 (ref), u25 (ref), u29 (ref)
    while u28 == true do
        task.wait();
    end;

    u20.ConnectToOnClose(function() -- Line: 2388
        -- upvalues: u21 (ref), _auto_save_list (ref), SaveProfileAsync (ref), u24 (ref), u25 (ref)
        u21.ServiceLocked = true;
        local v288 = {};
        local u289 = 0;

        for i, v in ipairs(_auto_save_list) do
            v288[i] = v;
        end;

        for _, v in ipairs(v288) do
            if v:IsActive() == true then
                u289 = u289 + 1;
                task.spawn(function() -- Line: 2401
                    -- upvalues: SaveProfileAsync (ref), v (copy), u289 (ref)
                    SaveProfileAsync(v, true);
                    u289 = u289 - 1;
                end);
            end;
        end;

        while u289 > 0 or (u24 > 0 or u25 > 0) do
            task.wait();
        end;
    end, u29 == false);
end);

return u21;