local version = _VERSION:match("%d+%.%d+")
-- add modules to path for require
package.path = 'lua_modules/share/lua/' .. version .. '/?.lua;lua_modules/share/lua/' .. version .. '/?/init.lua;' .. package.path
-- add src folder to path
package.path = package.path .. ";./src/?.lua"
package.cpath = 'lua_modules/lib/lua/' .. version .. '/?.so;' .. package.cpath