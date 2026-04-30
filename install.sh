#!/bin/zsh

DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)

backup() {
  target=$1
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      mv "$target" "$target.backup"
      echo "-----> Moved your old $target config file to $target.backup"
    fi
  fi
}

symlink() {
  file=$1
  link=$2
  if [ ! -e "$link" ]; then
    echo "-----> Symlinking your new $link"
    ln -s $file $link
  fi
}

# Core dotfiles
for name in aliases gitconfig zshrc; do
  if [ ! -d "$name" ]; then
    target="$HOME/.$name"
    backup $target
    symlink $DOTFILES_DIR/$name $target
  fi
done

# zsh_plugins.txt (antidote plugin list)
backup "$HOME/.zsh_plugins.txt"
symlink "$DOTFILES_DIR/zsh_plugins.txt" "$HOME/.zsh_plugins.txt"

# zshenv: copy example if no real file exists
if [ ! -f "$HOME/.zshenv" ]; then
  cp "$DOTFILES_DIR/zshenv.example" "$HOME/.zshenv"
  echo "-----> Created ~/.zshenv from zshenv.example — fill in your secrets"
fi

# VS Code settings and keybindings
if [[ $(uname) =~ "Darwin" ]]; then
  CODE_PATH="$HOME/Library/Application Support/Code/User"
else
  CODE_PATH="$HOME/.config/Code/User"
  if [ ! -e "$CODE_PATH" ]; then
    CODE_PATH="$HOME/.vscode-server/data/Machine"
  fi
fi

for name in settings.json keybindings.json; do
  target="$CODE_PATH/$name"
  backup "$target"
  symlink "$DOTFILES_DIR/vscode/$name" "$target"
done

# SSH config
if [[ $(uname) =~ "Darwin" ]]; then
  target="$HOME/.ssh/config"
  backup $target
  symlink "$DOTFILES_DIR/config" $target
  ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null || true
fi

# iTerm2: load preferences from dotfiles
if [[ $(uname) =~ "Darwin" ]] && [ -d "$DOTFILES_DIR/iterm2" ]; then
  echo "-----> Configuring iTerm2 to load prefs from dotfiles"
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool YES
  defaults write com.googlecode.iterm2 PrefsCustomFolder "$DOTFILES_DIR/iterm2"
fi

exec zsh

echo "👌 Carry on with git setup!"
