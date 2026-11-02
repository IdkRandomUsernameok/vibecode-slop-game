-- Decompiled with Potassium's decompiler.

local function cfToId(p1) -- Line: 3
    return table.concat({ p1:GetComponents() }, ",");
end;

local u2 = require("./RigInfo");

return function(p3: userdata) -- Line: 9
    -- upvalues: u2 (copy)
    local v4 = p3:findFirstChildWhichIsA("AnimationController");
    local v5 = p3:FindFirstChildWhichIsA("Humanoid");

    if not (v5 or v4) then
        v5 = Instance.new("Humanoid");
        v5.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        Instance.new("Animator").Parent = v5;
        v5.Parent = p3;
    end;

    if v4 and not v4:FindFirstChildWhichIsA("Animator") then
        Instance.new("Animator").Parent = v4;
    end;

    if v5 and not v5:FindFirstChildWhichIsA("Animator") then
        Instance.new("Animator").Parent = v5;
    end;

    if v5 then
        v5.EvaluateStateMachine = false;
        v5.RequiresNeck = false;
        v5.AutoRotate = false;
        v5.AutoJumpEnabled = false;
        v5.BreakJointsOnDeath = false;

        for _, v in Enum.HumanoidStateType:GetEnumItems() do
            if v ~= Enum.HumanoidStateType.None then
                v5:SetStateEnabled(v, false);
            end;
        end;

        local function addMissing(p6: userdata, p7: any) -- Line: 51
            -- upvalues: addMissing (copy)
            for _, v in p7 do
                local v8 = p6:FindFirstChild(v.Name);

                if v8 then
                    addMissing(v8, v.Children or {});
                elseif not v.Instance:IsA("WrapTarget") or p6:IsA("MeshPart") then
                    v.Instance:Clone().Parent = p6;
                end;
            end;
        end;

        for i, v in (u2[v5.RigType.Name] or {}).DefaultStructure or {} do
            local v9 = p3:FindFirstChild(i);

            if v9 then
                addMissing(v9, v);
            end;
        end;
    end;

    if not p3.PrimaryPart then
        p3.PrimaryPart = p3:FindFirstChild("HumanoidRootPart") or (v5 and v5.RootPart or nil);

        if not p3.PrimaryPart then
            warn("(Character::NormalizeRig) No primary part ???");
        end;
    end;

    for _, v in p3:QueryDescendants("BasePart") do
        v.CanCollide = false;
        v.CanQuery = false;
        v.CanTouch = false;
        v.AudioCanCollide = false;
    end;

    local u10 = {};

    for _, v in p3:QueryDescendants("Attachment") do
        local Parent = v.Parent;
        local v11 = u10[Parent] or {};
        u10[Parent] = v11;
        v11[table.concat({ v.CFrame:GetComponents() }, ",")] = v;
    end;

    for _, v in p3:QueryDescendants("BallSocketConstraint, NoCollisionConstraint") do
        v:Destroy();
    end;

    local v12 = p3:QueryDescendants("Motor6D");
    table.sort(v12, function(p13: userdata, p14: userdata) -- Line: 135
        return p13:GetFullName() < p14:GetFullName();
    end);

    local function getAttachmentOrNew(p15, p16) -- Line: 108
        -- upvalues: u10 (copy)
        if p15 then
            local table_concat_ret = table.concat({ p16:GetComponents() }, ",");
            local v17 = u10[p15];
            local v18;

            if v17 then
                v18 = v17[table_concat_ret] or nil;
            else
                v18 = nil;
            end;

            if v18 then
                return v18;
            end;

            local Attachment = Instance.new("Attachment");
            Attachment.Name = `_{p15.Name}`;
            Attachment.CFrame = p16;
            Attachment.Parent = p15;

            if v17 then
                v17[table_concat_ret] = Attachment;

                return Attachment;
            end;

            u10[p15] = {
                [table_concat_ret] = Attachment
            };

            return Attachment;
        end;
    end;

    for _, v in v12 do
        if v.Part0 or v.Part1 then
            local AnimationConstraint = Instance.new("AnimationConstraint");
            AnimationConstraint.Name = v.Name;
            AnimationConstraint.Enabled = v.Enabled;
            AnimationConstraint.IsKinematic = true;
            local v19 = getAttachmentOrNew(v.Part0, v.C0);
            local v20 = getAttachmentOrNew(v.Part1, v.C1);
            AnimationConstraint.Attachment0 = v19;
            AnimationConstraint.Attachment1 = v20;
            AnimationConstraint.Parent = v.Parent;
            v:Destroy();
        else
            v:Destroy();
        end;
    end;
end;