FROM prantlf/alpine-make-gcc:latest

LABEL version="0.0.1"
LABEL description="Lua docker container to easily run & develop Lua scripts"

ARG LUA_INSTALL_VERSION="5.2.4"
ARG LUAROCKS_INSTALL_VERSION="3.9.0"
ARG USERNAME=lua-user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV LUA_VERSION_STR="lua-$LUA_INSTALL_VERSION"
ENV LUAROCKS_VERSION_STR="luarocks-$LUAROCKS_INSTALL_VERSION"

# ---------- Build & install Lua from source ----------
# Install dependencies for build with apk add 
# realine-dev only needed for versions before Lua 5.4.4 e.g. 5.3.6
RUN apk update \                                                                                                                                                                                                                        
  && apk add readline-dev 
RUN wget http://www.lua.org/ftp/$LUA_VERSION_STR.tar.gz
RUN tar zxf $LUA_VERSION_STR.tar.gz

WORKDIR $LUA_VERSION_STR
RUN make linux test
RUN make install

# ---------- Build & install Luarocks ----------
WORKDIR /
RUN wget https://luarocks.org/releases/$LUAROCKS_VERSION_STR.tar.gz
RUN tar zxpf $LUAROCKS_VERSION_STR.tar.gz
WORKDIR $LUAROCKS_VERSION_STR
RUN ./configure --with-lua-include=/usr/local/include
RUN make
RUN make install

# Install full wget instead of busybox version - avoids issues with luarocks
# See issue https://github.com/luarocks/luarocks/issues/952
# --> wget install see https://github.com/Yelp/dumb-init/issues/73#issuecomment-240439732
RUN   apk update \                                                                                                                                                                                                                        
  &&   apk add ca-certificates wget \                                                                                                                                                                                                      
  &&   update-ca-certificates

# Add luarocks bin to path (e.g. we can run busted in CLI with "busted spec")
ENV PATH "$PATH:/workspaces/lua-docker/./lua_modules/bin:/home/lua-user/.luarocks/bin"

# [Optional] Install busybox-extras - e.g. useful to have telnet command available
RUN apk add busybox-extras

# Add git
RUN apk add git

# --------------------- Testwise create lua-language-server - move to separate image later
RUN apk add ninja

RUN git clone  --depth=1 https://github.com/sumneko/lua-language-server /lua-language-server
WORKDIR /lua-language-server
RUN git submodule update --depth 1 --init --recursive && \
    cd 3rd/luamake && ./compile/install.sh

WORKDIR /lua-language-server
RUN ./3rd/luamake/luamake rebuild

# Replace language server & link symbolically to our created version
# RUN mv /root/.vscode-server/extensions/sumneko.lua-2.5.3/server/bin/Linux/ /root/.vscode-server/extensions/sumneko.lua-2.5.3/server/bin/Linux_backup/
# RUN ln -s /lua-language-server/ /root/.vscode-server/extensions/sumneko.lua-2.5.3/server/bin/Linux

# ---------- Finally, create & use standard user ----------
# -g is the GID
RUN addgroup -g $USER_GID lua-users

# -u is the UID
# -D permits to create an user without password
RUN adduser -u $USER_UID -G lua-users -h /home/$USERNAME -D $USERNAME

# [Optional] Set the default user. Omit if you want to keep the default as root.
# e.g. if you notice that you have to run sudo .. in your terminal just comment the next line. (Note: Sudo not available in Alpine by default)
# USER $USERNAME
