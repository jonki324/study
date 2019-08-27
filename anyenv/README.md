# anyenv
## インストール
```
$ brew install anyenv
```
```
$ vi ~/.bash_profile
```
```
eval "$(anyenv init -)"
```

### 初期化
```
$ anyenv install --init
```

### プラグインのインストール
- anyenv-update : **envの一括アップデート
```
$ mkdir -p ~/.anyenv/plugins

$ git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update

# インストールした**envを一括アップデート
$ anyenv update
```

## anyenv使用方法
### 各**envのバージョン確認
```
$ anyenv versions
```

### インストールできる**env一覧
```
$ anyenv install --list
```

### **envインストール
```
$ anyenv install phpenv

$ source .bash_profile
```

## pyenv
### インストール可能なバージョン確認
```
$ pyenv install --list
```

### インストール
```
$ pyenv install anaconda3-5.1.0
```

### インストール済みバージョン確認
```
$ pyenv versions
```

### プラグインのインストール
```
$ git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
```

### バージョンを指定(グローバルの場合)
```
$ pyenv global anaconda3-5.1.0
```

### バージョンを指定(ローカルの場合)
```
$ mkdir test
$ cd test

$ pyenv local anaconda3-5.1.0
```

### 仮想環境作成
```
$ pyenv virtualenv 3.7.0 testenv

$ pyenv versions
```

### 環境削除
```
$ pyenv uninstall 3.7.0
$ pyenv uninstall testenv
```

## jenv
### インストール済みバージョン確認
```
$ jenv versions
```

### 追加
```
# Java_Homeを確認
$ /usr/libexec/java_home -V

$ jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home
```

### バージョンを指定(グローバルの場合)
```
$ jenv global 1.8
```

### バージョンを指定(ローカルの場合)
```
$ mkdir test
$ cd test

$ jenv local 1.8
```

## phpenv
### インストール可能なバージョン確認
```
$ phpenv install --list
```

### インストール
#### 前処理
```
$ brew install bison
$ echo 'export PATH="/usr/local/opt/bison/bin:$PATH"' >> ~/.bash_profile

$ brew install re2c

$ brew upgrade openssl
$ echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.bash_profile

$ brew install libxml2
$ echo 'export PATH="/usr/local/opt/libxml2/bin:$PATH"' >> ~/.bash_profile
```

#### バージョン指定してインストール
```
$ phpenv install 7.3.6
$ phpenv rehash
```

### インストール済みバージョン確認
```
$ phpenv versions
```

### バージョンを指定(グローバルの場合)
```
$ phpenv global 7.3.6
```

### バージョンを指定(ローカルの場合)
```
$ mkdir test
$ cd test

$ phpenv local 7.3.6
```
