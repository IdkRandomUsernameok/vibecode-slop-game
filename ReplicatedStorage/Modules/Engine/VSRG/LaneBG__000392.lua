-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
require(Modules.Types);
local ManiaData = require(Modules.Engine.VSRG.ManiaData);
local Lane = Modules.Assets.Templates.Lane;
local u2 = 0;

function u1.new(p3) -- Line: 15
    -- upvalues: Lane (copy), u2 (ref), u1 (copy)
    local v4 = Lane:Clone();
    v4.Name = "LaneBG" .. u2;
    local v5 = setmetatable({
        scale = 1,
        extraSize = 0,
        insetPixels = 2,
        extraOffset = 0,
        isDirty = false,
        alpha = 0.75,
        alphaMult = 1,
        laneVisible = true,
        strumVisible = true,
        visible = true,
        lane = v4,
        connections = {}
    }, u1);
    v5:setVisible(true);
    u2 = u2 + 1;

    if p3 then
        v5:attach(p3);
    end;

    return v5;
end;

function u1.attach(u6, u7) -- Line: 50
    for _, v in u6.connections do
        v:Disconnect();
    end;

    table.clear(u6.connections);

    if not u7 then
        u6.lane.Parent = nil;

        return;
    end;

    local Obj = u7.Obj;

    if not Obj then
        u6.lane.Parent = nil;

        return;
    end;

    u6.strum = u7;
    u6:setStrumVisible(u7.visible);
    local connections = u6.connections;
    local PropertyChangedSignal = Obj:GetPropertyChangedSignal("Visible");
    table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 66
        -- upvalues: u6 (copy), u7 (copy)
        u6:setStrumVisible(u7.visible);
    end));
    u6:updateAlpha();
    local connections2 = u6.connections;
    local PropertyChangedSignal2 = Obj:GetPropertyChangedSignal("ImageTransparency");
    table.insert(connections2, PropertyChangedSignal2:Connect(function() -- Line: 73
        -- upvalues: u6 (copy)
        if u6.visible then
            u6:updateAlpha();

            return;
        end;

        u6.isDirty = true;
    end));
    u6:updatePosition();
    local connections3 = u6.connections;
    local PropertyChangedSignal3 = Obj:GetPropertyChangedSignal("Position");
    table.insert(connections3, PropertyChangedSignal3:Connect(function() -- Line: 81
        -- upvalues: u6 (copy)
        if u6.visible then
            u6:updatePosition();

            return;
        end;

        u6.isDirty = true;
    end));
    u6:updateSize();
    local connections4 = u6.connections;
    local PropertyChangedSignal4 = Obj:GetPropertyChangedSignal("Size");
    table.insert(connections4, PropertyChangedSignal4:Connect(function() -- Line: 89
        -- upvalues: u6 (copy)
        if u6.visible then
            u6:updateSize();

            return;
        end;

        u6.isDirty = true;
    end));
    u6.lane.Parent = Obj.Parent or nil;
    local connections5 = u6.connections;
    local PropertyChangedSignal5 = Obj:GetPropertyChangedSignal("Parent");
    table.insert(connections5, PropertyChangedSignal5:Connect(function() -- Line: 97
        -- upvalues: u6 (copy), u7 (copy)
        u6.lane.Parent = u7.parent or nil;
    end));
end;

function u1.updateSize(p8) -- Line: 103
    -- upvalues: ManiaData (copy)
    local strum = p8.strum;

    if not strum then
        return;
    end;

    p8.lane.Size = UDim2.fromScale((ManiaData.noteSize * ((strum.__currentProperties._scaleX or strum:GetProperty("Scale").X) * p8.scale) - p8.insetPixels + p8.extraSize) / (strum.__currentProperties._sFactorX or strum:GetPosFactors().X), 1.5);
end;

function u1.updatePosition(p9) -- Line: 111
    local strum = p9.strum;

    if not strum then
        return;
    end;

    local v10 = strum.useFactorsForPosition and (strum.__currentProperties._sFactorX or (strum:GetPosFactors().X or 1280)) or 1280;
    p9.lane.Position = UDim2.fromScale((p9.extraOffset + (strum.__currentProperties.x or strum:GetProperty("x"))) / v10, 0.5);
end;

function u1.updateAlpha(p11) -- Line: 119
    local strum = p11.strum;

    if not strum then
        return;
    end;

    p11.lane.BackgroundTransparency = 1 - (strum.__currentProperties.alpha or strum:GetProperty("alpha")) * p11.alpha * p11.alphaMult;
end;

function u1.update(p12) -- Line: 126
    if not p12.visible then
        p12.isDirty = true;

        return;
    end;

    p12:updateSize();
    p12:updatePosition();
    p12:updateAlpha();
end;

function u1.updateVisibility(p13) -- Line: 134
    p13.visible = p13.strumVisible and p13.laneVisible and p13.alpha * p13.alphaMult ~= 0;
    p13.lane.Visible = p13.visible;

    if p13.visible and p13.isDirty then
        p13:updateSize();
        p13:updatePosition();
        p13:updateAlpha();
        p13.isDirty = false;
    end;
end;

function u1.setVisible(p14, p15) -- Line: 147
    p14.laneVisible = p15 and true or false;
    p14:updateVisibility();
end;

function u1.setStrumVisible(p16, p17) -- Line: 152
    p16.strumVisible = p17 and true or false;
    p16:updateVisibility();
end;

function u1.Destroy(p18) -- Line: 157
    p18:attach(nil);
    p18.lane:Destroy();
end;

return u1;