-- Decompiled with Potassium's decompiler.

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("HttpService");
local Assets = script.Parent.Parent:WaitForChild("Assets");
local Tag = Assets.PlayerViewerTemplates.Tag;
local TagSection = Assets.PlayerViewerTemplates.TagSection;
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Overheads = require(Modules.UI.Overheads);
require(Modules.UI.ColorConverter);

local function __deepCopy(p2, p3) -- Line: 36
    -- upvalues: __deepCopy (copy)
    if type(p2) ~= "table" then
        return p2;
    end;

    local v4 = p3 or {};

    if v4[p2] then
        return v4[p2];
    end;

    local v5 = {};
    v4[p2] = v5;

    for i, v in p2 do
        v5[__deepCopy(i, v4)] = __deepCopy(v, v4);
    end;

    return v5;
end;

function v1.GenerateTagFrames(p6: table, p7: table) -- Line: 61
    -- upvalues: Tag (copy), Overheads (copy), TagSection (copy)
    local v8 = {};

    for i, v in ipairs(p7.PlayerInfo.Tags) do
        local v9 = Tag:Clone();
        v9.UIGradient.Color = v.Color;
        v9.Overlay.UIGradient.Color = v.Color;
        v9.Label.Text = Overheads:formatTag(v.Text or "", p7.PlayerInfo.DisplayName);
        v9.LayoutOrder = i;
        v9.Size = UDim2.fromScale(1, 1);
        table.insert(v8, {
            Frame = v9,
            Text = v.Text or ""
        });
    end;

    local v10 = 1;
    local v11 = {};

    while true do
        local v12;

        while true do
            if v10 > #v8 then
                return v11;
            end;

            v12 = v8[v10];

            if #v12.Text >= 20 then
                break;
            end;

            local v13 = TagSection:Clone();
            table.insert(v11, v13);
            local v14 = 0;
            local v15 = {};

            while v10 <= #v8 do
                local v16 = v8[v10];
                local v17 = #v16.Text;

                if v14 + v17 > 20 then
                    break;
                end;

                table.insert(v15, v16);
                v14 = v14 + v17;
                v10 = v10 + 1;
            end;

            for _, v in ipairs(v15) do
                local v18 = #v.Text / 20;
                v.Frame.UIAspectRatioConstraint:Destroy();
                v.Frame.Size = UDim2.fromScale(v18, 1);
                v.Frame.Parent = v13;
            end;
        end;

        local v19 = TagSection:Clone();
        table.insert(v11, v19);
        v12.Frame.UIAspectRatioConstraint:Destroy();
        v12.Frame.Size = UDim2.fromScale(1, 1);
        v12.Frame.Parent = v19;
        v10 = v10 + 1;
    end;
end;

return v1;