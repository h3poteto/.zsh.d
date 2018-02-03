# .zsh.d

個人的なzshの設定になります．

## zplug
### 初回
pluginのインストールにzplugを利用しています．
ただし，zplug自体のインストールは，スクリプト読み込み時に自動的に行われます．もし既に`$HOME/.zplug` が存在する場合は，ディレクトリを削除しておいてください．このディレクトが存在しない場合に限り，zplugのインストールスクリプトが実行されます．

### plugin追加
pluginを追加する場合は，`plugins.zsh` に追記し，

```bash
zplug "h3poteto/zsh-ec2ssh"
```

zshを読み込み直した上でinstallします．

```bash
$ exec $SHELL -l
$ zplug install
```

## 別途必要になるもの

- [direnv](https://github.com/direnv/direnv)
- [peco](https://github.com/peco/peco)
- [myaws](https://github.com/minamijoyo/myaws)
- [gawk](https://www.gnu.org/software/gawk/)

## zsh-ec2ssh
awsのアカウント情報からログインできるサーバ一覧を表示し，ログインする関数を提供します．この関数の実行には，

- [peco](https://github.com/peco/peco)
- [myaws](https://github.com/minamijoyo/myaws)

が必要になります．

myawsインストール後，awsの認証情報を `$HOME/.aws/credentials` に記述しておきます．

```
[default]
aws_access_key_id = XXXXXX
aws_secret_access_key = XXXXXX
```

### sshログイン

以下のような設定を `~/.zshrc` に書くことで利用できます．

```sh
AWS_PROFILE_NAME=default
AWS_DEFAULT_REGION=ap-northeast-1
SSH_USER=h3poteto
SSH_PRIVATE_KEY_PATH=$HOME/.ssh/id_rsa

function zsh-ec2ssh-default() { zsh-ec2ssh $AWS_PROFILE_NAME $AWS_DEFAULT_REGION $SSH_USER $SSH_PRIVATE_KEY_PATH }
zle -N zsh-ec2ssh-default
bindkey '^t' zsh-ec2ssh-default # Ctrl + t
```

### proxyを踏み台にしてssh
上記のsshログイン時にプロキシサーバを踏み台にするパターンを提供します．

以下のような定義を `~/.zshrc` に追記します．

```sh
AWS_PROFILE_NAME=production
AWS_DEFAULT_REGION=ap-northeast-1
SSH_USER=h3poteto
AWS_PROXY_PROFILE=proxy
SSH_PROXY_USER=proxy-login-user
SSH_PRIVATE_KEY_PATH=$HOME/.ssh/id_rsa

function zsh-ec2ssh-production-proxy() { zsh-ec2ssh-with-proxy $AWS_PROFILE_NAME $AWS_DEFAULT_REGION $SSH_USER $AWS_PROXY_PROFILE $SSH_PROXY_USER $SSH_PRIVATE_KEY_PATH }
zle -N zsh-ec2ssh-production-proxy
bindkey '^p' zsh-ec2ssh-production-proxy # Ctrl + p
```

これでまずproxyサーバの選択肢が示されます．
そこでproxyサーバを選択した後，次にログイン先のサーバ選択肢が出てきます．

## 起動時間の計測
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

## linuxでzplugによるインストールがエラーになる

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
