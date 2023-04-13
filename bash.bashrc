# ~/.bashrc

# if not running interactively, end
[[ $- != *i* ]] && return

archASCII='
         \e[0;36m.
        \e[0;36m/ \
       \e[0;36m/   \    \e[1;37m         #     \e[1;36m| *
      \e[0;36m/^.   \   \e[1;37m#%" a#"e 6##%  \e[1;36m| | |-^-. |   | \ /
     \e[0;36m/  .-.  \  \e[1;37m#   #    #  #  \e[1;36m| | |   | |   |  X
    \e[0;36m/  (   ) _\ \e[1;37m#   %#e" #  #  \e[1;36m| | |   | ^._.| / \
   \e[1;36m/ _.~   ~._^\
  \e[1;36m/.^         ^.\ \e[0;37mTM\e[m'

echo -e "$archASCII"

alias b='bash'
alias bs='. ~/.bashrc'
alias v='vim'
alias vrc='v ~/.vimrc'
alias brc='v ~/.bashrc'
alias rm='rm -fr'

alias ls='ls --file-type --color=auto'
alias la='ls -A'
alias ll='ls -l'

gitc(){ # git clone
  if [[ ! $1 ]]; then
    printf 'Must specifiy a repository\n'; return 1
  elif [[ $2 ]]; then
    user="$1" repo="$2"
  elif [[ $1 =~ / ]]; then
    user="${1%%/*}" repo="${1##*/}"
  fi
  
  git clone https://github.com/"${user:-wick3dr0se}"/"${repo:=$1}"
  cd "$repo"; printf '\e[2J\e[H'; ls
}

# prompt
shopt -s autocd cdspell dirspell cdable_vars

prompt_command() {
  dir='~'
  [[ $PWD == $HOME ]] || dir="${PWD/$HOME\/}"
  branch=$(git branch 2>/dev/null)
  tag=$(git tag 2>/dev/null)

	[[ $EUID -eq 0 ]] && symbol='#' || symbol='$'
  
  timeStart=$(date +%s)

	sec=$(((timeStart-timeEnd)%60))
	min=$(((timeStart-timeEnd)%3600/60))
	hr=$(((timeStart-timeEnd)/3600))

	timer=
  (( $hr > 0 )) && timer=$(printf '\e[31m%s\e[0mh, ' "$hr")
  (( $min > 0 )) && timer+=$(printf '\e[33m%s\e[0mm, ' "$min")
  (( $sec > 0 )) && timer+=$(printf '\e[32m%s\e[0ms ' "$sec")
  
  [[ $timer ]] && timer="in $timer"

  timeEnd=$timeStart

  printf '%s \e[36m%s \e[0m%s %s\n' \
    "$dir" "${branch#* }" "$tag" "$timer"
}

PROMPT_COMMAND=prompt_command
timeEnd=$(date +%s)

PS1="\$([[ \$? -eq 0 ]] && printf 'archstrap \[\e[32m\]%s\[\e[m\] ' "\$symbol" || \
  printf 'archstrap \[\e[31m\]%s\[\e[0m\] ' "\$symbol")"

PS4='-[\e[33m${BASH_SOURCE/.sh}\e[0m: \e[32m${LINENO}\e[0m] '
PS4+='${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
