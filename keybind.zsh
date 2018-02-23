autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

bindkey '^r' anyframe-widget-execute-history
bindkey '^xb' anyframe-widget-cdr
bindkey '^x^b' anyframe-widget-checkout-git-branch
bindkey '^f' peco-z-search
bindkey '^i' peco-git-rebase

alias g='git'
alias cdu='cd-gitroot'
alias ghb='gitit branch'
alias ghm='gitit branch master'
