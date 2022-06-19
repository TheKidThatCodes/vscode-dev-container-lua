# vscode-dev-container-lua

Travis & Appveyor configuration copied from https://github.com/mpeterv/lua-ci-example. Docker configuration created & tested on Windows host.

[![Build Status](https://travis-ci.org/mpeterv/lua-ci-example.svg?branch=master)](https://travis-ci.org/mpeterv/lua-ci-example)
[![Build status](https://ci.appveyor.com/api/projects/status/1a3rgqpa7jv3f8tp/branch/master?svg=true)](https://ci.appveyor.com/project/mpeterv/lua-ci-example/branch/master)
[![codecov](https://codecov.io/gh/mpeterv/lua-ci-example/branch/master/graph/badge.svg)](https://codecov.io/gh/mpeterv/lua-ci-example)

This repository demonstrates how to setup up CI for a simple Lua project packaged for [LuaRocks](https://luarocks.org/). Builds are run on [Travis CI](https://travis-ci.org/) under Linux and Mac OS and on [AppVeyor](https://www.appveyor.com/) under Windows. On each platform there are separate builds using Lua 5.1, Lua 5.2, Lua 5.3, LuaJIT 2.0, and LuaJIT 2.1, using [hererocks](https://github.com/mpeterv/hererocks) to setup environment. Each build lints the code using [luacheck](https://github.com/mpeterv/luacheck), runs tests using [busted](https://olivinelabs.com/busted/), and collects test coverage using [LuaCov](https://keplerproject.github.io/luacov/). Test coverage is submitted to [Codecov](https://codecov.io).

Important files:

* `src/`: source files for the project.
* `spec`: [busted](https://olivinelabs.com/busted/) tests.
* `lua-docker-dev-1.rockspec`: [LuaRocks](https://luarocks.org/) project specification.
* `.luacheckrc.json`: [sumneko.lua](https://github.com/sumneko/lua-language-server/wiki/Setting) settings.
* `.luacov`: [LuaCov](https://keplerproject.github.io/luacov/) config.
* `.travis.yml`: [Travis CI](https://app.travis-ci.com/) config.
* `appveyor.yml`: [AppVeyor](https://www.appveyor.com/) config.

# Lua project
The project is generated with `luarocks init` note this seems still pretty experimental but it seems to work.
It creates a `lua_modules` folder and lua / luarocks start scripts in the root of the project.

## Install new dependencies
Run `luarocks install <name-of-dependency>` and please ensure that you're calling this in the root of the project. This will install the dependency into `lua_modules` folder.

# Docker information
## Getting started
Checkout the documentation form VS code [here](https://code.visualstudio.com/docs/remote/remote-overview).
Once you have Docker Desktop, Remote extension and WSL running on your machine you can open the Docker container like this:
- Open folder of this repo in VS Code
- Open command palette with F1-key or Ctrl+shift+P and start Remote-Containers: Reopen folder
- Open a terminal inside the container and run `lua -v` and `luarocks --version` to see that both are working.

## Dockerfile
The dockerfile is using `prantlf/alpine-make-gcc` which contains make + gcc in an Alpine container. Luarocks requires them.
Lua and Luarocks are installed by downloading the source and running make + install to generate the executables.

You can change the environment variables `DOCKER_LUA_VERSION` or `DOCKER_LUAROCKS_VERSION` before generating the image to change the version used. Defaults to lua version 5.4.4 and luarocks version 3.9.0 - see `devcontainer.json` `containerEnv`

To apply changes to `devcontainer.json` or `Dockerfile` run `Rebuild container` in command palette.

# VS Code settings / extensions
Run the main script `src/main.lua` with `ctrl+shift+b` - configured in `.vscode/tasks.json`.
`.vscode/launch.json` needed for Debugging. To Start Debugging click `Run\Start Debugging`

## lua-language server extension
Used for intellisense, goto to declaration, linting and a lot more - see [sumneko.lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) to get a complete list.

## oroschz.busted-tests extension
Running busted tests in VS Code - see File/preferences/Keyboard Shortcuts and type `testing all` to get a shortcut to run the tests.

## tomblind.local-lua-debugger-vscode extension
Debug your Lua script inside VS Code with breakpoints, single stepping, variables, watches, call stack etc.

For more details, see [tomblind.local-lua-debugger-vscode](https://marketplace.visualstudio.com/items?itemName=tomblind.local-lua-debugger-vscode)

# TODOS

- [ ] Check Travis
- [ ] Check appveyor
- [ ] Update Links in readme to the correct build
- [ ] Check if we can run CI with Docker - how?!
- [ ] Test if luarocks dependencies busted, luafilesystem & luasocket are installed correctly - new container.
- [ ] Check if there is an extension for running test with `ctrl+alt+t` - default settings are OK but could be better
- [ ] Create an issue at [lua-language-server](https://github.com/sumneko/lua-language-server/issues) with the original issue and the current workaround. Also check if there is an option to create a configuration for the `command`. Would be easier to use the build binary - no symlinking needed.
- [ ] Add template to https://github.com/microsoft/vscode-dev-containers
- [ ] Improve the example code and only create main.lua + socket-example.
- [ ] Check if lua_backup / luarocks_backup scripts are needed - we're handling the path with set_paths.


# License
MIT, (c) 2022 - present Alexander Wolf