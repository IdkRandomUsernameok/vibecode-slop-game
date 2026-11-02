-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ContentProvider = game:GetService("ContentProvider");
local LocalPlayer = Players.LocalPlayer;
local v2 = RunService:IsStudio() and not RunService:IsRunning() and game:GetService("StarterGui");

if v2 then
    LocalPlayer = v2;
elseif LocalPlayer then
    LocalPlayer = LocalPlayer:WaitForChild("PlayerGui", 5);
end;

local u3 = {};
local u4 = {};
local u5 = {
    ImageLabel = { {
            Type = "Image",
            Property = "ImageContent"
        } },
    ImageButton = { {
            Type = "Image",
            Property = "ImageContent"
        } },
    Texture = { {
            Type = "Image",
            Property = "ColorMapContent"
        } },
    Decal = { {
            Type = "Image",
            Property = "ColorMapContent"
        } },
    Beam = { {
            Type = "Image",
            Property = "TextureContent"
        } },
    Sky = { {
            Type = "Image",
            Property = "MoonTextureContent"
        }, {
            Type = "Image",
            Property = "SunTextureContent"
        }, {
            Type = "Image",
            Property = "SkyboxBkContent"
        }, {
            Type = "Image",
            Property = "SkyboxFtContent"
        }, {
            Type = "Image",
            Property = "SkyboxDnContent"
        }, {
            Type = "Image",
            Property = "SkyboxLfContent"
        }, {
            Type = "Image",
            Property = "SkyboxRtContent"
        }, {
            Type = "Image",
            Property = "SkyboxUpContent"
        } },
    ParticleEmitter = { {
            Type = "Image",
            Property = "ImageContent"
        } },
    MeshPart = { {
            Type = "Image",
            Property = "TextureContent"
        }, {
            Type = "Mesh",
            Property = "MeshContent"
        } },
    SpecialMesh = { {
            Type = "Image",
            Property = "TextureContent"
        }, {
            Type = "Mesh",
            Property = "MeshContent"
        } }
};
local v6 = ReplicatedStorage:WaitForChild("Characters").PreloaderDummy:Clone();

if not v6:FindFirstChild("Humanoid") then
    local Humanoid = Instance.new("Humanoid");
    Instance.new("Animator").Parent = Humanoid;
    Humanoid.Parent = v6;
end;

local Animator = v6.Humanoid:WaitForChild("Animator", 5);

if not Animator then
    Animator = Instance.new("Animator");
    Animator.Parent = v6.Humanoid;
end;

u1.AnimationDummy = v6;

function u1.clearAll() -- Line: 75
    -- upvalues: u3 (copy), u1 (copy)
    for _, v in u3 do
        v:Destroy();
    end;

    u1.clearAnims();
end;

function u1.clearAnims() -- Line: 83
    -- upvalues: u4 (copy), Animator (ref)
    for _, v in u4 do
        if v:IsA("AnimationTrack") then
            v:Stop(0);
        end;

        v:Destroy();
    end;

    local Animator2 = Instance.new("Animator");
    Animator2.Parent = Animator.Parent;
    Animator:Destroy();
    Animator = Animator2;
    table.clear(u4);
end;

function u1.cacheAll(p7) -- Line: 100
    -- upvalues: u1 (copy)
    for _, descendant in p7:GetDescendants() do
        u1.cacheInstance(descendant);
    end;
end;

function u1.cacheInstance(p8) -- Line: 106
    -- upvalues: u5 (copy), u1 (copy)
    local v9 = u5[p8.ClassName];

    if not v9 then
        return;
    end;

    local v14 = {
        Image = function(p10, p11) -- Line: 114, Name: Image
            -- upvalues: u1 (ref)
            local v12 = p10[p11];

            if v12 ~= nil then
                u1.cacheImage(v12);
            end;
        end,

        Any = function(p13) -- Line: 120, Name: Any
            -- upvalues: u1 (ref)
            u1.cacheAsset(p13);
        end
    };

    for _, v in ipairs(v9) do
        (v14[v.Type] or v14.Any)(p8, v.Property);
    end;
end;

function u1.cacheMesh(p15) -- Line: 131
    -- upvalues: u1 (copy)
    u1.cacheInstance(p15);
end;

function u1.cacheAsset(p16) -- Line: 136
    -- upvalues: ContentProvider (copy)
    if p16 == nil then
        return;
    end;

    if p16 == "" then
        return;
    end;

    if typeof(p16) == "Content" then
        p16 = p16.Uri;

        if not p16 then
            return;
        end;
    end;

    task.spawn(ContentProvider.PreloadAsync, ContentProvider, { p16 });
end;

function u1.cacheAnimation(p17) -- Line: 152
    -- upvalues: u4 (copy), u1 (copy), Animator (ref)
    local v18;

    if typeof(p17) == "Instance" then
        if p17:IsA("AnimationTrack") then
            v18 = p17.Animation and p17.Animation:Clone();
        else
            v18 = p17:Clone();
        end;
    elseif type(p17) == "string" then
        v18 = Instance.new("Animation");
        v18.AnimationId = p17;
    else
        v18 = p17;
    end;

    if not v18 then
        return;
    end;

    u4[#u4 + 1] = v18;

    if #u4 >= 60 then
        u1.clearAnims();
    end;

    local v19 = Animator:LoadAnimation(v18);
    v19.Priority = Enum.AnimationPriority.Action4;
    v19.Looped = true;
    v19:Play(0, 0.1, 1e-6);
    u4[#u4 + 1] = v19;
end;

function u1.cacheImage(u20) -- Line: 182
    -- upvalues: u3 (copy), u1 (copy), LocalPlayer (copy)
    if not u20 then
        return nil;
    end;

    if u20 == "" then
        return nil;
    end;

    if typeof(u20) == "Instance" then
        local success, _ = pcall(function() -- Line: 188
            -- upvalues: u20 (copy)
            return u20.ImageContent;
        end);

        if not success then
            return nil;
        end;

        u20 = u20.ImageContent;
    elseif type(u20) == "number" then
        u20 = Content.fromAssetId(u20);
    elseif type(u20) == "string" then
        u20 = Content.fromUri(u20);
    end;

    if u3[u20] then
        return u3[u20];
    end;

    u1.cacheAsset(u20);

    if LocalPlayer then
        local Instance_fromExisting_ret = Instance.fromExisting(script.CachedImage);
        Instance_fromExisting_ret.ImageContent = u20;
        u3[u20] = Instance_fromExisting_ret;
        local Main = LocalPlayer:FindFirstChild("Main");

        if not Main then
            return Instance_fromExisting_ret;
        end;

        Instance_fromExisting_ret.Parent = Main:FindFirstChild("Cache");

        return Instance_fromExisting_ret;
    end;
end;

return u1;