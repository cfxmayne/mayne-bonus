fx_version 'cerulean'
game 'gta5'
author "Mayne"
version "1.0.0"
client_scripts {
	'client/*.lua'
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/*.lua'
}