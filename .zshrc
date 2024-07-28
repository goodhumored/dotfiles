# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="amuse" # set by `omz`

zstyle ':omz:update' mode auto      # update automatically without asking

HIST_STAMPS="dd.mm.yyyy"

# plugins
plugins=(
  git
  zsh-autosuggestions
  aliases
  alias-finder
  archlinux
  thefuck
  tmux
  tmuxinator
  docker
  docker-compose
  zsh-syntax-highlighting 
  systemd
  pnpm-shell-completion
  web-search
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white,bold,underline"

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# pnpm
export PNPM_HOME="/home/goodhumored/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
alias n="pnpm"
alias v="nvim"
alias lv="lvim"
alias vim="nvim"
alias ni="n i"
alias ns="n start"
alias nsd="n start:dev"
alias nt="n test"
alias ntd="n test:dev"
# pnpm end

# eza
if command -v eza > /dev/null; then
  alias ls="eza"
  alias ll="eza --long --git --icons=always --no-user --no-permissions"
  alias tree="eza --tree"
fi
# cat -> bat
if command -v bat > /dev/null; then 
  alias cat="bat" 
fi

# fzf customization
if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type=d"

  _fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
  }

  _fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
  }

  if command -v bat > /dev/null; then 
    export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
  fi
  if command -v eza > /dev/null; then
    export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
  fi
  _fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)           fzf --preview 'eza --tree --color=always {} | head -200'               "$@" ;;
        export|unset) fzf --preview "eval 'echo \$' {}"                                      "$@" ;;
        ssh)          fzf --preview 'dig {}'                                                 "$@" ;;
        *)            fzf --preview "--preview 'bat -n --color=always --line-range :500 {}'" "$@" ;;
    esac
  }
fi

if [ -d ./fzf-git.sh ]; then
  source ./fzf-git.sh/fzf-git.sh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export PATH=/usr/local/texlive/2023/bin/x86_64-linux:$PATH

export QSYS_ROOTDIR="/home/goodhumored/intelFPGA/22.1std/quartus/sopc_builder/bin"
export TERM="screen-256color"

export LM_LICENSE_FILE=C:\\flexlm\\lic_modelsim.txt

eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"
