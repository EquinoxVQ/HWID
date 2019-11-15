---------------------------------------------------- Glow ----------------------------------------------------

-- Credits: Nexxed
-- Change this to your liking, it's how fast it pulses.
local speed = 12;
 
-- PUT YOUR GUI ELEMENTS HERE --
-- v = vector (so shit like cham colors where R, G, B and A are all in one var)
-- s = single (stuff that takes a single value - e.g. vis_viewfov)
-- sf = single-float (like glow alpha (0.000 - 1.000))
local guiElements = {
    ["vis_glowalpha"] = "sf"
};
 
 
-- Don't edit anything down here.
local cs, cd = 0, 0;
local function updateAlpha()
    for k, v in pairs(guiElements) do
        if (v == "v") then
            local r, g, b, a = gui.GetValue(k);
            gui.SetValue(k, r, g, b, cs);
        elseif (v == "s") then
            gui.SetValue(k, cs);
        elseif (v == "sf") then
            local p = cs / 255;
            gui.SetValue(k, p);
        end
    end
end
 
callbacks.Register("Draw", "Nex.Glow.Draw", function()
    if (cs >= 255) then
        cd = 1;
    elseif (cs <= speed) then
        cd = 0;
    end
    
    if (cd == 0) then
        cs = cs + speed;
    elseif (cd == 1) then
        cs = cs - speed;
    end
 
    updateAlpha();
end);