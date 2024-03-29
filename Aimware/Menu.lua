-- stuff
local draw_Line, draw_TextShadow, draw_Color, draw_Text, g_tickinterval, string_format, math_exp, math_rad, math_max, math_abs, math_tan, math_sin, math_cos, math_fmod, draw_GetTextSize, draw_FilledRect, draw_RoundedRect, draw_RoundedRectFill, draw_CreateFont, draw_SetFont, client_WorldToScreen, draw_GetScreenSize, client_GetConVar, client_SetConVar, client_exec, PlayerNameByUserID, PlayerIndexByUserID, GetLocalPlayer, gui_SetValue, gui_GetValue, LocalPlayerIndex, c_AllowListener, cb_Register, g_tickcount, g_realtime, g_curtime, g_absoluteframetime, math_floor, math_sqrt, GetPlayerResources, entities_FindByClass, IsButtonPressed, client_ChatSay, table_insert, table_remove = draw.Line, draw.TextShadow, draw.Color, draw.Text, globals.TickInterval, string.format, math.exp, math.rad, math.max, math.abs, math.tan, math.sin, math.cos, math.fmod, draw.GetTextSize, draw.FilledRect, draw.RoundedRect, draw_RoundedRectFill, draw.CreateFont, draw.SetFont, client.WorldToScreen, draw.GetScreenSize, client.GetConVar, client.SetConVar, client.Command, client.GetPlayerNameByUserID, client.GetPlayerIndexByUserID, entities.GetLocalPlayer, gui.SetValue, gui.GetValue, client.GetLocalPlayerIndex, client.AllowListener, callbacks.Register, globals.TickCount, globals.RealTime, globals.CurTime, globals.AbsoluteFrameTime, math.floor, math.sqrt, entities.GetPlayerResources, entities.FindByClass, input.IsButtonPressed, client.ChatSay, table.insert, table.remove
-------------- References
local L_RefE = gui.Reference("LEGIT", "Extra")
local V_RefM = gui.Reference("VISUALS", "Shared")
local G_VM = gui.Groupbox(V_RefM, "Extra Features", 0, 397, 200, 221)
local VOO_Ref = gui.Reference("VISUALS", "OTHER", "Options")
local VEO_Ref = gui.Reference("VISUALS", "ENEMIES", "Options")
local VEF_Ref = gui.Reference("VISUALS", "ENEMIES", "Filter")
local VTO_Ref = gui.Reference("VISUALS", "TEAMMATES", "Options")
local M_Ref1 = gui.Reference("MISC", "GENERAL", "Main")
local G_M1 = gui.Groupbox(M_Ref1, "Extra Features", 0, 206, 200, 223)
-------------- Font
local fontz = draw_CreateFont("Tahoma", 30);
local fontS = draw_CreateFont("Tahoma", 20);
local ff = draw_CreateFont("Tahoma");
-------------- Better Grenades
local better_grenades = gui.Checkbox(VOO_Ref, "esp_other_better_grenades", "Better Grenades", false)
-------------- Hit Log 
local HitLog = gui.Checkbox(G_M1, "msc_hitlog", "Hit Log", false)
-------------- Auto Buy
local AB_Show = gui.Checkbox(G_M1, "msc_autobuy", "AutoBuy", false)
local AB_W = gui.Window("AB_W", "Auto Buy", 200, 200, 200, 328);
local AB_GB = gui.Groupbox(AB_W, "Auto Buy Settings", 15, 14, 170, 268);
local AB_E = gui.Checkbox(AB_GB, "AB_Active", "Active", false);
local PrimaryWeapons = gui.Combobox(AB_GB, 'AB_Primary_Weapons', "Primary Weapons", "Off", "AK | M4", "Scout", "SG553 | AUG", "AWP", "Auto");
local SecondaryWeapons = gui.Combobox(AB_GB, 'AB_Secondary_Weapons', "Secondary Weapons", "Off", "Elite", "P250", "Tec-9 | Five-Seven", "R8 | Deagle");
local Armor = gui.Combobox(AB_GB, 'AB_Armor', "Armor", "Off", "Kevlar", "Kevlar + Helmet");
local Nades = gui.Checkbox(AB_GB, "AB_Nades", "Grenades", false);
local Zeus = gui.Checkbox(AB_GB, "AB_Zeus", "Zeus", false);
local Defuser = gui.Checkbox(AB_GB, "AB_Defuser", "Defuser", false);
-------------- View Model Extender
local function VM_Cache() xO = client_GetConVar("viewmodel_offset_x"); yO = client_GetConVar("viewmodel_offset_y"); zO = client_GetConVar("viewmodel_offset_z"); fO = client_GetConVar("viewmodel_fov"); end; VM_Cache()
local ViewModelShown = gui.Checkbox(G_M1, "msc_vme", "Viewmodel Changer", false)
local VM_W = gui.Window("VM_W", "Viewmodel Extender", 200,200,200,300)
local VMStuff = gui.Groupbox(VM_W, "Viewmodel Stuff", 15, 14, 170, 240)
local VM_e = gui.Checkbox(VMStuff, "msc_vme", "Enable", false)
local xS = gui.Slider(VMStuff, "VM_X", "X", xO, -20, 20)
local yS = gui.Slider(VMStuff, "VM_Y", "Y", yO, -100, 100)
local zS = gui.Slider(VMStuff, "VM_Z", "Z", zO, -20, 20)
local vfov = gui.Slider(VMStuff, "VM_fov", "Viewmodel FOV", fO, 0, 120)
-------------- Sniper Crosshair
local ComboCrosshair = gui.Combobox(G_VM, "vis_sniper_crosshair", "Sniper Crosshair", "Off", "Engine Crosshair", "Engine Crosshair (+scoped)", "Aimware Crosshair", "Draw Crosshair")
-------------- Scoped FOV Fix
local s_fovfix = gui.Checkbox(G_VM, "vis_fixfov", "Fix Scoped FOV", false)
local fov_value = gui_GetValue("vis_view_fov")
local vm_fov_value = gui_GetValue("vis_view_model_fov")
-------------- Knife On Left Hand
local K_O_L_H = gui.Checkbox(G_M1, "msc_knifelefthand", "Knife On Left Hand", false)
-------------- Bomb Timer
local BombTimer = gui.Checkbox(VOO_Ref, "esp_other_better_c4timer", "Bomb Timer", false)
-------------- Bomb Damage
local Bomb_Damage = gui.Checkbox(VOO_Ref, "esp_other_bombdamage", "Bomb Damage", false)
-------------- Chat Spammer
local CC_Show = gui.Checkbox(G_M1, "msc_chat_spams", "Chat Spams", false)
local CC_W = gui.Window("CC_W", "Chat Spam", 200,200,200,331)
local CC_G1 = gui.Groupbox(CC_W, "Chat Spams", 15, 15, 170, 269)
local CC_Spams = gui.Combobox(CC_G1, "CC_Spam", "Spams", "Off", "Spam 1", "Spam 2", "Spam 3", "Clear Chat")
local CC_Spam_spd = gui.Slider(CC_G1, "CC_Spam_Speed", "Spam Speed", 67.5, 10, 250)
local chatspam1txt = gui.Text(CC_G1, "Spam 1"); local ChatSpam1 = gui.Editbox(CC_G1, "CC_Spam1", "Custom Chat Spam 1")
local chatspam2txt = gui.Text(CC_G1, "Spam 2"); local ChatSpam2 = gui.Editbox(CC_G1, "CC_Spam2", "Custom Chat Spam 2")
local chatspam3txt = gui.Text(CC_G1, "Spam 3"); local ChatSpam3 = gui.Editbox(CC_G1, "CC_Spam3", "Custom Chat Spam 3")
-------------- Aspect Ratio Changer
local aspect_ratio_table = {};
local aspect_ratio_check = gui.Checkbox(G_M1, "msc_aspect_enable", "Aspect Ratio Changer", false) 
local aspect_ratio_reference = gui.Slider(G_M1, "msc_aspect_value", "Force aspect ratio", 100, 1, 199) -- % times your original ratio
-------------- Esp On Dead
local espdead = gui.Checkbox(VEF_Ref, "esp_espondead", "ESP when dead", false)
-------------- Engine Radar
local ERadar = gui.Checkbox(G_VM, "esp_engine_radar", "Engine Radar", false)
-------------- Team & Enemy Tracers
local tracersEnemy = gui.Checkbox(VEO_Ref, "esp_enemy_tracer", "Tracers", false)
local tracersTeam = gui.Checkbox(VTO_Ref, "esp_team_tracer", "Tracers", false)
-------------- Team & Enemy & Other Distance + visible help 
local enemy_distance = gui.Checkbox(VEO_Ref, "esp_enemy_distance", "Distance", false)
local enemy_visiblehelp = gui.Checkbox(VEO_Ref, "esp_enemy_vishelp", "Visible Help", false)
local team_distance = gui.Checkbox(VTO_Ref, "esp_team_distance", "Distance", false)
local other_distance = gui.Checkbox(VOO_Ref, "esp_other_distance", "Distance", false)
-------------- Full Bright
local fBright = gui.Checkbox(G_VM, "vis_fullbright", "Full Bright", false)
-------------- Disable Post Processing
local DPP = gui.Checkbox(G_VM, "vis_disable_post", "Disable Post Processing", false)
-------------- Third person on dead
local thirdpersonondead = gui.Checkbox(G_VM, "vis_thirdperson_ondead", "3rd Person While Dead", false)
-------------- Zeusbot
local zeusbot = gui.Checkbox(L_RefE, "lbot_zeusbot_enable", "Zeusbot", false)
local trigm, trigaf, trighc = gui_GetValue("lbot_trg_mode"), gui_GetValue("lbot_trg_autofire"), gui_GetValue("lbot_trg_hitchance")
-------------- Recoil Crosshair
local RecoilCrosshair = gui.Checkbox(G_VM, "msc_recoilcrosshair", "Recoil Crosshair", false)
-------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------- 
local abs_frame_time = g_absoluteframetime;
local frame_rate = 0.0;
local function get_abs_fps()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * abs_frame_time();
    return math_floor((1.0 / frame_rate) + 0.5);
end

local function distance2D(x1, y1, x2, y2) return math_floor(math_sqrt((x2-x1)^2 + (y2-y1)^2) * 0.0833); end
local function distance3D(x1, y1, z1, x2, y2, z2) return math_floor(math_sqrt((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2)* 0.0833); end

local pressed = true
function menus() if IsButtonPressed(gui_GetValue("msc_menutoggle")) then pressed = not pressed; end if pressed then if AB_Show:GetValue() then AB_W:SetActive(1); else AB_W:SetActive(0); end if ViewModelShown:GetValue() then VM_W:SetActive(1); else VM_W:SetActive(0); end if CC_Show:GetValue() then CC_W:SetActive(1); else CC_W:SetActive(0); end else AB_W:SetActive(0); VM_W:SetActive(0); CC_W:SetActive(0); end end
cb_Register("Draw", "shows", menus)

-------------------- Grenade Timers
local updatetick = 0; local grenades = {};
function EventHook(Event)
if Event:GetName() == "round_prestart" then grenades = {}; end
if Event:GetName() == "hegrenade_detonate" or Event:GetName() == "flashbang_detonate" 
or Event:GetName() == "inferno_expire" or Event:GetName() == "inferno_extinguish" then updatetick = g_tickcount(); 
for index,value in pairs(grenades) do 
if value[1] == Event:GetInt("entityid") then table_remove(grenades, index); end end end end
function ESPHook(Builder)
if better_grenades:GetValue() then
if Builder:GetEntity():GetClass() == "CBaseCSGrenadeProjectile" then
local found = false;
for index,value in pairs(grenades) do
if value[1] == Builder:GetEntity():GetIndex() then
DeltaT = (g_tickcount() - grenades[index][2]) * g_tickinterval();
Builder:AddBarBottom(1 - (DeltaT/1.65)); found = true; break; end end
if found == false and g_tickcount() > updatetick then
local gMatrix = {Builder:GetEntity():GetIndex(), g_tickcount()};
table_insert(grenades, gMatrix); end end end end
function DrawingHook()
draw_SetFont(ff);
if better_grenades:GetValue() then
for indexF,valueF in pairs(entities_FindByClass("CInferno")) do
local found = false;
for indexT,valueT in pairs(grenades) do
if valueT[1] == valueF:GetIndex() then
x, y = client_WorldToScreen(valueF:GetAbsOrigin())
local mollysize = 25;
if x ~= nil and y ~= nil then
draw_Color(0, 0, 0, 255); draw_RoundedRectFill( x - mollysize, y, x + mollysize, y + 4 ); draw_Color(227, 227, 227, 255);
local math = (((g_tickcount() - valueT[2]) * ((-1) - 1))/ ( (valueT[2] + 7 / g_tickinterval()) - valueT[2])) + 1
draw_RoundedRectFill(x - mollysize, y, x + mollysize * math, y + 4); draw_Color(255, 255, 255, 255); draw_RoundedRect(x - mollysize, y, x + mollysize, y + 4) 
local w,h = draw_GetTextSize( "MOLLY" ) 
draw_Text(x - w/2, y - h * 1.25 , "MOLLY"); draw_TextShadow(x - w/2, y - h * 1.25 , "MOLLY"); end found = true; break; end end
if found == false and g_tickcount() > updatetick then
local gMatrix = {valueF:GetIndex(), g_tickcount()}; table_insert(grenades, gMatrix); end end end end
c_AllowListener("inferno_expire"); c_AllowListener("inferno_extinguish"); c_AllowListener("molotov_detonate"); c_AllowListener("hegrenade_detonate"); c_AllowListener("flashbang_detonate"); 
cb_Register("Draw", "DrawingHookG", DrawingHook); cb_Register("DrawESP", "ESPHookG", ESPHook); cb_Register("FireGameEvent", "EventHookG", EventHook); 

-------------------- Hit Log
function HitGroup(i_hitgroup) if i_hitgroup == nil then return; elseif i_hitgroup == 0 then return "body"; elseif i_hitgroup == 1 then return "head"; elseif i_hitgroup == 2 then return "chest"; elseif i_hitgroup == 3 then return "stomach"; elseif i_hitgroup == 4 then return "left arm"; elseif i_hitgroup == 5 then return "right arm";  elseif i_hitgroup == 6 then return "left leg"; elseif i_hitgroup == 7 then return "right leg"; elseif i_hitgroup == 10 then return "body"; end end
local draw_hitsay = {};
function ChatLogger(Event)
if HitLog:GetValue() then
if Event:GetName() == nil then return;
elseif (Event:GetName() == 'player_hurt') then
local ME = LocalPlayerIndex();
local uid = Event:GetInt('userid');
local i_attacker = Event:GetInt('attacker');
local i_dmg = Event:GetString('dmg_health');
local i_health = Event:GetString('health');
local i_hitgroup = Event:GetInt('hitgroup');
local ind_Attacker = PlayerIndexByUserID(i_attacker);
local N_Attacker = PlayerNameByUserID(i_attacker);
local ind_Victim = PlayerIndexByUserID(uid);
local n_Victim = PlayerNameByUserID(uid);
hitPlayerName = ""; hitSpot = ""; hitDmg = ""; hitHealthRemaining = "";
hitPlayerName = n_Victim; hitSpot = i_hitgroup; hitDmg = i_dmg; hitHealthRemaining = i_health;
response = string_format("Hit %s in the %s for %s damage (%s health remaining)\n", hitPlayerName, HitGroup(hitSpot), hitDmg, hitHealthRemaining);
if ( ind_Attacker == ME and ind_Victim ~= ME ) then print(response);
table_insert(draw_hitsay, {g_realtime(), response}); end end end end
local On_Screen_Time, pixels_between_each_line, ScreenX, ScreenY = 10, 10, 8, 6
function hitlog()
if HitLog:GetValue() then local things_on_screen = 0;
for k, l in pairs(draw_hitsay) do
if g_realtime() > l[1] + On_Screen_Time then table_remove(draw_hitsay, k); else
draw_Color(255,255,255,255); draw_SetFont(ff); draw_TextShadow(ScreenX, things_on_screen * pixels_between_each_line + ScreenY, l[2]); things_on_screen = things_on_screen + 1; end end end end
c_AllowListener('player_hurt'); cb_Register('Draw', 'drawing your hits', hitlog); cb_Register('FireGameEvent', 'ChatLogger', ChatLogger);  

-------------------- Auto Buy 
SecondaryWeapon, PrimaryWeapon, armor = "", "", "";
function buy(Event)
if GetLocalPlayer() == nil then return end
if Event:GetName() == "player_spawn" then if PlayerIndexByUserID(Event:GetInt('userid')) == LocalPlayerIndex() then buy = true; end end
money = GetLocalPlayer():GetProp("m_iAccount");
if AB_E:GetValue() then if buy == true then
if (SecondaryWeapons:GetValue() == 0) then SecondaryWeapon = "";
elseif (SecondaryWeapons:GetValue() == 1) then SecondaryWeapon = 'buy "elite"; ';
elseif (SecondaryWeapons:GetValue() == 2) then SecondaryWeapon = 'buy "p250"; ';
elseif (SecondaryWeapons:GetValue() == 3) then SecondaryWeapon = 'buy "tec9"; ';
elseif (SecondaryWeapons:GetValue() == 4) then SecondaryWeapon = 'buy "deagle"; '; end
if money >= 200 or money < 1 then if Zeus:GetValue() then client_exec('buy "taser"', true); end end	
if money >= 2200 or money < 1 then PWb = true; end
if PWb == true then
if (PrimaryWeapons:GetValue() == 0) then PrimaryWeapon = "";
elseif (PrimaryWeapons:GetValue() == 1) then PrimaryWeapon = 'buy "ak47"; ';
elseif (PrimaryWeapons:GetValue() == 2) then PrimaryWeapon = 'buy "ssg08"; ';
elseif (PrimaryWeapons:GetValue() == 3) then PrimaryWeapon = 'buy "sg556"; ';
elseif (PrimaryWeapons:GetValue() == 4) then PrimaryWeapon = 'buy "awp"; ';
elseif (PrimaryWeapons:GetValue() == 5) then PrimaryWeapon = 'buy "scar20"; '; end
if Armor:GetValue() == 0 then armor = ""
elseif Armor:GetValue() == 1 then armor = 'buy "vest"; ';
elseif Armor:GetValue() == 2 then armor = 'buy "vest"; buy "vesthelm"'; end
if Nades:GetValue() then client_exec('buy "hegrenade"; buy "incgrenade"; buy "molotov"; buy "smokegrenade"; buy "flashbang"', true); end
if Defuser:GetValue() then client_exec("buy defuser", true); end
PWb = false; end
current_buy = (PrimaryWeapon.. SecondaryWeapon.. armor); client_exec(current_buy, true); buy = false; end end end
c_AllowListener("player_spawn"); cb_Register("FireGameEvent", "buy", buy); 

-------------------- View Model Extender
function VM_E() if VM_e:GetValue() then client_SetConVar("viewmodel_offset_x", xS:GetValue(), true); client_SetConVar("viewmodel_offset_y", yS:GetValue(), true); client_SetConVar("viewmodel_offset_z", zS:GetValue(), true); client_SetConVar("viewmodel_fov", vfov:GetValue(), true); end end
cb_Register("Draw", "vm sets", VM_E);

-------------------- Scoped Fov Fix
function scopefov()
local view_fov = gui_GetValue("vis_view_fov"); local view_model_fov = gui_GetValue("vis_view_model_fov");
if view_fov ~= 0 then fov_value = gui_GetValue("vis_view_fov"); end if view_model_fov ~= 0 then vm_fov_value = gui_GetValue("vis_view_model_fov"); end
if s_fovfix:GetValue() then 
if GetLocalPlayer() ~= nil then
if GetLocalPlayer():GetProp("m_bIsScoped") == 1 or GetLocalPlayer():GetProp("m_bIsScoped") == 257 then gui_SetValue("vis_view_fov", 0); gui_SetValue("vis_view_model_fov", 0); 
elseif view_fov == 0 then gui_SetValue("vis_view_fov", fov_value); gui_SetValue("vis_view_model_fov", vm_fov_value); end end end end
cb_Register("Draw", "scopefov", scopefov);

-------------------- Sniper Crosshair
function ifCrosshair()
if GetLocalPlayer() == nil then return; end
local Weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon");
local Scoped = GetLocalPlayer():GetProp("m_bIsScoped") == 1 or GetLocalPlayer():GetProp("m_bIsScoped") == 257
if Weapon == nil then return; end
local cWep = Weapon:GetClass();
if cWep == "CWeaponAWP" or cWep == "CWeaponSSG08" or cWep == "CWeaponSCAR20" or cWep == "CWeaponG3SG1" then drawCrosshair = true; 
else drawCrosshair = false; end 
local screenCenterX, screenY = draw_GetScreenSize(); local scX, scY = screenCenterX / 2, screenY / 2;
if drawCrosshair == true and ComboCrosshair:GetValue() == 0 then client_SetConVar("weapon_debug_spread_show", 0, true)
elseif drawCrosshair == true and ComboCrosshair:GetValue() == 1 then gui_SetValue('esp_crosshair', false); if Scoped then client_SetConVar("weapon_debug_spread_show", 0, true); else client_SetConVar("weapon_debug_spread_show", 3, true) end
elseif drawCrosshair == true and ComboCrosshair:GetValue() == 2 then gui_SetValue('esp_crosshair', false); client_SetConVar("weapon_debug_spread_show", 3, true)
elseif drawCrosshair == true and ComboCrosshair:GetValue() == 3 then if Scoped then gui_SetValue('esp_crosshair', false); else client_SetConVar("weapon_debug_spread_show", 0, true); gui_SetValue('esp_crosshair', true); end 
elseif drawCrosshair == false and ComboCrosshair:GetValue() == 3 then gui_SetValue('esp_crosshair', false)
elseif drawCrosshair == true and ComboCrosshair:GetValue() == 4 then client_SetConVar("weapon_debug_spread_show", 0, true); gui_SetValue('esp_crosshair', false); draw_SetFont(ff);
draw_Color(255,255,255,255); draw_Line(scX, scY - 8, scX, scY + 8); --[[ line down ]] draw_Line(scX - 8, scY, scX + 8, scY); --[[ line across ]] end end
cb_Register("Draw", "sniper crosshairs", ifCrosshair);

-------------------- Bomb Timer & defuse timer
local function mathfix() local screenX, screenY = draw_GetScreenSize() screenY3 = screenY/2; end cb_Register("Draw", "fix", mathfix);
colorchange, drawBar, drawDefuse, drawPlanting, plantedTime, plantedTime2, fill, fill2, fill3, plantingName, plantingStarted, plantingTime, plantingSite = 10, false, false, false, 0, 0, 0, screenY3, 0, "", 0, 3.125, ""
function bomb(event)
if event:GetName() == "bomb_beginplant" then drawPlanting = true; plantingName = PlayerNameByUserID(event:GetInt("userid")); plantingStarted = g_curtime(); plantingSite = ""; end
if event:GetName() == "bomb_abortplant" then drawPlanting = false; end
if event:GetName() == "bomb_planted" then plantedTime = g_curtime(); drawBar = true; drawPlanting = false; end
if event:GetName() == "bomb_begindefuse" then defusingName = PlayerNameByUserID(event:GetInt("userid")); plantedTime2 = g_curtime(); drawDefuse = true; end
if event:GetName() == "bomb_abortdefuse" then drawDefuse = false; fill2 = screenY3; fill3 = 0; end
if event:GetName() == "round_end" then drawBar = false; drawDefuse = false; drawPlanting = false; fill = 0; fill2 = screenY3; fill3 = 0; end end
function drawProgress()
if BombTimer:GetValue() then
local screenX, screenY = draw_GetScreenSize()
if drawBar then
local ToExplode = entities_FindByClass("CPlantedC4")
for i=1, #ToExplode do
c4time = math_floor(ToExplode[i]:GetProp("m_flTimerLength"))
if math_floor((plantedTime - g_curtime()) + c4time) > -1  then
local godownby = (screenY / c4time) / get_abs_fps()
C4time = string_format("%.1f", ((plantedTime - g_curtime()) + c4time))
if math_floor((plantedTime - g_curtime()) + c4time) <= colorchange then draw_Color(255,0,0,255) else draw_Color(0,255,0,255) end 
draw_FilledRect(0, fill, 10, screenY); draw_SetFont(ff); draw_Color(0,0,0,100); draw_FilledRect(0, 0, 10, screenY); fill = fill + godownby; end end end
if drawPlanting then
local plant_percentage = (g_curtime() - plantingStarted) / plantingTime; local planttime = string_format("%.1fs", (plantingStarted - g_curtime()) + plantingTime); 
if plant_percentage > 0 and 1 > plant_percentage then local remove_from_Y = screenY * (1 - plant_percentage); draw_SetFont(fontz);
draw_Color(255,255,255,255); draw_Text(15, 0, plantingSite.." - Planting"); draw_Color(255,255,255,255); draw_Text(15, 25, plantingName.. " - ".. planttime); draw_Color(0,255,0,255); draw_FilledRect(0, 0+remove_from_Y, 10, screenY+remove_from_Y); draw_Color(0,0,0,100); draw_FilledRect(0, 0, 10, screenY); draw_SetFont(ff); end end
if drawDefuse then
local ToDefuse = entities_FindByClass("CPlantedC4"); DefuseTime = math_floor(ToDefuse[1]:GetProp("m_flDefuseLength")); DefuseT = string_format("%.1fs", (plantedTime2 - g_curtime()) + DefuseTime); draw_SetFont(fontz); draw_Color(255,255,255,255); draw_Text(15, 50, defusingName.." - ".. DefuseT); draw_SetFont(ff); 
if DefuseTime == 10 then local godownby3 = (screenY / DefuseTime) / get_abs_fps(); draw_SetFont(ff); draw_Color(0,0,255,255); draw_FilledRect(0, fill3, 10, screenY); draw_Color(0,0,0,100); draw_FilledRect(0, 0, 10, screenY); fill3 = fill3 + godownby3;
elseif DefuseTime == 5 then screenY3 = screenY/2; local godownby2 = (screenY3 / DefuseTime) / get_abs_fps(); draw_SetFont(ff); draw_Color(0,0,255,255); draw_FilledRect(0, fill2, 10, screenY); draw_Color(0,0,0,100); draw_FilledRect(0, screenY3, 10, screenY); fill2 = fill2 + godownby2; end end end end

-------------------- Bomb Damage
function DrawDamage()
if Bomb_Damage:GetValue() then
if entities_FindByClass("CPlantedC4")[1] ~= nil then
local Bomb = entities_FindByClass("CPlantedC4")[1];
if C4time == nil or c4time == nil then return end
if Bomb:GetProp("m_bBombTicking") and Bomb:GetProp("m_bBombDefused") == 0 and g_curtime() < Bomb:GetProp("m_flC4Blow") then
local Player = GetLocalPlayer();
HealthToTake = string_format("%.0f", (DamagefromDomb(Bomb, Player))); draw_SetFont(fontz)
if Player:GetTeamNumber() == 3 and Player:GetProp("m_bHasDefuser") == 0 then if (plantedTime - g_curtime()) + c4time <= 10.05 then r, g, b, a = 255,13,13,255; else r, g, b, a = 255,255,255,255; end
elseif Player:GetTeamNumber() == 3 and Player:GetProp("m_bHasDefuser") == 1 then if (plantedTime - g_curtime()) + c4time <= 5.05 then r, g, b, a = 255,13,13,255; else r, g, b, a = 255,255,255,255; end else r, g, b, a = 255,255,255,255 end
local bombsite = Bomb:GetProp("m_nBombSite") == 0 and "A" or "B"
draw_Color(r, g, b, a); draw_Text(15, 0, bombsite.. " - ".. C4time.."s")
if g_curtime() < Bomb:GetProp("m_flC4Blow") then
if HealthToTake + 0.95 < Player:GetHealth() and HealthToTake - 0 > 0 then 
draw_Color(255,255,255,255); draw_Text(15, 25, "-"..math_floor(HealthToTake+1));
elseif HealthToTake + 1 >= Player:GetHealth() then draw_Color(255,0,0,255); draw_Text(15, 25, "FATAL"); end
end end end end draw_SetFont(ff); end
cb_Register('Draw', 'DrawDamage', DrawDamage);
function DamagefromDomb(Bomb, Player)
local C4Distance = math_sqrt((select(1,Bomb:GetAbsOrigin()) - select(1,Player:GetAbsOrigin())) ^ 2 + (select(2,Bomb:GetAbsOrigin()) - select(2,Player:GetAbsOrigin())) ^ 2 + (select(3,Bomb:GetAbsOrigin()) - select(3,Player:GetAbsOrigin())) ^ 2);
local Gauss = (C4Distance - 75.68) / 789.2 
local flDamage = 450.7 * math_exp(-Gauss * Gauss);
if Player:GetProp("m_ArmorValue") > 0 then
local flArmorRatio = 0.5; local flArmorBonus = 0.5;
if Player:GetProp("m_ArmorValue") > 0 then
local flNew = flDamage * flArmorRatio;
local flArmor = (flDamage - flNew) * flArmorBonus;
if flArmor > Player:GetProp("m_ArmorValue") then
flArmor = Player:GetProp("m_ArmorValue") * (1 / flArmorBonus); flNew = flDamage - flArmor; end; flDamage = flNew; end end
return math_max(flDamage, 0); end 
c_AllowListener('bomb_beginplant'); c_AllowListener('bomb_abortplant'); c_AllowListener('bomb_planted'); c_AllowListener("bomb_defused"); c_AllowListener('round_end'); c_AllowListener('bomb_begindefuse'); c_AllowListener('bomb_abortdefuse');
cb_Register('Draw', 'drawing bomb time', drawProgress); cb_Register('FireGameEvent', 'bomb thing', bomb);

-------------------- Chat Spams
local c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100
function custom_chat()
if CC_Spams:GetValue() == 0 then return
elseif CC_Spams:GetValue() == 1 and g_realtime() >= c_spammedlast then client_ChatSay(ChatSpam1:GetValue()); c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100;
elseif CC_Spams:GetValue() == 2 and g_realtime() >= c_spammedlast then client_ChatSay(ChatSpam2:GetValue()); c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100;
elseif CC_Spams:GetValue() == 3 and g_realtime() >= c_spammedlast then client_ChatSay(ChatSpam3:GetValue()); c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100;
elseif CC_Spams:GetValue() == 4 and g_realtime() >= c_spammedlast then client_ChatSay("\n ?? ??? ??? ??? ??? ??? ??? ??? ?? \n"); c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100; end end
cb_Register("Draw", "custom spam", custom_chat);
 
-------------------- Aspect Ratio Changer
local function gcd(m, n) while m ~= 0 do m, n = math_fmod(n, m), m; end return n; end
local function set_aspect_ratio(aspect_ratio_multiplier) local screen_width, screen_height = draw_GetScreenSize(); local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height; if aspect_ratio_multiplier == 1 or not aspect_ratio_check:GetValue() then aspectratio_value = 0; end client_SetConVar( "r_aspectratio", tonumber(aspectratio_value), true); end
local function on_aspect_ratio_changed() local screen_width, screen_height = draw_GetScreenSize(); for i=1, 200 do local i2=i*0.01;    i2 = 2 - i2; local divisor = gcd(screen_width*i2, screen_height); if screen_width*i2/divisor < 100 or i2 == 1 then aspect_ratio_table[i] = screen_width*i2/divisor .. ":" .. screen_height/divisor;  end  end local aspect_ratio = aspect_ratio_reference:GetValue()*0.01; aspect_ratio = 2 - aspect_ratio; set_aspect_ratio(aspect_ratio); end
cb_Register('Draw', "aspect ratio" ,on_aspect_ratio_changed);

-------------------- Esp on Dead
function ESP_Always_OnDead() 
if not espdead:GetValue() then return end
if GetLocalPlayer() == nil then return end
if GetLocalPlayer():GetHealth() <= 0 then
    gui_SetValue("esp_visibility_enemy", 0);
    gui_SetValue("esp_enemy_box", 3);
    gui_SetValue("esp_enemy_weapon", 1);
    gui_SetValue("esp_enemy_health", 2); gui_SetValue("esp_enemy_glow", 2);
	gui_SetValue("esp_enemy_skeleton", true); gui_SetValue("esp_enemy_name", true);
else
    gui_SetValue("esp_visibility_enemy", 1);
    gui_SetValue("esp_enemy_box", 0); gui_SetValue("esp_enemy_weapon", 0); gui_SetValue("esp_enemy_health", 0); gui_SetValue("esp_enemy_glow", 0);
	gui_SetValue("esp_enemy_skeleton", false); gui_SetValue("esp_enemy_name", false);	end end
cb_Register("Draw", "espalwaysondead", ESP_Always_OnDead);

-------------------- Engine Radar
function engineradar()
if ERadar:GetValue() then ERval = 1; else ERval = 0; end
for o, radar in pairs(entities_FindByClass("CCSPlayer")) do radar:SetProp("m_bSpotted", ERval); end end
cb_Register("Draw", "engine radar", engineradar);

-------------------- Enemy & Team Tracers
function Tracers()
if GetLocalPlayer() == nil then return end
local sX, sY = draw_GetScreenSize();
local lpTeamNum = GetLocalPlayer():GetProp("m_iTeamNum")
local players = entities_FindByClass("CCSPlayer");
for i = 1, #players do
	local player = players[i];
	local pX, pY, pZ = client_WorldToScreen(player:GetProp("m_vecOrigin"));
if tracersEnemy:GetValue() then
	if player:GetProp("m_iTeamNum") ~= lpTeamNum then
		if player:IsAlive() then
			if pX ~= nil and pY ~= nil then
				draw_Color(255, 0, 0, 255); draw_Line(sX/2, sY, pX, pY); end end end end
if tracersTeam:GetValue() then
	if player:GetProp("m_iTeamNum") == lpTeamNum then
		if player:IsAlive() then
			if pX ~= nil and pY ~= nil then
				draw_Color(0, 0, 255, 255); draw_Line(sX/2, sY, pX, pY); end end end end	
end end
cb_Register("Draw", "I'm already tracer", Tracers);

-------------------- Enemy & Team & Other Distance + visible help
function Distance(builder)
local ent = builder:GetEntity(); local ppX, ppY, ppZ = ent:GetProp("m_vecOrigin"); local lX, lY, lZ = GetLocalPlayer():GetProp("m_vecOrigin"); local dist = distance3D(ppX, ppY, ppZ, lX, lY, lZ);
if enemy_distance:GetValue() and ent:IsAlive() and ent:IsPlayer() and ent:GetTeamNumber() ~= GetLocalPlayer():GetTeamNumber() then builder:Color(255, 255, 255, 255); builder:AddTextBottom(dist.. "ft"); end
if team_distance:GetValue() and ent:IsAlive() and ent:IsPlayer() and ent:GetTeamNumber() == GetLocalPlayer():GetTeamNumber() then builder:Color(255, 255, 255, 255); builder:AddTextBottom(dist.. "ft"); end
if other_distance:GetValue() and not ent:IsPlayer() then builder:Color(255, 255, 255, 255); builder:AddTextBottom(dist.. "ft"); end
if enemy_visiblehelp:GetValue() and ent:IsAlive() and ent:IsPlayer() and ent:GetTeamNumber() ~= GetLocalPlayer():GetTeamNumber() then builder:Color(255, 255, 255, 255); builder:AddTextTop("VISIBLE"); end end
cb_Register("DrawESP", "distance", Distance)

-------------------- full bright
function full_bright() if fBright:GetValue() then client_SetConVar("mat_fullbright", 1, true); else client_SetConVar("mat_fullbright", 0, true); end end
cb_Register('Draw', "Full brightness" ,full_bright);

-------------------- Disable Post Processing
function Dis_PP() 
if DPP:GetValue() then client_SetConVar("mat_postprocess_enable", 0, true); else client_SetConVar("mat_postprocess_enable", 1, true); end end
cb_Register('Draw', "Disable Post Processing" ,Dis_PP);

-------------------- Knife on Left Hand
function on_knife_righthand()
if not K_O_L_H:GetValue() then return end
if GetLocalPlayer() == nil then return end
if GetLocalPlayer():GetHealth() == nil or GetLocalPlayer():GetHealth() <= 0 then client_exec("cl_righthand 1", true); return; end
local wep = GetLocalPlayer():GetPropEntity("m_hActiveWeapon");
if wep == nil then return; end local cwep = wep:GetClass();
if cwep == "CKnife" then client_exec("cl_righthand 0", true); else client_exec("cl_righthand 1", true); end end
cb_Register("Draw", "knife", on_knife_righthand); 

-------------------- 3rd person if you are dead
function ifyoudead() if thirdpersonondead:GetValue() then gui_SetValue("vis_thirdperson_mode", 1); if GetLocalPlayer():GetHealth() <= 0 then gui_SetValue("vis_thirdperson_dist", 150); else gui_SetValue("vis_thirdperson_dist", 0); end  return; end end 
cb_Register("Draw", "3rd", ifyoudead);

-------------------- Zeusbot
function zeuslegit()
if zeusbot:GetValue() then 
if GetLocalPlayer() ~= nil then local Weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
if Weapon ~= nil then local CWeapon = Weapon:GetClass()
if CWeapon == "CWeaponTaser" then gui_SetValue("lbot_trg_enable", 1); gui_SetValue("lbot_trg_mode", 0); gui_SetValue("lbot_trg_autofire", 1); gui_SetValue("lbot_trg_hitchance", 100)
else gui_SetValue("lbot_trg_enable", 0); gui_SetValue("lbot_trg_mode", trigm); gui_SetValue("lbot_trg_autofire", trigaf); gui_SetValue("lbot_trg_hitchance", trighc); end end end end end
cb_Register("Draw", "zeus", zeuslegit)

-------------------- Spectator list fix | made by anue
function speclistfix(E) if gui_GetValue("msc_showspec") == 1 then if E:GetName() == "round_start" then client_exec("cl_fullupdate", true); end end end c_AllowListener('round_start'); cb_Register('FireGameEvent', 'speclistfix', speclistfix)

-------------------- Recoil Crosshair | only recoil, doesn't account for spread
function RCC()
if not RecoilCrosshair:GetValue() then return end
if GetLocalPlayer():GetProp("m_iHealth") <= 0 then return end
local screenX, screenY = draw_GetScreenSize(); local x = screenX/2; local y = screenY/2;
local r, g, b, a = gui_GetValue("clr_esp_crosshair_recoil"); local recoil_scale = client_GetConVar("weapon_recoil_scale"); local fov = gui_GetValue("vis_view_fov"); 
local weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon"); local weapon_name = weapon:GetClass(); 
if weapon_name == "CWeaponAWP" or weapon_name == "CWeaponSSG08" then return end
if weapon:GetProp("m_flRecoilIndex") == 0 then return end
local aim_punch_angle_pitch, aim_punch_angle_yaw = GetLocalPlayer():GetPropVector("localdata", "m_Local", "m_aimPunchAngle")
if -aim_punch_angle_pitch >= 0.05 and -aim_punch_angle_pitch >= 0.05 then
local xX = screenX/fov; local yY = screenY/fov; local x = x - (xX * aim_punch_angle_yaw)*(recoil_scale/2); local y = y + (yY * aim_punch_angle_pitch)*(recoil_scale/2);
draw_Color(r, g, b, a); draw_RoundedRect(x-3, y-3, x+3, y+3); end end
cb_Register("Draw", "Recoil Crosshair", RCC)