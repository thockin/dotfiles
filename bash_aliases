alias more=less
alias vi=vim
alias ls='ls --color=tty'
alias bashrc='source ~/.bashrc'
alias dos2unix='perl -pi -e "tr/\r//d"'
alias unix2dos='perl -pi -e "s/\n$/\r\n/g"'
alias mac2unix='perl -pi -e "tr/\r/\n/d"'
alias findgrep="find . -print0 | xargs -0 grep"
alias enprint='enscript -h -G -E -2 -r --rotate-even-pages -DDuplex:true'

function count {
  I=$1
  while [ $I -le $2 ];
    do echo $I
    I=$((I+1))
  done
}

function field {
  awk "{print \$${1}}"
}

## General environment setup stuff
function _titlebar {
  echo -ne "\033]2;"$@"\a"
}
function titlebar {
  unset PROMPT_COMMAND
  _titlebar "$@"
}

function audio_alert {
  play ~/alert.wav >/dev/null 2>&1
}

function _color() {
  tput setf $1
}
function _term_reset() {
  tput sgr0
}
function color() {
  _color $1
  shift
  echo "$@"
  _term_reset
}

function _tput_if_set {
  for arg; do
      tput "$arg"
  done
}
function _default_ps1 {
  err="$1"

  local HC=9 # color = white
  local HF=() # formatting = none
  if [ "$err" != 0 ]; then
      HC=4 # red
      HF=(rev)
  fi

  local lvl=""
  if (( "$SHLVL" != 1 )); then
      lvl="shlvl=$SHLVL "
  fi

  PS1=""
  # Titlebar
  PS1="${PS1}\[\e]0;\u@\h: \w\a\]"
  # Formatted user@host
  PS1="${PS1}\[$(_tput_if_set "${HF[@]}")$(_color $HC)\]"
  PS1="${PS1}${lvl}"
  PS1="${PS1}\u@\h"
  PS1="${PS1}\[$(_term_reset)\]"
  PS1="${PS1}:\w\$ "
}
function _git_ps1 {
  err="$1"

  # Change color in case of errors
  local HC=6 # yellow
  local HF=() # no formatting
  if [ "$err" != 0 ]; then
      HC=4 # red
      HF=(rev)
  fi

  # Print shell-level if not 0
  local L=""
  if (( "$SHLVL" != 1 )); then
      L="shlvl=$SHLVL "
  fi

  # Notes
  local notes=()
  if [ -n "${PS1_NOTE:-}" ]; then
      notes+=("${PS1_NOTE}")
  fi
  local N=""
  if (( "${#notes[@]}" != 0 )); then
      N="($(IFS=','; echo "${notes[*]}")) "
  fi

  local H=$(hostname | cut -f1 -d.)
  local R=$(basename $(git root))
  local S=$(git rev-parse --short=5 HEAD 2>/dev/null || echo "<no sha>")
  local B=$(git curbr 2>/dev/null)
  local D=$(realpath . | sed "s|$(git root)/\?|/|")

  PS1=""
  PS1="${PS1}\[$(_tput_if_set "${HF[@]}")$(_color $HC)\]"
  PS1="${PS1}$L$H"
  PS1="${PS1}\[$(_term_reset)\]"
  PS1="${PS1} \[$(_color 1)\]$R"
  PS1="${PS1} \[$(_color 3)\]$S $B $N"
  PS1="${PS1}\[$(_color 6)\]$D"
  PS1="${PS1}\[$(_term_reset)\]"
  PS1="${PS1}\$ "
  _titlebar "git $R$D"
}
function my_ps1() {
  local err=$?
  #if [ $err != 0 ]; then
  #    play ~/alert.wav >/dev/null 2>&1 &
  #fi

  if [ -n "$DEMOSH" ]; then
      unset PROMPT_COMMAND
      PS1='\n\$ '
      return
  fi

  PROMPT_COMMAND=my_ps1

  if git root >/dev/null 2>&1; then
    _git_ps1 "$err"
    return
  fi
  _default_ps1 "$err"
}
alias config_ps1=my_ps1  # for back-compat
config_ps1  # Always run it

# Run a demo shell
alias demosh="DEMOSH=1 bash"

# My environment variables.
export CVS_RSH="ssh"
export GITHUB_USER="$USER"
export PRINTER=animatic-color
export ENV=$HOME/.bashrc
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export TERM=xterm

# Golang stuff
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$GOPATH/bin:/usr/local/go/bin:$PATH"

## Google perforce-related stuff
function g4vi {
  g4 edit "$@"
  vi "$@"
}
alias p4vi=g4vi

function do_p4_ps1() {
  X=$(pwd | awk -F / '{
    printf("%s %s", $6, gensub("^.*google3/?", "//", "g"));
  }' \
  | sed 's|java/com/google|j/c/g|' \
  | sed 's|javatest|j|')
  echo -n $X
}
function p4ps1() {
  PS1="\$(
      echo -ne \\[; tput setf 6; echo -ne \\];
      do_p4_ps1;
      echo -ne \\$\\[; tput sgr0; echo -ne \\];
  ) "
}
function g3_root() {
  r=$(g4 info | grep "^Client root" | cut -f2 -d:)
  if [ -z "$r" ]; then
    echo "CWD is not inside a g4 client" > /dev/stderr
    return
  fi
  echo $r/google3
}

# Google env vars.
export P4CONFIG=.p4config
#export P4DIFF=/google/src/files/head/depot/google3/devtools/scripts/p4diff
#export P4MERGE=/home/build/public/eng/perforce/mergep4.tcl
export P4EDITOR=$EDITOR
#export G4MULTIDIFF=1
#export P4DIFF="vim -f '+so /home/thockin/.vim/p4diff.vim'"
export DOCKER_CLI_EXPERIMENTAL=enabled

# The next line updates PATH for the Google Cloud SDK.
source ~thockin/google-cloud-sdk/path.bash.inc

[ -f ~/bin/usb-hotplug.sh ] && ~/bin/usb-hotplug.sh
