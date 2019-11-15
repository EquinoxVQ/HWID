local gui_set = gui.SetValue;
local gui_get = gui.GetValue;
local LeftKey = 0;
local BackKey = 0;
local RightKey = 0;

local function main()
    if input.IsButtonPressed(90) then
        LeftKey = LeftKey + 1;
        BackKey = 0;
        RightKey = 0;
    elseif input.IsButtonPressed(88) then
        BackKey = BackKey + 1;
        LeftKey = 0;
        RightKey = 0;
    elseif input.IsButtonPressed(67) then
        RightKey = RightKey + 1;
        LeftKey = 0;
        BackKey = 0;
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
   gui_set("rbot_antiaim_stand_real_add", -4);
    gui_set("rbot_antiaim_move_real_add", -80);
	gui_set("rbot_antiaim_move_desync", 3);
	gui_set("rbot_antiaim_stand_desync", 2);
    
end

function SetBackWard()
   gui_set("rbot_antiaim_stand_real_add", 70);
    gui_set("rbot_antiaim_move_real_add", 80);
	gui_set("rbot_antiaim_move_desync", 2);
	gui_set("rbot_antiaim_stand_desync", 2);
    
end

function SetRight()
   gui_set("rbot_antiaim_stand_real_add", -2);
    gui_set("rbot_antiaim_move_real_add", 90);
	gui_set("rbot_antiaim_move_desync", 2);
	gui_set("rbot_antiaim_stand_desync", 3);
    
end

function SetAuto()
   gui_set("rbot_antiaim_stand_real_add", 0);
    gui_set("rbot_antiaim_move_real_add", 0);
    
end
	


function draw_indicator()
   local w,h = draw.GetScreenSize();
    if ( LeftKey == 1 ) then
        SetLeft();
        draw.Color(gui.GetValue("clr_gui_window_footer_text"));
        draw.Text(5,(h/2)+100, "<--Left" );
    elseif ( BackKey == 1 ) then
        SetBackWard();
        draw.Color(gui.GetValue("clr_gui_window_footer_text"));
        draw.Text(5,(h/2)+100, "^Back^" );
    elseif ( RightKey == 1 ) then
        SetRight();
        draw.Color(gui.GetValue("clr_gui_window_footer_text"));
        draw.Text(5,(h/2)+100, "Right-->" );
    elseif ((LeftKey == 0) and (BackKey == 0) and (RightKey == 0)) then
        SetAuto();
        draw.Color(gui.GetValue("clr_gui_window_footer_text"));
        draw.Text(5,(h/2)+100, "<-Auto->" );
    end
end

callbacks.Register( "Draw", "main", main);
callbacks.Register( "Draw", "CountCheck", CountCheck);
callbacks.Register( "Draw", "SetLeft", SetLeft);
callbacks.Register( "Draw", "SetBackWard", SetBackWard);
callbacks.Register( "Draw", "SetRight", SetRight);
callbacks.Register( "Draw", "SetAuto", SetAuto);
callbacks.Register( "Draw", "draw_indicator", draw_indicator);
