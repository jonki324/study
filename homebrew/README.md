# HomeBrew
## 前準備
### Xcodeインストール
- Xcodeインストール
- Command Line Toolsインストール
```
$ xcode-select --install
```
## インストールと確認
### $PATH確認
```
$ echo $PATH
/usr/local...
```
### /usr/localが存在しない場合
```
$ mkdir /usr/local
```

### インストール
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### 確認
```
$ brew -v
Homebrew 2.1.0
Homebrew/homebrew-core (git revision 3becb; last commit 2019-04-14)
Homebrew/homebrew-cask (git revision d0d20f; last commit 2019-04-15)

$ brew doctor
Your system is ready to brew.
```

## 基本コマンド
### 本体、formula情報更新
```
$ brew update
```

### インストール済みのformula更新
```
$ brew upgrade
```

### formula検索
```
$ brew search /wget/
```

### formula情報
```
$ brew info wget
```

### formulaインストールオプション
```
$ brew options wget
```

### formulaインストール
```
$ brew install wget
```

### formula一覧
```
$ brew list
```

### formulaアンインストール
```
$ brew uninstall wget
```

### 古いformula削除
```
$ brew cleanup
```

### リポジトリ一覧
```
$ brew tap
```

### リポジトリ追加
```
$ brew tap user/repo
```

### リポジトリ削除
```
$ brew untap user/repo
```

### バージョン切り替え
```
$ brew unlink mysql && brew link mysql56
```

### cask
```
$ brew tap caskroom/versions
```

### caskでインストール
```
$ brew cask install java8
 
$ /usr/libexec/java_home -V
 
$ vi .bash_profile
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
 
$ source ~/.bash_profile
```

### caskで入れたアプリ一覧
```
$ brew cask list
```

### アンインストール
```
$ brew cask uninstall java8
```

### バージョンアップ
```
$ brew cask upgrade
```

## 一括インストール
### 現在のインストールアプリを出力
```
$ brew bundle dump
```

### Brewfileをもとに一括インストール
```
$ brew bundle
```
