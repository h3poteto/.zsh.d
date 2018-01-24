# .zsh.d

個人的なzshの設定になります．

## zplug
pluginのインストールにzplugを利用しています．
[公式リポジトリ](https://github.com/zplug/zplug#installation) を参考にプラットフォームに合った形でzplugをインストールしてください．

また，このリポジトリで提供する共通設定を読み込む前にzplugを初期化する必要があります．
`~/.zshrc` では以下のようにして読み込みます．

```sh
source ~/.zplug/init.zsh
source ~/.zsh.d/.zshrc
```

## 別途必要になるもの

- [direnv](https://github.com/direnv/direnv)
- [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- [jq](https://stedolan.github.io/jq/)
- [peco](https://github.com/peco/peco)

### peco-ec2ssh
awsのアカウント情報からログインできるサーバ一覧を表示し，ログインする関数を提供します．この関数の実行には，

- [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- [jq](https://stedolan.github.io/jq/)
- [peco](https://github.com/peco/peco)

が必要になります．

以下のような設定を `~/.zshrc` に書くことで利用できます．

```sh
export EC2_SSH_USER=ec2-user
export AWS_PROFILE=default

function peco-ec2ssh-default() { peco-ec2ssh $AWS_PROFILE ap-northeast-1 $EC2_SSH_USER }
zle -N peco-ec2ssh-default
bindkey '^t' peco-ec2ssh-default
```

