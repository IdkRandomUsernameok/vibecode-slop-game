-- Decompiled with Potassium's decompiler.

local v1 = {
    Dependencies = {}
};

for _, child in script.Main.Dependencies:GetChildren() do
    if child:IsA("ModuleScript") then
        local success, result = pcall(function() -- Line: 7
            -- upvalues: child (copy)
            return require(child);
        end);

        if success then
            v1.Dependencies[child.Name] = result;
        end;
    end;
end;

local Main = require(script.Main.Main);
Main:Setup(v1);

return Main;