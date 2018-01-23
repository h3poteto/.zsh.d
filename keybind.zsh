### plugin
fpath=($HOME/.zsh.d/anyframe(N-/) $fpath)

autoload -Uz anyframe-init
anyframe-init

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

bindkey '^x^r' anyframe-widget-execute-history
bindkey '^xb' anyframe-widget-cdr
bindkey '^x^b' anyframe-widget-checkout-git-branch

alias g='git'
