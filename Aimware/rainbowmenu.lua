function rainbowmenu() 

  local speed = 1
  local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
  local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
  local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
  local a = 255
  
  for k,v in pairs({  "clr_gui_window_logo1", 
                       "clr_gui_window_header_tab1",
                       "clr_gui_window_header_tab2"                     
                    }) do
                      
      gui.SetValue(v, r,g,b,a)
      
  end
end

callbacks.Register( "Draw", "rmenu", rainbowmenu);