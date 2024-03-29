

local gui_set = gui.SetValue;
local gui_get = gui.GetValue;
local LeftKey = 0;
local BackKey = 0;
local RightKey = 0;
local rage_ref = gui.Reference("RAGE", "MAIN", "Anti-Aim Main");
local check_indicator = gui.Checkbox( rage_ref, "Enable", "Manual AA", false)
local AntiAimleft = gui.Keybox(rage_ref, "Anti-Aim_left", "Left Keybind", 0);
local AntiAimRight = gui.Keybox(rage_ref, "Anti-Aim_Right", "Right Keybind", 0);
local AntiAimBack = gui.Keybox(rage_ref, "Anti-Aim_Back", "Back Keybind", 0);

local rifk7_font = draw.CreateFont("Verdana", 20, 700)
local damage_font = draw.CreateFont("Verdana", 15, 700)

local arrow_font = draw.CreateFont("Marlett", 45, 700)
local normal = draw.CreateFont("Arial")

local function main()
    if AntiAimleft:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimleft:GetValue()) then
            LeftKey = LeftKey + 1;
            BackKey = 0;
            RightKey = 0;
        end
    end
    if AntiAimBack:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimBack:GetValue()) then
            BackKey = BackKey + 1;
            LeftKey = 0;
            RightKey = 0;
        end
    end
    if AntiAimRight:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimRight:GetValue()) then
            RightKey = RightKey + 1;
            LeftKey = 0;
            BackKey = 0;
        end
    end
end


function CountCheck()
   if ( LeftKey == 1 ) then
        BackKey = 0;
        RightKey = 0;
   elseif ( BackKey == 1 ) then
        LeftKey = 0;
        RightKey = 0;
    elseif ( RightKey == 1 ) then
        LeftKey = 0;
        BackKey = 0;
    elseif ( LeftKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
   elseif ( BackKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
   elseif ( RightKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
   end        
end

function SetLeft()
   gui_set("rbot_antiaim_stand_real_add", -90);
    gui_set("rbot_antiaim_move_real_add", -90);
    gui_set("rbot_antiaim_autodir", false);
end

function SetBackWard()
   gui_set("rbot_antiaim_stand_real_add", 0);
    gui_set("rbot_antiaim_move_real_add", 0);
    gui_set("rbot_antiaim_autodir", false);
end

function SetRight()
   gui_set("rbot_antiaim_stand_real_add", 90);
    gui_set("rbot_antiaim_move_real_add", 90);
    gui_set("rbot_antiaim_autodir", false);
end

function SetAuto()
   gui_set("rbot_antiaim_stand_real_add", 0);
    gui_set("rbot_antiaim_move_real_add", 0);
    gui_set("rbot_antiaim_autodir", true);
end

function draw_indicator()

    local active = check_indicator:GetValue()

    if active then


        local w, h = draw.GetScreenSize();
        draw.SetFont(rifk7_font)
        if (LeftKey == 1) then
            SetLeft();
            draw.Color(129, 255, 254, 255);
            draw.Text(15, h - 560, "MANUAL");
            draw.TextShadow(15, h - 560, "MANUAL");
			draw.SetFont(arrow_font)
			draw.Text( w/2 - 100, h/2 - 21, "3");
			draw.TextShadow( w/2 - 100, h/2 - 21, "3");
			draw.SetFont(rifk7_font)
        elseif (BackKey == 1) then
            SetBackWard();
            draw.Color(129, 255, 254, 255);
            draw.Text(15, h - 560, "MANUAL");
            draw.TextShadow(15, h - 560, "MANUAL");
			draw.SetFont(arrow_font)
			draw.Text( w/2 - 21, h/2 + 60, "6");
			draw.TextShadow( w/2 - 21, h/2 + 60, "6");
			draw.SetFont(rifk7_font)
        elseif (RightKey == 1) then
            SetRight();
            draw.Color(129, 255, 254, 255);
            draw.Text(15, h - 560, "MANUAL");
            draw.TextShadow(15, h - 560, "MANUAL");
			draw.SetFont(arrow_font)
			draw.Text( w/2 + 60, h/2 - 21, "4");
			draw.TextShadow( w/2 + 60, h/2 - 21, "4");
			draw.SetFont(rifk7_font)
        elseif ((LeftKey == 0) and (BackKey == 0) and (RightKey == 0)) then
            SetAuto();
            draw.Color(107, 244, 65, 255);
            draw.Text(15, h - 560, "AUTO");
            draw.TextShadow(15, h - 560, "AUTO");
        end
        draw.SetFont(normal)
    end
end

callbacks.Register( "Draw", "main", main);
callbacks.Register( "Draw", "CountCheck", CountCheck);
callbacks.Register( "Draw", "SetLeft", SetLeft);
callbacks.Register( "Draw", "SetBackWard", SetBackWard);
callbacks.Register( "Draw", "SetRight", SetRight);
callbacks.Register( "Draw", "SetAuto", SetAuto);
callbacks.Register( "Draw", "draw_indicator", draw_indicator);