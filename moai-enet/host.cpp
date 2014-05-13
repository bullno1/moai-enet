#include <moai-enet/host.h>
#include <enet/enet.h>
#include "lua-enet.h"
#include <lua.h>

void MOAIEnetAppInitialize()
{
	enet_initialize();
}

void MOAIEnetContextInitialize()
{
	luaopen_enet(AKUGetLuaState());
}

void MOAIEnetAppFinalize()
{
	enet_deinitialize();
}
