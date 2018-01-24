# emacs 風
bindkey -e

# 補完
autoload -Uz compinit
compinit -C

# グロブ展開をさせない
setopt nonomatch

## 日本語ファイル名を表示可能にする
setopt print_eight_bit

#補完候補など表示する時はその場に表示し、終了時に画面から消す
setopt ALWAYS_LAST_PROMPT

# cdコマンド無しでcdできる
setopt AUTO_CD

# 曖昧な保管で自動的に選択肢をリストアップ
setopt AUTO_LIST

#語の途中でもカーソル位置で補完
setopt COMPLETE_IN_WORD

# コマンドが間違っている時に候補を提示する
setopt CORRECT

# コマンドのスペルの訂正を使用する
unsetopt CORRECT_ALL

# Ctrl+Dでzshを終了させない
setopt IGNORE_EOF

#ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt MARK_DIRS

# ジョブの状態をただちに知らせる
setopt NOTIFY

#Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_FLOW_CONTROL

# BEEP音を鳴らさない
setopt NO_BEEP

setopt PROMPT_SUBST

# シェル間の履歴共有をする
setopt SHARE_HISTORY

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
