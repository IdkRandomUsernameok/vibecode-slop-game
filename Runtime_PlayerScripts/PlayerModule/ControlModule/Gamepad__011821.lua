-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local UserFlag = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserPlayerScriptsSupportTVRemoteKeycodes");
local None = Enum.UserInputType.None;
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u1 = setmetatable({}, BaseCharacterController);
u1.__index = u1;

function u1.new(p2) -- Line: 26
    -- upvalues: BaseCharacterController (copy), u1 (copy), None (copy)
    local v3 = BaseCharacterController.new();
    local v4 = setmetatable(v3, u1);
    v4.CONTROL_ACTION_PRIORITY = p2;
    v4.forwardValue = 0;
    v4.backwardValue = 0;
    v4.leftValue = 0;
    v4.rightValue = 0;
    v4.thumbstickVector = Vector3.new(0, 0, 0);
    v4.activeGamepad = None;
    v4.gamepadConnectedConn = nil;
    v4.gamepadDisconnectedConn = nil;

    return v4;
end;

function u1.Enable(p5: table, p6: boolean) -- Line: 43
    -- upvalues: None (copy)
    if p6 == p5.enabled then
        return true;
    end;

    p5.forwardValue = 0;
    p5.backwardValue = 0;
    p5.leftValue = 0;
    p5.rightValue = 0;
    p5.thumbstickVector = Vector3.new(0, 0, 0);
    p5.moveVector = Vector3.new(0, 0, 0);
    p5.isJumping = false;

    if p6 then
        p5.activeGamepad = p5:GetHighestPriorityGamepad();

        if p5.activeGamepad == None then
            return false;
        end;

        p5:BindContextActions();
        p5:ConnectGamepadConnectionListeners();
    else
        p5:UnbindContextActions();
        p5:DisconnectGamepadConnectionListeners();
        p5.activeGamepad = None;
    end;

    p5.enabled = p6;

    return true;
end;

function u1.GetHighestPriorityGamepad(p7) -- Line: 80
    -- upvalues: UserInputService (copy), None (copy)
    local ConnectedGamepads = UserInputService:GetConnectedGamepads();
    local v8 = None;

    for _, v in pairs(ConnectedGamepads) do
        if v.Value < v8.Value then
            v8 = v;
        end;
    end;

    return v8;
end;

function u1.UpdateMovement(p9) -- Line: 91
    p9.moveVector = p9.thumbstickVector + Vector3.new(0, 0, p9.forwardValue + p9.backwardValue);
end;

function u1.BindContextActions(u10) -- Line: 95
    -- upvalues: None (copy), UserFlag (copy), ContextActionService (copy)
    if u10.activeGamepad == None then
        return false;
    end;

    local function v14(p11, p12, p13) -- Line: 102
        -- upvalues: u10 (copy)
        u10.isJumping = p12 == Enum.UserInputState.Begin;

        return Enum.ContextActionResult.Sink;
    end;

    local function v18(p15, p16, p17) -- Line: 107
        -- upvalues: UserFlag (ref), u10 (copy)
        if p16 == Enum.UserInputState.Cancel then
            if UserFlag then
                u10.thumbstickVector = Vector3.new(0, 0, 0);
                u10:UpdateMovement();
            else
                u10.moveVector = Vector3.new(0, 0, 0);
            end;

            return Enum.ContextActionResult.Sink;
        end;

        if u10.activeGamepad ~= p17.UserInputType then
            return Enum.ContextActionResult.Pass;
        end;

        if p17.KeyCode == Enum.KeyCode.Thumbstick1 then
            if UserFlag then
                if p17.Position.magnitude > 0.2 then
                    u10.thumbstickVector = Vector3.new(p17.Position.X, 0, -p17.Position.Y);
                else
                    u10.thumbstickVector = Vector3.new(0, 0, 0);
                end;

                u10:UpdateMovement();
            elseif p17.Position.magnitude > 0.2 then
                u10.moveVector = Vector3.new(p17.Position.X, 0, -p17.Position.Y);
            else
                u10.moveVector = Vector3.new(0, 0, 0);
            end;

            return Enum.ContextActionResult.Sink;
        end;
    end;

    local function v23(p19, p20, p21) -- Line: 141
        -- upvalues: u10 (copy)
        if p20 == Enum.UserInputState.Cancel then
            u10.forwardValue = 0;
            u10.backwardValue = 0;
            u10:UpdateMovement();

            return Enum.ContextActionResult.Sink;
        end;

        local v22 = p21.Position.magnitude <= 0.2 and 0 or p21.Position.Z;

        if p21.KeyCode == Enum.KeyCode.ButtonUp then
            u10.forwardValue = -v22;
        elseif p21.KeyCode == Enum.KeyCode.ButtonDown then
            u10.backwardValue = v22;
        end;

        u10:UpdateMovement();

        return Enum.ContextActionResult.Sink;
    end;

    ContextActionService:BindActivate(u10.activeGamepad, Enum.KeyCode.ButtonR2);

    if UserFlag then
        ContextActionService:BindActionAtPriority("jumpAction", v14, false, u10.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA, Enum.KeyCode.ButtonCenter);
        ContextActionService:BindActionAtPriority("moveDirectionalButton", v23, false, u10.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonUp, Enum.KeyCode.ButtonDown);
    else
        ContextActionService:BindActionAtPriority("jumpAction", v14, false, u10.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA);
    end;

    ContextActionService:BindActionAtPriority("moveThumbstick", v18, false, u10.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1);

    return true;
end;

function u1.UnbindContextActions(p24) -- Line: 180
    -- upvalues: None (copy), ContextActionService (copy), UserFlag (copy)
    if p24.activeGamepad ~= None then
        ContextActionService:UnbindActivate(p24.activeGamepad, Enum.KeyCode.ButtonR2);
    end;

    if UserFlag then
        ContextActionService:UnbindAction("moveDirectionalButton");
    end;

    ContextActionService:UnbindAction("moveThumbstick");
    ContextActionService:UnbindAction("jumpAction");
end;

function u1.OnNewGamepadConnected(p25) -- Line: 191
    -- upvalues: None (copy)
    local HighestPriorityGamepad = p25:GetHighestPriorityGamepad();

    if HighestPriorityGamepad == p25.activeGamepad then
        return;
    end;

    if HighestPriorityGamepad == None then
        warn("Gamepad:OnNewGamepadConnected found no connected gamepads");
        p25:UnbindContextActions();

        return;
    end;

    if p25.activeGamepad ~= None then
        p25:UnbindContextActions();
    end;

    p25.activeGamepad = HighestPriorityGamepad;
    p25:BindContextActions();
end;

function u1.OnCurrentGamepadDisconnected(p26) -- Line: 218
    -- upvalues: None (copy), ContextActionService (copy)
    if p26.activeGamepad ~= None then
        ContextActionService:UnbindActivate(p26.activeGamepad, Enum.KeyCode.ButtonR2);
    end;

    local HighestPriorityGamepad = p26:GetHighestPriorityGamepad();

    if p26.activeGamepad == None or HighestPriorityGamepad ~= p26.activeGamepad then
        if HighestPriorityGamepad == None then
            p26:UnbindContextActions();
            p26.activeGamepad = None;

            return;
        end;

        p26.activeGamepad = HighestPriorityGamepad;
        ContextActionService:BindActivate(p26.activeGamepad, Enum.KeyCode.ButtonR2);

        return;
    end;

    warn("Gamepad:OnCurrentGamepadDisconnected found the supposedly disconnected gamepad in connectedGamepads.");
    p26:UnbindContextActions();
    p26.activeGamepad = None;
end;

function u1.ConnectGamepadConnectionListeners(u27) -- Line: 243
    -- upvalues: UserInputService (copy)
    u27.gamepadConnectedConn = UserInputService.GamepadConnected:Connect(function(p28) -- Line: 244
        -- upvalues: u27 (copy)
        u27:OnNewGamepadConnected();
    end);
    u27.gamepadDisconnectedConn = UserInputService.GamepadDisconnected:Connect(function(p29) -- Line: 248
        -- upvalues: u27 (copy)
        if u27.activeGamepad == p29 then
            u27:OnCurrentGamepadDisconnected();
        end;
    end);
end;

function u1.DisconnectGamepadConnectionListeners(p30) -- Line: 255
    if p30.gamepadConnectedConn then
        p30.gamepadConnectedConn:Disconnect();
        p30.gamepadConnectedConn = nil;
    end;

    if p30.gamepadDisconnectedConn then
        p30.gamepadDisconnectedConn:Disconnect();
        p30.gamepadDisconnectedConn = nil;
    end;
end;

return u1;