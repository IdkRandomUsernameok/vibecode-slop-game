-- Decompiled with Potassium's decompiler.

local function invert_table(p1) -- Line: 39
    local v2 = {};

    for i in p1 do
        v2[p1[i]] = i;
    end;

    return v2;
end;

local table_pack = table.pack;
local table_unpack = table.unpack;
local Instance_new = Instance.new;
local Vector2_new = Vector2.new;
local Vector3_new = Vector3.new;
local Color3_new = Color3.new;
local ColorSequence_new = ColorSequence.new;
local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
local CFrame_new = CFrame.new;
local NumberRange_new = NumberRange.new;
local NumberSequenceKeypoint_new = NumberSequenceKeypoint.new;
local NumberSequence_new = NumberSequence.new;
local Lighting = game:GetService("Lighting");
local u3 = {
    Folder = { "Name" },
    Model = { "Name", "PrimaryPart", "WorldPivot" },
    SpecialMesh = { "MeshId", "MeshType", "Name", "Offset", "Scale", "TextureId" },
    BlockMesh = { "Name", "Offset", "Scale", "VertexColor" },
    CylinderMesh = { "Name", "Offset", "Scale", "VertexColor" },
    Weld = { "C0", "C1", "Name", "Part0", "Part1", "Enabled" },
    Snap = { "C0", "C1", "Name", "Part0", "Part1", "Enabled" },
    Part = { "CastShadow", "Color", "Material", "Reflectance", "Transparency", "Locked", "Name", "Size", "Position", "Rotation", "CanCollide", "Anchored", "Shape", "BackSurface", "BottomSurface", "FrontSurface", "LeftSurface", "RightSurface", "TopSurface" },
    WedgePart = { "CastShadow", "Color", "Material", "Reflectance", "Transparency", "Locked", "Name", "Size", "Position", "Rotation", "CanCollide", "Anchored", "BackSurface", "BottomSurface", "FrontSurface", "LeftSurface", "RightSurface", "TopSurface" },
    CornerWedgePart = { "CastShadow", "Color", "Material", "Reflectance", "Transparency", "Locked", "Name", "Size", "Position", "Rotation", "CanCollide", "Anchored", "BackSurface", "BottomSurface", "FrontSurface", "LeftSurface", "RightSurface", "TopSurface" },
    TrussPart = { "CastShadow", "Color", "Material", "Reflectance", "Transparency", "Locked", "Name", "Size", "Position", "Rotation", "CanCollide", "Anchored", "Shape", "BackSurface", "BottomSurface", "FrontSurface", "LeftSurface", "RightSurface", "TopSurface" },
    SpawnLocation = { "CastShadow", "Color", "Material", "Reflectance", "Transparency", "Locked", "Name", "Size", "Position", "Rotation", "CanCollide", "Anchored", "Shape", "BackSurface", "BottomSurface", "FrontSurface", "LeftSurface", "RightSurface", "TopSurface", "Duration", "AllowTeamChangeOnTouch", "Neutral", "TeamColor" },
    Seat = { "CastShadow", "Color", "Material", "Reflectance", "Transparency", "Locked", "Name", "Size", "Position", "Rotation", "CanCollide", "Anchored", "Shape", "BackSurface", "BottomSurface", "FrontSurface", "LeftSurface", "RightSurface", "TopSurface", "Disabled" },
    VehicleSeat = { "CastShadow", "Color", "Material", "Reflectance", "Transparency", "Locked", "Name", "Size", "Position", "Rotation", "CanCollide", "Anchored", "Shape", "BackSurface", "BottomSurface", "FrontSurface", "LeftSurface", "RightSurface", "TopSurface", "Disabled", "HeadsUpDisplay", "MaxSpeed", "Steer", "SteerFloat", "Throttle", "ThrottleFloat", "Torque", "TurnSpeed" },
    Decal = { "Color3", "Texture", "Transparency", "ZIndex", "Face", "Name" },
    Texture = { "Color3", "OffsetStudsU", "OffsetStudsV", "StudsPerTileU", "StudsPerTileV", "Texture", "Transparency", "ZIndex", "Face", "Name" },
    ClickDetector = { "MaxActivationDistance", "Name", "CursorIcon" },
    PointLight = { "Brightness", "Color", "Enabled", "Range", "Shadows", "Name" },
    SpotLight = { "Angle", "Brightness", "Color", "Enabled", "Face", "Range", "Shadows", "Name" },
    SurfaceLight = { "Angle", "Brightness", "Color", "Enabled", "Face", "Range", "Shadows", "Name" },
    Fire = { "Color", "Enabled", "Heat", "Name", "SecondaryColor", "Size", "TimeScale" },
    Smoke = { "Color", "Enabled", "Name", "Opacity", "RiseVelocity", "Size", "TimeScale" },
    Sparkles = { "Enabled", "Name", "SparkleColor", "TimeScale" },
    ParticleEmitter = { "Color", "LightEmission", "LightInfluence", "Orientation", "Size", "Squash", "Texture", "Transparency", "ZOffset", "Name", "EmissionDirection", "Enabled", "Lifetime", "Rate", "Rotation", "RotSpeed", "Speed", "SpreadAngle", "Shape", "ShapeInOut", "ShapeStyle", "FlipbookLayout", "Acceleration", "Drag", "LockedToPart", "TimeScale", "VelocityInheritance", "WindAffectsDrag" },
    Beam = { "Color", "Enabled", "LightEmission", "LightInfluence", "Texture", "TextureLength", "TextureMode", "TextureSpeed", "Transparency", "ZOffset", "Name", "Attachment0", "Attachment1", "CurveSize0", "CurveSize1", "FaceCamera", "Segments", "Width0", "Width1" },
    Attachment = { "Visible", "Name", "CFrame" },
    HumanoidDescription = { "BackAccessory", "FaceAccessory", "FrontAccessory", "HairAccessory", "HatAccessory", "NeckAccessory", "ShouldersAccessory", "WaistAccessory", "ClimbAnimation", "FallAnimation", "IdleAnimation", "JumpAnimation", "MoodAnimation", "RunAnimation", "SwimAnimation", "WalkAnimation", "HeadColor", "LeftArmColor", "LeftLegColor", "RightArmColor", "RightLegColor", "TorsoColor", "Face", "Head", "LeftArm", "LeftLeg", "RightArm", "RightLeg", "Torso", "GraphicTShirt", "Pants", "Shirt", "BodyTypeScale", "DepthScale", "HeadScale", "HeightScale", "ProportionScale", "WidthScale" },
    AccessoryDescription = { "AccessoryType", "AssetId", "IsLayered", "Order", "Position", "Puffiness", "Rotation", "Scale" },
    BodyPartDescription = { "AssetId", "BodyPart", "Color" }
};
local u4 = {};

for i in u3 do
    u4[#u4 + 1] = i;
end;

local u5 = {};

for i in u4 do
    u5[u4[i]] = i;
end;

local u6 = { "string", "number", "boolean", "NumberRange", "NumberSequence", "Vector2", "Vector3", "Color3", "ColorSequence", "EnumItem", "CFrame", "Instance" };
local u7 = {};

for i in u6 do
    u7[u6[i]] = i;
end;

local u8 = {};

for i in u3 do
    u8[i] = Instance_new(i);
end;

local u9 = false;
local u10 = nil;
local u11 = 0;
local u12 = {};
local u13 = 0;
local u14 = {};
local u15 = 0;
local u16 = {};

local function reset_internal_variables() -- Line: 572
    -- upvalues: u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref)
    u10 = nil;
    u11 = 0;
    u12 = {};
    u13 = 0;
    u14 = {};
    u15 = 0;
    u16 = {};
end;

local function build_uid_reference(p17) -- Line: 585
    -- upvalues: u11 (ref), u12 (ref), build_uid_reference (copy)
    u11 = u11 + 1;
    u12[p17] = u11;
    local Children = p17:GetChildren();

    for i in Children do
        build_uid_reference(Children[i]);
    end;
end;

local function serialize_property(p18) -- Line: 598
    -- upvalues: u7 (copy), table_pack (copy), u10 (ref), u12 (ref)
    local v19 = typeof(p18);
    local v20 = u7[v19];

    if not v20 then
        return nil;
    end;

    local v21 = nil;

    if v19 == "EnumItem" then
        v21 = p18.Value;
    elseif v19 == "Vector3" then
        v21 = { p18.X, p18.Y, p18.Z };
    elseif v19 == "boolean" then
        v21 = p18;
    elseif v19 == "Color3" then
        v21 = { p18.R, p18.G, p18.B };
    elseif v19 == "number" or v19 == "string" then
        v21 = p18;
    elseif v19 == "CFrame" then
        v21 = table_pack(p18:GetComponents());
    elseif v19 == "Instance" then
        if not p18:IsDescendantOf(u10) then
            warn("Object-type property references \'" .. p18.Name .. "\' which is not in the serialization scope.");

            return nil;
        end;

        v21 = u12[p18];
    elseif v19 == "Vector2" then
        v21 = { p18.X, p18.Y };
    elseif v19 == "ColorSequence" then
        local Keypoints = p18.Keypoints;
        v21 = {};

        for i in Keypoints do
            local v22 = Keypoints[i];
            local Value = v22.Value;
            v21[i] = {
                v22.Time,
                Value.R,
                Value.G,
                Value.B
            };
        end;
    elseif v19 == "NumberRange" then
        v21 = { p18.Min, p18.Max };
    elseif v19 == "NumberSequence" then
        local Keypoints = p18.Keypoints;
        v21 = {};

        for i in Keypoints do
            local v23 = Keypoints[i];
            v21[i] = { v23.Time, v23.Value, v23.Envelope };
        end;
    end;

    return { v20, v21 };
end;

local function serialize_instance(p24) -- Line: 675
    -- upvalues: u3 (copy), u8 (copy), serialize_property (copy), u14 (ref), u13 (ref), serialize_instance (copy), u12 (ref), u5 (copy)
    local ClassName = p24.ClassName;
    local v25 = u3[ClassName];
    local v26 = {};

    for i in v25 do
        local v27 = v25[i];

        if u8[ClassName][v27] ~= p24[v27] then
            v26[v27] = serialize_property(p24[v27]);
        end;
    end;

    local Children = p24:GetChildren();
    local v28 = 0;
    local v29 = {};

    for i in Children do
        local v30 = Children[i];

        if u3[v30.ClassName] then
            v28 = v28 + 1;
            v29[v28] = serialize_instance(v30);
        else
            u14[v30.ClassName] = 1;
            u13 = u13 + 1;
        end;
    end;

    return {
        u12[p24],
        u5[ClassName],
        v26,
        v29
    };
end;

local function post_deserialize_link_pass() -- Line: 717
    -- upvalues: u16 (ref), u12 (ref)
    for i in u16 do
        local v31 = u16[i];
        v31[1][v31[2]] = u12[v31[3]];
    end;
end;

local function deserialize_property(p32, p33, p34) -- Line: 725
    -- upvalues: u6 (copy), Vector3_new (copy), Color3_new (copy), CFrame_new (copy), table_unpack (copy), u15 (ref), u16 (ref), Vector2_new (copy), ColorSequenceKeypoint_new (copy), ColorSequence_new (copy), NumberRange_new (copy), NumberSequenceKeypoint_new (copy), NumberSequence_new (copy)
    local v35 = u6[p32[1]];
    local v36 = p32[2];
    local v37 = nil;

    if v35 == "EnumItem" then
        return v36;
    end;

    if v35 == "Vector3" then
        return Vector3_new(v36[1], v36[2], v36[3]);
    end;

    if v35 == "boolean" then
        return v36;
    end;

    if v35 == "Color3" then
        return Color3_new(v36[1], v36[2], v36[3]);
    end;

    if v35 == "number" then
        return v36;
    end;

    if v35 == "string" then
        return v36;
    end;

    if v35 == "CFrame" then
        return CFrame_new(table_unpack(v36));
    end;

    if v35 == "Instance" then
        u15 = u15 + 1;
        u16[u15] = { p34, p33, v36 };

        return v37;
    end;

    if v35 == "Vector2" then
        return Vector2_new(v36.X, v36.Y);
    end;

    if v35 == "ColorSequence" then
        local v38 = {};

        for i in v36 do
            local v39 = v36[i];
            v38[i] = ColorSequenceKeypoint_new(v39[1], Color3_new(v39[2], v39[3], v39[4]));
        end;

        return ColorSequence_new(v38);
    end;

    if v35 == "NumberRange" then
        return NumberRange_new(v36[1], v36[2]);
    end;

    if v35 == "NumberSequence" then
        local v40 = {};

        for i in v36 do
            local v41 = v36[i];
            v40[i] = NumberSequenceKeypoint_new(v41[1], v41[2], v41[3]);
        end;

        v37 = NumberSequence_new(v40);
    end;

    return v37;
end;

local function deserialize_instance(p42, p43) -- Line: 792
    -- upvalues: Instance_new (copy), u4 (copy), deserialize_instance (copy), deserialize_property (copy), u12 (ref), Lighting (copy)
    local v44 = Instance_new(u4[p42[2]]);

    for i in p42[4] do
        deserialize_instance(p42[4][i], v44);
    end;

    for i in p42[3] do
        v44[i] = deserialize_property(p42[3][i], i, v44);
    end;

    u12[p42[1]] = v44;
    v44.Parent = p43 or Lighting;

    return v44;
end;

return {
    serialize = function(p45) -- Line: 815, Name: serialize
        -- upvalues: u3 (copy), reset_internal_variables (copy), u11 (ref), u12 (ref), build_uid_reference (copy), serialize_instance (copy), u13 (ref), u9 (ref), u14 (ref)
        if not u3[p45.ClassName] then
            warn("Given instance was not serializable");

            return nil;
        end;

        reset_internal_variables();
        u11 = u11 + 1;
        u12[p45] = u11;
        local Children = p45:GetChildren();

        for i in Children do
            build_uid_reference(Children[i]);
        end;

        local v46 = serialize_instance(p45);

        if u13 ~= 0 and u9 then
            warn("ROSE - Some instance(s) were not serialized:");

            for i in u14 do
                warn("    Type \'" .. i .. "\'");
            end;
        end;

        return {
            version = 2,
            tree = v46
        };
    end,

    deserialize = function(p47) -- Line: 840, Name: deserialize
        -- upvalues: reset_internal_variables (copy), deserialize_instance (copy), u16 (ref), u12 (ref)
        if p47.version ~= 2 then
            warn("ROSE packet provided was generated by an older version of ROSE.");

            return nil;
        end;

        reset_internal_variables();
        local v48 = deserialize_instance(p47.tree);

        for i in u16 do
            local v49 = u16[i];
            v49[1][v49[2]] = u12[v49[3]];
        end;

        return v48;
    end,

    give_warnings = function(p50: boolean) -- Line: 855, Name: give_warnings
        -- upvalues: u9 (ref)
        u9 = p50;
    end
};