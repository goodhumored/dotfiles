# goodhumored dotfiles

- zsh config
- ohmyzsh 
- tmux
- neovim
- midnight commander

## Prerequisites

#### Required

- git
- gcc
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
sudo apt install git tmux neovim stow fzf bat eza fd gcc
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
```

Arch:
```bash
sudo yay -S git tmux neovim zoxide stow fzf bat eza fd gcc
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
