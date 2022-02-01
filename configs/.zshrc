# coreutils優先
# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# 入力補完
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

# カラー設定
autoload -Uz colors
colors

# プロンプト
PROMPT="%{$fg[cyan]%}%n@%m %c %#%{$reset_color%} "

# 入力補完の色
zstyle ':completion:*' menu select

# インストールしたコマンドの即時反映
zstyle ":completion:*:commands" rehash 1

# 履歴設定
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# コマンドの重複除去
setopt hist_ignore_dups

# 同時起動時共有
setopt share_history

# 誤入力修正
setopt correct

# プログラミング言語バージョン管理
eval "$(anyenv init -)"

# Alias設定
alias ls="gls --color=auto"
alias ll="ls -la"
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"
alias dk="docker"
alias dc="docker-compose"
alias tf="terraform"
