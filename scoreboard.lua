local players = {}

local sort = {
    ['<span class="rainbow_text_animated">Supreme Leader</span>'] = 1,
    ['<span class="rainbow_text_animated">Director</span>'] = 2,
    ['<span class="pen_text">Developer</span>'] = 3,
    ['<span class="rainbow_text_animated">Management</span>'] = 4,
    ["Head Admin"] = 5,
    ["Staff"] = 6,
    ["FDLE"] = 7,
    ["HCFR"] = 8,
    ["Civilian"] = 9,
    ["Guest"] = 10,
}

function GetPlayerList()
    local p = {}

    table.sort(players, function(a, b)
        a = a or {}
        b = b or {}

        a.discord = a.discord or "Guest"
        b.discord = b.discord or "Guest"

        return ( sort[a.discord] or 100 ) > ( sort[b.discord] or 100 )
    end)

    for k, v in pairs(players) do
        v.name = v.name or GetPlayerName(GetPlayerFromServerId(k))
        v.name = sanitize(v.name)

        local name = '<td>'..v.name..'</td>'
        if v.patreon and not v.nameOverride then
            local beginning <const> = "<td><span style='color: " 
            --local patreon <const> = "<span style='font-size: 15px'>😍</span></td>"
            local patreon <const> = "<span style='font-size: 15px'></span></td>"

            if v.patreon == 4 then
                name = beginning .. "#2b75ff'>"..v.name.."</span> " .. patreon
            elseif v.patreon == 3 then
                name = beginning .. "#8e3ed8'>"..v.name.."</span> " .. patreon
            elseif v.patreon == 2 then
                name = beginning .. "#f23ad3'>"..v.name.."</span> " .. patreon
            elseif v.patreon == 1 then
                name = beginning .. "#84062c'>"..v.name.."</span> ".. patreon
            end
        end

        if v.rainbow and not v.nameOverride then
            --name = '<div id="shadowBox"><td><span class="rainbow_text_animated">' .. v.name .. '</span> <span style="font-size: 15px">😎</span></td></div>'
            name = '<div id="shadowBox"><td><span class="rainbow_text_animated">' .. v.name .. '</span> <span style="font-size: 15px"></span></td></div>'
        end

        -- if v.mae then
        --     name = '<div id="shadowBox"><td><span class="mae_text">' .. v.name .. '</span> <span style="font-size: 15px"></span></td></div>'
        -- end

        if v.nameOverride then
            name = v.nameOverride:format( v.name )
        end

        v.discord = v.discord or "Guest"
        table.insert(p, { id = v.id or k, discord = v.discord, sort = sort[v.discord] or 100, name = name })
    end

    return p
end

function GeneratePlayerList()
    local p = GetPlayerList()

    table.sort(p, function(a, b)
        return a.sort < b.sort
    end)

    local t = {}
    for k, v in pairs(p) do
        table.insert(t, '<tr style="color: rgb(0, 0, 0)"><td>'..v.id..'</td>'..v.name..'<td>'..v.discord..'</td></tr>')
    end

    return t
end

Citizen.CreateThread( function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(0)
    end

    TriggerServerEvent("SCOREBOARD::PLAYER_READY")
end )

local pattern <const> = "~([rbxgtypqocmuw])~"
function sanitize( txt )
    local res <const> = txt:gsub( pattern, '' )
    return res
end

RegisterNetEvent "SCOREBOARD::SEND_PLAYER_LIST"
AddEventHandler("SCOREBOARD::SEND_PLAYER_LIST", function( p )
    players = p
    GeneratePlayerList()
end)

RegisterNetEvent "SCOREBOARD::UPDATE_PLAYER_LIST"
AddEventHandler("SCOREBOARD::UPDATE_PLAYER_LIST", function( player, t )
    players[player] = t
    GeneratePlayerList()
end)

if not GetResourceKvpInt( "scoreboard_position" ) then
    SetResouceKvpInt( "scoreboard_position", 1 )
end

RegisterKeyMapping( '+scoreboard', '(Misc) Toggle Scoreboard', 'keyboard', 'up' )
RegisterCommand( '+scoreboard', function()
    SendNUIMessage{ text = table.concat( GeneratePlayerList(), GetResourceKvpInt( "scoreboard_position" ) ) }
end )

RegisterCommand( '-scoreboard', function()
    SendNUIMessage{ meta = 'close' }
end )

-- local POSITION_LEFT <const> = 0
-- local POSITION_CENTER <const> = 1
-- local POSITION_RIGHT <const> = 2

-- RegisterCommand( "scoreboardpos", function( _, args )
--     if not tonumber( args[1] ) then
--         TriggerEvent( 'chat:addMessage', {
--             args = { "^1ERROR", "Please enter a number." }
--         } )

--         return
--     end

--     local pos = tonumber( args[1] )
    
--     if pos ~= POSITION_LEFT and pos ~= POSITION_CENTER and pos ~= POSITION_RIGHT then
--         TriggerEvent( 'chat:addMessage', {
--             args = { "^1ERROR", "Please enter either 0, 1, or 2" }
--         } )

--         return
--     end

--     SetResourceKvpInt( "scoreboard_position", pos )
--     GeneratePlayerList()
-- end )
