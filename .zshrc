export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gozilla"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  git
  z
  zsh-autosuggestions
  zsh-vi-mode
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# fnm
eval "$(fnm env --use-on-cd)"

# fuzzy finder
export FZF_DEFAULT_OPTS='--height=70%'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND='rg --files --no-messages'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.resticenv

# bun completions
[ -s "/Users/sam/.bun/_bun" ] && source "/Users/sam/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# auto-commit
export PATH="$PATH:$HOME/.bin"
source ~/.openaiapikey

# custom function to fzf chrome search history
ch () {
  COLS=40
  SEP='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h

  sqlite3 -separator $SEP /tmp/h \
    "select substr(title, 1, $COLS), url
     from urls order by last_visit_time desc" |
  awk -F $SEP '{printf "%-'$COLS's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi --no-preview | sed 's#.*\(https*://\)#\1#' | xargs open
}

if [[ -x "$(command -v exa)" ]] then
  alias ll='exa -l --icons --group-directories-first'
  alias lla='ll -a'
fi

# aliases
alias gs="git status"
alias c="open . -a 'Visual Studio Code'"
alias gl='git log'
alias hb='gh browse'
alias vim='nvim'
alias v='nvim .'
alias config='/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cat='bat'
alias tl='tmux ls'
alias ta='tmux a -t'
alias tn='tmux new -s'

# pnpm
export PNPM_HOME="/Users/sam/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# github copilot cli
eval "$(github-copilot-cli alias -- "$0")"

eval "$(rbenv init - zsh)"

#compdef index.js
###-begin-index.js-completions-###
#
# yargs command completion script
#
# Installation: ./../../Library/pnpm/global/5/node_modules/@withgraphite/graphite-cli/dist/src/index.js completion >> ~/.zshrc
#    or ./../../Library/pnpm/global/5/node_modules/@withgraphite/graphite-cli/dist/src/index.js completion >> ~/.zprofile on OSX.
#
_index.js_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" ./../../Library/pnpm/global/5/node_modules/@withgraphite/graphite-cli/dist/src/index.js --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _index.js_yargs_completions index.js
###-end-index.js-completions-###

