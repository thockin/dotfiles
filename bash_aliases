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

function titlebar {
  unset PROMPT_COMMAND
  echo -ne "\033]2;$*\a"
}

function titlebar_reset {
  export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
}

function g4vi {
  g4 edit "$@"
  vi "$@"
}
alias p4vi=g4vi

# old version
#function setps1 {
#  PS1="\$(pwd | awk -F / '{
#      printf(\"%s %s\", \$6, gensub(\"^.*google3/?\", \"//\", \"g\"));
#  }')\$ "
#}

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
    PS1="\u@\h:\w\$ "
    return
  fi

  B=$(git curbr)
  U=$USER
  R=$(basename $(git root))
  H=$(hostname | cut -f1 -d.)
  W=$(realpath . | sed "s|$(git root)/\?|/|")

  PS1="\[$(color 6)\]$U@$H \[$(color 1)\]$R \[$(color 3)\]$B \[$(color 6)\]$W\[$(nocolor)\]\$ "
}

# Define some handy variables
export CVS_RSH="ssh"
export PRINTER=tahiti-color
export PRINTER2=waikiki-color
export ENV=$HOME/.bashrc
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

export PATH=~/src/go/bin:$PATH
export GOPATH=~/src/go
function KUBEGOPATH {
  export GOPATH=`pwd`/Godeps/_workspace:`pwd`/_output/local/go:$GOPATH
}
