-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local u1 = {
    RolloutOverriden = false,
    List = {},
    AlwaysEnabled = {},
    Updated = require(Modules.Lib.Signal).new()
};

function u1.IsEnabled(p2: table, p3: string) -- Line: 12
    -- upvalues: u1 (copy)
    return table.find(u1.List, p3) ~= nil and true or table.find(u1.AlwaysEnabled, p3) ~= nil;
end;

function u1.ListEnabled(p4) -- Line: 16
    -- upvalues: u1 (copy)
    return u1.List;
end;

function u1.Format(p5: table, p6: string) -- Line: 20
    local v7 = `Unknown Feature Name ({p6})`;
    local v8;

    if p6 == "feature_pbot1_scoring" then
        v7 = "New Scoring System (PBOT 1)";
        v8 = "This feature introduces a new scoring system, with score awarded based on timing rather than ratings. Additionally, you can now gain score while holding a hold note.";
    else
        v8 = "This feature doesn\'t contain a description.";
    end;

    return {
        name = v7,
        id = p6,
        desc = v8
    };
end;

return u1;