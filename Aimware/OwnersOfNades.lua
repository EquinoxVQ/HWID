local enable_fire_esp = true -- fire esp masterswitch
local enable_fire_esp_circle = false -- draws circle around potential fire spread area
local enable_fire_esp_info = true -- draws owner name on fire
local disable_fire_info_ff = true -- if friendly fire is disabled, enable_fire_esp_info will be forced to false

local enable_decoy_info = true -- draws decoy information on decoys
local disable_decoy_info_ff = true -- if friendly fire is disabled, enable_decoy_info will be forced to false

local enable_team_dmg_scoreboard = true -- draws team damage scoreboard when holding tab

-- don't edit below this line
-- credits: il-marc (https://aimware.net/forum/user-57048.html) for original team damage scoreboard
-- credits: RadicalMario (https://aimware.net/forum/user-88057.html) for drawCircle function
local function drawCircle(x, y, z, radius, thickness, quality, r, g, b, a)
local quality = quality or 20
local thickness = thickness or  8
local Screen_X_Line_Old, Screen_Y_Line_Old
for rot=0, 360, quality do
local rot_temp = math.rad(rot)
local LineX, LineY, LineZ = radius * math.cos(rot_temp) + x, radius * math.sin(rot_temp) + y, z
local Screen_X_Line, Screen_Y_Line = client.WorldToScreen(LineX, LineY, LineZ)
if Screen_X_Line ~=nil and Screen_X_Line_Old ~= nil then
draw.SetFont(draw.CreateFont("Tahoma", 12));
draw.Color(r, g, b, a)
draw.Line(Screen_X_Line, Screen_Y_Line, Screen_X_Line_Old, Screen_Y_Line_Old)
for i = 0, thickness do
draw.Line(Screen_X_Line, Screen_Y_Line+i, Screen_X_Line_Old, Screen_Y_Line_Old+i)
end
end
Screen_X_Line_Old, Screen_Y_Line_Old = Screen_X_Line, Screen_Y_Line
end
end

-- decoy ESP
callbacks.Register("DrawESP", function(EspBuilder)
local local_player = entities.GetLocalPlayer()
local ent = EspBuilder:GetEntity()

if (local_player == nil or ent == nil) then return end
if (engine.GetMapName() == "dz_blacksite") then return end
local friendlyfire = (client.GetConVar("mp_friendlyfire") == "1") and true or false

if (not enable_decoy_info) then return end
if (not (not disable_decoy_info_ff or friendlyfire)) then return end
if (next(entities.FindByClass("CDecoyProjectile")) == nil) then return end

if (ent:GetClass() == "CDecoyProjectile") then
local owner = ent:GetPropEntity("m_hThrower")

if (owner == nil) then 
EspBuilder:Color(255, 30, 30, 255)
EspBuilder:AddTextTop("Ownerless decoy")
elseif (owner:GetIndex() == local_player:GetIndex()) then
EspBuilder:Color(255, 30, 30, 255)
EspBuilder:AddTextTop("Your decoy")
else
local team = entities.GetPlayerResources():GetPropInt("m_iTeam", owner:GetIndex())
if (team == local_player:GetTeamNumber()) then
local owner_name = client.GetPlayerNameByIndex(owner:GetIndex())
if (string.len(owner_name) > 23) then
owner_name = string.sub(owner_name, 0, 17) .. "..."
end

EspBuilder:Color(30, 255, 30, 255)
EspBuilder:AddTextTop("Team decoy (" .. owner_name .. ")")
elseif (team ~= local_player:GetTeamNumber()) then
EspBuilder:Color(255, 30, 30, 255)
EspBuilder:AddTextTop("Enemy decoy")
end
end
end
end)


local scoreboard = {}

local function is_steam_id_present(steamid)
if (next(scoreboard) == nil or scoreboard == nil) then 
return false 
end

for index, value in pairs(scoreboard) do
if (value.steamid == steamid) then
return true
end
end

return false
end

-- param: steamid; steamid player that you want to operate on
-- param: key; key which will be changed
-- param: value; value that will be assigned to key
local function set_scoreboard_val(steamid, key, value)
if (next(scoreboard) == nil or scoreboard == nil) then return end
if (not is_steam_id_present(steamid)) then return end

for index, player in pairs(scoreboard) do
if (player["steamid"] == steamid) then
scoreboard[index][key] = value
end
end
end

-- param: steamid; steamid of player that you want to operate on
-- param: key; key by which we'll be searching for value
-- return: key value OR nil if we failed to find steamid
local function get_scoreboard_val(steamid, key)
if (next(scoreboard) == nil or scoreboard == nil) then return end
if (not is_steam_id_present(steamid)) then return end

for index, player in pairs(scoreboard) do
if (player["steamid"] == steamid) then
return player[key]
end
end

return nil
end

local function get_team(player_index)
return entities.GetPlayerResources():GetPropInt("m_iTeam", player_index)
end

local function update_players()
for i = globals.MaxClients(), 1, -1 do
local forced_index = math.floor(i)
local name = client.GetPlayerNameByIndex(forced_index)

if (name ~= nil) then
local info = client.GetPlayerInfo(forced_index)
local steamid = info["SteamID"]
if (info["IsGOTV"] == false and info["IsBot"] == false) then
local team = get_team(forced_index)
if (entities.GetLocalPlayer():GetTeamNumber() == team and not is_steam_id_present(steamid)) then
table.insert(scoreboard, {["index"] = forced_index, ["steamid"] = steamid, ["damage"] = 0, ["kills"] = 0, ["suicides"] = 0})
end
end
end
end
end

client.AllowListener("player_death")
client.AllowListener("round_announce_match_start")
client.AllowListener("client_disconnect")
callbacks.Register("FireGameEvent", function(event)
if (engine.GetMapName() == "dz_blacksite") then return end
if (entities.GetLocalPlayer() == nil) then return end
local event_name = event:GetName()

if (event_name == "round_announce_match_start" or event_name == "client_disconnect") then
scoreboard = {}
end

local friendlyfire = (client.GetConVar("mp_friendlyfire") == "1") and true or false
if (not friendlyfire) then return end

if(event_name == "player_hurt" or event_name == "player_death") then
local victim_index = client.GetPlayerIndexByUserID(event:GetInt('userid'))

local attacker_index
if (event:GetInt('attacker') == 0) then
if (event:GetString('weapon') ~= "worldspawn" or event:GetString('weapon') ~= "trigger_hurt") then
attacker_index = victim_index
end
else
attacker_index = client.GetPlayerIndexByUserID(event:GetInt('attacker'))
if(get_team(attacker_index) ~= entities.GetLocalPlayer():GetTeamNumber()) then return end
end

if (attacker_index == nil or victim_index == nil) then return end

local attacker_team = get_team(attacker_index)
local attacker_steamid = client.GetPlayerInfo(attacker_index)["SteamID"]

local victim_team = get_team(victim_index)
local victim_steamid = client.GetPlayerInfo(victim_index)["SteamID"]

if (attacker_index == victim_index and event_name == "player_death") then
set_scoreboard_val(attacker_steamid, "suicides", get_scoreboard_val(attacker_steamid, "suicides") + 1)
end

if (entities.GetLocalPlayer():GetTeamNumber() == attacker_team) then
if (attacker_index ~= victim_index and attacker_team == victim_team) then
if (event_name == "player_hurt") then
local dmg = event:GetInt("dmg_health") 
set_scoreboard_val(attacker_steamid, "damage", get_scoreboard_val(attacker_steamid, "damage") + dmg)
end

if (event_name == "player_death") then
set_scoreboard_val(attacker_steamid, "kills", get_scoreboard_val(attacker_steamid, "kills") + 1)
end
end
end
end

end)

callbacks.Register("Draw", function()
if (engine.GetMapName() == "dz_blacksite") then return end
local local_player = entities.GetLocalPlayer()
if (local_player == nil) then return end
local friendlyfire = (client.GetConVar("mp_friendlyfire") == "1") and true or false

-- Team damage scoreboard
if (friendlyfire) then
update_players()

local w, h = draw.GetScreenSize()

local x = w * 0.0104
local y = h * 0.324
local listY = 28
local listItemHigh = 21
local w = 224

if (input.IsButtonDown(9) and enable_team_dmg_scoreboard) then
local n = 0
for index, player in pairs(scoreboard) do
local name = client.GetPlayerNameByIndex(player.index)
if (name ~= nil and (player.damage ~= 0 or player.kills ~= 0 or player.suicides ~= 0)) then
draw.Color(gui.GetValue("clr_gui_groupbox_background"))
draw.FilledRect(x, y+listY+listItemHigh*n, x+w, y+listY+listItemHigh*(1+n)-1)
draw.Color(gui.GetValue("clr_gui_text2"))
draw.SetFont(draw.CreateFont("Lucida Console", 14))
if (string.len(name) > 16) then
name = string.sub(name, 0, 16) .. "..."
end
draw.Text( x+7, y+listY+listItemHigh*n+3, string.format("%3d %1d %1d %s", player.damage, player.kills, player.suicides, name))
draw.Color(gui.GetValue("clr_gui_window_background"))
draw.Line(x, y+listY+listItemHigh*(1+n)-1, x+w, y+listY+listItemHigh*(1+n)-1)
n = n + 1
end
end
if (n > 0) then
local h = listY+listItemHigh*n
draw.Color(gui.GetValue("clr_gui_window_header"))
draw.FilledRect(x, y, x+w, y+24)
draw.Color(18,18,18,100)
draw.OutlinedRect(x, y, x+w, y+h+4)
draw.Color(gui.GetValue("clr_gui_window_header_tab2"))
draw.FilledRect(x, y+24, x+w, y+28)
draw.Color(gui.GetValue("clr_gui_window_footer"))
draw.FilledRect(x, y+h, x+w, y+h+4)
draw.Color(gui.GetValue("clr_gui_text1"))
draw.SetFont(draw.CreateFont("Lucida Console", 14))
draw.Text( x+7, y+5, "  D K S Player" )
end
end

end

-- Fire ESP
local ents = entities.FindByClass("CInferno")
if (ents ~= nil and enable_fire_esp) then
for i = 1, #ents do
local molotov = ents[i]
local x, y, z = molotov:GetAbsOrigin()

if (enable_fire_esp_circle) then
drawCircle(x, y, z, 210, 1, 15, 214, 69, 65, 255)
end

if(enable_fire_esp_info and (not disable_fire_info_ff or friendlyfire)) then
draw.SetFont(draw.CreateFont("Tahoma", 22))

local owner = molotov:GetPropEntity("m_hOwnerEntity")
local w2s_x, w2s_y = client.WorldToScreen(x, y, z)
if (w2s_x ~= nil and w2s_y ~= nil) then
if (owner == nil) then
draw.Color(255, 30, 30, 255)
draw.TextShadow(w2s_x, w2s_y, "Ownerless")
elseif (owner:GetIndex() == local_player:GetIndex()) then
draw.Color(255, 30, 30, 255)
draw.TextShadow(w2s_x, w2s_y, "Your fire")
else
local team = entities.GetPlayerResources():GetPropInt("m_iTeam", owner:GetIndex())
if (team == local_player:GetTeamNumber()) then
local owner_name = client.GetPlayerNameByIndex(owner:GetIndex())
if (string.len(owner_name) > 23) then
owner_name = string.sub(owner_name, 0, 17) .. "..."
end

draw.Color(30, 255, 30, 255)
draw.TextShadow(w2s_x, w2s_y, "Team fire (" .. owner_name .. ")")
elseif (team ~= local_player:GetTeamNumber()) then
draw.Color(255, 30, 30, 255)
draw.TextShadow(w2s_x, w2s_y, "Enemy fire")
end
end
end
end

end
end
end)