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
if command -v zoxide > /dev/null && command -v nvim-zoxide > /dev/null; then
  alias nvim="nvim-zoxide"
fi
alias nv="nvim"
alias lv="lvim"
alias vim="nvim"
alias v="vim"

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
