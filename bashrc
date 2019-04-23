# Allow local customizations in the ~/.bashrc_local_before file
if [ -f ~/.bashrc_local_before ]; then
    source ~/.bashrc_local_before
fi

# Make it possbile for do Ctrl-s for forward search
# https://superuser.com/questions/159106/reverse-i-search-in-bash
stty -ixon

alias g='git'
alias gs='git status'
alias gss='git status -s'
alias gc='git commit'
alias gcm='git commit --message'
alias gco='git checkout'
alias gbr='git branch'
alias ga='git add'
alias gau='git add --update'
alias glgoaad='git log --graph --oneline --abbrev-commit --all --decorate'
alias d='docker'
alias dc='docker-compose'
alias grep='grep --color'

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

vg() {
  local file

  file="$(rg --no-heading $@ | fzf -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Another fd - cd into the selected directory
# This one differs from the above, by only showing the sub directories and not
#  showing the directories within those.
fdd() {
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Allow local customizations in the ~/.bashrc_local_after file
if [ -f ~/.bashrc_local_after ]; then
    source ~/.bashrc_local_after
fi
