# My Neovim configuration

## Prerequisites (obviously): Neovim installation

Many possibilities documented in the official neovim github repository.
My prefered choices are AppImage for 64bits architecture and build from source for ARM.

### AMD64 (All distrib)

```
TODO
```

### AMD64 and ARM (Ubuntu / Debian for the prerequisites)

```bash
sudo apt-get install ninja-build gettext cmake unzip curl
```

```bash
cd /tmp
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=Release
sudo make install
```

## Installation

```bash
mkdir -p $HOME/.config
cd $HOME/.config
git clone https://github.com/NicoGGG/nvim.git
```

## External tools to install

### Node18

Many plugins need nodejs to work. The simplest is to install with nvm (Not at all a confusing name with nvim)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 20
```

### Nerd font

For better looking UI with icons, a [NerdFont](https://www.nerdfonts.com/) needs to be installed

#### On windows WSL

- Download the font on [NerdFont](https://www.nerdfonts.com/font-downloads)
- Open the ttf font file you want to use. A preview appears. On the top left side, click on the Install button
- On the WSL top bar, right click and select settings
- Select your profile at the bottom left
- Appearance -> Font Face -> The font your previously just installed
- Save

#### On ubuntu

TODO

#### On chromebook

I found myself trying to use neovim on my chromebook, and this is the solution I found to install a Nerd font
(From [here](https://github.com/ye-rm/Use-Meslo-Nerd-Font-on-chromebook))

1. open your terminal
2. press CTRL+SHIFT+J
3. copy&run

```javascript
term_.prefs_.set("font-family", "MesloLGM Nerd Font");
term_.prefs_.set(
  "user-css-text",
  '@font-face {font-family: "MesloLGM Nerd Font"; src: url("https://raw.githubusercontent.com/ye-rm/MesloNerdFont-in-chrome-OS/main/MesloLGMNerdFont-Regular.ttf"); font-weight: normal; font-style: normal;}',
);
```

This should be adaptable for other fonts by adapting the font-family name and the src url

### Go

To use the golang LSP (and run my go programs in the process)

#### Ubuntu (Works also in WSL)

```bash
mkdir -p /tmp/goinstall
cd /tmp/goinstall
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
tar -xf go1.21.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo "\n# Add the go bin to your PATH\nexport PATH=\$PATH:/usr/local/go/bin" >> $HOME/.zshrc
source $HOME/.zshrc
echo "# Add GOPATH/bin to your PATH\nexport PATH=\$PATH:$(go env GOPATH)/bin" >> $HOME/.zshrc
source $HOME/.zshrc
go version

```

#### ARM

[Official install instructions](https://go.dev/doc/install)

```bash
mkdir -p /tmp/goinstall
cd /tmp/goinstall
wget https://go.dev/dl/go1.21.5.linux-arm64.tar.gz
tar -xf go1.21.5.linux-arm64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.5.linux-arm64.tar.gz
echo "\n# Add the go bin to your PATH\nexport PATH=\$PATH:/usr/local/go/bin" >> $HOME/.zshrc
source $HOME/.zshrc
echo "# Add GOPATH/bin to your PATH\nexport PATH=\$PATH:$(go env GOPATH)/bin" >> $HOME/.zshrc
source $HOME/.zshrc
go version
```

### Lazygit

[Official repository](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#manual)

Now that we have go installed, we can simply use the manual install method that should work with any distrib and architecture

```bash
mkdir /tmp/lazygit
cd /tmp/lazygit
git clone https://github.com/jesseduffield/lazygit.git
cd lazygit
go install
```

### Formatters for Neoformat

As of now, I am using [Neoformat](https://github.com/sbdchd/neoformat) as a formatter since null-ls is archived.
I need to find the time to use [none-ls](https://github.com/nvimtools/none-ls.nvim) instead.
It would be cleaner for the LSP and Mason to also handle the lint and format (and maybe the debugger later on).

#### Auto Install

In Neovim execute

```vim
:MasonInstallAll
```

#### Manual install

```bash
# Python formatters
pip install --user install black
pip install --user install djlint

# Go import format
go install golang.org/x/tools/cmd/goimports@latest

# Stylua
npx @johnnymorganz/stylua-bin --help
cp .npm/_npx/*/node_modules/@johnnymorganz/stylua-bin/bin/stylua $HOME/.local/bin

# Add .local/bin to PATH
echo "\n# .local/bin to PATH\nexport PATH=\$PATH:$HOME/.local/bin"  >> $HOME/.zshrc
```

### Potential issue with nvim-treesitter

> [!NOTE]
> If the parser goes crazy, it might be due to a conflict between the native nvim parser and nvim-treesitter one.
> To resolve the issue, run the command `:echo nvim_get_runtime_file('parser', v:true)`. If there is another parser
> in addition to $HOME/.local/share/nvim/lazy/nvim-treesitter/parser, go to that folder and rename it whatever.
> Now running the same command should only show the nvim-treesitter parser.

## TODO

- [x] Basic setup
- [x] LSP for python and go
- [x] Which key for keymap helpers
- [x] More LSP/Formatter: html, django, javascript/typescript, heredoc
- [ ] Try to use none-ls for formatting, using lspconfig and mason instead of outside installation and configuration with Neoformat
- [ ] Try to improve the file diff view in lazygit because right now it's hard to visualize all the changes in a file
- [ ] Debugger for python and go
