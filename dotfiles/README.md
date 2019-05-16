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

## Mac設定環境調査
```
$ vi ~/dotfiles/setting_search.sh
```
```
#!/bin/sh

if [ "$1" = 1 ]
then
# write read-list
defaults read > global-list-new.txt
defaults -currentHost read > currentHost-list-new.txt

# check diff
echo 'currentHost'
diff currentHost-list.txt currentHost-list-new.txt
echo 'global'
diff global-list.txt global-list-new.txt

else
# write read-list
defaults read > global-list.txt
defaults -currentHost read > currentHost-list.txt
fi
```

- ファイルを保存したディレクトリへ移動
```
$ cd ~/dotfiles
```

- 設定値書き出し
```
$ chmod +x setting_search.sh
$ ./setting_search.sh
```

- 確認したい設定をGUIで変更

- 設定値書き出し＆差分確認
```
$ ./setting_search.sh 1
```

- テンプファイル削除
```
$ rm global-list.txt
$ rm global-list-new.txt
$ rm currentHost-list.txt
$ rm currentHost-list-new.txt
```

## Mac環境設定スクリプト作成
```
$ vi ~/dotfiles/setup_mac.sh
```
```
#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
  echo 'Not macOS!'
  exit 1
fi

echo 'Setup MacOS'

# 全ての拡張子のファイルを表示する
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# USB やネットワークストレージに .DS_Store ファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Finder のタイトルバーにフルパスを表示する
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# 検索時にデフォルトでカレントディレクトリを検索する
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# パスバーを表示する
defaults write com.apple.finder ShowPathbar -bool true

# ステータスバーを表示する
defaults write com.apple.finder ShowStatusBar -bool true

# タブバーを表示する
defaults write com.apple.finder ShowTabView -bool true

echo 'Finished'
```

## Mac環境設定スクリプト実行
```
$ chmod +x ~/dotfiles/setup_mac.sh
$ ./setup_mac.sh
```

## Mac設定一覧
### Finder環境設定
- 新規Finderで次を表示
- サイドバーに表示する項目
- すべてのファイル名拡張子を表示
- 現在のフォルダ内を検索
- 表示→タブバーを表示
- 表示→パスバーを表示
- 表示→ステータスバーを表示
### Dock
- Dockを自動的に隠す/表示
### セキュリティとプライバシー
- ファイアウォール入
- 一般→詳細→apple remote 無効
### 省エネルギー
- ディスプレイをオフにするまでの時間
### キーボード
- F1、F2を標準のファンクションキーとして使用
- ユーザー辞書→英字入力中にスペルを自動変換
- ユーザー辞書→文頭を自動的に大文字にする
- ショートカット→サービス→フォルダに新規ターミナル
- ショートカット→サービス→フォルダに新規ターミナルタブ
- ショートカット→ペーストしてスタイルを合わせる　⌘V 
- ショートカット→ペーストしてスタイルを保持　⇧⌘V
- 入力ソース→ライブ変換
- 入力ソース→タイプミスを修正
- 入力ソース→Windows風のキー操作
- 入力ソース→’¥’キーで入力する文字
### マウス
- スクロールの方向
- 副ボタンクリック
- スマートズーム
- 軌跡の速さ
- ページ間をスワイプ
### Bluetooth
- メニューバーにBluetoothを表示する
### 拡張機能
- 今日
### 共有
- コンピュータ名
### 日付と時刻
- 日付を表示
