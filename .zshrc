# zplugを自動インストールする
# https://github.com/zplug/zplug
export ZPLUG_HOME=~/.zplug
if [ ! -d "$ZPLUG_HOME" ];then
    echo "install zplug"
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source $ZPLUG_HOME/init.zsh

script_dir=$(cd $(dirname $0); pwd)
source $script_dir/plugins.zsh


# Then, source plugins and add commands to $PATH
zplug load

source $script_dir/config.zsh
source $script_dir/prompt.zsh
source $script_dir/env.zsh
source $script_dir/function.zsh
source $script_dir/keybind.zsh
