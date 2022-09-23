set fish_greeting ""

set -gx TERM xterm-256color

fzf_configure_bindings --directory=\cp

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
alias gaa "git add -A"
alias gap "git add -p"
alias gco "git checkout"
alias gb "git branch"
alias gcb "git checkout -b"
alias hb "gh browse"
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

  function fzf-rg-search-widget -d 'find text in files'

    set rg_command "rg --ignore-case --files-with-matches -uu --iglob='!**/.git/' --follow"
    # Start with all files; i.e. .*
    FZF_DEFAULT_COMMAND="$rg_command '.*'" SHELL=fish fzf \
      -m \
      -e \
      --ansi \
      --disabled \
      --bind "change:reload:$rg_command {q} || true" \
      # I'm not sure what this `cut` does — but remove it and the whole thing fails.
      --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2 \
      | fzf_add_to_commandline
  end


  # The following few `__git` functions are Heavily adapted from
  # https://gist.github.com/aluxian/9c6f97557b7971c32fdff2f2b1da8209
  function __git_fzf_is_in_git_repo -d "Check whether we're in a git repo"
    command -s -q git
      and git rev-parse HEAD >/dev/null 2>&1
  end

  # Deciphered from fzf-file-widget. Surprising why it doesn't exist already!
  function fzf_add_to_commandline -d 'add stdin to the command line, for fzf functions'
    read -l -z result
    commandline -t ""
    # Do we need to escape this? This was here before, but doesn't work well with
    # multiline strings.
    # commandline -it -- (string escape $result)
    commandline -it -- (echo $result | paste -s -d" " -)
    commandline -f repaint
  end

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block
