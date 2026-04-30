##### ────────────────[ Profiling ]─────────────── #####

if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# Put nanobrew on PATH before anything that needs fnm/archey/antidote/etc.
export PATH="/opt/nanobrew/prefix/bin:$PATH"

##### ────────────────[ Antidote ]─────────────── #####

# Antidote (https://getantidote.github.io)
source /opt/nanobrew/prefix/Cellar/antidote/*/share/antidote/antidote.zsh

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

# Chargement rapide des plugins (regenerate static bundle if missing)
[[ -f ~/.zsh_plugins.zsh ]] || antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh
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

unset FNM_ARCH  # was leaking x64 from old Intel fnm and forcing Rosetta Node
eval "$(fnm env --use-on-cd)"

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

# Prevent nanobrew/Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
# export HOMEBREW_NO_ANALYTICS=1

# iterm shell integration
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# github-copilot-cli aliases
# eval "$(github-copilot-cli alias -- "$0")"

# flutter path
# export PATH="$PATH:`pwd`/flutter/bin"

##### ────────────────[ Archey swag ]─────────────── #####

# archey swag from https://github.com/HorlogeSkynet/archey4
archey

##### ────────────────[ Google Cloud SDK ]─────────────── #####

if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi

if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

##### ────────────────[ Bun ]─────────────── #####

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# eval "$(starship init zsh)"

##### ────────────────[ Extra PATH ]─────────────── #####

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$HOME/.local/bin:$PATH"

# Strip Intel Homebrew paths so nothing runs under Rosetta (chrome-devtools-mcp etc.)
PATH=$(echo "$PATH" | tr ':' '\n' | grep -vE '^/usr/local(/bin|/sbin|/opt/)' | paste -sd: -)
export PATH

# OrbStack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# LM Studio
export PATH="$PATH:$HOME/.lmstudio/bin"

##### ────────────────[ Fin de profiling ]─────────────── #####

if [[ "$ZPROF" = true ]]; then
  zprof
fi

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
