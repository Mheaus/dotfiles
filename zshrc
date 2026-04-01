##### ────────────────[ Profiling ]─────────────── #####

if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

##### ────────────────[ Antidote ]─────────────── #####

# Antidote (https://getantidote.github.io)
source $(brew --prefix antidote)/share/antidote/antidote.zsh

autoload -Uz compinit
compinit

setopt prompt_subst

autoload -Uz colors && colors

# Patch pour éviter les erreurs avec les wrappers OMZ (ex: _defer_async_git_register)
_omz_register_handler() {}

git_branch_prompt() {
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [[ -n "$branch" ]] && echo "%{$fg[magenta]%}($branch)%{$reset_color%}"
}

# Chargement rapide des plugins
source ~/.zsh_plugins.zsh

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt correct

##### ────────────────[ Fonctions utilitaires ]─────────────── #####

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

profzsh() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}

##### ────────────────[ FNM: ultra-rapide alternative à NVM ]─────────────── #####

eval "$(fnm env --use-on-cd)"
[[ -f "$HOME/.fnm/completions" ]] && source "$HOME/.fnm/completions"
[[ -f "$HOME/.fnm/env" ]] && source "$HOME/.fnm/env"

##### ────────────────[ Liaison clavier plugins ]─────────────── #####

# don't forget to bindkey with zsh-history-substring-search :
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

##### ────────────────[ Aliases & Envs persos ]─────────────── #####

[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
[[ -f "$HOME/.zshenv" ]] && source "$HOME/.zshenv"

##### ────────────────[ Divers exports ]─────────────── #####

# Always enable colored `grep` output.
alias grep='grep --color=auto'

# set default git main branch to main
export git_main_branch="main"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
# export HOMEBREW_NO_ANALYTICS=1

# iterm shell integration
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# github-copilot-cli aliases
# eval "$(github-copilot-cli alias -- "$0")"

# flutter path
# export PATH="$PATH:`pwd`/flutter/bin"

##### ────────────────[ Archey swag ]─────────────── #####

# archey swag from https://github.com/HorlogeSkynet/archey4
archey() {
  command archey
}
precmd_functions+=(archey)

##### ────────────────[ Google Cloud SDK ]─────────────── #####

if [ -f '/Users/mheos/google-cloud-sdk/path.zsh.inc' ]; then
  . '/Users/mheos/google-cloud-sdk/path.zsh.inc'
fi

if [ -f '/Users/mheos/google-cloud-sdk/completion.zsh.inc' ]; then
  . '/Users/mheos/google-cloud-sdk/completion.zsh.inc'
fi

##### ────────────────[ Bun ]─────────────── #####

[ -s "/Users/mheos/.bun/_bun" ] && source "/Users/mheos/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# eval "$(starship init zsh)"

##### ────────────────[ Extra PATH ]─────────────── #####

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="/opt/nanobrew/prefix/bin:$HOME/.local/bin:$HOME/Library/Python/3.9/bin:$PATH"

# OrbStack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# LM Studio
export PATH="$PATH:$HOME/.lmstudio/bin"

##### ────────────────[ Fin de profiling ]─────────────── #####

if [[ "$ZPROF" = true ]]; then
  zprof
fi
