-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local VarTweener = require(ReplicatedStorage:WaitForChild("Modules").Main.VarTweener);
local v1 = {};
local u2 = {};
local NumberSequence_new_ret = NumberSequence.new(0);
local NumberSequence_new_ret2 = NumberSequence.new(1);

local function getTransparencyValue(p3) -- Line: 11
    if typeof(p3) == "NumberSequence" then
        return p3.Keypoints[1].Value;
    end;

    return p3;
end;

function v1.Fade(p4, p5, p6) -- Line: 18
    -- upvalues: u2 (copy), TweenService (copy), VarTweener (copy), NumberSequence_new_ret2 (copy), NumberSequence_new_ret (copy)
    local ActiveCharacter = p4:GetActiveCharacter();

    if not ActiveCharacter then
        return;
    end;

    local TweenInfo_new_ret = TweenInfo.new(p5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
    local v7 = 1 - p6;
    local v8 = u2[ActiveCharacter];

    if not v8 then
        v8 = {
            Part = {},
            Beam = {}
        };

        for _, descendant in ActiveCharacter:GetDescendants() do
            if descendant ~= ActiveCharacter.PrimaryPart then
                if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                    descendant:SetAttribute("DefTransparency", descendant:GetAttribute("DefTransparency") or descendant.Transparency);
                    table.insert(v8.Part, descendant);
                elseif descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                    descendant:SetAttribute("DefTransparency", descendant:GetAttribute("DefTransparency") or descendant.Transparency);
                    table.insert(v8.Beam, descendant);
                end;
            end;
        end;

        u2[ActiveCharacter] = v8;
    end;

    for _, v in v8.Part do
        TweenService:Create(v, TweenInfo_new_ret, {
            Transparency = 1 - v7 * (1 - v:GetAttribute("DefTransparency"))
        }):Play();
    end;

    for _, v in v8.Beam do
        local Attribute = v:GetAttribute("DefTransparency");

        if typeof(Attribute) == "NumberSequence" then
            Attribute = Attribute.Keypoints[1].Value;
        end;

        local v9 = 1 - v7 * (1 - Attribute);
        VarTweener:Create(v, TweenInfo_new_ret, {
            Transparency = v9 >= 1 and NumberSequence_new_ret2 or (v9 <= 0 and NumberSequence_new_ret or NumberSequence.new(v9))
        }):Play();
    end;
end;

function v1.ClearCache(p10) -- Line: 61
    -- upvalues: u2 (copy)
    u2[p10] = nil;
end;

return v1;