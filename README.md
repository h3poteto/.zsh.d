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
- [gawk](https://www.gnu.org/software/gawk/)

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

### 起動時間の計測
zshの起動が遅い場合には起動時間を計測することができます．

`~/.zshenv` で `zprof` を読み込みます．

```sh
zmodload zsh/zprof && zprof
```

そして `/.zshrc` で結果を表示します．

```sh
if (which zprof > /dev/null) ;then
  zprof | cat
fi
```

### linuxでzplugによるインストールがエラーになる

Ubuntu14.04でzplugを使っていたところ，下記のようなエラーがありました．


```sh
- peterhurford/git-it-on.zsh: not installed
- zsh-users/zsh-completions: not installed
- zsh-users/zsh-autosuggestions: not installed
- zsh-users/zsh-syntax-highlighting: not installed
- mollifier/cd-gitroot: not installed
- rupa/z: not installed
- mollifier/anyframe: not installed
Install? [y/N]: y
[zplug] Start to install 7 plugins in parallel

 ✘  Unknown error         zsh-users/zsh-completions
 ✘  Unknown error         peterhurford/git-it-on.zsh
 ✘  Unknown error         mollifier/cd-gitroot
 ✘  Unknown error         zsh-users/zsh-syntax-highlighting
 ✘  Unknown error         zsh-users/zsh-autosuggestions
 ✘  Unknown error         rupa/z
 ✘  Unknown error         mollifier/anyframe

[zplug] Elapsed time: 2.4594 sec.
 ==> Installation finished successfully!
 Load "~/.zplug/repos/peterhurford/git-it-on.zsh/git-it-on.plugin.zsh" (peterhurford/git-it-on.zsh)
 Load "~/.zplug/repos/rupa/z/z.sh" (rupa/z)
 Load "~/.zplug/repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" (zsh-users/zsh-autosuggestions)
 Load "~/.zplug/repos/mollifier/cd-gitroot/cd-gitroot.plugin.zsh" (mollifier/cd-gitroot)
 Load "~/.zplug/repos/zsh-users/zsh-completions/zsh-completions.plugin.zsh" (zsh-users/zsh-completions)
 Load "~/.zplug/repos/mollifier/anyframe/anyframe.plugin.zsh" (mollifier/anyframe)
[zplug] Run compinit
 Load "~/.zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" (zsh-users/zsh-syntax-highlighting)
[akira]:~/.zplug/repos$
```

インストール自体は完了しているように見えますが，個々のプラグインのインストールは全て失敗しているようにも見えます．

これに関しては[zplugのissue](https://github.com/zplug/zplug/issues/359)で報告されています．修正するには，`gawk`が必要になります．

```sh
$ sudo apt-get update
...
$ sudo apt-get install gawk
```

これでインストールが成功するようになります．
