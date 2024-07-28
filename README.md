# goodhumored dotfiles

- zsh config
- ohmyzsh 
- tmux
- neovim
- midnight commander

## Prerequisites

#### Required

- git
- stow - dotfiles symlink in home
- fzf - for fuzzy search
- neovim - editor

#### Optional

- zoxide - better cd
- bat - better cat
- eza - better ls and tree
- fd - better find
- [thefuck](https://github.com/nvbn/thefuck)

Ubuntu:

```bash
sudo apt update && sudo apt update
sudo apt install git tmux neovim stow fzf bat eza fd
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

Arch:
```bash
sudo yay -S git tmux neovim zoxide stow fzf bat eza fd
```

## Installation

0. install prerequisites

1. clone & cd

```bash
git clone http://github.com/goodhumored/dotfiles
cd dotfiles
```

2. install git submodules

```bash
git submodule update --init --recursive
```

3. backup existing config files

```bash
mv ~/.gitconfig ~/.gitconfig.bak
mv ~/.config/nvim ~/.config/nvim.bak/
mv ~/.config/mc ~/.config/mc.bak
mv ~/.zshrc ~/.zshrc.bak
mv ~/.oh-my-zsh/ ~/.oh-my-zsh.bak/
mv ~/.tmux.conf ~/.tmux.conf.bak
mv ~/.tmux/ ~/.tmux.bak
mv ~/.bashrc ~/.bashrc.bak
```

4. make symlinks

```bash
stow .
```

5. change shell to zsh

```bash
chsh $(which zsh)
```

6. source tmux.conf

in tmux press <prefix>: and type `source ~/.tmux.conf`
