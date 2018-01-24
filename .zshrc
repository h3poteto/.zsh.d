# プラグインマネージャとしてzplugを使用することを前提にしている
# そのため先に~/.zshrcにsource ~/.zplug/init.zshの記述をした上でこのファイルを読むこと
# その他環境による差分もあるので，こちらを参照: https://github.com/zplug/zplug

zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-completions"

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
source ./env.zsh
source ./function.zsh
source ./keybind.zsh
