cmake_minimum_required ( VERSION 2.8.5 )

project ( lua-enet )

set ( LUA_ENET_SOURCES 
    enet.c
)

add_library(lua-enet STATIC ${LUA_ENET_SOURCES})

target_link_libraries(lua-enet enet)
