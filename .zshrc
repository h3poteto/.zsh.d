# emacs 風
bindkey -e

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt share_history

# 補完
autoload -Uz compinit
compinit

setopt print_eight_bit

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




###################################
## custom
##################################

source $HOME/.zsh.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

alias g='git'

# for go lang
if [ -x "`which go`" ]; then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
