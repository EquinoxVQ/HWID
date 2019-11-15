local kills  = {}
local deaths = {};

local frametimes = {}
local fps_prev = 0

local function accumulate_fps()
    local ft = globals.AbsoluteFrameTime()
    if ft > 0 then
        table.insert(frametimes, 1, ft)
    end

    local count = #frametimes
    if count == 0 then
        return 0
    end

    local i, accum = 0, 0
    while accum < 0.5 do
        i = i + 1
        accum = accum + frametimes[i]
        if i >= count then
            break
        end
    end
    accum = accum / i
    while i < count do
        i = i + 1
        table.remove(frametimes)
    end
    
    local fps = 1 / accum
    local rt = globals.RealTime()
    if math.abs(fps - fps_prev) > 4 or rt - last_update_time > 2 then
        fps_prev = fps
        last_update_time = rt
    else
        fps = fps_prev
    end
    
    return math.floor(fps + 0.5)
end


local function events_stuff( event )
        if event:GetName( ) == "client_disconnect" then
            kills = {}
             deaths = {}

end
    if event:GetName( ) == "player_death" then
    local local_player = client.GetLocalPlayerIndex( );
    local INDEX_Attacker = client.GetPlayerIndexByUserID( event:GetInt( 'attacker' ) );
    local INDEX_Victim = client.GetPlayerIndexByUserID( event:GetInt( 'userid' ) );

    if INDEX_Attacker == local_player then
       kills[#kills + 1] = {}
    end
    if (INDEX_Victim == local_player) then
        deaths[#deaths + 1] = {};
        end
    end
end

local function drawing_stuff( )
    if not entities.GetLocalPlayer() then
        return 
    end
    
    draw.Color(5,5,5,255)
    draw.FilledRect( 3, 380, 81, 455 )
    draw.Color(60,60,60,255)
    draw.FilledRect( 4, 381, 80, 454 )
    draw.Color(40,40,40,255)
    draw.FilledRect( 5, 382, 79, 453 )
    draw.Color(60,60,60,255)
    draw.FilledRect( 7, 384, 77, 451 )
    draw.Color(17,17,17,255)
    draw.FilledRect( 8, 385, 76, 450 )
    draw.Color(gui.GetValue("clr_gui_window_logo2"))
    draw.Line(9,386,75,386)
    draw.Color(255,255,255,255)
    draw.Text(13, 390, "aim")
    draw.Color(gui.GetValue("clr_gui_window_logo2"))
    draw.Text(39, 390, "ware")
    if accumulate_fps() > 100 then
        r, g, b = 0, 255, 0
    else
        r, g, b = 255, 0, 0
    end
    draw.Color(r,g,b,255)
    draw.Text(13, 410, "FPS: ".. accumulate_fps())
    if #kills/#deaths > 1 then
    draw.Color(0,255,0,255)
    else
    draw.Color(255,0,0,255)
    end
    if #kills == 0 and #deaths == 0 then
           draw.Color(255,255,255,255)
    end
    if #deaths > 0 then 
    kdratio = string.format("%.2f", #kills/#deaths)
    else
    kdratio = string.format("%.2f", #kills/1)
    end
    draw.Text(13, 430, "kd/r: ".. kdratio)   

    
end
client.AllowListener( "round_start" );
client.AllowListener( "player_death" );
callbacks.Register( "FireGameEvent", "events_stuff", events_stuff);
callbacks.Register( "Draw", "drawing_stuff", drawing_stuff );