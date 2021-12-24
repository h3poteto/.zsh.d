autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

bindkey '^r' anyframe-widget-execute-history
bindkey '^xb' anyframe-widget-cdr
bindkey '^x^b' anyframe-widget-checkout-git-branch
bindkey '^f' peco-z-search
bindkey '^g^r' peco-git-rebase

alias awsp="source _awsp"
alias g='git'
alias cdu='cd-gitroot'
alias ghb='gitit branch'
alias ghm='gitit branch master'
alias e='~/.emacs.d/emacs-client'
alias k='kubectl'
alias tf='terraform'
alias kc='kubectx | peco | xargs kubectx'
alias kn='kubens | peco | xargs kubens'

