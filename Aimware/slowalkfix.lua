local gui_set = gui.SetValue
local gui_get = gui.GetValue
local c_reg = callbacks.Register
local b_toggle = input.IsButtonDown

local auto =   gui_get("rbot_autosniper_autostop")
local awp =    gui_get("rbot_sniper_autostop")
local ssg =    gui_get("rbot_scout_autostop")
local rev =    gui_get("rbot_revolver_autostop")
local pist =   gui_get("rbot_pistol_autostop")
local smg =    gui_get("rbot_smg_autostop")
local rifle =  gui_get("rbot_rifle_autostop")
local shotg =  gui_get("rbot_shotgun_autostop")
local lmg =    gui_get("rbot_lmg_autostop")
local shared = gui_get("rbot_shared_autostop")



local key = "shift"

function SlowWalkFIX()


    if b_toggle(key) then
        draw.Color(0,255,0,255);
        draw.Text(10, 980, "SlowWalk FIX")
 gui_set("rbot_autosniper_autostop", 0)
 gui_set("rbot_lmg_autostop", 0)
 gui_set("rbot_pistol_autostop", 0)
 gui_set("rbot_revolver_autostop", 0)
 gui_set("rbot_rifle_autostop", 0)
 gui_set("rbot_scout_autostop", 0)
 gui_set("rbot_shared_autostop", 0)
 gui_set("rbot_shotgun_autostop", 0)
 gui_set("rbot_smg_autostop", 0) 
 gui_set("rbot_sniper_autostop", 0)

  else

 gui_set("rbot_autosniper_autostop", auto)
 gui_set("rbot_lmg_autostop", lmg)
 gui_set("rbot_pistol_autostop", pist)
 gui_set("rbot_revolver_autostop", rev)
 gui_set("rbot_rifle_autostop", rifle)
 gui_set("rbot_scout_autostop", ssg)
 gui_set("rbot_shared_autostop", shared)
 gui_set("rbot_shotgun_autostop", shotg)
 gui_set("rbot_smg_autostop", smg) 
 gui_set("rbot_sniper_autostop", awp)

    end
end


c_reg("Draw", "SlowWalk FIX", SlowWalkFIX)