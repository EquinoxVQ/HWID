function SkyBox()
    if (client.GetConVar("sv_skyname") ~= "pink1" and gui.GetValue("msc_restrict") ~= 1) then
        client.SetConVar("sv_skyname", "pink1")    
    end
end

callbacks.Register("Draw", "SkyBox", SkyBox)