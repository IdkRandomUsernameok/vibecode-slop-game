-- Decompiled with Potassium's decompiler.

local u1 = {
    currentEntries = {}
};
local u2 = game:GetService("RunService"):IsStudio();
debug.setmemorycategory("AFNTranslations");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LocalizationService = game:GetService("LocalizationService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Signal = require(Modules.Lib.Signal);
local Languages = ReplicatedStorage:WaitForChild("Languages");
local Default = Languages:WaitForChild("Default");
local u3 = "en";
local u4 = "en-us";

if LocalizationService:FindFirstChild("AFNTranslations") then
    LocalizationService.AFNTranslations:Destroy();
end;

local LocalizationTable = Instance.new("LocalizationTable");
LocalizationTable.SourceLocaleId = "en-us";
LocalizationTable.Name = "AFNTranslations";

if not game:GetService("RunService"):IsRunning() then
    LocalizationTable.Archivable = false;
end;

u1.globalLocalizationTable = LocalizationTable;
u1.localizationTable = LocalizationTable;
local success, result = pcall(function() -- Line: 74
    -- upvalues: LocalizationService (copy), Players (copy)
    return LocalizationService:GetTranslatorForPlayerAsync(Players.LocalPlayer);
end);
local u5 = {};

for i, v in {
    sq = { "sq-al" },
    ar = { "ar-001" },
    bn = { "bn-bd" },
    nb = { "nb-no" },
    bs = { "bs-ba" },
    bg = { "bg-bg" },
    my = { "my-mm" },
    ["zh-hans"] = { "zh-cn" },
    ["zh-hant"] = { "zh-tw" },
    hr = { "hr-hr" },
    cs = { "cs-cz" },
    da = { "da-dk" },
    nl = { "nl-nl" },
    en = { "en-us", "en-gb" },
    et = { "et-ee" },
    fil = { "fil-ph" },
    fi = { "fi-fi" },
    fr = { "fr-fr", "fr-ca" },
    ka = { "ka-ge" },
    de = { "de-de" },
    el = { "el-gr" },
    hi = { "hi-in" },
    hu = { "hu-hu" },
    id = { "id-id" },
    it = { "it-it" },
    ja = { "ja-jp" },
    kk = { "kk-kz" },
    km = { "km-kh" },
    ko = { "ko-kr" },
    lv = { "lv-lv" },
    lt = { "lt-lt" },
    ms = { "ms-my" },
    pl = { "pl-pl" },
    pt = { "pt-br", "pt-pt" },
    ro = { "ro-ro" },
    ru = { "ru-ru" },
    sr = { "sr-rs" },
    si = { "si-lk" },
    sk = { "sk-sk" },
    sl = { "sl-sl" },
    es = { "es-es", "es-mx" },
    sv = { "sv-se" },
    th = { "th-th" },
    tr = { "tr-tr" },
    uk = { "uk-ua" },
    vi = { "vi-vn" }
} do
    local v6 = i;

    for _, v2 in v do
        u5[v2] = v6;
    end;
end;

function deepCopy(p7: table)
    local v8 = {};

    for i, v in p7 do
        local v9;

        if type(v) == "table" then
            v9 = deepCopy(v) or v;
        else
            v9 = v;
        end;

        v8[i] = v9;
    end;

    return v8;
end;

function mergeLanguages(p10: table, p11: table)
    for i, v in p11 do
        if p10[i] ~= nil then
            if type(p10[i]) == "table" and type(v) == "table" then
                mergeLanguages(p10[i], v);
            elseif type(p10[i]) == "string" and type(v) == "string" then
                p10[i] = v;
            end;
        end;
    end;
end;

function getParametersFromString(p12)
    local v13 = 1;
    local v14 = {};
    local v15 = {};

    while true do
        local string_find_ret = string.find(p12, "{", v13, true);

        if not string_find_ret then
            break;
        end;

        local string_find_ret2 = string.find(p12, "}", string_find_ret, true);

        if not string_find_ret2 then
            warn("What in the sigma");
            break;
        end;

        local v16 = string.sub(p12, string_find_ret + 1, string_find_ret2 - 1):split(":")[1];
        local string_sub_ret = string.sub(p12, v13, string_find_ret - 1);
        table.insert(v14, string_sub_ret);
        local v17 = `\{{v16}}`;
        table.insert(v14, v17);
        v15[v16] = #v14;
        v13 = string_find_ret2 + 1;
    end;

    local string_sub_ret = string.sub(p12, v13);
    table.insert(v14, string_sub_ret);

    return v14, v15;
end;

function u1.GetLangFileContent(p18: table, p19: userdata) -- Line: 199
    -- upvalues: Languages (copy)
    local v20 = deepCopy((require(p19)));

    if v20._extends then
        local v21 = {};

        while true do
            local v22 = Languages:FindFirstChild(v20._extends);

            if not v22 then
                warn((`Language is trying to extend missing language: {v20._extends}`));
                break;
            end;

            local v23 = require(v22);

            if table.find(v21, v22) then
                warn((`Language: {p19.Name}->{v20._extends} is extending in a cyclic way`));
            end;

            table.insert(v21, v22);

            if v23._extends == nil then
                break;
            end;
        end;

        for i = 1, #v21 do
            local v24 = require(v21[i]);
            mergeLanguages(v20, v24);
            local _ = i;
        end;
    end;

    return v20;
end;

function u1.BuildLanguage(p25, p26) -- Line: 232
    -- upvalues: Languages (copy), u5 (copy), Default (copy), u1 (copy)
    if type(p26) == "string" then
        p26 = Languages:FindFirstChild(p26);
    end;

    if typeof(p26) == "Instance" then
        if p26:IsA("ModuleScript") then
            local v27 = p26:GetAttribute("LanguageId") or p26.Name;
            local v28 = u5[v27];

            if not v27:find("-") then
                v28 = v27;
            end;

            if not p26:GetAttribute("Global") then
                local _ = v28 == v27;
            end;

            if p26 == Default then
                v27 = "en-us";
                v28 = "en";
            end;

            return {
                File = p26,
                Content = p26 == Default and u1:GetLangFileContent(p26) or nil,
                Ids = v27 == v28 and ({ v27 } or { v27, v28 }) or { v27, v28 }
            };
        end;

        return;
    end;

    warn("[Translator] Trying to build a language that doesnt exist");
end;

local u29 = {};

function u1.Init(p30: table, p31: userdata, p32: table) -- Line: 267
    -- upvalues: u2 (copy), u1 (copy), u29 (copy)
    local u33 = {};
    local u34 = {};
    local u35 = {};

    local function recursiveEntryRead(p36: table, p37: any, p38: any, p39: any, p40: any, p41: any) -- Line: 272
        -- upvalues: u35 (copy), recursiveEntryRead (copy), u2 (ref), u34 (copy), u33 (copy)
        local v42 = p38 or "";
        local v43 = p40 or "";
        local v44 = p39 or 1;

        for i, v in p36 do
            local v45 = (v42 == "" and v42 and v42 or v42 .. "_") .. i;
            local _ = (v43 == "" and v43 and v43 or v43 .. ".") .. i;

            if v45 ~= "_extends" and v45 ~= "__TranslationsContext" then
                if type(v) == "table" then
                    local v46 = {};
                    (p41 or u35)[i] = v46;
                    recursiveEntryRead(v, p37, v45, v44 + 1, v43, v46);
                elseif type(v) == "string" then
                    local v47 = {
                        isEntry = true,
                        Key = v45,
                        Source = v,
                        Context = v45,
                        Values = {}
                    };
                    local v48, v49 = getParametersFromString(v);
                    local v50;

                    if next(v49) then
                        v47.Format = {};
                        v50 = i;

                        for _, v2 in p37 do
                            v47.Format[v2] = {
                                content = v48,
                                params = v49
                            };
                        end;
                    else
                        v50 = i;
                    end;

                    if u2 then
                        v47.Values["zh-hant"] = v45;

                        if v47.Format then
                            v47.Format["zh-hant"] = {
                                params = {},
                                content = { v45 }
                            };
                        end;
                    end;

                    local v51 = v45:gsub("_", ".");
                    u34[v45] = v47;
                    u34[v51] = v47;
                    u35[v45] = v47;
                    u35[v51] = v47;
                    (p41 or u35)[v50] = v47;
                    table.insert(u33, v47);
                end;
            end;
        end;
    end;

    recursiveEntryRead(p32.Content or u1:GetLangFileContent(p32.File), p32.Ids);
    table.move(p32.Ids, 1, #p32.Ids, #u29 + 1, u29);
    p30.currentEntries = u34;
    p30.entryIndexing = u35;
    p30.allEntries = u33;
    setmetatable(u35, {
        __index = function(p52, p53) -- Line: 343, Name: __index
            return p53;
        end
    });

    if p30 == u1 then
        p30:BuildIndexTable();
    end;

    p31:SetEntries(u33);
end;

function u1.AddLanguage(p54: table, p55: userdata, u56: table) -- Line: 354
    -- upvalues: u29 (copy), u1 (copy)
    if not (u56 and p55) then
        return;
    end;

    local v57 = true;

    for _, v in u56.Ids do
        if not v57 then
            break;
        end;

        v57 = table.find(u29, v);
    end;

    if v57 then
        return;
    end;

    local currentEntries = p54.currentEntries;

    local function u66(p58: table, p59: any) -- Line: 367
        -- upvalues: u66 (copy), currentEntries (copy), u56 (copy)
        local v60 = p59 or "";

        for i, v in p58 do
            local v61 = (v60 == "" and v60 and v60 or v60 .. "_") .. i;

            if v61 ~= "_extends" and v61 ~= "__TranslationsContext" then
                if type(v) == "table" then
                    u66(v, v61);
                elseif type(v) == "string" then
                    local v62 = currentEntries[v61];

                    if v62 then
                        local v63 = v;

                        for _, v2 in u56.Ids do
                            v62.Values[v2] = v63;

                            if v62.Format then
                                local v64, v65 = getParametersFromString(v63);
                                v62.Format[v2] = {
                                    content = v64,
                                    params = v65
                                };
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    u66(u56.Content or u1:GetLangFileContent(u56.File));
    p55:SetEntries(p54.allEntries or {});
end;

function u1.BuildTable(p67: table, p68: userdata, p69: table) -- Line: 400
    -- upvalues: u1 (copy)
    local v70 = p69 or {};

    if not next(v70) then
        p68:SetEntries(u1.localizationTable:GetEntries());
    end;

    local v71 = {};
    local v72 = {};

    for i, v in u1.currentEntries do
        if not v71[v] then
            local v73 = v;
            local v74 = i;

            for _, v2 in v70 do
                if v74:find(v2, 1, true) == 1 then
                    v71[v73] = true;
                    table.insert(v72, v73);
                    break;
                end;
            end;
        end;
    end;

    p68:SetEntries(v72);
end;

function u1.BuildIndexTable(p75) -- Line: 426
    -- upvalues: u4 (ref), u3 (ref)
    local u76 = {};

    local function recursiveTab(p77, p78) -- Line: 429
        -- upvalues: u76 (copy), recursiveTab (copy), u4 (ref), u3 (ref)
        local v79 = p78 or u76;

        for i, v in p77 do
            if type(v) == "table" and v.isEntry ~= true then
                local v80 = {};
                v79[i] = v80;
                recursiveTab(v, v80);
            else
                v79[i] = v.Values[u4] or (v.Values[u3] or v.Source);
            end;
        end;
    end;

    recursiveTab(p75.entryIndexing or {});
    setmetatable(p75, {
        __index = u76
    });
end;

function u1.Format(p81: string, p82: table) -- Line: 447
    -- upvalues: u1 (copy), u4 (ref), u3 (ref)
    local v83 = u1.currentEntries[p81];

    if not v83 then
        return p81;
    end;

    local Format = v83.Format;

    if not Format then
        return v83.Values[u4] or (v83.Values[u3] or v83.Source);
    end;

    local v84 = Format[u4] or (Format[u3] or Format["en-us"]);
    local content = v84.content;

    for i, v in v84.params do
        local v85 = p82[i];

        if v85 then
            content[v] = v85;
        end;
    end;

    return table.concat(content);
end;

function u1.Get(p86) -- Line: 465
    -- upvalues: u1 (copy), u4 (ref), u3 (ref)
    local v87 = u1.currentEntries[p86];

    if v87 then
        return v87.Values[u4] or (v87.Values[u3] or v87.Source);
    end;

    return p86;
end;

function u1.GetOr(p88, p89) -- Line: 471
    -- upvalues: u1 (copy), u4 (ref), u3 (ref)
    local v90 = u1.currentEntries[p88];

    if v90 then
        return v90.Values[u4] or v90.Values[u3] or (v90.Source or p89);
    end;

    return p89;
end;

function u1.RawFormat(p91: string, p92: table) -- Line: 478
    -- upvalues: u1 (copy)
    local v93 = u1.currentEntries[p91];

    if not v93 then
        return p91;
    end;

    local Format = v93.Format;

    if not Format then
        return v93.Source;
    end;

    local v94 = Format["en-us"];
    local content = v94.content;

    for i, v in v94.params do
        local v95 = p92[i];

        if v95 then
            content[v] = v95;
        end;
    end;

    return table.concat(content);
end;

function u1.RawGet(p96) -- Line: 496
    -- upvalues: u1 (copy)
    local v97 = u1.currentEntries[p96];

    if v97 then
        return v97.Source;
    end;

    return p96;
end;

function u1.RawGetOr(p98, p99) -- Line: 502
    -- upvalues: u1 (copy)
    local v100 = u1.currentEntries[p98];

    if v100 then
        return v100.Source or p99;
    end;

    return p99;
end;

local u101 = Signal.new();

function u1.new(p102: string, u103: table?) -- Line: 509
    -- upvalues: u1 (copy), u101 (copy)
    local LocalizationTable2 = Instance.new("LocalizationTable");
    LocalizationTable2.Name = "_" .. p102;
    LocalizationTable2.SourceLocaleId = "en-us";
    local u104 = setmetatable({
        localizationTable = LocalizationTable2
    }, {
        __index = u1
    });
    u104:BuildTable(LocalizationTable2, u103);
    u101:Connect(function() -- Line: 519
        -- upvalues: u104 (copy), LocalizationTable2 (copy), u103 (copy)
        u104:BuildTable(LocalizationTable2, u103);
    end);

    return u104;
end;

local u105 = {};
local u106 = 0;

function u1.AsignTask(p107: function, u108: string?) -- Line: 530
    -- upvalues: u106 (ref), u105 (copy)
    if not u108 then
        u108 = tostring(u106);
        u106 = u106 + 1;
    end;

    u105[u108] = p107;
    p107();

    return function() -- Line: 538
        -- upvalues: u105 (ref), u108 (ref)
        u105[u108] = nil;
    end;
end;

function u1.CleanTask(p109: string) -- Line: 543
    -- upvalues: u105 (copy)
    u105[p109] = nil;
end;

local u110 = Signal.new();
u110:Connect(function() -- Line: 550
    -- upvalues: u1 (copy), u101 (copy), u105 (copy)
    u1:BuildIndexTable();
    u101:Fire();

    for i, v in u105 do
        if not pcall(v) then
            warn("[Translator] Failed LocaleChanged task with id:", i);
        end;
    end;
end);
local u111 = {};

for _, child in Languages:GetChildren() do
    local v112 = u1:BuildLanguage(child);

    for _, v in v112.Ids do
        u111[v] = v112;
    end;
end;

local en = u111.en;
u1:Init(LocalizationTable, en);
u1.Default = en.Content;

local function setLocale(p113) -- Line: 582
    -- upvalues: u4 (ref), result (copy), u3 (ref), u5 (copy), u1 (copy), LocalizationTable (copy), u111 (copy), u110 (copy)
    u4 = result.LocaleId;
    u3 = u5[u4] or u4;
    local v114 = u4;
    local v115 = u3;
    u1:AddLanguage(LocalizationTable, u111[v115]);
    u1:AddLanguage(LocalizationTable, u111[v114]);
    u110:Fire(v114, v115);
end;

if success then
    local _ = result.LocaleId;
    u4 = result.LocaleId;
    u3 = u5[u4] or u4;
    local v116 = u4;
    local v117 = u3;
    u1:AddLanguage(LocalizationTable, u111[v117]);
    u1:AddLanguage(LocalizationTable, u111[v116]);
    u110:Fire(v116, v117);
    result:GetPropertyChangedSignal("LocaleId"):Connect(function() -- Line: 657
        -- upvalues: result (copy), u4 (ref), u3 (ref), u5 (copy), u1 (copy), LocalizationTable (copy), u111 (copy), u110 (copy)
        local _ = result.LocaleId;
        u4 = result.LocaleId;
        u3 = u5[u4] or u4;
        local v118 = u4;
        local v119 = u3;
        u1:AddLanguage(LocalizationTable, u111[v119]);
        u1:AddLanguage(LocalizationTable, u111[v118]);
        u110:Fire(v118, v119);
    end);
else
    warn("[Translator] Couldn\'t retrieve translator instance");
end;

LocalizationTable.Parent = LocalizationService;

return u1;