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

function defaultps1() {
  PS1='\[\e]0;${TITLEBAR_PREFIX} \w\a\]\u@\h:\w\$ '
}
defaultps1 # call it

TITLEBAR_PREFIX=""
function titlebar {
  TITLEBAR_PREFIX="$*"
  echo -ne "\033]2;$*\a"
}

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

function color() {
  tput setf $1
}
function nocolor() {
  tput sgr0
}

function gitps1() {
  PROMPT_COMMAND=gitps1

  if ! git root >/dev/null 2>&1; then
    defaultps1
    return
  fi

  B=$(git curbr)
  U=$USER
  R=$(basename $(git root))
  H=$(hostname | cut -f1 -d.)
  W=$(realpath . | sed "s|$(git root)/\?|/|")

  #TODO: abstract the prefix, which sets titlebar and is duplicated
  #TODO: with defaultps1
  PS1='\[\e]0;${TITLEBAR_PREFIX} \w\a\]\[$(color 6)\]$U@$H \[$(color 1)\]$R \[$(color 3)\]$B \[$(color 6)\]$W\[$(nocolor)\]\$ '
}

# Define some handy variables
export CVS_RSH="ssh"
export P4CONFIG=.p4config
#export P4DIFF=/google/src/files/head/depot/google3/devtools/scripts/p4diff
#export P4MERGE=/home/build/public/eng/perforce/mergep4.tcl
export P4EDITOR=$EDITOR
export PRINTER=tahiti-color
export PRINTER2=waikiki-color
export ENV=$HOME/.bashrc
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
#export G4MULTIDIFF=1
#export P4DIFF="vim -f '+so /home/thockin/.vim/p4diff.vim'"

export PATH=~/src/go/bin:/usr/local/go/bin:$PATH
export GOPATH=~/src/go
function KUBEGOPATH {
  export GOPATH=`pwd`/Godeps/_workspace:`pwd`/_output/local/go:$GOPATH
}

# The next line updates PATH for the Google Cloud SDK.
source '/home/thockin/google-cloud-sdk/path.bash.inc'
