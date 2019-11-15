function Arrow()
if entities.GetLocalPlayer() ~= nil and entities.GetLocalPlayer():IsAlive() then

local font = draw.CreateFont("", 18);
draw.SetFont(font);

local w, h = draw.GetScreenSize()
local w = w/2
local h = h/2

local antiaim = gui.GetValue("rbot_antiaim_stand_real_add")
        
        if antiaim == 0 then

       draw.Color(255,25,25,200);
       draw.Text(w-3.5,h+30, "v")
        
        draw.Color(255,255,255.200);
       draw.Text(w-38,h+0, "<")
        
        draw.Color(255,255,255,200);
       draw.Text(w+30,h+0, ">")
       
        elseif antiaim == 90 then
        
        draw.Color(255,255,255,200);
       draw.Text(w-3.5,h+30, "v")
        
        draw.Color(255,255,255,200);
       draw.Text(w-38,h+0, "<")
        
        draw.Color(255,25,25,200);
       draw.Text(w+30,h+0, ">")
       
        elseif antiaim == -90 then
        
        draw.Color(255,255,255,200);
       draw.Text(w-3.5,h+30, "v")
        
        draw.Color(255,25,25,200);
       draw.Text(w-38,h+0, "<")
        
        draw.Color(255,255,255,200);
       draw.Text(w+30,h+0, ">")
        
   end
    
end

end

callbacks.Register("Draw", "Arrow", Arrow)