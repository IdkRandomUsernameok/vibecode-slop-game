-- Decompiled with Potassium's decompiler.

local v1 = {};

for _, v in require(script.Parent.APIDump) do
    if v1[v] == nil then
        v1[v] = game.Lighting[v];
    end;
end;

return v1;