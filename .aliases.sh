#          ╭──────────────────────────────────────────────────────────╮
#          │                         aliases                          │
#          ╰──────────────────────────────────────────────────────────╯
#   ───────────────────────────────── pnpm ─────────────────────────────────
alias n="pnpm"
alias ni="n i"
alias ns="n start"
alias nsd="n start:dev"
alias nt="n test"
alias ntd="n test:dev"

#   ─────────────────────────────── vim/nvim ───────────────────────────────
NVIM_PREFIX="NVIM_USE_COPILOT=true LC_TIME=en_US proxychains -q"
alias nv="$NVIM_PREFIX nvim ."
alias lv="$NVIM_PREFIX lvim"
alias v="$NVIM_PREFIX vim"
alias vim="$NVIM_PREFIX nvim"
if command -v zoxide > /dev/null && command -v nvim-zoxide > /dev/null; then
  alias nv="nvim-zoxide"
fi

#   ───────────────────────────── drag n drop ───────────────────────────
alias dnd="dragon-drop"
alias cpdnd='cp $(dragon-drop -p -x -t .) .'

#   ───────────────────────────────── eza ───────────────────────────────
if command -v eza > /dev/null; then
  alias ls="eza"
  alias ll="eza --long --git --icons=always --no-user --no-permissions"
  alias tree="eza --tree"
fi

#   ────────────────────────────── cat -> bat ──────────────────────────────
if command -v bat > /dev/null; then 
  alias cat="bat" 
fi

#   ──────────────────────── zoxide (cd -> zoxide) ──────────────────────
eval "$(zoxide init --cmd cd zsh)"

#   ──────────────────────────────── gitea ──────────────────────────────
PROG=tea _CLI_ZSH_AUTOCOMPLETE_HACK=1 source "/home/goodhumored/.config/tea/autocomplete.zsh"
if command -v tea > /dev/null; then
  alias tprl="tea pr list"
  alias tprl="tea pr list"
fi
