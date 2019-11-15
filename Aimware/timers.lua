-- Bomb Info by Nyanpasu!

local defusing = false;

function EventHook(Event)
if Event:GetName() == "bomb_begindefuse" then
defusing = true;
elseif Event:GetName() == "bomb_abortdefuse" then
defusing = false;
elseif Event:GetName() == "round_officially_ended"
or Event:GetName() == "bomb_defused" or Event:GetName() == "bomb_exploded" then
defusing = false;
end
end


function DrawingHook()
if entities.FindByClass("CPlantedC4")[1] ~= nil then
local Bomb = entities.FindByClass("CPlantedC4")[1];

if Bomb:GetProp("m_bBombTicking") and Bomb:GetProp("m_bBombDefused") == 0 and globals.CurTime() < Bomb:GetProp("m_flC4Blow") then

local ScreenW, ScreenH = draw.GetScreenSize();
local Player = entities.GetLocalPlayer();

if defusing == true then
local BombMath = ((globals.CurTime() - Bomb:GetProp("m_flDefuseCountDown")) * 
(0 - 1)) / ((Bomb:GetProp("m_flDefuseCountDown") - Bomb:GetProp("m_flDefuseLength")) - Bomb:GetProp("m_flDefuseCountDown")) + 1;

draw.Color(0, 0, 0, 170);
draw.RoundedRectFill( 0, 0, ScreenW/200, ScreenH );
draw.Color(0, 135, 255, 255);
draw.RoundedRectFill( 0, ScreenH * BombMath, ScreenW/200, ScreenH );
draw.Color(255, 255, 255, 255);
draw.RoundedRect( 0, 0, ScreenW/200, ScreenH );

if Bomb:GetProp("m_flDefuseCountDown") > Bomb:GetProp("m_flC4Blow") then
draw.Color(255, 0, 0, 255);
end

draw.Text( (ScreenW/175), ScreenH * BombMath, math.floor( (Bomb:GetProp("m_flDefuseCountDown") - globals.CurTime()) * 10 ) / 10);
draw.TextShadow( (ScreenW/175), ScreenH * BombMath, math.floor( (Bomb:GetProp("m_flDefuseCountDown") - globals.CurTime()) * 10 ) / 10);

else
local BombMath = ((globals.CurTime() - Bomb:GetProp("m_flC4Blow")) * 
(0 - 1)) / ((Bomb:GetProp("m_flC4Blow") - Bomb:GetProp("m_flTimerLength")) - Bomb:GetProp("m_flC4Blow")) + 1;

draw.Color(0, 0, 0, 170);
draw.RoundedRectFill( 0, 0, ScreenW/200, ScreenH );
draw.Color(255, 0, 0, 255);
draw.RoundedRectFill( 0, ScreenH * BombMath, ScreenW/200, ScreenH );
draw.Color(255, 255, 255, 255);
draw.RoundedRect( 0, 0, ScreenW/200, ScreenH );

draw.Text( (ScreenW/175), ScreenH * BombMath, math.floor(Bomb:GetProp("m_flC4Blow") - globals.CurTime()));
draw.TextShadow( (ScreenW/175), ScreenH * BombMath, math.floor(Bomb:GetProp("m_flC4Blow") - globals.CurTime()));

end


if Player:IsAlive() and globals.CurTime() < Bomb:GetProp("m_flC4Blow") then
if math.floor(0.5 + BombDamage(Bomb, Player)) >= Player:GetHealth() then
draw.Color(255, 0, 0, 255)
else
draw.Color(255, 255, 255, 255)
end
draw.Text(ScreenW/150, 0, math.floor(0.5 + BombDamage(Bomb, Player)) .. " HP");
draw.TextShadow(ScreenW/150, 0, math.floor(0.5 + BombDamage(Bomb, Player)) .. " HP");
end


end
end
end

function BombDamage(Bomb, Player)
local C4Distance = math.sqrt((select(1,Bomb:GetAbsOrigin()) - select(1,Player:GetAbsOrigin())) ^ 2 + 
(select(2,Bomb:GetAbsOrigin()) - select(2,Player:GetAbsOrigin())) ^ 2 + 
(select(3,Bomb:GetAbsOrigin()) - select(3,Player:GetAbsOrigin())) ^ 2);

local Gauss = (C4Distance - 75.68) / 789.2
local flDamage = 450.7 * math.exp(-Gauss * Gauss);

if Player:GetProp("m_ArmorValue") > 0 then

local flArmorRatio = 0.5;
local flArmorBonus = 0.5;

if Player:GetProp("m_ArmorValue") > 0 then
local flNew = flDamage * flArmorRatio;
local flArmor = (flDamage - flNew) * flArmorBonus;
 
if flArmor > Player:GetProp("m_ArmorValue") then
flArmor = Player:GetProp("m_ArmorValue") * (1 / flArmorBonus);
flNew = flDamage - flArmor;
end
 
flDamage = flNew;

end

end
return math.max(flDamage, 0);
end

-- Bomb Info by Nyanpasu!

client.AllowListener( "bomb_begindefuse" );
client.AllowListener( "bomb_abortdefuse" );
client.AllowListener( "bomb_defused" );
client.AllowListener( "bomb_exploded" );
client.AllowListener( "round_officially_ended" );

callbacks.Register("FireGameEvent", "EventHookB", EventHook);
callbacks.Register("Draw", "DrawingHookB", DrawingHook)