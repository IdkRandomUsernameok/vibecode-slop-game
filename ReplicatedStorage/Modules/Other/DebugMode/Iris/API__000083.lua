-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);

return function(u1) -- Line: 3
    local function wrapper(u2: string) -- Line: 5
        -- upvalues: u1 (copy)
        return function(p3, p4) -- Line: 6
            -- upvalues: u1 (ref), u2 (copy)
            return u1.Internal._Insert(u2, p3, p4);
        end;
    end;

    local u5 = "Window";

    function u1.Window(p6, p7) -- Line: 6
        -- upvalues: u1 (copy), u5 (copy)
        return u1.Internal._Insert(u5, p6, p7);
    end;

    u1.SetFocusedWindow = u1.Internal.SetFocusedWindow;
    local u8 = "Tooltip";

    function u1.Tooltip(p9, p10) -- Line: 6
        -- upvalues: u1 (copy), u8 (copy)
        return u1.Internal._Insert(u8, p9, p10);
    end;

    local u11 = "MenuBar";

    function u1.MenuBar(p12, p13) -- Line: 6
        -- upvalues: u1 (copy), u11 (copy)
        return u1.Internal._Insert(u11, p12, p13);
    end;

    local u14 = "Menu";

    function u1.Menu(p15, p16) -- Line: 6
        -- upvalues: u1 (copy), u14 (copy)
        return u1.Internal._Insert(u14, p15, p16);
    end;

    local u17 = "MenuItem";

    function u1.MenuItem(p18, p19) -- Line: 6
        -- upvalues: u1 (copy), u17 (copy)
        return u1.Internal._Insert(u17, p18, p19);
    end;

    local u20 = "MenuToggle";

    function u1.MenuToggle(p21, p22) -- Line: 6
        -- upvalues: u1 (copy), u20 (copy)
        return u1.Internal._Insert(u20, p21, p22);
    end;

    local u23 = "Separator";

    function u1.Separator(p24, p25) -- Line: 6
        -- upvalues: u1 (copy), u23 (copy)
        return u1.Internal._Insert(u23, p24, p25);
    end;

    local u26 = "Indent";

    function u1.Indent(p27, p28) -- Line: 6
        -- upvalues: u1 (copy), u26 (copy)
        return u1.Internal._Insert(u26, p27, p28);
    end;

    local u29 = "SameLine";

    function u1.SameLine(p30, p31) -- Line: 6
        -- upvalues: u1 (copy), u29 (copy)
        return u1.Internal._Insert(u29, p30, p31);
    end;

    local u32 = "Group";

    function u1.Group(p33, p34) -- Line: 6
        -- upvalues: u1 (copy), u32 (copy)
        return u1.Internal._Insert(u32, p33, p34);
    end;

    local u35 = "Text";

    function u1.Text(p36, p37) -- Line: 6
        -- upvalues: u1 (copy), u35 (copy)
        return u1.Internal._Insert(u35, p36, p37);
    end;

    function u1.TextWrapped(p38) -- Line: 366
        -- upvalues: u1 (copy)
        p38[2] = true;

        return u1.Internal._Insert("Text", p38);
    end;

    function u1.TextColored(p39) -- Line: 391
        -- upvalues: u1 (copy)
        p39[3] = p39[2];
        p39[2] = nil;

        return u1.Internal._Insert("Text", p39);
    end;

    local u40 = "SeparatorText";

    function u1.SeparatorText(p41, p42) -- Line: 6
        -- upvalues: u1 (copy), u40 (copy)
        return u1.Internal._Insert(u40, p41, p42);
    end;

    local u43 = "InputText";

    function u1.InputText(p44, p45) -- Line: 6
        -- upvalues: u1 (copy), u43 (copy)
        return u1.Internal._Insert(u43, p44, p45);
    end;

    local u46 = "Button";

    function u1.Button(p47, p48) -- Line: 6
        -- upvalues: u1 (copy), u46 (copy)
        return u1.Internal._Insert(u46, p47, p48);
    end;

    local u49 = "SmallButton";

    function u1.SmallButton(p50, p51) -- Line: 6
        -- upvalues: u1 (copy), u49 (copy)
        return u1.Internal._Insert(u49, p50, p51);
    end;

    local u52 = "Checkbox";

    function u1.Checkbox(p53, p54) -- Line: 6
        -- upvalues: u1 (copy), u52 (copy)
        return u1.Internal._Insert(u52, p53, p54);
    end;

    local u55 = "RadioButton";

    function u1.RadioButton(p56, p57) -- Line: 6
        -- upvalues: u1 (copy), u55 (copy)
        return u1.Internal._Insert(u55, p56, p57);
    end;

    local u58 = "Image";

    function u1.Image(p59, p60) -- Line: 6
        -- upvalues: u1 (copy), u58 (copy)
        return u1.Internal._Insert(u58, p59, p60);
    end;

    local u61 = "ImageButton";

    function u1.ImageButton(p62, p63) -- Line: 6
        -- upvalues: u1 (copy), u61 (copy)
        return u1.Internal._Insert(u61, p62, p63);
    end;

    local u64 = "Tree";

    function u1.Tree(p65, p66) -- Line: 6
        -- upvalues: u1 (copy), u64 (copy)
        return u1.Internal._Insert(u64, p65, p66);
    end;

    local u67 = "CollapsingHeader";

    function u1.CollapsingHeader(p68, p69) -- Line: 6
        -- upvalues: u1 (copy), u67 (copy)
        return u1.Internal._Insert(u67, p68, p69);
    end;

    local u70 = "TabBar";

    function u1.TabBar(p71, p72) -- Line: 6
        -- upvalues: u1 (copy), u70 (copy)
        return u1.Internal._Insert(u70, p71, p72);
    end;

    local u73 = "Tab";

    function u1.Tab(p74, p75) -- Line: 6
        -- upvalues: u1 (copy), u73 (copy)
        return u1.Internal._Insert(u73, p74, p75);
    end;

    local u76 = "InputNum";

    function u1.InputNum(p77, p78) -- Line: 6
        -- upvalues: u1 (copy), u76 (copy)
        return u1.Internal._Insert(u76, p77, p78);
    end;

    local u79 = "InputVector2";

    function u1.InputVector2(p80, p81) -- Line: 6
        -- upvalues: u1 (copy), u79 (copy)
        return u1.Internal._Insert(u79, p80, p81);
    end;

    local u82 = "InputVector3";

    function u1.InputVector3(p83, p84) -- Line: 6
        -- upvalues: u1 (copy), u82 (copy)
        return u1.Internal._Insert(u82, p83, p84);
    end;

    local u85 = "InputUDim";

    function u1.InputUDim(p86, p87) -- Line: 6
        -- upvalues: u1 (copy), u85 (copy)
        return u1.Internal._Insert(u85, p86, p87);
    end;

    local u88 = "InputUDim2";

    function u1.InputUDim2(p89, p90) -- Line: 6
        -- upvalues: u1 (copy), u88 (copy)
        return u1.Internal._Insert(u88, p89, p90);
    end;

    local u91 = "InputRect";

    function u1.InputRect(p92, p93) -- Line: 6
        -- upvalues: u1 (copy), u91 (copy)
        return u1.Internal._Insert(u91, p92, p93);
    end;

    local u94 = "DragNum";

    function u1.DragNum(p95, p96) -- Line: 6
        -- upvalues: u1 (copy), u94 (copy)
        return u1.Internal._Insert(u94, p95, p96);
    end;

    local u97 = "DragVector2";

    function u1.DragVector2(p98, p99) -- Line: 6
        -- upvalues: u1 (copy), u97 (copy)
        return u1.Internal._Insert(u97, p98, p99);
    end;

    local u100 = "DragVector3";

    function u1.DragVector3(p101, p102) -- Line: 6
        -- upvalues: u1 (copy), u100 (copy)
        return u1.Internal._Insert(u100, p101, p102);
    end;

    local u103 = "DragUDim";

    function u1.DragUDim(p104, p105) -- Line: 6
        -- upvalues: u1 (copy), u103 (copy)
        return u1.Internal._Insert(u103, p104, p105);
    end;

    local u106 = "DragUDim2";

    function u1.DragUDim2(p107, p108) -- Line: 6
        -- upvalues: u1 (copy), u106 (copy)
        return u1.Internal._Insert(u106, p107, p108);
    end;

    local u109 = "DragRect";

    function u1.DragRect(p110, p111) -- Line: 6
        -- upvalues: u1 (copy), u109 (copy)
        return u1.Internal._Insert(u109, p110, p111);
    end;

    local u112 = "InputColor3";

    function u1.InputColor3(p113, p114) -- Line: 6
        -- upvalues: u1 (copy), u112 (copy)
        return u1.Internal._Insert(u112, p113, p114);
    end;

    local u115 = "InputColor4";

    function u1.InputColor4(p116, p117) -- Line: 6
        -- upvalues: u1 (copy), u115 (copy)
        return u1.Internal._Insert(u115, p116, p117);
    end;

    local u118 = "SliderNum";

    function u1.SliderNum(p119, p120) -- Line: 6
        -- upvalues: u1 (copy), u118 (copy)
        return u1.Internal._Insert(u118, p119, p120);
    end;

    local u121 = "SliderVector2";

    function u1.SliderVector2(p122, p123) -- Line: 6
        -- upvalues: u1 (copy), u121 (copy)
        return u1.Internal._Insert(u121, p122, p123);
    end;

    local u124 = "SliderVector3";

    function u1.SliderVector3(p125, p126) -- Line: 6
        -- upvalues: u1 (copy), u124 (copy)
        return u1.Internal._Insert(u124, p125, p126);
    end;

    local u127 = "SliderUDim";

    function u1.SliderUDim(p128, p129) -- Line: 6
        -- upvalues: u1 (copy), u127 (copy)
        return u1.Internal._Insert(u127, p128, p129);
    end;

    local u130 = "SliderUDim2";

    function u1.SliderUDim2(p131, p132) -- Line: 6
        -- upvalues: u1 (copy), u130 (copy)
        return u1.Internal._Insert(u130, p131, p132);
    end;

    local u133 = "SliderRect";

    function u1.SliderRect(p134, p135) -- Line: 6
        -- upvalues: u1 (copy), u133 (copy)
        return u1.Internal._Insert(u133, p134, p135);
    end;

    local u136 = "Selectable";

    function u1.Selectable(p137, p138) -- Line: 6
        -- upvalues: u1 (copy), u136 (copy)
        return u1.Internal._Insert(u136, p137, p138);
    end;

    local u139 = "Combo";

    function u1.Combo(p140, p141) -- Line: 6
        -- upvalues: u1 (copy), u139 (copy)
        return u1.Internal._Insert(u139, p140, p141);
    end;

    function u1.ComboArray(p142: any, p143: any, p144: table) -- Line: 1569
        -- upvalues: u1 (copy)
        if p143 == nil then
            p143 = u1.State(p144[1]);
        end;

        local v145 = u1.Internal._Insert("Combo", p142, p143);
        local index = v145.state.index;

        for _, v in p144 do
            u1.Internal._Insert("Selectable", { v, v }, {
                index = index
            });
        end;

        u1.End();

        return v145;
    end;

    function u1.ComboEnum(p146: any, p147: any, p148: userdata) -- Line: 1618
        -- upvalues: u1 (copy)
        if p147 == nil then
            p147 = u1.State(p148:GetEnumItems()[1]);
        end;

        local v149 = u1.Internal._Insert("Combo", p146, p147);
        local index = v149.state.index;

        for _, v in p148:GetEnumItems() do
            u1.Internal._Insert("Selectable", { v.Name, v }, {
                index = index
            });
        end;

        u1.End();

        return v149;
    end;

    u1.InputEnum = u1.ComboEnum;
    local u150 = "ProgressBar";

    function u1.ProgressBar(p151, p152) -- Line: 6
        -- upvalues: u1 (copy), u150 (copy)
        return u1.Internal._Insert(u150, p151, p152);
    end;

    local u153 = "PlotLines";

    function u1.PlotLines(p154, p155) -- Line: 6
        -- upvalues: u1 (copy), u153 (copy)
        return u1.Internal._Insert(u153, p154, p155);
    end;

    local u156 = "PlotHistogram";

    function u1.PlotHistogram(p157, p158) -- Line: 6
        -- upvalues: u1 (copy), u156 (copy)
        return u1.Internal._Insert(u156, p157, p158);
    end;

    local u159 = "Table";

    function u1.Table(p160, p161) -- Line: 6
        -- upvalues: u1 (copy), u159 (copy)
        return u1.Internal._Insert(u159, p160, p161);
    end;

    function u1.NextColumn() -- Line: 1808
        -- upvalues: u1 (copy)
        local v162 = u1.Internal._GetParentWidget();
        assert(v162.type == "Table", "Iris.NextColumn() can only be called within a table.");
        v162.RowColumnIndex = v162.RowColumnIndex + 1;
    end;

    function u1.SetColumnIndex(p163: number) -- Line: 1821
        -- upvalues: u1 (copy)
        local v164 = u1.Internal._GetParentWidget();
        assert(v164.type == "Table", "Iris.SetColumnIndex() can only be called within a table.");
        assert(v164.InitialNumColumns <= p163, "Iris.SetColumnIndex() argument must be in column range.");
        v164.RowColumnIndex = math.floor(v164.RowColumnIndex / v164.InitialNumColumns) + (p163 - 1);
    end;

    function u1.NextRow() -- Line: 1835
        -- upvalues: u1 (copy)
        local v165 = u1.Internal._GetParentWidget();
        assert(v165.type == "Table", "Iris.NextColumn() can only be called within a table.");
        local InitialNumColumns = v165.InitialNumColumns;
        v165.RowColumnIndex = math.floor((v165.RowColumnIndex + 1) / InitialNumColumns) * InitialNumColumns;
    end;
end;