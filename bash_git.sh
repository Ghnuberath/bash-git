#!/bin/bash

# custom prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
git_status() {
  git status --porcelain 2> /dev/null | wc -l | grep -v 0 | awk '{print "["$1"]"}'
}
git_unstaged() {
  git status --porcelain 2> /dev/null | grep '^ [M|D]\|^??' | wc -l | grep -v 0 | awk '{print "["$1"]"}'
}
git_staged() {
  git status --porcelain 2> /dev/null | grep -v '^ [M|D]\|^??' | wc -l | grep -v 0 | awk '{print "["$1"]"}'
}
current_username() {
  echo "$USER"@ | grep -v smcintyre@
}
PS1="\$(current_username)\h:\w\[\033[33m\]\$(parse_git_branch) \[\033[31m\]\$(git_unstaged)\[\033[32m\]\$(git_staged)\[\033[00m\]\n$ "
