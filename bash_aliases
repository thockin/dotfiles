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

function _color() {
  tput setf $1
}
function _nocolor() {
  tput sgr0
}
function color() {
  _color $1
  shift
  echo "$@"
  _nocolor
}

function _default_ps1 {
  local lvl=""
  if (( "$SHLVL" != 1 )); then
      lvl="shlvl=$SHLVL "
  fi
  PS1="${lvl}\[\e]0;\u@\h: \w\a\]\u@\h:\w\$ "
}
function my_ps1() {
  if [ -n "$DEMOSH" ]; then
      unset PROMPT_COMMAND
      PS1='\n\$ '
      return
  fi

  PROMPT_COMMAND=my_ps1

  if ! git root >/dev/null 2>&1; then
    _default_ps1
    return
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

  PS1="\[$(_color 6)\]$L$H \[$(_color 1)\]$R \[$(_color 3)\]$S $B $N\[$(_color 6)\]$D\[$(_nocolor)\]\$ "
  _titlebar "git $R$W"
}
alias gitps1=my_ps1  # for back-compat
gitps1  # Always run it

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
