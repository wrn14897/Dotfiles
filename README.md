# nvim
1. Copy everything in `/.config/nvim`

2. Ready to rock !!


# Linter / Formatter
1. Linter configs
    - js/ts: `eslint_d` (https://www.npmjs.com/package/eslint_d)
    - python: flake8
2. Formatter configs (https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes)
    - lua: stylua
    - js/ts: prettierd
    - json: jq
    - html: tidy
    - rust: rustfmt
    - python: black
    - sql: pgformatter


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
5. Copy alias files (`.bash_aliases`, `.docker_aliases`) to $HOME


# tmux
1. Install tmux
2. Copy .tmux.conf to $HOME


# OSX
1. Install homebrew (https://brew.sh/)
2. Install packages
```
brew bundle --file=./homebrew/Brewfile
```


# alacritty
1. Install FiraCode font (https://github.com/tonsky/FiraCode)
2. Install FiraCode Nerd Font
  - Download fonts https://www.nerdfonts.com/font-downloads
  - Unzip and copy to ~/.fonts
  - Run the command `fc-cache -fv` to manually rebuild the font cache
3. Copy `.confgs/alacritty`
