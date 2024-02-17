fx_version 'cerulean'
games { 'gta5' };
version '1.0'
lua54 'yes'

client_scripts {
    "config/config.lua",
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    "client/*.lua",
    "client/function/*.lua",
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "config/config.lua",
    "config/config_server.lua",
    "server/server.lua",
}

shared_scripts {
    '@ox_lib/init.lua'
}

--██████╗  █████╗ ██╗    ██╗ █████╗ ██╗         ███████╗████████╗ ██████╗ ██████╗ ███████╗
--██╔══██╗██╔══██╗██║    ██║██╔══██╗██║         ██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝
--██████╔╝███████║██║ █╗ ██║███████║██║         ███████╗   ██║   ██║   ██║██████╔╝█████╗  
--██╔═══╝ ██╔══██║██║███╗██║██╔══██║██║         ╚════██║   ██║   ██║   ██║██╔══██╗██╔══╝  
--██║     ██║  ██║╚███╔███╔╝██║  ██║███████╗    ███████║   ██║   ╚██████╔╝██║  ██║███████╗
--╚═╝     ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝    ╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝
                                                                                        