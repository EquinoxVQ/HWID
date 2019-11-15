function on_sniper_AWP(Event)    
    if (Event:GetName() ~= 'item_equip') then
       return;
    end

   if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
       if Event:GetString('item') == "awp" then

            drawAWPCH = true
       elseif Event:GetString('item') ~= "awp" then
            drawAWPCH = false
            return;
       end
   end

end
-- AWP CROSSHAIR -------------------------------------------------------
function ifawp()        
         if drawAWPCH == true then
                draw.Color(gui.GetValue("clr_gui_window_footer_text"))
         draw.Text(959,529, "|") -- middle bar 1
         draw.Text(959,537, "|") -- middle bar 2 
         draw.Text(952,529, "__") -- across bar 1
         draw.Text(959,529, "__") -- across bar 2
-- AWP CROSSHAIR ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
end
end


function on_sniper_SSG(Event)    
    if (Event:GetName() ~= 'item_equip') then
       return;
    end

   if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
       if Event:GetString('item') == "ssg08" then

            drawSSGCH = true
       elseif Event:GetString('item') ~= "ssg08" then
            drawSSGCH = false
            return;
       end
   end

end
--SCOUT CROSSHAIR ------------------------------------------------------
function ifssg()
         if drawSSGCH == true then
                 draw.Color(gui.GetValue("clr_gui_window_footer_text"))
         draw.Text(959,529, "|") -- middle bar 1
         draw.Text(959,537, "|") -- middle bar 2 
         draw.Text(952,529, "__") -- across bar 1
         draw.Text(959,529, "__") -- across bar 2
end
end
-- SCOUT CROSSHAIR ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^       


client.AllowListener('item_equip');
callbacks.Register("FireGameEvent", "on_sniper_AWP", on_sniper_AWP);
callbacks.Register("FireGameEvent", "on_sniper_SSG", on_sniper_SSG);
callbacks.Register("Draw", "ifawp", ifawp);
callbacks.Register("Draw", "ifssg", ifssg);