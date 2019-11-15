function rainbowmenu()

   local speed = 3
   local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
   local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
   local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
   local a = 255
   
   for k,v in pairs({  "clr_gui_window_logo1",
                       "clr_gui_window_footer_text",
                       "clr_gui_checkbox_on",
                       "clr_gui_checkbox_on_hover",
                       "clr_gui_tablist4",
                       "clr_gui_tablist1",
                       "clr_gui_slider_button",
                       "clr_gui_window_header_tab2"}) do
                       
       gui.SetValue(v, r,g,b,a)
       
   end
end

callbacks.Register( "Draw", "owo", rainbowmenu);