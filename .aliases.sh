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
alias nv="nvim"
alias lv="lvim"
alias vim="nvim"
alias v="vim"
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
