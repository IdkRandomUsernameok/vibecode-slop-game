-- Decompiled with Potassium's decompiler.

return {
    MOUSE_LOCK_OPTION_COMPATIBILITY = true,
    USE_CONTEXT_ACTION = true,
    ROTATION_ENABLED = true,
    CAMERA_OFFSET_ENABLED = true,
    MOUSE_LOCK_ENABLED = true,
    CONTEXT_ACTION = {
        ACTION_NAME = "SmoothMouseLockSwitchAction",
        MOBILE_BUTTON = false,
        ACTION_PRIORITY = Enum.ContextActionPriority.High.Value,
        KEYBINDS = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift }
    },
    ROTATION = {
        ASSUME_USING_ROBLOX_CHARACTERS = true,
        SMOOTH = true,
        SMOOTH_SPEED = 25
    },
    CAMERA_OFFSET = {
        OFFSET = Vector3.new(1.75, 0.25, 0),
        SMOOTH = true,
        SMOOTH_DAMPER = 0.75,
        SMOOTH_SPEED_IN = 20,
        SMOOTH_SPEED_OUT = 25
    },
    MOUSE_LOCK = {
        MOUSE_ICON = "rbxassetid://9947313248",
        MOUSE_BEHAVIOUR = Enum.MouseBehavior.LockCenter
    }
};