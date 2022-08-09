set fish_greeting ""

set -gx TERM xterm-256color

#theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

#aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias gs "git status"
alias gl "git log"
alias gd "git diff"
alias gc "git commit -m"
alias hb "hub browse"
alias c "open . -a \"Visual Studio Code\""

alias config "/opt/homebrew/bin//git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

alias     ... 'cd ../..'
alias    .... 'cd ../../..'
alias   ..... 'cd ../../../..'
alias  ...... 'cd ../../../../..'
alias ....... 'cd ../../../../../..'

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-osx.fish
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
  case '*'
    source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
  source $LOCAL_CONFIG
end

# ch - browse chrome history
function ch
  set -l cols 40
  set -l sep '{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
end


# pnpm
set -gx PNPM_HOME "/Users/sam/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
