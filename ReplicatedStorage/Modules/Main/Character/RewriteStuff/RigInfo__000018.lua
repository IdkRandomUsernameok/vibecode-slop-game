-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");

local function extractDefaults(p1: userdata) -- Line: 6
    -- upvalues: extractDefaults (copy)
    local v2 = {};

    for _, v in p1:QueryDescendants(">Attachment,>WrapTarget") do
        local v3 = {
            Name = v.Name,
            ClassName = v.ClassName,
            Instance = v:Clone(),
            Children = extractDefaults(v)
        };
        table.insert(v2, v3);
    end;

    return v2;
end;

local v4 = {};

for _, v in { Enum.HumanoidRigType.R6, Enum.HumanoidRigType.R15 } do
    local v5 = Players:CreateHumanoidModelFromDescriptionAsync(Instance.new("HumanoidDescription"), v);
    local v6 = {};
    local v7 = {};
    local v8 = {};
    local v9 = {};

    for _, v2 in v5:QueryDescendants("Attachment") do
        table.insert(v6, v2.Name);
    end;

    for _, v2 in v5:QueryDescendants("WrapTarget") do
        table.insert(v7, v2.Name);
    end;

    for _, v2 in v5:QueryDescendants(">BasePart") do
        table.insert(v8, v2.Name);
        v9[v2.Name] = extractDefaults(v2);
    end;

    v4[v.Name] = {
        Attachments = v6,
        Wraps = v7,
        BodyParts = v8,
        DefaultStructure = v9,
        DefaultHeight = v5.HumanoidRootPart.Size.Y / 2 + v5.Humanoid.HipHeight
    };
    v5:Destroy();
end;

return v4;