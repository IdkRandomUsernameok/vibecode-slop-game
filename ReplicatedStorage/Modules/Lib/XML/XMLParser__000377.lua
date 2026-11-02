-- Decompiled with Potassium's decompiler.

function parse(p1: string, p2: boolean?)
    if not p1 then
        return nil;
    end;

    local v3 = p1:gsub("<!%-%-(.-)%-%->", "");
    local u4 = {};
    local v5 = {};

    if p2 then
        local v6 = v3:find("<[_%w]");

        if v6 then
            v3:sub(1, v6):gsub("<!ENTITY%s+([_%w]+)%s+(.)(.-)%2", function(p7: string, p8: userdata, p9: string) -- Line: 29
                -- upvalues: u4 (copy)
                table.insert(u4, {
                    name = p7,
                    value = p9
                });

                return nil;
            end);
            v5 = createEntityTable(u4);
            v3 = replaceEntities(v3:sub(v6), v5);
        end;
    end;

    local u10 = {};
    local u11 = {};

    local function _(p12: string) -- Line: 41
        -- upvalues: u10 (ref)
        local v13 = p12:match("^%s*(.*%S)") or "";

        if #v13 ~= 0 then
            u10[#u10].text = v13;
        end;
    end;

    v3:gsub("<([?!/]?)([-:_%w]+)%s*(/?>?)([^<]*)", function(p14: string, p15: string, p16: string, p17: string) -- Line: 49
        -- upvalues: u10 (ref), u11 (copy), u4 (copy)
        if #p14 == 0 then
            local v18 = {};

            if #p16 == 0 then
                local v19 = 0;

                for i, v, _, v2, v4 in string.gmatch(p17, "(.-([-_%w]+)%s*=%s*(.)(.-)%3%s*(/?>?))") do
                    v19 = v19 + #i;
                    v18[v] = v2;

                    if #v4 ~= 0 then
                        p17 = p17:sub(v19 + 1);
                        p16 = v4;
                        break;
                    end;
                end;
            end;

            table.insert(u10, {
                tag = p15,
                attrs = v18,
                children = {}
            });
            local v20 = p17:match("^%s*(.*%S)") or "";

            if #v20 ~= 0 then
                u10[#u10].text = v20;
            end;

            if p16:byte(1) ~= 47 then
                u11[#u11 + 1] = u10;
                u10 = u10[#u10].children;
            end;
        else
            if p14 == "/" then
                local v21 = p17:match("^%s*(.*%S)") or "";

                if #v21 ~= 0 then
                    u10[#u10].text = v21;
                end;

                u10 = u11[#u11];
                u11[#u11] = nil;

                return;
            end;

            if p14 == "!" and p15:byte(1) == 69 then
                p17:gsub("([_%w]+)%s+(.)(.-)%2", function(p22: string, p23: string, p24: string) -- Line: 83
                    -- upvalues: u4 (ref)
                    table.insert(u4, {
                        name = p22,
                        value = p24
                    });
                end, 1);
            end;
        end;
    end);

    return {
        children = u10,
        entities = u4,
        tentities = v5
    };
end;

function defaultEntityTable()
    return {
        quot = "\"",
        apos = "\'",
        lt = "<",
        gt = ">",
        amp = "&",
        tab = "\t",
        nbsp = " "
    };
end;

function replaceEntities(p25: string, p26: table)
    return p25:gsub("&([^;]+);", p26);
end;

function createEntityTable(p27: table, p28: table?)
    local v29 = p28 or defaultEntityTable();

    for _, v in p27 do
        v.value = replaceEntities(v.value, v29);
        v29[v.name] = v.value;
    end;

    return v29;
end;

return {
    defaultEntityTable = defaultEntityTable,
    parse = parse,
    createEntityTable = createEntityTable,
    replaceEntities = replaceEntities
};