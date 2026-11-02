-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local u1 = game:GetService("RunService"):IsServer();
local u2 = nil;

return {
    get = function(p3: userdata) -- Line: 11, Name: get
        -- upvalues: u1 (copy), ServerStorage (copy), u2 (ref)
        local Assets = p3:FindFirstChild("Assets");

        if Assets then
            return Assets;
        end;

        local Attribute = p3:GetAttribute("StreamedAssets");

        if not Attribute then
            return nil;
        end;

        if not u1 then
            u2 = u2 or require(script.Parent.AssetReplicator);

            return u2.getAsset((p3:GetAttribute("AnimationType") or "Animations") .. "Rigs", Attribute);
        end;

        local ReplicableAssets = ServerStorage:FindFirstChild("ReplicableAssets");

        if ReplicableAssets then
            ReplicableAssets = ReplicableAssets:FindFirstChild((p3:GetAttribute("AnimationType") or "Animations") .. "Rigs");
        end;

        p3:GetAttribute("AnimationType");

        if ReplicableAssets then
            ReplicableAssets = ReplicableAssets:FindFirstChild(Attribute);
        end;

        return ReplicableAssets;
    end
};