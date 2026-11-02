-- Decompiled with Potassium's decompiler.

local v1 = game:FindService("ReplicatedStorage");
local CacheService = require(v1.Modules.Main.CacheService);
local u2 = {
    "rbxassetid://18636610078",
    "rbxassetid://18636669921",
    "rbxassetid://18636669422",
    "rbxassetid://18636668832",
    "rbxassetid://18636668391",
    "rbxassetid://18636667781",
    "rbxassetid://18636667004",
    "rbxassetid://18636666004",
    "rbxassetid://18636665478",
    "rbxassetid://18636665009",
    "rbxassetid://18636664594",
    "rbxassetid://18636664210",
    "rbxassetid://18636663794",
    "rbxassetid://18636663375",
    "rbxassetid://18636662989",
    "rbxassetid://18636662538",
    "rbxassetid://18636662184",
    "rbxassetid://18636661740",
    "rbxassetid://18636661406",
    "rbxassetid://18636660939",
    "rbxassetid://18636660491",
    "rbxassetid://18636660056",
    "rbxassetid://18636659687",
    "rbxassetid://18636659282",
    "rbxassetid://18636658801",
    "rbxassetid://18636658284",
    "rbxassetid://18636657846",
    "rbxassetid://18636657425",
    "rbxassetid://18636657060",
    "rbxassetid://18636656543",
    "rbxassetid://18636656170",
    "rbxassetid://18636655783",
    "rbxassetid://18636655361",
    "rbxassetid://18636654954",
    "rbxassetid://18636654481",
    "rbxassetid://18636653827",
    "rbxassetid://18636653133",
    "rbxassetid://18636652749",
    "rbxassetid://18636652423",
    "rbxassetid://18636651368"
};
local u3 = nil;
local u4 = 1;
local u5 = tick();
local u6 = nil;
local Random_new_ret = Random.new();
local os_clock_ret = os.clock();

return {
    create = function(p7: userdata, p8: userdata) -- Line: 70, Name: create
        -- upvalues: u2 (copy), CacheService (copy), u6 (ref), u3 (ref), u4 (ref)
        for _, v in u2 do
            CacheService.cacheImage(v);
        end;

        u6 = script.Noise:Clone();
        u6.Parent = p8;
        u3 = script.BG:Clone();
        u3.Image = u2[u4];
        u3.Parent = p7;
    end,

    onUpdate = function(p9) -- Line: 83, Name: onUpdate
        -- upvalues: u5 (ref), u3 (ref), u4 (ref), u2 (copy), os_clock_ret (ref), u6 (ref), Random_new_ret (copy)
        local v10 = tick();

        if math.abs(v10 - u5) >= 0.022222222222222223 and u3 ~= nil then
            u5 = v10;
            u4 = u4 + 1;

            if u4 > #u2 then
                u4 = 1;
            end;

            u3.Image = u2[u4];
        end;

        if os.clock() - os_clock_ret > 0.016666666666666666 then
            os_clock_ret = os.clock();
            u6.Position = UDim2.fromScale(Random_new_ret:NextNumber(-1, 0), Random_new_ret:NextNumber(-1, 0));
        end;
    end,

    clearUp = function() -- Line: 102, Name: clearUp
        -- upvalues: u3 (ref), u6 (ref)
        if u3 then
            u3:Destroy();
        end;

        if u6 then
            u6:Destroy();
        end;
    end
};