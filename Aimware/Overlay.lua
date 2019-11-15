--version 2
local abs_frame_time = globals.AbsoluteFrameTime;     local frame_rate = 0.0;        local get_abs_fps = function()  frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * abs_frame_time(); return math.floor((1.0 / frame_rate) + 0.5);  end
function use_Crayon()
local ff = draw.CreateFont('Tahoma')
if entities.GetLocalPlayer() ~= nil then
local name = client.GetPlayerNameByIndex(client.GetLocalPlayerIndex())
local x, y = draw.GetScreenSize()
local z, v, b, n = gui.GetValue('clr_gui_window_header_tab1');    local s, g, f, r = gui.GetValue('clr_gui_window_header_tab2');   local q, e, t, u = gui.GetValue('clr_gui_tablist4');      local h, a, o, i = gui.GetValue('clr_gui_text2'); 
--Back
draw.Color(s, g, f, r)
draw.FilledRect(0, 0, x, 44)
draw.Color(q, e, t, u)
draw.OutlinedRect(1,1,x - 1,43)
--welcome thing
draw.Color(z, v, b, n)
draw.FilledRect(8, 8, 150, 30)
draw.Color(q, e, t, u)
draw.OutlinedRect(7,7,149,29)
--welcome/name
draw.Color(214,214,214, 255)
draw.Text(15, 12, "welcome back ")
draw.Color(149,189,54, 255)
       draw.Text(95, 12, name)
-- back thing for time and fps
draw.Color(z, v, b, n)
draw.FilledRect(170, 8, 650, 30)
draw.Color(q, e, t, u)
draw.OutlinedRect(169,7,649,29)
-- os time
draw.Color(214,214,214, 255)
-- Tuesday, 10 October 2018 | 03:14:17 AM
draw.Text(190, 12 , os.date("%A, %d %B %Y | %I:%M:%S %p"))
--fps
draw.Color(214,214,214, 255)
draw.Text(450, 12, "fps: ".. get_abs_fps())
--back again
draw.Color(z, v, b, n)
draw.FilledRect(1308, 8, 1690, 30)
draw.Color(q, e, t, u)
draw.OutlinedRect(1307, 7, 1689, 29)
--ping
local m_iPing = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex())
draw.Color(214,214,214, 255)
draw.Text(550, 11, "Ping: ".. m_iPing) 
--kills
local m_iKills = entities.GetPlayerResources():GetPropInt("m_iKills", client.GetLocalPlayerIndex())
draw.Color(100,250,100, 255)
draw.Text(1325, 11, "Kills: ".. m_iKills) 
--death
local m_iDeaths = entities.GetPlayerResources():GetPropInt("m_iDeaths", client.GetLocalPlayerIndex())
draw.Color(250,100,100, 255)
draw.Text(1425, 11, "Deaths: ".. m_iDeaths) 
--assists
local m_iAssists = entities.GetPlayerResources():GetPropInt("m_iAssists", client.GetLocalPlayerIndex())
draw.Color(214,214,214, 255)
draw.Text(1525, 11, "Assists: ".. m_iAssists) 
-- KDR
if m_iDeaths > 0 then  KDR = string.format("%.2f", (m_iKills/m_iDeaths));  else    KDR = string.format("%.2f", m_iKills/1);  end
draw.Color(214,214,214, 255)
draw.Text(1625, 11, "KDR: ".. KDR)
-- aw 
local font = draw.CreateFont('Calibri', 40)
draw.SetFont(font)
draw.Color(h, a, o, i)
draw.Text((x / 2) - 70, -1, "AIM ")
draw.Color(q, e, t, u)
draw.Text((x / 2) - 14, -1, "WARE")
draw.Color(h, a, o, i)
draw.Text((x / 2) + 67, -1, ".NET")
end draw.SetFont(ff); end
callbacks.Register('Draw', 'use_Crayon', use_Crayon)
