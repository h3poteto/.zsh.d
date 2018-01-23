# プラグインマネージャとしてzplugを使用することを前提にしている
# そのため先に~/.zshrcにsource ~/.zplug/init.zshの記述をした上でこのファイルを読むこと
# https://github.com/zplug/zplug

zplug "zsh-users/zsh-syntax-highlighting"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

source ./config.zsh
source ./prompt.zsh
source ./keybind.zsh
source ./env.zsh
source ./function.zsh
