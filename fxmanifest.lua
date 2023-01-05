fx_version 'cerulean'
game 'gta5'

author 'Elusive'
description 'Steal from cars'
version 'legacy'

client_scripts{
    '@es_extended/locale.lua',
    'client/client.lua'
}

server_scripts{
    '@es_extended/locale.lua',
    'server/server.lua'
}

dependencies {
	'es_extended',
}