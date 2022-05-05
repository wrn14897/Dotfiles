# vimrc
My vim config files (NeoVIM compatible)

1. Install vim-plug
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

2. Install ripgrep (https://github.com/BurntSushi/ripgrep)

3. Install fzf (https://github.com/junegunn/fzf) and bat (https://github.com/sharkdp/bat)

4. Install node (nvm -> https://github.com/nvm-sh/nvm)

5. Copy .vimrc to HOME dir

6. Open vim and do `:PlugInstall`

7. Ready to rock !!


# oh-my-zsh
1. Install zsh (https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
2. Run following cmd to install oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
3. Copy .zshrc to $HOME
4. Install 3rd party plugins 
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  - [zsh-autojump](https://github.com/wting/autojump) (brew)
5. Copy alias files (`.bash_aliases`, `.docker_aliases`) to $HOME


# tmux
1. Install tmux
2. Copy .tmux.conf to $HOME


# alacritty
1. Install FiraCode font (https://github.com/tonsky/FiraCode)
2. Install Powerline fonts (https://github.com/powerline/fonts)
3. Copy `.confgs/alacritty`
