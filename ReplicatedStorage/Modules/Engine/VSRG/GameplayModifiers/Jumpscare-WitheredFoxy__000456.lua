-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CacheService = require(ReplicatedStorage.Modules.Main.CacheService);
local Sprite = require(ReplicatedStorage.Modules.Main.Sprite);
local u1 = nil;

function foxyJumpscare()
    -- upvalues: Sprite (copy), u1 (ref)
    local v2 = script.Foxy:Clone();
    local u3 = Sprite.new(v2, nil, true, true);
    u3:AddSparrowXml(v2.XML, "Jumpscare", "withered_foxy_jumpscare0", 24, false);
    u3.Position = UDim2.fromScale(0.5, 0.5);
    u3.Obj.ScaleType = Enum.ScaleType.Stretch;
    u3.Size = UDim2.fromScale(1, 1);
    u3.Parent = u1.Overlay;
    u3.Visible = true;
    u1.playSound(script.Scream);
    u3:Play("Jumpscare", true);
    u3.AnimationEnded:Once(function() -- Line: 23
        -- upvalues: u3 (copy)
        if u3 and u3.Destroy then
            u3:Destroy();
        end;
    end);
end;

return {
    onCreate = function(p4) -- Line: 29, Name: onCreate
        -- upvalues: u1 (ref), Sprite (copy), CacheService (copy)
        u1 = p4;
        u1.cacheSound(script.Scream);

        for _, child in script:GetChildren() do
            local XML = child:FindFirstChild("XML");
            local v5 = XML and XML:IsA("ModuleScript") and XML.Name == "XML";

            if XML and v5 then
                local v6 = Sprite.new(child:Clone(), nil, true, true);
                v6:loadGraphic(child.XML, nil);

                for _, v in v6:GetSpriteImages(child.XML) do
                    CacheService.cacheImage(v);
                end;

                v6:Destroy();
            end;
        end;
    end,

    onUpdate = function() -- Line: 48, Name: onUpdate
        if math.random(1, 10000) == 1 then
            foxyJumpscare();
        end;
    end,

    clearUp = function() -- Line: 53, Name: clearUp
    end
};