# dotfiles
## GitHubリポジトリを作成し、クローン
```
$ git clone https://github.com/jonki324/dotfiles.git
```

## 管理対象ファイルを移動する
```
$ mv ~/.bash_profile ~/dotfiles
...
```

## 移動したファイルのシンボリックリンクを設定するスクリプトを作成する
```
$ vi ~/dotfiles/setup.sh
```
```
#!/bin/bash

DOT_FILES=(.bashrc .bash_profile …)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
```

## スクリプトを実行する
```
$ chmod +x ~/dotfiles/setup.sh
```

## GitHubにアップロードする
```
$ git add .
$ git commit -m "initial commit"
$ git push
```
