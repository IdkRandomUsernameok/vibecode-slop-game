-- Decompiled with Potassium's decompiler.

local Lib = game:GetService("ReplicatedStorage"):WaitForChild("Modules").Lib;
local Bitmask = require(Lib.Bitmask);

return {
    AnimationRigType = Bitmask.newEnum("r15", "r6", "d15", "s15", "meshrig"),
    AnimationInfo = Bitmask.newEnum("isHuge", "hasAlts", "hasFaces", "hasProps", "hasEvents")
};