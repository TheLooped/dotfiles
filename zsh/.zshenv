# Set the PATH to include local binaries
export PATH=$HOME/.local/bin:$PATH

# Set the ZSH configuration directory
export ZSH="$HOME/.oh-my-zsh"
. "$HOME/.cargo/env"

# ZVM
export ZVM_INSTALL=/home/loop/.zvm/self
export PATH="$PATH:$HOME/.zvm/bin"

export PATH="$PATH:$ZVM_INSTALL/"
