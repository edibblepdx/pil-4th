// a bar-bones stand-alone Lua interpreter from chapter 27.1
// compile with gcc lua_interpreter.c -llua

#include <stdio.h>
#include <string.h>
#include "lua.h"
#include "lauxlib.h"    // auxiliary functions for loading lua libraries
#include "lualib.h"     // standard lua library functions

int main (void) {
    char buff[256];
    int error;
    lua_State *L = luaL_newstate();     // opens lua
    luaL_openlibs(L);                   // opens the standard libraries

    while (fgets(buff, sizeof(buff), stdin) != NULL) {
        error = luaL_loadstring(L, buff) || lua_pcall(L, 0, 0, 0);
        if (error) {
            fprintf(stderr, "%s\n", lua_tostring(L, -1));
            lua_pop(L, 1);  // pop error message from the stack
        }
    }

    lua_close(L);
    return 0;
}
