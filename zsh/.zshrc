
HYPHEN_INSENSITIVE="true"

DISABLE_LS_COLORS="false"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(
	git
	npm
)

alias astro="NVIM_APPNAME=AstroNvim nvim"
alias chad="NVIM_APPNAME=Nvchad nvim"
alias lax="NVIM_APPNAME=lax nvim"
alias lazy="NVIM_APPNAME=lazy nvim"
alias normal="NVIM_APPNAME=NormalNvim nvim"
alias omega="NVIM_APPNAME=omega nvim"

function nvims() {
  items=("default", "AstroNvim", "Lax", "lazy", "omega" "NormalNvim" "Nvchad")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opam configuration
[[ ! -r /home/loop/.opam/opam-init/init.zsh ]] || source /home/loop/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

eval "$(zoxide init --cmd cd zsh)"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

source $HOME/.zprofile
source $ZSH/oh-my-zsh.sh
source $HOME/.zalias
