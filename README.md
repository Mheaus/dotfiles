# Setup instructions

- Grab a text editor
- Install a package manager
- Pimp your Terminal
- Setup git and GitHub

## Command Line Tools

Open the Terminal and run:

```bash
xcode-select --install
```

If you get `command line tools are already installed`, skip this step.

## GitHub account

Sign up at [github.com](https://github.com/join) if you haven't already and [upload a profile picture](https://github.com/settings/profile).

## Homebrew

Install [Homebrew](https://brew.sh/), the macOS package manager:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install some useful software:

```bash
brew update
brew install git wget jq openssl
```

## VSCode - Text Editor

Download **VSCode** from [code.visualstudio.com](https://code.visualstudio.com/) and drag it into `Applications`.

## iTerm2 - Terminal

Download and install [iTerm2](https://iterm2.com/) for a better terminal experience.

## Antidote - Zsh Plugin Manager

[Antidote](https://getantidote.github.io/) is a fast zsh plugin manager used by this dotfiles setup.

```bash
brew install antidote
```

Plugins are declared in `~/.zsh_plugins.txt`. The `zshrc` sources antidote automatically on shell start.

## fnm - Node Version Manager

[fnm](https://github.com/Schniz/fnm) is a fast Node.js version manager (alternative to nvm).

```bash
brew install fnm
```

Install the latest LTS and set it as default:

```bash
fnm install --lts
fnm default lts-latest
```

fnm automatically switches Node versions when a `.nvmrc` or `.node-version` file is found in the project directory.

## Bun - JavaScript Runtime & Package Manager

[Bun](https://bun.sh/) is a fast all-in-one JavaScript runtime and package manager.

```bash
curl -fsSL https://bun.sh/install | bash
```

## OrbStack - Docker & Linux VMs

[OrbStack](https://orbstack.dev/) is a lightweight alternative to Docker Desktop for running containers and Linux VMs.

Download and install from [orbstack.dev](https://orbstack.dev/). Shell integration is handled automatically via `~/.orbstack/shell/init.zsh`.

## GitHub SSH

Generate SSH keys for GitHub authentication:

```bash
mkdir -p ~/.ssh && ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/id_ed25519 -C "your@email.com"
```

Copy your public key and add it to [github.com/settings/ssh](https://github.com/settings/ssh):

```bash
cat ~/.ssh/id_ed25519.pub
```

Verify it works:

```bash
ssh -T git@github.com
# Hi --------! You've successfully authenticated...
```

## Dotfiles

Fork [mheaus/dotfiles](https://github.com/mheaus/dotfiles/fork) to your GitHub account, then clone it:

```bash
export GITHUB_USERNAME=replace_this_with_your_github_username
mkdir -p ~/code/$GITHUB_USERNAME && cd $_ && git clone git@github.com:$GITHUB_USERNAME/dotfiles.git
```

Run the installers:

```bash
cd ~/code/$GITHUB_USERNAME/dotfiles
zsh install.sh
zsh git_setup.sh
```

### SSH config

To avoid re-typing your SSH passphrase at every `git push`, add the following to `~/.ssh/config`:

```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

## Security

Go to **System Settings > Users & Groups** to set a login password. Enable **System Settings > Lock Screen > Require password after screen saver begins**.

## Check-up

```bash
brew doctor
```

## Keyboard

### Key Repeat Speed

Go to **System Settings > Keyboard**. Set `Key Repeat` to the fastest and `Delay Until Repeat` to the shortest.

### macOS tweaks

Cherry-pick from [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles/blob/master/.macos):

```bash
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Save screenshots to the Desktop
defaults write com.apple.screencapture location "${HOME}/Desktop"
```
