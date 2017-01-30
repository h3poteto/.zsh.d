# emacs 風
bindkey -e

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 履歴の共有はしない
# setopt share_history

# 補完
autoload -Uz compinit
compinit -C

setopt print_eight_bit

setopt nonomatch

# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|)"



# カレントディレクトリ

autoload colors
colors

PROMPT="[%n]:%{${fg[yellow]}%}%~%{${reset_color}%}$ "

PROMPT2='[%n]> '

setopt AUTO_CD

setopt IGNORE_EOF
setopt NO_FLOW_CONTROL
setopt NO_BEEP


### plugin
source $HOME/.zsh.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath=($HOME/.zsh.d/anyframe(N-/) $fpath)

autoload -Uz anyframe-init
anyframe-init

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

bindkey '^x^r' anyframe-widget-execute-history
bindkey '^xb' anyframe-widget-cdr
bindkey '^x^b' anyframe-widget-checkout-git-branch



###################################
## custom
##################################


export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

alias g='git'


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

eval "$(direnv hook zsh)"
export EDITOR=emacs
export PATH="$HOME/.cask/bin:$PATH"

###################################
## ssh
###################################

function peco-ec2ssh() {
   aws_profile_name=$1
   aws_region=$2
  echo "Fetching ec2 host..."
  local selected_host=$(myaws ec2 ls --profile=${aws_profile_name} --region=${aws_region} --fields='InstanceId PublicIpAddress LaunchTime Tag:Name Tag:attached_asg' | sort -k4 | peco | cut -f2)
  if [ -n "${selected_host}" ]; then
    BUFFER="ssh $EC2_SSH_USER@${selected_host} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ec2ssh
