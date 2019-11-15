--                          menu shit

-- refs

print("cLua | Loaded")

local mPlacement = gui.Reference("MISC", "AUTOMATION", "Other");

-- checkboxes

local cMenu = gui.Checkbox(mPlacement, "cluashow", "cLua", false);

-- windows
local cWindow = gui.Window("clua_menu", "cLua main", 1280, 740, 600, 600)
local cDesyncgroup = gui.Groupbox(cWindow, "Desync", 20, 20, 200, 140)
local cFixesGroup = gui.Groupbox(cWindow, "Fixes", 20, 200, 200, 100)
local cKnifeGroup = gui.Groupbox(cWindow, "Knife/Zeus", 250, 20, 200, 72)

--                         actual features
local me = entities.GetLocalPlayer()
-- invert desync

local invertKey = gui.Keybox(cDesyncgroup, "cluainvert_key", "Invert key", false)
local desyncators = gui.Multibox(cDesyncgroup, "Indicators")
local dArrows = gui.Checkbox(desyncators, "cluadesync_arrows", "arrows", false)
local dText = gui.Checkbox(desyncators, "cluadesync_text", "text", false)

--local tankCheckBox = gui.Checkbox(cluaInvertGroup, "cluadesync_tank", "Tank AA", false)
local vleftDesync = 3;
local vrightDesync = 2;
local eleftDesync = 2;
local erightDesync = 3;
local activeSide = "null";


local function inverter()
    if entities.GetLocalPlayer() ~= nil then
        if invertKey:GetValue() == 0 then return end
        if input.IsButtonPressed(invertKey:GetValue()) and not input.IsButtonDown(69) then
            if rightDesync == false then
                gui.SetValue("rbot_antiaim_stand_desync", vrightDesync);
                gui.SetValue("rbot_antiaim_move_desync", vrightDesync);
                rightDesync = not rightDesync;
            else
                gui.SetValue("rbot_antiaim_stand_desync", vleftDesync);
                gui.SetValue("rbot_antiaim_move_desync", vleftDesync);
                rightDesync = not rightDesync;
            end
        else if input.IsButtonPressed(invertKey:GetValue()) and input.IsButtonDown(69) then
            if rightDesync == false then
                gui.SetValue("rbot_antiaim_stand_desync", erightDesync);
                gui.SetValue("rbot_antiaim_move_desync", erightDesync);
                rightDesync = not rightDesync;
            else
                gui.SetValue("rbot_antiaim_stand_desync", eleftDesync);
                gui.SetValue("rbot_antiaim_move_desync", eleftDesync);
                rightDesync = not rightDesync;
            end
        end
        end
    end
end
callbacks.Register("Draw", "inverter", inverter)

-- anti knife

local antiknife_mode = 0; 
local antiknife_value = 7;

local antiknifeEnabled = gui.Checkbox(cKnifeGroup, "cluaknife_antiknife", "Anti-Knife", false)

local antiknife, antiknife_modeB, antiknife_valueB;

antiknife_modeB = gui.GetValue("msc_fakelag_mode")
antiknife_valueB = gui.GetValue("msc_fakelag_value")
local function antiknifeE()
    if antiknifeEnabled:GetValue() and me ~= nil then
        if cMenu:IsActive() then 
            antiknife_modeB = gui.GetValue("msc_fakelag_mode")
            antiknife_valueB = gui.GetValue("msc_fakelag_value")
            return 
        end
        if input.IsButtonDown(69)  then
            gui.SetValue("msc_fakelag_mode", antiknife_mode)
            gui.SetValue("msc_fakelag_value", antiknife_value)
        else
            gui.SetValue("msc_fakelag_mode", antiknife_modeB)
            gui.SetValue("msc_fakelag_value", antiknife_valueB)
        end
    end
end
callbacks.Register("Draw", "antiknifeE", antiknifeE)

-- USE desync

local desync_pitch, desync_yaw = 0;

local desyncEnabled = gui.Checkbox(cDesyncgroup, "cluaknife_desync", "ON USE Desync", false)

local desync_pitchS, desync_yawS, desync_pitchM, desync_yawM

desync_pitchS = gui.GetValue("rbot_antiaim_stand_pitch_real")
desync_yawS = gui.GetValue("rbot_antiaim_stand_real")
desync_pitchM = gui.GetValue("rbot_antiaim_move_pitch_real")
desync_yawM = gui.GetValue("rbot_antiaim_move_real")
local function eDesync()
    if desyncEnabled:GetValue() and me ~= nil then
        if cMenu:IsActive() then 
            desync_pitchS = gui.GetValue("rbot_antiaim_stand_pitch_real")
            desync_yawS = gui.GetValue("rbot_antiaim_stand_real")
            desync_pitchM = gui.GetValue("rbot_antiaim_move_pitch_real")
            desync_yawM = gui.GetValue("rbot_antiaim_move_real")
            return 
        end
        if input.IsButtonDown(69) then
            gui.SetValue("rbot_antiaim_stand_pitch_real", desync_pitch)
            gui.SetValue("rbot_antiaim_stand_real",desync_yaw)
            gui.SetValue("rbot_antiaim_move_pitch_real", desync_pitch)
            gui.SetValue("rbot_antiaim_move_real", desync_yaw)
        else
            gui.SetValue("rbot_antiaim_stand_pitch_real", desync_pitchS)
            gui.SetValue("rbot_antiaim_stand_real", desync_yawS)
            gui.SetValue("rbot_antiaim_move_pitch_real", desync_pitchM)
            gui.SetValue("rbot_antiaim_move_real", desync_yawM)

        end
    end
end
callbacks.Register("Draw", "eDesync", eDesync)

-- disable autostrafer on jump

local straferDisabled = gui.Checkbox(cFixesGroup, "cluafixes_strafer", "Jumpshot anti-strafer", false)

local function jumpStrafer()
    if gui.GetValue("cluafixes_strafer") == true then
        local velocity = vector.Length(entities.GetLocalPlayer():GetPropVector("localdata", "m_vecVelocity[0]")) -- Thanks to Tomeno!
        gui.SetValue("msc_autostrafer_enable", 0)
        if input.IsButtonDown(32) then
            local x,y,z = entities.GetLocalPlayer():GetPropVector("localdata", "m_vecVelocity[0]") -- Thanks to Tomeno & CloudFlare1337!
            local velocity = math.sqrt(x^2 + y^2)
            if velocity >= 5 then
                gui.SetValue("msc_autostrafer_enable", 1)
            else
                gui.SetValue("msc_autostrafer_enable", 0)
            end
        end
    end
end
callbacks.Register("CreateMove", jumpStrafer)

-- indicators

local function indicators()
    if entities.GetLocalPlayer() ~= nil then
        local x,y = draw.GetScreenSize()
        local textFont = draw.CreateFont('Verdana', 50, 700)
        draw.SetFont(textFont)
        if not rightDesync then
            if gui.GetValue("cluadesync_text") == true then
                draw.Color(66, 135, 245, 255)
                draw.Text(30, y - 600, "DSIDE: LEFT")
                draw.TextShadow(30, y - 600, "DSIDE: LEFT")
            end

            if gui.GetValue("cluadesync_arrows") == true then
                draw.Color(66, 135, 245, 255)
                draw.Text(x/2 - x/16, y/2 - 25, "?")
                draw.TextShadow(x/2 - x/16, y/2 - 25, "?")
                draw.Color(255, 255, 255, 255)
                draw.Text(x/2 + x/21.4412955466, y/2 - 25, "?")
                draw.TextShadow(x/2 + x/21.4412955466, y/2 - 25, "?")
            end

        else if rightDesync then
            if gui.GetValue("cluadesync_text") == true then
                draw.Color(66, 135, 245, 255)
                draw.Text(30, y - 600, "DSIDE: RIGHT")
                draw.TextShadow(30, y - 600, "DSIDE: RIGHT")
            end

            if gui.GetValue("cluadesync_arrows") == true then
                draw.Color(255, 255, 255, 255)
                draw.Text(x/2 - x/16, y/2 - 25, "?")
                draw.TextShadow(x/2 - x/16, y/2 - 25, "?")
                draw.Color(66, 135, 245, 255)
                draw.Text(x/2 + x/21.4412955466, y/2 - 25, "?")
                draw.TextShadow(x/2 + x/21.4412955466, y/2 - 25, "?")
            end
        else
            if gui.GetValue("cluadesync_text") == true then
                draw.Color(66, 135, 245, 255)
                draw.Text(30, y - 600, "DSIDE: OFF")
                draw.TextShadow(30, y - 600, "DSIDE: OFF")
            end

            if gui.GetValue("cluadesync_arrows") == true then
                draw.Color(255, 255, 255, 255)
                draw.Text(x/2 - x/16, y/2 - 25, "?")
                draw.TextShadow(x/2 - x/16, y/2 - 25, "?")
                draw.Color(255, 255, 255, 255)
                draw.Text(x/2 + x/21.4412955466, y/2 - 25, "?")
                draw.TextShadow(x/2 + x/21.4412955466, y/2 - 25, "?")
            end
        end
        end
    end
end
callbacks.Register("Draw", "indicators", indicators)



--[[
    FIXES FOR VARIOUS SHIT
]]--

-- revolver fix | credits to adrianobessa5682 OR original author

local revolverEnabled = gui.Checkbox(cFixesGroup, "cluafixes_revolver", "Revolver fix", false)

local cnt = 0
local cntmax = 15;
local function revolverFix(cmd)
    gui.SetValue("rbot_revolver_autocock", 0)
    if revolverEnabled:GetValue() and me ~= nil then
        local wep = me:GetPropEntity("m_hActiveWeapon")
        if wep ~= nil and wep:GetWeaponID() == 64 then
            cnt = cnt + 1
            if cnt <= cntmax then
                cmd:SetButtons(cmd:GetButtons() | (1 << 0))
            else
                cnt = 0
                
                local m_flPostponeFireReadyTime = wep:GetPropFloat("m_flPostponeFireReadyTime")
                if m_flPostponeFireReadyTime > 0 and m_flPostponeFireReadyTime < globals.CurTime() then
                    cmd:SetButtons(cmd:GetButtons() & ~(1 << 0))
                end
            end
        end
    end
end

callbacks.Register("CreateMove", revolverFix)

-- fakeduck fix

local fakeduckEnabled = gui.Checkbox(cFixesGroup, "cluafixes_fakeduck", "Fakeduck Fakelag", false)
local fakeduckDisable = gui.Checkbox(cFixesGroup, "cluafixes_fakeduckdisable", "Fakeduck AA fix", false)
local fakeduckKey = gui.GetValue("rbot_antiaim_fakeduck")
local fakeducking = false

local fakeduck_mode = 0; 

local fakeduck_value = 4;
local fakeduck_valueB, fakeduck_modeB, desyncS, desyncM;


function fakeduckFix()
    if entities.GetLocalPlayer() ~= nil then
        if fakeduckEnabled:GetValue() == true and fakeduckKey ~= nil then
            if input.IsButtonDown( fakeduckKey ) then
                if fakeducking == false then
                    fakeduck_modeB = gui.GetValue("msc_fakelag_mode")
                    fakeduck_valueB = gui.GetValue("msc_fakelag_value")
                    desyncS = gui.GetValue("rbot_antiaim_stand_desync")
                    desyncM = gui.GetValue("rbot_antiaim_move_desync")
                    fakeducking = true;
                end
                if fakeduckDisable:GetValue() == true then
                    gui.SetValue("rbot_antiaim_stand_desync", 0)
                    gui.SetValue("rbot_antiaim_move_desync", 0)
                end
                gui.SetValue("msc_fakelag_mode", fakeduck_mode)
                gui.SetValue("msc_fakelag_value", fakeduck_value)
            else
                if fakeducking == true then
                    gui.SetValue("msc_fakelag_mode", fakeduck_modeB)
                    gui.SetValue("msc_fakelag_value", fakeduck_valueB)
                    gui.SetValue("rbot_antiaim_stand_desync", desyncS)
                    gui.SetValue("rbot_antiaim_move_desync", desyncM)
                    fakeducking = false;
                end
            end
        end
    end
end
callbacks.Register("Draw", "fakeduckFix", fakeduckFix)

-- menu hide

local ogMenu = gui.Reference("MENU");

local function hideMenu()
    if ogMenu:IsActive() then
        cActive = 1
    else
        cActive = 0
    end
    if (cMenu:GetValue()) then
        cWindow:SetActive(cActive);
    else
        cWindow:SetActive(0);
    end
end
callbacks.Register("Draw", "hideMenu", hideMenu)