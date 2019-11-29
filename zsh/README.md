# zsh

## インストール
```bash
$ brew install zsh
$ brew install zsh-completion
$ brew install coreutils
$ chmod go-w '/usr/local/share'
```

## 設定ファイル作成
```bash
$ vi .zshrc
```
```
# 履歴設定
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# コマンドの重複除去
setopt hist_ignore_dups

# 同時起動時共有
setopt share_history

# カラー設定
autoload -Uz colors
colors

# プロンプト
PROMPT="%{$fg[cyan]%}%n@%m %c %#%{$reset_color%} "

# ディレクトリ等
eval "$(/usr/local/opt/coreutils/libexec/gnubin/dircolors ~/.dircolors-solarized/dircolors.ansi-dark)"

# 入力補完
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz compinit
compinit

# 入力補完の色
zstyle ':completion:*' menu select

# 誤入力修正
setopt correct

# 各言語バージョン切り替え
eval "$(anyenv init - zsh)"

# Oracle sqlplus設定
export ORACLE_HOME="/usr/local/oracle"
export SQLPATH="$ORACLE_HOME/sqlplus"
export PATH="$SQLPATH:$PATH"
export NLS_LANG="Japanese_Japan.AL32UTF8"

# phpenv設定
# OpenSSL設定
export PATH="/usr/local/opt/openssl/bin:$PATH"

# bison設定
export PATH="/usr/local/opt/bison/bin:$PATH"

# libxml設定
export PATH="/usr/local/opt/libxml2/bin:$PATH"

# postgresql設定
export PGDATA="/usr/local/var/postgres"

# エイリアス設定
alias ls="gls --color=auto"
alias ll="ls -la"
alias brew="PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin brew"
alias py="python"
alias conda_activate='source $PYENV_ROOT/versions/$(pyenv version-name)/bin/activate'
alias conn_oracle='rlwrap sqlplus ca/pro@//localhost:1521/ORCLPDB1'
```

## シェルの変更
```bash
# シェル一覧
$ sudo vi /etc/shells
```
```
# 下記を追記
/usr/local/bin/zsh
```

```bash
$ chsh -s /usr/local/bin/zsh
```
