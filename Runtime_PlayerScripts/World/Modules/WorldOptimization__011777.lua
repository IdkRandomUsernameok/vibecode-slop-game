-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");

return function(p1, p2) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), Lighting (copy)
    local DataManager = require(p1.Data.DataManager);
    local OptimizableStuff = require(p1.Data.OptimizableStuff);
    local CurrentLobby = require(p1.Main.MapService.Main.Main.Lighting.CurrentLobby);
    local u3 = p2;

    local function updateProps() -- Line: 11
        -- upvalues: u3 (ref), ReplicatedStorage (ref), OptimizableStuff (copy)
        local v4 = u3.DisableProps and ReplicatedStorage.Temp:FindFirstChild("DisabledMapProps") or (workspace:FindFirstChild("Map") or workspace);

        for _, v in OptimizableStuff.Props do
            v.Parent = v4;
        end;
    end;

    local function updateTextures() -- Line: 18
        -- upvalues: u3 (ref)
        local Map = workspace:FindFirstChild("Map");

        if not Map then
            return;
        end;

        if u3.DisableTextures then
            for _, v in Map:QueryDescendants("BasePart") do
                v.Material = Enum.Material.SmoothPlastic;
            end;

            return;
        end;

        for _, v in Map:QueryDescendants("BasePart[$OriginalMaterial]") do
            v.Material = v:GetAttribute("OriginalMaterial");
        end;
    end;

    local function updateShadows() -- Line: 33
        -- upvalues: u3 (ref), CurrentLobby (copy), Lighting (ref)
        local v5 = not u3.DisableShadows;
        CurrentLobby.GlobalShadows = v5;
        Lighting.GlobalShadows = v5;
    end;

    DataManager.DataChanged:Connect(function(p6, p7) -- Line: 39
        -- upvalues: u3 (ref), DataManager (copy), ReplicatedStorage (ref), OptimizableStuff (copy), updateTextures (copy), CurrentLobby (copy), Lighting (ref)
        u3 = DataManager:GetData();

        if p6 == "DisableProps" then
            local v8 = u3.DisableProps and ReplicatedStorage.Temp:FindFirstChild("DisabledMapProps") or (workspace:FindFirstChild("Map") or workspace);

            for _, v in OptimizableStuff.Props do
                v.Parent = v8;
            end;

            return;
        end;

        if p6 == "DisableTextures" then
            updateTextures();

            return;
        end;

        if p6 == "DisableShadows" then
            local v9 = not u3.DisableShadows;
            CurrentLobby.GlobalShadows = v9;
            Lighting.GlobalShadows = v9;
        end;
    end);
    local v10 = u3.DisableProps and ReplicatedStorage.Temp:FindFirstChild("DisabledMapProps") or (workspace:FindFirstChild("Map") or workspace);

    for _, v in OptimizableStuff.Props do
        v.Parent = v10;
    end;

    updateTextures();
    local v11 = not u3.DisableShadows;
    CurrentLobby.GlobalShadows = v11;
    Lighting.GlobalShadows = v11;
end;