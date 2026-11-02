-- Decompiled with Potassium's decompiler.

require(game:GetService("ReplicatedStorage").Modules.Main.Sprite);
require(game:GetService("ReplicatedStorage").Modules.Main.Note);
require(game:GetService("ReplicatedStorage").Modules.Engine.VSRG.NoteSplash);
local u1 = {};

function u1.init(p2) -- Line: 9
    -- upvalues: u1 (copy)
    return setmetatable({
        Api = p2,
        Playfields = {}
    }, {
        __index = u1
    });
end;

function u1.create(p3: table, p4: boolean?) -- Line: 16
    local Instance_new_ret = Instance.new(p4 and "CanvasGroup" or "Frame");
    Instance_new_ret.BackgroundTransparency = 1;
    Instance_new_ret.Size = UDim2.fromScale(1, 1);
    Instance_new_ret.Position = UDim2.fromScale(0.5, 0.5);
    Instance_new_ret.AnchorPoint = Vector2.new(0.5, 0.5);
    local v5 = p3.Api.Game:FindFirstChildOfClass("UIAspectRatioConstraint");

    if v5 then
        v5:Clone().Parent = Instance_new_ret;
    end;

    local v6 = {
        x = 0,
        y = 0,
        zoom = 1,
        alpha = 1,
        angle = 0,
        CopyNotes = true,
        CopyStrums = true,
        CopyLanesBG = false,
        CopySplashes = false,
        isCanvas = p4,
        Obj = Instance_new_ret,
        Notes = {},
        Strums = {},
        LanesBG = {},
        Splashes = {}
    };
    table.insert(p3.Playfields, v6);

    return v6;
end;

u1.offsetIndex = "_playfieldOffset";

function u1.update(p7) -- Line: 58
    local Api = p7.Api;

    for _, v in p7.Playfields do
        local Obj = v.Obj;

        if Obj ~= nil then
            Obj.Position = UDim2.fromScale(Obj.AnchorPoint.X + v.x / 1280, Obj.AnchorPoint.Y + v.y / 720);
            Obj.Rotation = v.angle;
            Obj.Size = UDim2.fromScale(v.zoom, v.zoom);
            local alpha = v.alpha;

            if v.isCanvas then
                Obj.GroupTransparency = 1 - alpha;
            else
                local v8 = v;

                for _, v2 in v.Strums do
                    if v2 and v2.offsets.set then
                        v2.offsets.set("alpha", "_playfieldOffset", alpha);
                    end;
                end;

                for _, v2 in v8.Notes do
                    if v2 and v2.offsets.set then
                        v2.offsets.set("alpha", "_playfieldOffset", alpha);
                    end;
                end;

                for _, v2 in v8.Splashes do
                    if v2 and v2.offsets.set then
                        v2.offsets.set("alpha", "_playfieldOffset", alpha);
                    end;
                end;

                Obj.Visible = v8.alpha ~= 0;
            end;
        end;
    end;

    for _, v in Api.Strums do
        local v9 = v;

        for i, v2 in p7.Playfields do
            if v2.CopyStrums and (v2.alpha ~= 0 and not v9.copies[i]) then
                local v10 = v9:Copy(true);
                v9.copies[i] = v10;

                if not v2.isCanvas then
                    v10.offsets.set("alpha", "_playfieldOffset", v2.alpha);
                end;

                v10.parent = v2.Obj;
                table.insert(v2.Strums, v10);
            end;
        end;
    end;

    for _, v in Api.Notes do
        local v11 = v;

        for i, v2 in p7.Playfields do
            if v2.CopyNotes and (v2.alpha ~= 0 and not v11.copies[i]) then
                local v12 = v11:Copy(true);
                v11.copies[i] = v12;
                v12.parent = v2.Obj;

                if not v2.isCanvas then
                    v12.offsets.set("alpha", "_playfieldOffset", v2.alpha);
                end;

                table.insert(v2.Notes, v12);
                table.insert(v12.tablesStored, v2.Notes);
            end;
        end;
    end;

    for _, v in Api.NoteSplashes do
        local v13 = v;

        for i, v2 in p7.Playfields do
            if v2.CopySplashes and (v2.alpha ~= 0 and (v13.alive and not v13.copies[i])) then
                local v14 = v13:Copy(true);
                v13.copies[i] = v14;
                v14.parent = v2.Obj;

                if not v2.isCanvas then
                    v14.offsets.set("alpha", "_playfieldOffset", v2.alpha);
                end;

                table.insert(v2.Splashes, v14);
            end;
        end;
    end;
end;

function u1.clear(p15) -- Line: 142
    for _, v in p15.Playfields do
        local u16 = v;

        for _, v2 in v.Strums do
            v2:Destroy();
        end;

        for _, v2 in u16.Notes do
            v2:Destroy();
        end;

        for _, v2 in u16.Splashes do
            v2:Destroy();
        end;

        pcall(function() -- Line: 154
            -- upvalues: u16 (copy)
            u16.Obj:Destroy();
        end);
    end;

    table.clear(p15.Playfields);
end;

return u1;