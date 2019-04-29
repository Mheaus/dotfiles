# profiling
if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# zplug framework https://github.com/zplug/zplug
# install zplug if not found
[[ -d ~/.zplug ]] || {
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  source ~/.zplug/zplug
  zplug update --self
}

# essential
source ~/.zplug/init.zsh

ZSH=$HOME/.oh-my-zsh

##### history management #####
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt BANG_HIST # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS # Do not display a line previously found.
setopt HIST_IGNORE_SPACE # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY # Don't execute immediately upon history expansion.

##### functions ####
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

profzsh() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}


# Add ruby version on prompt (float right)
# if [ -x "$(command -v rbenv)" ]; then RPS1='[$(ruby_prompt_info)]$EPS1'; fi

# custom title
# DISABLE_AUTO_TITLE="true"
# case $TERM in
#   xterm*)
#     precmd () {print -Pn "\e]0;%~\a"}
#     ;;
# esac

##### theme #####
zplug "Mheaus/zsh-theme", from:github, as:theme
# zplug "themes/robbyrussell", from:oh-my-zsh, as:theme
# zplug "ergenekonyigit/lambda-gitster", from:github, as:theme
# zplug "NicolaiRuckel/oh-my-zsh-candy-light", from:github, as:theme
# zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

# You can change the theme with another one:
#   https://github.com/robbyrussell/oh-my-zsh/wiki/themes
# ZSH_THEME="robbyrussell"


# nvm
export NVM_LAZY_LOAD=true
# export NVM_DIR="$HOME/.nvm"
# . "/usr/local/opt/nvm/nvm.sh"

##### plugins #####
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/gitfast", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh
zplug "plugins/battery", from:oh-my-zsh
zplug "plugins/bgnotify", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
# don't forget to bindkey with zsh-history-substring-search :
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "mdumitru/last-working-dir"
# handle dark/light theme
zplug "pndurette/zsh-lux"
# plugin that reminds you to use existing aliases for commands you just typed
zplug "MichaelAquilina/zsh-you-should-use"
# installing, updating and loading nvm
zplug "lukechilds/zsh-nvm"

# oh-my-zsh plugins
# plugins=(gitfast brew rbenv last-working-dir common-aliases zsh-syntax-highlighting history-substring-search z cp osx battery bgnotify)

# Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
# export HOMEBREW_NO_ANALYTICS=1

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# export PATH="./bin:${PATH}:/usr/local/sbin"

##### aliases #####
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1"

# iterm shell integration
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# install plugins if some of them are not installed yet
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# essential
zplug load

# end of profiling
if [[ "$ZPROF" = true ]]; then
  zprof
fi
