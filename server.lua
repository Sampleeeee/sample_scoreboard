local players = {}

local function GeneratePlayerData( player )
    players[player] = {}

    local owner = exports.sample_util:IsRolePresent( player, "Owner" )
    local coowner = exports.sample_util:IsRolePresent( player, "Co-Owner" )
    local developer = exports.sample_util:IsRolePresent( player, "Developer" )
    local manager = exports.sample_util:IsRolePresent( player, "Management" )
    local hadmin = exports.sample_util:IsRolePresent( player, "Head Admin" )
    local adev = exports.sample_util:IsRolePresent( player, "Asset Developer" )
    local staff = exports.sample_util:IsRolePresent( player, "Staff" )
    local alea = exports.sample_util:IsCop( player )
    local civ = exports.sample_util:IsCiv( player )
    local bfd = exports.sample_util:IsFire( player )
    local aleac = exports.sample_util:IsRolePresent( player, "FHP Command" )
    local dispatch = exports.sample_util:IsRolePresent( player, "Dispatch" )
    local civc = exports.sample_util:IsRolePresent( player, "Civ Command" )
    local bfdc = exports.sample_util:IsRolePresent( player, "OFD Command" )

    local discordId = exports.sample_util:GetDiscordId( player )

    players[player].patreon = exports.sample_util:GetTierNumber( player )
    players[player].discord = owner and '<span class="rainbow_text_animated">Supreme Leader</span>' or 
        coowner and '<span class="rainbow_text_animated">Director</span>' or 
        developer and '<span class="pen_text">Developer</span>' or 
        manager and '<span class="rainbow_text_animated">Management</span>' or
        hadmin and "Head Admin" or 
        adev and "Asset Developer" or 
        staff and "Staff" or 
        civc and "Civilian" or 
        aleac and "FDLE" or 
        bfdc and "HCFR" or 
        civ and "Civilian" or 
        alea and "FDLE" or 
        bfd and "HCFR" or 
        "Guest"

    local nameOverrides <const> = {
        ["551918087352614952"] = '<div id="shadowBox"><td><span class="sample_text">%s</span> <span style="font-size: 15px"></span></td></div>',
        ["338794010846167040"] = '<div id="shadowBox"><td><span class="mae_text">%s</span> <span style="font-size: 15px"></span></td></div>',
        ["261810003944538113"] = '<div id="shadowBox"><td><span class="pen_text">%s</span> <span style="font-size: 15px"></span></td></div>'
    }

    local rainbow <const> = {
        -- ["DISCORD-ID"] = true, -- NAME
        -- ["DISCORD-ID"] = true, -- NAME
        -- ["DISCORD-ID"] = true, -- NAME
    }

    if owner or coowner or manager or developer or rainbow[discordId] then
        players[player].rainbow = true
    end

    if nameOverrides[discordId] then
        players[player].nameOverride = nameOverrides[discordId]
    end

    players[player].name = GetPlayerName( player ) or "Unknown"
    players[player].id = player

    TriggerClientEvent( "SCOREBOARD::SEND_PLAYER_LIST", -1, players )
end

AddEventHandler( 'sample_util:PlayerNameChanged', function( player ) 
    GeneratePlayerData( player )
    TriggerClientEvent( "SCOREBOARD::UPDATE_PLAYER_LIST", -1, player, players[player] )
end )

RegisterNetEvent "SCOREBOARD::PLAYER_READY"
AddEventHandler("SCOREBOARD::PLAYER_READY", function()
    local player = source
    
    GeneratePlayerData( player )
end)

AddEventHandler( "playerDropped", function()
    local player = source

    players[player] = nil
    TriggerClientEvent( "SCOREBOARD::UPDATE_PLAYER_LIST", -1, player, players[player] )
end )
