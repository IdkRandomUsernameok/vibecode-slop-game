-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);

return function(u1) -- Line: 3
    local u2 = u1.State(true);
    local u3 = u1.State(false);
    local u4 = u1.State(false);
    local u5 = u1.State(false);
    local u6 = u1.State(false);
    local u7 = u1.State(false);
    local u8 = u1.State(false);

    local function helpMarker(p9: string) -- Line: 12
        -- upvalues: u1 (copy)
        u1.PushConfig({
            TextColor = u1._config.TextDisabledColor
        });
        local v10 = u1.Text({ "(?)" });
        u1.PopConfig();
        u1.PushConfig({
            ContentWidth = UDim.new(0, 350)
        });

        if v10.hovered() then
            u1.Tooltip({ p9 });
        end;

        u1.PopConfig();
    end;

    local function textAndHelpMarker(p11: string, p12: string) -- Line: 24
        -- upvalues: u1 (copy), helpMarker (copy)
        u1.SameLine();
        u1.Text({ p11 });
        helpMarker(p12);
        u1.End();
    end;

    local u75 = {
        Basic = function() -- Line: 35, Name: Basic
            -- upvalues: u1 (copy)
            u1.Tree({ "Basic" });
            u1.SeparatorText({ "Basic" });
            local v13 = u1.State(1);
            u1.Button({ "Button" });
            u1.SmallButton({ "SmallButton" });
            u1.Text({ "Text" });
            u1.TextWrapped({ string.rep("Text Wrapped ", 5) });
            u1.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) });
            u1.Text({ "Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>", true, nil, true });
            u1.SameLine();
            u1.RadioButton({ "Index \'1\'", 1 }, {
                index = v13
            });
            u1.RadioButton({ "Index \'two\'", "two" }, {
                index = v13
            });

            if u1.RadioButton({ "Index \'false\'", false }, {
                index = v13
            }).active() == false and u1.SmallButton({ "Select last" }).clicked() then
                v13:set(false);
            end;

            u1.End();
            u1.Text({ "The Index is: " .. tostring(v13.value) });
            u1.SeparatorText({ "Inputs" });
            u1.InputNum({});
            u1.DragNum({});
            u1.SliderNum({});
            u1.End();
        end,

        Image = function() -- Line: 71, Name: Image
            -- upvalues: u1 (copy)
            u1.Tree({ "Image" });
            u1.SeparatorText({ "Image Controls" });
            local v14 = u1.State("rbxasset://textures/ui/common/robux.png");
            local v15 = u1.State(UDim2.fromOffset(100, 100));
            local v16 = u1.State(Rect.new(0, 0, 0, 0));
            local v17 = u1.State(Enum.ScaleType.Stretch);
            local v18 = u1.State(false);
            local v20 = u1.ComputedState(v18, function(p19: boolean) -- Line: 81
                return p19 and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default;
            end);
            local v21 = u1.State(u1._config.ImageColor);
            local v22 = u1.State(u1._config.ImageTransparency);
            u1.InputColor4({ "Image Tint" }, {
                color = v21,
                transparency = v22
            });
            u1.Combo({ "Asset" }, {
                index = v14
            });
            u1.Selectable({ "Robux Small", "rbxasset://textures/ui/common/robux.png" }, {
                index = v14
            });
            u1.Selectable({ "Robux Large", "rbxasset://textures//ui/common/robux@3x.png" }, {
                index = v14
            });
            u1.Selectable({ "Loading Texture", "rbxasset://textures//loading/darkLoadingTexture.png" }, {
                index = v14
            });
            u1.Selectable({ "Hue-Saturation Gradient", "rbxasset://textures//TagEditor/huesatgradient.png" }, {
                index = v14
            });
            u1.Selectable({ "famfamfam.png (WHY?)", "rbxasset://textures//TagEditor/famfamfam.png" }, {
                index = v14
            });
            u1.End();
            u1.SliderUDim2({
                "Image Size",
                nil,
                nil,
                UDim2.new(1, 240, 1, 240)
            }, {
                number = v15
            });
            u1.SliderRect({
                "Image Rect",
                nil,
                nil,
                Rect.new(256, 256, 256, 256)
            }, {
                number = v16
            });
            u1.Combo({ "Scale Type" }, {
                index = v17
            });
            u1.Selectable({ "Stretch", Enum.ScaleType.Stretch }, {
                index = v17
            });
            u1.Selectable({ "Fit", Enum.ScaleType.Fit }, {
                index = v17
            });
            u1.Selectable({ "Crop", Enum.ScaleType.Crop }, {
                index = v17
            });
            u1.End();
            u1.Checkbox({ "Pixelated" }, {
                isChecked = v18
            });
            u1.PushConfig({
                ImageColor = v21:get(),
                ImageTransparency = v22:get()
            });
            u1.Image({
                v14:get(),
                v15:get(),
                v16:get(),
                v17:get(),
                v20:get()
            });
            u1.PopConfig();
            u1.SeparatorText({ "Tile" });
            local v23 = u1.State(UDim2.fromScale(0.5, 0.5));
            u1.SliderUDim2({
                "Tile Size",
                nil,
                nil,
                UDim2.new(1, 240, 1, 240)
            }, {
                number = v23
            });
            u1.PushConfig({
                ImageColor = v21:get(),
                ImageTransparency = v22:get()
            });
            u1.Image({
                "rbxasset://textures/grid2.png",
                v15:get(),
                nil,
                Enum.ScaleType.Tile,
                v20:get(),
                v23:get()
            });
            u1.PopConfig();
            u1.SeparatorText({ "Slice" });
            local v24 = u1.State(1);
            u1.SliderNum({ "Image Slice Scale", 0.1, 0.1, 5 }, {
                number = v24
            });
            u1.PushConfig({
                ImageColor = v21:get(),
                ImageTransparency = v22:get()
            });
            u1.Image({
                "rbxasset://textures/ui/chatBubble_blue_notify_bkg.png",
                v15:get(),
                nil,
                Enum.ScaleType.Slice,
                v20:get(),
                nil,
                Rect.new(12, 12, 56, 56),
                1
            }, v24:get());
            u1.PopConfig();
            u1.SeparatorText({ "Image Button" });
            local v25 = u1.State(0);
            u1.SameLine();
            u1.PushConfig({
                ImageColor = v21:get(),
                ImageTransparency = v22:get()
            });

            if u1.ImageButton({ "rbxasset://textures/AvatarCompatibilityPreviewer/add.png", UDim2.fromOffset(20, 20) }).clicked() then
                v25:set(v25.value + 1);
            end;

            u1.PopConfig();
            u1.Text({ (`Click count: {v25.value}`) });
            u1.End();
            u1.End();
        end,

        Selectable = function() -- Line: 162, Name: Selectable
            -- upvalues: u1 (copy)
            u1.Tree({ "Selectable" });
            local v26 = u1.State(2);
            u1.Selectable({ "Selectable #1", 1 }, {
                index = v26
            });
            u1.Selectable({ "Selectable #2", 2 }, {
                index = v26
            });

            if u1.Selectable({ "Double click Selectable", 3, true }, {
                index = v26
            }).doubleClicked() then
                v26:set(3);
            end;

            u1.Selectable({ "Impossible to select", 4, true }, {
                index = v26
            });

            if u1.Button({ "Select last" }).clicked() then
                v26:set(4);
            end;

            u1.Selectable({ "Independent Selectable" });
            u1.End();
        end,

        Combo = function() -- Line: 182, Name: Combo
            -- upvalues: u1 (copy)
            u1.Tree({ "Combo" });
            u1.PushConfig({
                ContentWidth = UDim.new(1, -200)
            });
            local v27 = u1.State("No Selection");
            u1.SameLine();
            local v28 = u1.Checkbox({ "No Preview" });
            local v29 = u1.Checkbox({ "No Button" });

            if v28.checked() and v29.isChecked.value == true then
                v29.isChecked:set(false);
            end;

            if v29.checked() and v28.isChecked.value == true then
                v28.isChecked:set(false);
            end;

            u1.End();
            u1.Combo({ "Basic Usage", v29.isChecked:get(), v28.isChecked:get() }, {
                index = v27
            });
            u1.Selectable({ "Select 1", "One" }, {
                index = v27
            });
            u1.Selectable({ "Select 2", "Two" }, {
                index = v27
            });
            u1.Selectable({ "Select 3", "Three" }, {
                index = v27
            });
            u1.End();
            u1.ComboArray({ "Using ComboArray" }, {
                index = "No Selection"
            }, { "Red", "Green", "Blue" });
            local v30 = u1.State("7 AM");
            u1.Combo({ "Combo with Inner widgets" }, {
                index = v30
            });
            u1.Tree({ "Morning Shifts" });
            u1.Selectable({ "Shift at 7 AM", "7 AM" }, {
                index = v30
            });
            u1.Selectable({ "Shift at 11 AM", "11 AM" }, {
                index = v30
            });
            u1.Selectable({ "Shift at 3 PM", "3 PM" }, {
                index = v30
            });
            u1.End();
            u1.Tree({ "Night Shifts" });
            u1.Selectable({ "Shift at 6 PM", "6 PM" }, {
                index = v30
            });
            u1.Selectable({ "Shift at 9 PM", "9 PM" }, {
                index = v30
            });
            u1.End();
            u1.End();
            local v31 = u1.ComboEnum({ "Using ComboEnum" }, {
                index = Enum.UserInputState.Begin
            }, Enum.UserInputState);
            u1.Text({ "Selected: " .. v31.index:get().Name });
            u1.PopConfig();
            u1.End();
        end,

        Tree = function() -- Line: 239, Name: Tree
            -- upvalues: u1 (copy), helpMarker (copy)
            u1.Tree({ "Trees" });
            u1.Tree({ "Tree using SpanAvailWidth", true });
            helpMarker("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area");
            u1.End();
            local v32 = u1.Tree({ "Tree with Children" });
            u1.Text({ "Im inside the first tree!" });
            u1.Button({ "Im a button inside the first tree!" });
            u1.Tree({ "Im a tree inside the first tree!" });
            u1.Text({ "I am the innermost text!" });
            u1.End();
            u1.End();
            u1.Checkbox({ "Toggle above tree" }, {
                isChecked = v32.state.isUncollapsed
            });
            u1.End();
        end,

        CollapsingHeader = function() -- Line: 265, Name: CollapsingHeader
            -- upvalues: u1 (copy)
            u1.Tree({ "Collapsing Headers" });
            u1.CollapsingHeader({ "A header" });
            u1.Text({ "This is under the first header!" });
            u1.End();
            local v33 = u1.State(false);
            u1.CollapsingHeader({ "Another header" }, {
                isUncollapsed = v33
            });

            if u1.Button({ "Shhh... secret button!" }).clicked() then
                v33:set(true);
            end;

            u1.End();
            u1.End();
        end,

        Group = function() -- Line: 286, Name: Group
            -- upvalues: u1 (copy)
            u1.Tree({ "Groups" });
            u1.SameLine();
            u1.Group();
            u1.Text({ "I am in group A" });
            u1.Button({ "Im also in A" });
            u1.End();
            u1.Separator();
            u1.Group();
            u1.Text({ "I am in group B" });
            u1.Button({ "Im also in B" });
            u1.Button({ "Also group B" });
            u1.End();
            u1.End();
            u1.End();
        end,

        Tab = function() -- Line: 313, Name: Tab
            -- upvalues: u1 (copy)
            u1.Tree({ "Tabs" });
            u1.Tree({ "Simple" });
            u1.TabBar();
            u1.Tab({ "Apples" });
            u1.Text({ "Who loves apples?" });
            u1.End();
            u1.Tab({ "Broccoli" });
            u1.Text({ "And what about broccoli?" });
            u1.End();
            u1.Tab({ "Carrots" });
            u1.Text({ "But carrots are the best." });
            u1.End();
            u1.End();
            u1.Separator();
            u1.Text({ "Very important questions." });
            u1.End();
            u1.Tree({ "Closable" });
            local v34 = u1.State(true);
            local v35 = u1.State(true);
            local v36 = u1.State(true);
            u1.TabBar();
            u1.Tab({ "🍎", true }, {
                isOpened = v34
            });
            u1.Text({ "Who loves apples?" });

            if u1.Button({ "I don\'t like apples." }).clicked() then
                v34:set(false);
            end;

            u1.End();
            u1.Tab({ "🥦", true }, {
                isOpened = v35
            });
            u1.Text({ "And what about broccoli?" });

            if u1.Button({ "Not for me." }).clicked() then
                v35:set(false);
            end;

            u1.End();
            u1.Tab({ "🥕", true }, {
                isOpened = v36
            });
            u1.Text({ "But carrots are the best." });

            if u1.Button({ "I disagree with you." }).clicked() then
                v36:set(false);
            end;

            u1.End();
            u1.End();
            u1.Separator();

            if u1.Button({ "Actually, let me reconsider it." }).clicked() then
                v34:set(true);
                v35:set(true);
                v36:set(true);
            end;

            u1.End();
            u1.End();
        end,

        Indent = function() -- Line: 388, Name: Indent
            -- upvalues: u1 (copy)
            u1.Tree({ "Indents" });
            u1.Text({ "Not Indented" });
            u1.Indent();
            u1.Text({ "Indented" });
            u1.Indent({ 7 });
            u1.Text({ "Indented by 7 more pixels" });
            u1.End();
            u1.Indent({ -7 });
            u1.Text({ "Indented by 7 less pixels" });
            u1.End();
            u1.End();
            u1.End();
        end,

        Input = function() -- Line: 410, Name: Input
            -- upvalues: u1 (copy), helpMarker (copy)
            u1.Tree({ "Input" });
            local v37 = u1.State(false);
            local v38 = u1.State(false);
            local v39 = u1.State(0);
            local v40 = u1.State(100);
            local v41 = u1.State(1);
            local v42 = u1.State("%d");
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            local v43 = u1.InputNum({
                [u1.Args.InputNum.Text] = "Input Number",
                [u1.Args.InputNum.NoButtons] = v38.value,
                [u1.Args.InputNum.Min] = v39.value,
                [u1.Args.InputNum.Max] = v40.value,
                [u1.Args.InputNum.Increment] = v41.value,
                [u1.Args.InputNum.Format] = { v42.value }
            });
            u1.PopConfig();
            u1.Text({ "The Value is: " .. v43.number.value });

            if u1.Button({ "Randomize Number" }).clicked() then
                v43.number:set(math.random(1, 99));
            end;

            local v44 = u1.Checkbox({ "NoField" }, {
                isChecked = v37
            });
            local v45 = u1.Checkbox({ "NoButtons" }, {
                isChecked = v38
            });

            if v44.checked() and v45.isChecked.value == true then
                v45.isChecked:set(false);
            end;

            if v45.checked() and v44.isChecked.value == true then
                v44.isChecked:set(false);
            end;

            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.InputVector2({ "InputVector2" });
            u1.InputVector3({ "InputVector3" });
            u1.InputUDim({ "InputUDim" });
            u1.InputUDim2({ "InputUDim2" });
            local v46 = u1.State(false);
            local v47 = u1.State(false);
            local v48 = u1.State(Color3.new());
            local v49 = u1.State(0);
            u1.SliderNum({ "Transparency", 0.01, 0, 1 }, {
                number = v49
            });
            u1.InputColor3({ "InputColor3", v46:get(), v47:get() }, {
                color = v48
            });
            u1.InputColor4({ "InputColor4", v46:get(), v47:get() }, {
                color = v48,
                transparency = v49
            });
            u1.SameLine();
            u1.Text({ v48:get():ToHex() });
            u1.Checkbox({ "Use Floats" }, {
                isChecked = v46
            });
            u1.Checkbox({ "Use HSV" }, {
                isChecked = v47
            });
            u1.End();
            u1.PopConfig();
            u1.Separator();
            u1.SameLine();
            u1.Text({ "Slider Numbers" });
            helpMarker("ctrl + click slider number widgets to input a number");
            u1.End();
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.SliderNum({ "Slide Int", 1, 1, 8 });
            u1.SliderNum({ "Slide Float", 0.01, 0, 100 });
            u1.SliderNum({ "Small Numbers", 0.001, -2, 1, "%f radians" });
            u1.SliderNum({ "Odd Ranges", 0.001, -3.141592653589793, 3.141592653589793, "%f radians" });
            u1.SliderNum({ "Big Numbers", 10000, 100000, 10000000 });
            u1.SliderNum({ "Few Numbers", 1, 0, 3 });
            u1.PopConfig();
            u1.Separator();
            u1.SameLine();
            u1.Text({ "Drag Numbers" });
            helpMarker("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed");
            u1.End();
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.DragNum({ "Drag Int" });
            u1.DragNum({ "Slide Float", 0.001, -10, 10 });
            u1.DragNum({ "Percentage", 1, 0, 100, "%d %%" });
            u1.PopConfig();
            u1.End();
        end,

        InputText = function() -- Line: 493, Name: InputText
            -- upvalues: u1 (copy)
            u1.Tree({ "Input Text" });
            local v50 = u1.InputText({ "Input Text Test", "Input Text here" });
            u1.Text({ "The text is: " .. v50.text.value });
            u1.End();
        end,

        MultiInput = function() -- Line: 502, Name: MultiInput
            -- upvalues: u1 (copy)
            u1.Tree({ "Multi-Component Input" });
            local v51 = u1.State(Vector2.new());
            local v52 = u1.State((Vector3.new()));
            local v53 = u1.State(UDim.new());
            local v54 = u1.State(UDim2.new());
            local v55 = u1.State(Color3.new());
            local v56 = u1.State(Rect.new(0, 0, 0, 0));
            u1.SeparatorText({ "Input" });
            u1.InputVector2({}, {
                number = v51
            });
            u1.InputVector3({}, {
                number = v52
            });
            u1.InputUDim({}, {
                number = v53
            });
            u1.InputUDim2({}, {
                number = v54
            });
            u1.InputRect({}, {
                number = v56
            });
            u1.SeparatorText({ "Drag" });
            u1.DragVector2({}, {
                number = v51
            });
            u1.DragVector3({}, {
                number = v52
            });
            u1.DragUDim({}, {
                number = v53
            });
            u1.DragUDim2({}, {
                number = v54
            });
            u1.DragRect({}, {
                number = v56
            });
            u1.SeparatorText({ "Slider" });
            u1.SliderVector2({}, {
                number = v51
            });
            u1.SliderVector3({}, {
                number = v52
            });
            u1.SliderUDim({}, {
                number = v53
            });
            u1.SliderUDim2({}, {
                number = v54
            });
            u1.SliderRect({}, {
                number = v56
            });
            u1.SeparatorText({ "Color" });
            u1.InputColor3({}, {
                color = v55
            });
            u1.InputColor4({}, {
                color = v55
            });
            u1.End();
        end,

        Tooltip = function() -- Line: 544, Name: Tooltip
            -- upvalues: u1 (copy)
            u1.PushConfig({
                ContentWidth = UDim.new(0, 250)
            });
            u1.Tree({ "Tooltip" });

            if u1.Text({ "Hover over me to reveal a tooltip" }).hovered() then
                u1.Tooltip({ "I am some helpful tooltip text" });
            end;

            local v57 = u1.State("Hello ");
            local v58 = u1.State(1);

            if u1.InputNum({ "# of repeat", 1, 1, 50 }, {
                number = v58
            }).numberChanged() then
                v57:set(string.rep("Hello ", v58:get()));
            end;

            if u1.Checkbox({ "Show dynamic text tooltip" }).state.isChecked.value then
                u1.Tooltip({ v57:get() });
            end;

            u1.End();
            u1.PopConfig();
        end,

        Plotting = function() -- Line: 564, Name: Plotting
            -- upvalues: u1 (copy)
            u1.Tree({ "Plotting" });
            u1.SeparatorText({ "Progress" });
            local v59 = os.clock() * 15;
            local v60 = u1.State(0);
            local v61 = math.abs(v59 % 100 - 50) - 7.5;
            v60:set(math.clamp(v61, 0, 35) / 35);
            u1.ProgressBar({ "Progress Bar" }, {
                progress = v60
            });
            local ProgressBar = u1.ProgressBar;
            local v62 = {};
            local v63 = v60:get() * 1753;
            v62[1], v62[2] = "Progress Bar", `{math.floor(v63)}/1753`;
            ProgressBar(v62, {
                progress = v60
            });
            u1.SeparatorText({ "Graphs" });
            local v64 = u1.State({ 0.5, 0.8, 0.2, 0.9, 0.1, 0.6, 0.4, 0.7, 0.3, 0 });
            u1.PlotHistogram({ "Histogram", 100, 0, 1, "random" }, {
                values = v64
            });
            u1.PlotLines({ "Lines", 100, 0, 1, "random" }, {
                values = v64
            });
            local v65 = u1.State("Cos");
            local v66 = u1.State(37);
            local v67 = u1.State(0);
            local v68 = u1.State({});
            local v69 = u1.State(0);
            local v70 = u1.Checkbox({ "Animate" });
            local v71 = u1.ComboArray({ "Plotting Function" }, {
                index = v65
            }, { "Sin", "Cos", "Tan", "Saw" });
            local v72 = u1.SliderNum({ "Samples", 1, 1, 145, "%d samples" }, {
                number = v66
            });

            if u1.SliderNum({ "Baseline", 0.1, -1, 1 }, {
                number = v67
            }).numberChanged() then
                v68:set(v68.value, true);
            end;

            if v70.state.isChecked.value or (v71.closed() or (v72.numberChanged() or #v68.value == 0)) then
                if v70.state.isChecked.value then
                    v69:set(v69.value + u1.Internal._deltaTime);
                end;

                local v73 = math.floor(v69.value * 30) - 1;
                local value = v65.value;
                table.clear(v68.value);

                for i = 1, v66.value do
                    local v74;

                    if value == "Sin" then
                        local value2 = v68.value;
                        local math_rad_ret = math.rad((i + v73) * 5);
                        value2[i] = math.sin(math_rad_ret);
                        v74 = i;
                    elseif value == "Cos" then
                        local value2 = v68.value;
                        local math_rad_ret = math.rad((i + v73) * 5);
                        value2[i] = math.cos(math_rad_ret);
                        v74 = i;
                    elseif value == "Tan" then
                        local value2 = v68.value;
                        local math_rad_ret = math.rad((i + v73) * 5);
                        value2[i] = math.tan(math_rad_ret);
                        v74 = i;
                    elseif value == "Saw" then
                        v68.value[i] = i % 2 == v73 % 2 and 1 or -1;
                        v74 = i;
                    else
                        v74 = i;
                    end;
                end;

                v68:set(v68.value, true);
            end;

            u1.PlotHistogram({
                "Histogram",
                100,
                -1,
                1,
                "",
                v67:get()
            }, {
                values = v68
            });
            u1.PlotLines({ "Lines", 100, -1, 1 }, {
                values = v68
            });
            u1.End();
        end
    };
    local u76 = { "Basic", "Image", "Selectable", "Combo", "Tree", "CollapsingHeader", "Group", "Tab", "Indent", "Input", "MultiInput", "InputText", "Tooltip", "Plotting" };

    local function recursiveTree() -- Line: 632
        -- upvalues: u1 (copy), recursiveTree (copy)
        if u1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
            recursiveTree();
        end;

        u1.End();
    end;

    local function recursiveWindow(p77) -- Line: 642
        -- upvalues: u1 (copy), recursiveWindow (copy)
        u1.Window({ "Recursive Window" }, {
            size = u1.State(Vector2.new(175, 100)),
            isOpened = p77
        });
        local v78 = u1.Checkbox({ "Recurse Again" });
        u1.End();

        if v78.isChecked.value then
            recursiveWindow(v78.isChecked);
        end;
    end;

    local function runtimeInfo() -- Line: 656
        -- upvalues: u1 (copy), u4 (copy), helpMarker (copy)
        local v79 = u1.Window({ "Runtime Info" }, {
            isOpened = u4
        });
        local _lastVDOM = u1.Internal._lastVDOM;
        local _states = u1.Internal._states;
        local v80 = u1.State(3);
        local v81 = u1.State(0);
        local v82 = u1.State(os.clock());
        u1.SameLine();
        u1.InputNum({
            [u1.Args.InputNum.Text] = "",
            [u1.Args.InputNum.Format] = "%d Seconds",
            [u1.Args.InputNum.Max] = 10
        }, {
            number = v80
        });

        if u1.Button({ "Disable" }).clicked() then
            u1.Disabled = true;
            task.delay(v80:get(), function() -- Line: 671
                -- upvalues: u1 (ref)
                u1.Disabled = false;
            end);
        end;

        u1.End();
        local os_clock_ret = os.clock();
        v81.value = v81.value + (os_clock_ret - v82.value - v81.value) * 0.2;
        v82.value = os_clock_ret;
        u1.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", v81.value * 1000, 1 / v81.value) });
        u1.Text({ string.format("Window Position: (%d, %d), Window Size: (%d, %d)", v79.position.value.X, v79.position.value.Y, v79.size.value.X, v79.size.value.Y) });
        u1.SameLine();
        u1.Text({ "Enter an ID to learn more about it." });
        helpMarker("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs");
        u1.End();
        u1.PushConfig({
            ItemWidth = UDim.new(1, -150)
        });
        local value = u1.InputText({ "ID field" }, {
            text = u1.State(v79.ID)
        }).state.text.value;
        u1.PopConfig();
        u1.Indent();
        local v83 = _lastVDOM[value];
        local v84 = _states[value];

        if v83 then
            u1.Table({ 1 });
            u1.Text({ string.format("The ID, \"%s\", is a widget", value) });
            u1.NextRow();
            u1.Text({ string.format("Widget is type: %s", v83.type) });
            u1.NextRow();
            u1.Tree({ "Widget has Args:" }, {
                isUncollapsed = u1.State(true)
            });

            for i, v in v83.arguments do
                u1.Text({ i .. " - " .. tostring(v) });
            end;

            u1.End();
            u1.NextRow();

            if v83.state then
                u1.Tree({ "Widget has State:" }, {
                    isUncollapsed = u1.State(true)
                });

                for i, v in v83.state do
                    u1.Text({ i .. " - " .. tostring(v.value) });
                end;

                u1.End();
            end;

            u1.End();
        elseif v84 then
            u1.Table({ 1 });
            u1.Text({ string.format("The ID, \"%s\", is a state", value) });
            u1.NextRow();
            u1.Text({ string.format("Value is type: %s, Value = %s", typeof(v84.value), (tostring(v84.value))) });
            u1.NextRow();
            u1.Tree({ "state has connected widgets:" }, {
                isUncollapsed = u1.State(true)
            });

            for i, v in v84.ConnectedWidgets do
                u1.Text({ i .. " - " .. v.type });
            end;

            u1.End();
            u1.NextRow();
            u1.Text({ string.format("state has: %d connected functions", #v84.ConnectedFunctions) });
            u1.End();
        else
            u1.Text({ string.format("The ID, \"%s\", is not a state or widget", value) });
        end;

        u1.End();

        if u1.Tree({ "Widgets" }).state.isUncollapsed.value then
            local v85 = 0;
            local v86 = "";

            for _, v in _lastVDOM do
                v85 = v85 + 1;
                v86 = v86 .. "\n" .. v.ID .. " - " .. v.type;
            end;

            u1.Text({ "Number of Widgets: " .. v85 });
            u1.Text({ v86 });
        end;

        u1.End();

        if u1.Tree({ "States" }).state.isUncollapsed.value then
            local v87 = 0;
            local v88 = "";

            for i, v in _states do
                v87 = v87 + 1;
                v88 = v88 .. "\n" .. i .. " - " .. tostring(v.value);
            end;

            u1.Text({ "Number of States: " .. v87 });
            u1.Text({ v88 });
        end;

        u1.End();
        u1.End();
    end;

    local function debugPanel() -- Line: 780
        -- upvalues: u1 (copy), u8 (copy)
        u1.Window({ "Debug Panel" }, {
            isOpened = u8
        });
        u1.CollapsingHeader({ "Widgets" });
        u1.SeparatorText({ "GuiService" });
        u1.Text({ (`GuiOffset: {u1.Internal._utility.GuiOffset}`) });
        u1.Text({ (`MouseOffset: {u1.Internal._utility.MouseOffset}`) });
        u1.SeparatorText({ "UserInputService" });
        u1.Text({ (`MousePosition: {u1.Internal._utility.UserInputService:GetMouseLocation()}`) });
        u1.Text({ (`MouseLocation: {u1.Internal._utility.getMouseLocation()}`) });
        u1.Text({ (`Left Control: {u1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)}`) });
        u1.Text({ (`Right Control: {u1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)}`) });
        u1.End();
        u1.End();
    end;

    local function recursiveMenu() -- Line: 801
        -- upvalues: u1 (copy), recursiveMenu (copy)
        if u1.Menu({ "Recursive" }).state.isOpened.value then
            u1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl });
            u1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl });
            u1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl });
            u1.Separator();
            u1.MenuToggle({ "Autosave" });
            u1.MenuToggle({ "Checked" });
            u1.Separator();
            u1.Menu({ "Options" });
            u1.MenuItem({ "Red" });
            u1.MenuItem({ "Yellow" });
            u1.MenuItem({ "Green" });
            u1.MenuItem({ "Blue" });
            u1.Separator();
            recursiveMenu();
            u1.End();
        end;

        u1.End();
    end;

    local function mainMenuBar() -- Line: 822
        -- upvalues: u1 (copy), recursiveMenu (copy), u2 (copy), u3 (copy), u6 (copy), u7 (copy), u4 (copy), u5 (copy), u8 (copy)
        u1.MenuBar();
        u1.Menu({ "File" });
        u1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl });
        u1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl });
        u1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl });
        recursiveMenu();

        if u1.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt }).clicked() then
            u2:set(false);
        end;

        u1.End();
        u1.Menu({ "Examples" });
        u1.MenuToggle({ "Recursive Window" }, {
            isChecked = u3
        });
        u1.MenuToggle({ "Windowless" }, {
            isChecked = u6
        });
        u1.MenuToggle({ "Main Menu Bar" }, {
            isChecked = u7
        });
        u1.End();
        u1.Menu({ "Tools" });
        u1.MenuToggle({ "Runtime Info" }, {
            isChecked = u4
        });
        u1.MenuToggle({ "Style Editor" }, {
            isChecked = u5
        });
        u1.MenuToggle({ "Debug Panel" }, {
            isChecked = u8
        });
        u1.End();
        u1.End();
    end;

    local function mainMenuBarExample() -- Line: 856
        -- upvalues: mainMenuBar (copy)
        mainMenuBar();
    end;

    local function u107() -- Line: 871
        -- upvalues: u1 (copy), helpMarker (copy), u5 (copy)
        local v104 = {
            { "Sizing", function() -- Line: 875
                    -- upvalues: u1 (ref), helpMarker (ref)
                    local u89 = u1.State({});
                    u1.SameLine();

                    if u1.Button({ "Update" }).clicked() then
                        u1.UpdateGlobalConfig(u89.value);
                        u89:set({});
                    end;

                    helpMarker("Update the global config with these changes.");
                    u1.End();

                    local function SliderInput(p90: string, p91: table) -- Line: 889
                        -- upvalues: u1 (ref), u89 (copy)
                        local v92 = u1[p90](p91, {
                            number = u1.WeakState(u1._config[p91[1]])
                        });

                        if v92.numberChanged() then
                            u89.value[p91[1]] = v92.number:get();
                        end;
                    end;

                    local function BooleanInput(p93: table) -- Line: 896
                        -- upvalues: u1 (ref), u89 (copy)
                        local v94 = u1.Checkbox(p93, {
                            isChecked = u1.WeakState(u1._config[p93[1]])
                        });

                        if v94.checked() or v94.unchecked() then
                            u89.value[p93[1]] = v94.isChecked:get();
                        end;
                    end;

                    u1.SeparatorText({ "Main" });
                    SliderInput("SliderVector2", {
                        "WindowPadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    SliderInput("SliderVector2", {
                        "WindowResizePadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    SliderInput("SliderVector2", {
                        "FramePadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    SliderInput("SliderVector2", {
                        "ItemSpacing",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    SliderInput("SliderVector2", {
                        "ItemInnerSpacing",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    SliderInput("SliderVector2", {
                        "CellPadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    SliderInput("SliderNum", { "IndentSpacing", 1, 0, 36 });
                    SliderInput("SliderNum", { "ScrollbarSize", 1, 0, 20 });
                    SliderInput("SliderNum", { "GrabMinSize", 1, 0, 20 });
                    u1.SeparatorText({ "Borders & Rounding" });
                    SliderInput("SliderNum", { "FrameBorderSize", 0.1, 0, 1 });
                    SliderInput("SliderNum", { "WindowBorderSize", 0.1, 0, 1 });
                    SliderInput("SliderNum", { "PopupBorderSize", 0.1, 0, 1 });
                    SliderInput("SliderNum", { "SeparatorTextBorderSize", 1, 0, 20 });
                    SliderInput("SliderNum", { "FrameRounding", 1, 0, 12 });
                    SliderInput("SliderNum", { "GrabRounding", 1, 0, 12 });
                    SliderInput("SliderNum", { "PopupRounding", 1, 0, 12 });
                    u1.SeparatorText({ "Widgets" });
                    SliderInput("SliderVector2", {
                        "DisplaySafeAreaPadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(20, 20)
                    });
                    SliderInput("SliderVector2", {
                        "SeparatorTextPadding",
                        nil,
                        Vector2.zero,
                        Vector2.new(36, 36)
                    });
                    SliderInput("SliderUDim", {
                        "ItemWidth",
                        nil,
                        UDim.new(),
                        UDim.new(1, 200)
                    });
                    SliderInput("SliderUDim", {
                        "ContentWidth",
                        nil,
                        UDim.new(),
                        UDim.new(1, 200)
                    });
                    SliderInput("SliderNum", { "ImageBorderSize", 1, 0, 12 });
                    local v95 = u1.ComboEnum({ "WindowTitleAlign" }, {
                        index = u1.WeakState(u1._config.WindowTitleAlign)
                    }, Enum.LeftRight);

                    if v95.closed() then
                        u89.value.WindowTitleAlign = v95.index:get();
                    end;

                    BooleanInput({ "RichText" });
                    BooleanInput({ "TextWrapped" });
                    u1.SeparatorText({ "Config" });
                    BooleanInput({ "UseScreenGUIs" });
                    SliderInput("DragNum", { "DisplayOrderOffset", 1, 0 });
                    SliderInput("DragNum", { "ZIndexOffset", 1, 0 });
                    SliderInput("SliderNum", { "MouseDoubleClickTime", 0.1, 0, 5 });
                    SliderInput("SliderNum", { "MouseDoubleClickMaxDist", 0.1, 0, 20 });
                end },
            { "Colors", function() -- Line: 946
                    -- upvalues: u1 (ref), helpMarker (ref)
                    local v96 = u1.State({});
                    u1.SameLine();

                    if u1.Button({ "Update" }).clicked() then
                        u1.UpdateGlobalConfig(v96.value);
                        v96:set({});
                    end;

                    helpMarker("Update the global config with these changes.");
                    u1.End();

                    for _, v in { "Text", "TextDisabled", "WindowBg", "PopupBg", "Border", "BorderActive", "ScrollbarGrab", "TitleBg", "TitleBgActive", "TitleBgCollapsed", "MenubarBg", "FrameBg", "FrameBgHovered", "FrameBgActive", "Button", "ButtonHovered", "ButtonActive", "Image", "SliderGrab", "SliderGrabActive", "Header", "HeaderHovered", "HeaderActive", "SelectionImageObject", "SelectionImageObjectBorder", "TableBorderStrong", "TableBorderLight", "TableRowBg", "TableRowBgAlt", "NavWindowingHighlight", "NavWindowingDimBg", "Separator", "CheckMark" } do
                        local v97 = u1.InputColor4({ v }, {
                            color = u1.WeakState(u1._config[v .. "Color"]),
                            transparency = u1.WeakState(u1._config[v .. "Transparency"])
                        });

                        if v97.numberChanged() then
                            v96.value[v .. "Color"] = v97.color:get();
                            v96.value[v .. "Transparency"] = v97.transparency:get();
                        end;
                    end;
                end },
            { "Fonts", function() -- Line: 1009
                    -- upvalues: u1 (ref), helpMarker (ref)
                    local v98 = u1.State({});
                    u1.SameLine();

                    if u1.Button({ "Update" }).clicked() then
                        u1.UpdateGlobalConfig(v98.value);
                        v98:set({});
                    end;

                    helpMarker("Update the global config with these changes.");
                    u1.End();
                    local v99 = {
                        ["Code (default)"] = Font.fromEnum(Enum.Font.Code),
                        ["Ubuntu (template)"] = Font.fromEnum(Enum.Font.Ubuntu),
                        Arial = Font.fromEnum(Enum.Font.Arial),
                        Highway = Font.fromEnum(Enum.Font.Highway),
                        Roboto = Font.fromEnum(Enum.Font.Roboto),
                        ["Roboto Mono"] = Font.fromEnum(Enum.Font.RobotoMono),
                        ["Noto Sans"] = Font.new("rbxassetid://12187370747"),
                        ["Builder Sans"] = Font.fromEnum(Enum.Font.BuilderSans),
                        ["Builder Mono"] = Font.new("rbxassetid://16658246179"),
                        Sono = Font.new("rbxassetid://12187374537")
                    };
                    u1.Text({ (`Current Font: {u1._config.TextFont.Family} Weight: {u1._config.TextFont.Weight} Style: {u1._config.TextFont.Style}`) });
                    u1.SeparatorText({ "Size" });
                    local v100 = u1.SliderNum({ "Font Size", 1, 4, 20 }, {
                        number = u1.WeakState(u1._config.TextSize)
                    });

                    if v100.numberChanged() then
                        v98.value.TextSize = v100.state.number:get();
                    end;

                    u1.SeparatorText({ "Properties" });
                    local v101 = u1.WeakState(u1._config.TextFont.Family);
                    local v102 = u1.ComboEnum({ "Font Weight" }, {
                        index = u1.WeakState(u1._config.TextFont.Weight)
                    }, Enum.FontWeight);
                    local v103 = u1.ComboEnum({ "Font Style" }, {
                        index = u1.WeakState(u1._config.TextFont.Style)
                    }, Enum.FontStyle);
                    u1.SeparatorText({ "Fonts" });

                    for i, v in v99 do
                        local Font_new_ret = Font.new(v.Family, v102.state.index.value, v103.state.index.value);
                        u1.SameLine();
                        u1.PushConfig({
                            TextFont = Font_new_ret
                        });

                        if u1.Selectable({ `{i} | "The quick brown fox jumps over the lazy dog."`, Font_new_ret.Family }, {
                            index = v101
                        }).selected() then
                            v98.value.TextFont = Font_new_ret;
                        end;

                        u1.PopConfig();
                        u1.End();
                    end;
                end }
        };
        u1.Window({ "Style Editor" }, {
            isOpened = u5
        });
        u1.Text({ "Customize the look of Iris in realtime." });
        local v105 = u1.State("Dark Theme");

        if u1.ComboArray({ "Theme" }, {
            index = v105
        }, { "Dark Theme", "Light Theme" }).closed() then
            if v105.value == "Dark Theme" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
            elseif v105.value == "Light Theme" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.colorLight);
            end;
        end;

        local v106 = u1.State("Classic Size");

        if u1.ComboArray({ "Size" }, {
            index = v106
        }, { "Classic Size", "Larger Size" }).closed() then
            if v106.value == "Classic Size" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
            elseif v106.value == "Larger Size" then
                u1.UpdateGlobalConfig(u1.TemplateConfig.sizeClear);
            end;
        end;

        u1.SameLine();

        if u1.Button({ "Revert" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
            u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
            v105:set("Dark Theme");
            v106:set("Classic Size");
        end;

        helpMarker("Reset Iris to the default theme and size.");
        u1.End();
        u1.TabBar();

        for i, v in ipairs(v104) do
            u1.Tab({ v[1] });
            v104[i][2]();
            u1.End();
        end;

        u1.End();
        u1.Separator();
        u1.End();
    end;

    local function widgetEventInteractivity() -- Line: 1123
        -- upvalues: u1 (copy)
        u1.CollapsingHeader({ "Widget Event Interactivity" });
        local v108 = u1.State(0);

        if u1.Button({ "Click to increase Number" }).clicked() then
            v108:set(v108:get() + 1);
        end;

        u1.Text({ "The Number is: " .. v108:get() });
        u1.Separator();
        local v109 = u1.State(false);
        local v110 = u1.State("clicked");
        u1.SameLine();
        u1.RadioButton({ "clicked", "clicked" }, {
            index = v110
        });
        u1.RadioButton({ "rightClicked", "rightClicked" }, {
            index = v110
        });
        u1.RadioButton({ "doubleClicked", "doubleClicked" }, {
            index = v110
        });
        u1.RadioButton({ "ctrlClicked", "ctrlClicked" }, {
            index = v110
        });
        u1.End();
        u1.SameLine();

        if u1.Button({ v110:get() .. " to reveal text" })[v110:get()]() then
            v109:set(not v109:get());
        end;

        if v109:get() then
            u1.Text({ "Here i am!" });
        end;

        u1.End();
        u1.Separator();
        local v111 = u1.State(0);
        u1.SameLine();

        if u1.Button({ "Click to show text for 20 frames" }).clicked() then
            v111:set(20);
        end;

        if v111:get() > 0 then
            u1.Text({ "Here i am!" });
        end;

        u1.End();
        local v112 = v111:get() - 1;
        v111:set((math.max(0, v112)));
        u1.Text({ "Text Timer: " .. v111:get() });
        local v113 = u1.Checkbox({ "Event-tracked checkbox" });
        u1.Indent();
        u1.Text({ "unchecked: " .. tostring(v113.unchecked()) });
        u1.Text({ "checked: " .. tostring(v113.checked()) });
        u1.End();
        u1.SameLine();

        if u1.Button({ "Hover over me" }).hovered() then
            u1.Text({ "The button is hovered" });
        end;

        u1.End();
        u1.End();
    end;

    local function widgetStateInteractivity() -- Line: 1194
        -- upvalues: u1 (copy)
        u1.CollapsingHeader({ "Widget State Interactivity" });
        local v114 = u1.Checkbox({ "Widget-Generated State" });
        u1.Text({ (`isChecked: {v114.state.isChecked.value}\n`) });
        local v115 = u1.State(false);
        local v116 = u1.Checkbox({ "User-Generated State" }, {
            isChecked = v115
        });
        u1.Text({ (`isChecked: {v116.state.isChecked.value}\n`) });
        local v117 = u1.Checkbox({ "Widget Coupled State" });
        local v118 = u1.Checkbox({ "Coupled to above Checkbox" }, {
            isChecked = v117.state.isChecked
        });
        u1.Text({ (`isChecked: {v118.state.isChecked.value}\n`) });
        local v119 = u1.State(false);
        u1.Checkbox({ "Widget and Code Coupled State" }, {
            isChecked = v119
        });

        if u1.Button({ "Click to toggle above checkbox" }).clicked() then
            v119:set(not v119:get());
        end;

        u1.Text({ (`isChecked: {v119.value}\n`) });
        local v120 = u1.State(true);
        local v122 = u1.ComputedState(v120, function(p121) -- Line: 1217
            return not p121;
        end);
        u1.Checkbox({ "ComputedState (dynamic coupling)" }, {
            isChecked = v120
        });
        u1.Checkbox({ "Inverted of above checkbox" }, {
            isChecked = v122
        });
        u1.Text({ (`isChecked: {v122.value}\n`) });
        u1.End();
    end;

    local function dynamicStyle() -- Line: 1227
        -- upvalues: u1 (copy), helpMarker (copy)
        u1.CollapsingHeader({ "Dynamic Styles" });
        local v123 = u1.State(0);
        u1.SameLine();

        if u1.Button({ "Change Color" }).clicked() then
            v123:set(math.random());
        end;

        local Text = u1.Text;
        local v124 = {};
        local v125 = v123:get() * 255;
        v124[1] = "Hue: " .. math.floor(v125);
        Text(v124);
        helpMarker("Using PushConfig with a changing value, this can be done with any config field");
        u1.End();
        u1.PushConfig({
            TextColor = Color3.fromHSV(v123:get(), 1, 1)
        });
        u1.Text({ "Text with a unique and changable color" });
        u1.PopConfig();
        u1.End();
    end;

    local function tablesDemo() -- Line: 1248
        -- upvalues: u1 (copy), helpMarker (copy)
        local v126 = u1.State(false);
        u1.CollapsingHeader({ "Tables & Columns" }, {
            isUncollapsed = v126
        });

        if v126.value == false then
            u1.End();

            return;
        end;

        u1.SameLine();
        u1.Text({ "Table using NextRow and NextColumn syntax:" });
        helpMarker("calling Iris.NextRow() in the outer loop, and Iris.NextColumn()in the inner loop");
        u1.End();
        u1.Table({ 3 });

        for i = 1, 4 do
            u1.NextRow();
            local v127 = i;

            for i2 = 1, 3 do
                u1.NextColumn();
                u1.Text({ (`Row: {v127}, Column: {i2}`) });
                local _ = i2;
            end;
        end;

        u1.End();
        u1.Text({ "" });
        u1.SameLine();
        u1.Text({ "Table using NextColumn only syntax:" });
        helpMarker("only calling Iris.NextColumn() in the inner loop, the result is identical");
        u1.End();
        u1.Table({ 2 });

        for i = 1, 4 do
            local v128 = i;

            for i2 = 1, 2 do
                u1.NextColumn();
                u1.Text({ (`Row: {v128}, Column: {i2}`) });
                local _ = i2;
            end;
        end;

        u1.End();
        u1.Separator();
        local v129 = u1.State(false);
        local v130 = u1.State(false);
        local v131 = u1.State(true);
        local v132 = u1.State(true);
        local v133 = u1.State(3);
        u1.Text({ "Table with Customizable Arguments" });
        u1.Table({
            [u1.Args.Table.NumColumns] = 4,
            [u1.Args.Table.RowBg] = v129.value,
            [u1.Args.Table.BordersOuter] = v130.value,
            [u1.Args.Table.BordersInner] = v131.value
        });

        for i = 1, v133:get() do
            local v134 = i;

            for i2 = 1, 4 do
                u1.NextColumn();
                local v135;

                if v132.value then
                    u1.Button({ (`Month: {v134}, Week: {i2}`) });
                    v135 = i2;
                else
                    u1.Text({ (`Month: {v134}, Week: {i2}`) });
                    v135 = i2;
                end;
            end;
        end;

        u1.End();
        u1.Checkbox({ "RowBg" }, {
            isChecked = v129
        });
        u1.Checkbox({ "BordersOuter" }, {
            isChecked = v130
        });
        u1.Checkbox({ "BordersInner" }, {
            isChecked = v131
        });
        u1.SameLine();
        u1.RadioButton({ "Buttons", true }, {
            index = v132
        });
        u1.RadioButton({ "Text", false }, {
            index = v132
        });
        u1.End();
        u1.InputNum({
            [u1.Args.InputNum.Text] = "Number of rows",
            [u1.Args.InputNum.Min] = 0,
            [u1.Args.InputNum.Max] = 100,
            [u1.Args.InputNum.Format] = "%d"
        }, {
            number = v133
        });
        u1.End();
    end;

    local function layoutDemo() -- Line: 1348
        -- upvalues: u1 (copy), helpMarker (copy)
        u1.CollapsingHeader({ "Widget Layout" });
        u1.Tree({ "Widget Alignment" });
        u1.Text({ "Iris.SameLine has optional argument supporting horizontal and vertical alignments." });
        u1.Text({ "This allows widgets to be place anywhere on the line." });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "By default child widgets will be aligned to the left." });
        helpMarker("Iris.SameLine()\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()");
        u1.End();
        u1.SameLine();
        u1.Button({ "Button A" });
        u1.Button({ "Button B" });
        u1.End();
        u1.SameLine();
        u1.Text({ "But can be aligned to the center." });
        helpMarker("Iris.SameLine({ nil, nil, Enum.HorizontalAlignment.Center })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()");
        u1.End();
        u1.SameLine({ nil, nil, Enum.HorizontalAlignment.Center });
        u1.Button({ "Button A" });
        u1.Button({ "Button B" });
        u1.End();
        u1.SameLine();
        u1.Text({ "Or right." });
        helpMarker("Iris.SameLine({ nil, nil, Enum.HorizontalAlignment.Right })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()");
        u1.End();
        u1.SameLine({ nil, nil, Enum.HorizontalAlignment.Right });
        u1.Button({ "Button A" });
        u1.Button({ "Button B" });
        u1.End();
        u1.Separator();
        u1.SameLine();
        u1.Text({ "You can also specify the padding." });
        helpMarker("Iris.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()");
        u1.End();
        u1.SameLine({ 0, nil, Enum.HorizontalAlignment.Center });
        u1.Button({ "Button A" });
        u1.Button({ "Button B" });
        u1.End();
        u1.End();
        u1.Tree({ "Widget Sizing" });
        u1.Text({ "Nearly all widgets are the minimum size of the content." });
        u1.Text({ "For example, text and button widgets will be the size of the text labels." });
        u1.Text({ "Some widgets, such as the Image and Button have Size arguments will will set the size of them." });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "The button takes up the full screen-width." });
        helpMarker("Iris.Button({ \"Button\", UDim2.fromScale(1, 0) })");
        u1.End();
        u1.Button({ "Button", UDim2.fromScale(1, 0) });
        u1.SameLine();
        u1.Text({ "The button takes up half the screen-width." });
        helpMarker("Iris.Button({ \"Button\", UDim2.fromScale(0.5, 0) })");
        u1.End();
        u1.Button({ "Button", UDim2.fromScale(0.5, 0) });
        u1.SameLine();
        u1.Text({ "Combining with SameLine, the buttons can fill the screen width." });
        helpMarker("The button will still be larger that the text size.");
        u1.End();
        local v136 = u1.State(2);
        u1.SliderNum({ "Number of Buttons", 1, 1, 8 }, {
            number = v136
        });
        u1.SameLine({ 0, nil, Enum.HorizontalAlignment.Center });

        for i = 1, v136.value do
            u1.Button({ `Button {i}`, UDim2.fromScale(1 / v136.value, 0) });
            local _ = i;
        end;

        u1.End();
        u1.End();
        u1.Tree({ "Content Width" });
        local v137 = u1.State(50);
        local v138 = u1.State(Enum.Axis.X);
        u1.Text({ "The Content Width is a size property which determines the width of input fields." });
        u1.SameLine();
        u1.Text({ "By default the value is UDim.new(0.65, 0)" });
        helpMarker("This is the default value from Dear ImGui.\nIt is 65% of the window width.");
        u1.End();
        u1.Text({ "This works well, but sometimes we know how wide elements are going to be and want to maximise the space." });
        u1.Text({ "Therefore, we can use Iris.PushConfig() to change the width" });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "Content Width = 150 pixels" });
        helpMarker("UDim.new(0, 150)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(0, 150)
        });
        u1.DragNum({ "number", 1, 0, 100 }, {
            number = v137
        });
        u1.InputEnum({ "axis" }, {
            index = v138
        }, Enum.Axis);
        u1.PopConfig();
        u1.SameLine();
        u1.Text({ "Content Width = 50% window width" });
        helpMarker("UDim.new(0.5, 0)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(0.5, 0)
        });
        u1.DragNum({ "number", 1, 0, 100 }, {
            number = v137
        });
        u1.InputEnum({ "axis" }, {
            index = v138
        }, Enum.Axis);
        u1.PopConfig();
        u1.SameLine();
        u1.Text({ "Content Width = -150 pixels from the right side" });
        helpMarker("UDim.new(1, -150)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(1, -150)
        });
        u1.DragNum({ "number", 1, 0, 100 }, {
            number = v137
        });
        u1.InputEnum({ "axis" }, {
            index = v138
        }, Enum.Axis);
        u1.PopConfig();
        u1.End();
        u1.Tree({ "Content Height" });
        local v139 = u1.State("a single line");
        local v140 = u1.State(50);
        local v141 = u1.State(Enum.Axis.X);
        local v142 = u1.State(0);
        local v143 = os.clock() * 15 % 100 - 50;
        local v144 = math.abs(v143) - 7.5;
        v142:set(math.clamp(v144, 0, 35) / 35);
        u1.Text({ "The Content Height is a size property that determines the minimum size of certain widgets." });
        u1.Text({ "By default the value is UDim.new(0, 0), so there is no minimum height." });
        u1.Text({ "We use Iris.PushConfig() to change this value." });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "Content Height = 0 pixels" });
        helpMarker("UDim.new(0, 0)");
        u1.End();
        u1.InputText({ "text" }, {
            text = v139
        });
        u1.ProgressBar({ "progress" }, {
            progress = v142
        });
        u1.DragNum({ "number", 1, 0, 100 }, {
            number = v140
        });
        u1.ComboEnum({ "axis" }, {
            index = v141
        }, Enum.Axis);
        u1.SameLine();
        u1.Text({ "Content Height = 60 pixels" });
        helpMarker("UDim.new(0, 60)");
        u1.End();
        u1.PushConfig({
            ContentHeight = UDim.new(0, 60)
        });
        u1.InputText({ "text", nil, nil, true }, {
            text = v139
        });
        u1.ProgressBar({ "progress" }, {
            progress = v142
        });
        u1.DragNum({ "number", 1, 0, 100 }, {
            number = v140
        });
        u1.ComboEnum({ "axis" }, {
            index = v141
        }, Enum.Axis);
        u1.PopConfig();
        u1.Text({ "This property can be used to force the height of a text box." });
        u1.Text({ "Just make sure you enable the MultiLine argument." });
        u1.End();
        u1.End();
    end;

    local function windowlessDemo() -- Line: 1549
        -- upvalues: u1 (copy), helpMarker (copy)
        u1.PushConfig({
            ItemWidth = UDim.new(0, 150)
        });
        u1.SameLine();
        u1.TextWrapped({ "Windowless widgets" });
        helpMarker("Widgets which are placed outside of a window will appear on the top left side of the screen.");
        u1.End();
        u1.Button({});
        u1.Tree({});
        u1.InputText({});
        u1.End();
        u1.PopConfig();
    end;

    return function() -- Line: 1569
        -- upvalues: u1 (copy), u2 (copy), mainMenuBar (copy), widgetEventInteractivity (copy), widgetStateInteractivity (copy), recursiveTree (copy), dynamicStyle (copy), u76 (copy), u75 (copy), tablesDemo (copy), layoutDemo (copy), u3 (copy), recursiveWindow (copy), u4 (copy), runtimeInfo (copy), u8 (copy), debugPanel (copy), u5 (copy), u107 (ref), u6 (copy), windowlessDemo (copy), u7 (copy)
        local v145 = u1.State(false);
        local v146 = u1.State(false);
        local v147 = u1.State(false);
        local v148 = u1.State(true);
        local v149 = u1.State(false);
        local v150 = u1.State(false);
        local v151 = u1.State(false);
        local v152 = u1.State(false);
        local v153 = u1.State(false);

        if u2.value ~= false then
            debug.profilebegin("Iris/Demo/Window");
            local v154 = u1.Window({
                [u1.Args.Window.Title] = "Iris Demo Window",
                [u1.Args.Window.NoTitleBar] = v145.value,
                [u1.Args.Window.NoBackground] = v146.value,
                [u1.Args.Window.NoCollapse] = v147.value,
                [u1.Args.Window.NoClose] = v148.value,
                [u1.Args.Window.NoMove] = v149.value,
                [u1.Args.Window.NoScrollbar] = v150.value,
                [u1.Args.Window.NoResize] = v151.value,
                [u1.Args.Window.NoNav] = v152.value,
                [u1.Args.Window.NoMenu] = v153.value
            }, {
                size = u1.State(Vector2.new(600, 550)),
                position = u1.State(Vector2.new(100, 25)),
                isOpened = u2
            });

            if v154.state.isUncollapsed.value and v154.state.isOpened.value then
                debug.profilebegin("Iris/Demo/MenuBar");
                mainMenuBar();
                debug.profileend();
                u1.Text({ "Iris says hello. (" .. u1.Internal._version .. ")" });
                debug.profilebegin("Iris/Demo/Options");
                u1.CollapsingHeader({ "Window Options" });
                u1.Table({ 3, false, false, false });
                u1.NextColumn();
                u1.Checkbox({ "NoTitleBar" }, {
                    isChecked = v145
                });
                u1.NextColumn();
                u1.Checkbox({ "NoBackground" }, {
                    isChecked = v146
                });
                u1.NextColumn();
                u1.Checkbox({ "NoCollapse" }, {
                    isChecked = v147
                });
                u1.NextColumn();
                u1.Checkbox({ "NoClose" }, {
                    isChecked = v148
                });
                u1.NextColumn();
                u1.Checkbox({ "NoMove" }, {
                    isChecked = v149
                });
                u1.NextColumn();
                u1.Checkbox({ "NoScrollbar" }, {
                    isChecked = v150
                });
                u1.NextColumn();
                u1.Checkbox({ "NoResize" }, {
                    isChecked = v151
                });
                u1.NextColumn();
                u1.Checkbox({ "NoNav" }, {
                    isChecked = v152
                });
                u1.NextColumn();
                u1.Checkbox({ "NoMenu" }, {
                    isChecked = v153
                });
                u1.End();
                u1.End();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Events");
                widgetEventInteractivity();
                debug.profileend();
                debug.profilebegin("Iris/Demo/States");
                widgetStateInteractivity();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Recursive");
                u1.CollapsingHeader({ "Recursive Tree" });

                if u1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
                    recursiveTree();
                end;

                u1.End();
                u1.End();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Style");
                dynamicStyle();
                debug.profileend();
                u1.Separator();
                debug.profilebegin("Iris/Demo/Widgets");
                u1.CollapsingHeader({ "Widgets" });

                for _, v in u76 do
                    debug.profilebegin((`Iris/Demo/Widgets/{v}`));
                    u75[v]();
                    debug.profileend();
                end;

                u1.End();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Tables");
                tablesDemo();
                debug.profileend();
                debug.profilebegin("Iris/Demo/Layout");
                layoutDemo();
                debug.profileend();
            end;

            u1.End();
            debug.profileend();

            if u3.value then
                recursiveWindow(u3);
            end;

            if u4.value then
                runtimeInfo();
            end;

            if u8.value then
                debugPanel();
            end;

            if u5.value then
                u107();
            end;

            if u6.value then
                windowlessDemo();
            end;

            if u7.value then
                mainMenuBar();
            end;

            return v154;
        end;

        u1.Checkbox({ "Open main window" }, {
            isChecked = u2
        });
    end;
end;