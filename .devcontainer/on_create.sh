#!/bin/bash

# Use our created binary by using a symbolic link
# No configuration in sumneko extension available
# Path is fixed - see issue https://github.com/sumneko/lua-language-server/issues/1190

cd /root/.vscode-server/extensions/sumneko.lua-2.5.3/server/bin
# copy original implementation is optional.
mv Linux Linux_backup
ln -s /lua-language-server/bin Linux

cd /