# Set the preferred text editor
export EDITOR=/usr/bin/nvim

# Set the language and locale settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set the home directory for applications
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# Setup NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
