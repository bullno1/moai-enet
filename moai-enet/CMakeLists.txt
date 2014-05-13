cmake_minimum_required ( VERSION 2.8.5 )
project(moai-enet)

add_library(moai-enet STATIC
    host.cpp
    lua-enet.c
)
target_include_directories(moai-enet PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/../)
target_link_libraries(moai-enet enet moai-core moai-util moai-sim zlcore)
