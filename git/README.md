# Gitまとめ
## インストール
```
$ brew install git
$ git --version
git version 2.18.0
```

## 設定
設定は下記の順で上書きされる
- system : /etc/gitconfig
- global : ~/.gitconfig
- local : repository/.git/config
```
$ git config --global user.name jonki324
$ git config --global user.email jonki324@gmail.com
```

## 設定の確認
```
$ git config --global --list
user.name=jonki324
user.email=jonki324@gmail.com
```

## ローカルリポジトリ作成
```
$ mkdir project.git
$ cd project.git
$ git init
Initialized empty Git repository in /local/project.git/.git/
```

## Gitで管理することをやめる
```
$ rm -rf .git
```

## コミットの流れ
1. ファイル作成
1. ステージング
1. ローカルリポジトリにコミット
1. リモートリポジトリにプッシュ

## ステージング
```
# 変更内容をステージング
$ git add .

# 個別ファイルのステージング
$ git add newfile.txt
```

## ステージングの取り消し
```
$ git rm --cached *
$ git rm --cached newfile.txt
```

## ステージングの状況確認
### git add 前の状況確認
```
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        newfile.txt

nothing added to commit but untracked files present (use "git add" to track)
```
### git add 後の状況確認
```
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   newfile.txt
```

## コミット
```
$ git commit -m 'message'
[master (root-commit) 2bf7d96] message
 1 file changed, 2 insertions(+)
 create mode 100644 newfile.txt
```

## コミット確認
```
$ git log
commit 2bf7d96e65ade312c56e9335ba62b2a97351ec15 (HEAD -> master)
Author: jonki324 <jonki324@gmail.com>
Date:   Thu May 16 22:03:30 2019 +0900

    message
```

## 直前のコミットメッセージを修正(Vimで修正)
```
$ git commit --amend
```

## コミットの取り消し
```
# 変更内容は残す
$ git reset --soft HEAD^

# 変更内容も取り消す
$ git reset --hard HEAD^
```

## 差分の確認
```
$ git diff
diff --git a/newfile.txt b/newfile.txt
index 9a80a22..97531f3 100644
--- a/newfile.txt
+++ b/newfile.txt
@@ -1,2 +1,2 @@
 hello
-
+hello2
```

## ブランチ作成
```
$ git branch dev
```

## ブランチ確認
```
$ git branch
  dev
* master
```

## ブランチ移動
```
$ git checkout dev
M       newfile.txt
Switched to branch 'dev'
```

## ブランチ差分
```
$ git diff master dev
diff --git a/newfile.txt b/newfile.txt
index 9a80a22..b030cc9 100644
--- a/newfile.txt
+++ b/newfile.txt
@@ -1,2 +1,4 @@
 hello
+hello2
+branch test
```

## ブランチマージ
```
$ git merge dev
Updating d446a3d..eb868e3
Fast-forward
 newfile.txt | 2 ++
 1 file changed, 2 insertions(+)
```

## ブランチ削除
```
$ git branch -D dev
Deleted branch dev (was eb868e3).
```

## リモートリポジトリ作成
```
$ git init --bare --shared
Initialized empty shared Git repository in /remote/project.git/
```

## ローカルリポジトリをリモートリポジトリへ追加
ローカルリポジトリで操作  
※リモートリポジトリがローカルPCに存在する場合
```
$ git remote add origin file:///remote/project.git
```

## リモートリポジトリ確認
```
$ git remote -v
origin  file:///remote/project.git (fetch)
origin  file:///remote/project.git (push)
```

## リモートリポジトリ変更
```
$ git remote set-url origin file:///remote/project.git
```

## リモート削除
```
$ git remote remove origin
```

## リモートリポジトリをクローン
```
$ git clone file:///remote/project.git
Cloning into 'project'...
remote: Enumerating objects: 9, done.
remote: Counting objects: 100% (9/9), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 9 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (9/9), done.

$ git clone ssh://user@remote.server:22/home/user/project.git

$ git clone https://remote.server/project.git
```

## リモートリポジトリへプッシュ
```
$ git push origin master
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 8 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (9/9), 676 bytes | 338.00 KiB/s, done.
Total 9 (delta 0), reused 0 (delta 0)
To file:///remote/project.git
 * [new branch]      master -> master
```

## プッシュしたコミットを打ち消す
```
# Vimでコメントを修正して保存
$ git revert HEAD

$ git push origin master
```

## プル
```
$ git pull origin master
From file:///remote/project
 * branch            master     -> FETCH_HEAD
Already up to date.
```

## プルの取り消し
```
$ git reset --hard HEAD^
```

## スタッシュ
```
$ git stash save 'stash1'
Saved working directory and index state On master: stash1
```

## スタッシュ一覧
```
$ git stash list
stash@{0}: On master: stash1
```

## スタッシュの内容確認
```
$ git stash show stash@{0} -p
diff --git a/newfile.txt b/newfile.txt
index c100072..424eeea 100644
--- a/newfile.txt
+++ b/newfile.txt
@@ -1,3 +1,3 @@
 hello
 world
-
+stash
```

## スタッシュを戻す
```
# スタッシュに内容を残す
$ git stash apply stash@{0}
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   newfile.txt

no changes added to commit (use "git add" and/or "git commit -a")

# スタッシュから内容を削除する
$ git stash pop stash@{0}
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   newfile.txt

no changes added to commit (use "git add" and/or "git commit -a")
Dropped stash@{0} (35fd995714ec262605d92506831f16afac3d1f32)
```

## スタッシュを消す
```
$ git stash drop stash@{0}
Dropped stash@{0} (f68f0ddfe6096ffd74f454e498e77d612a0bd8c5)

# 全クリア
$ git stash clear
```

## タグ
```
$ git tag -a ver1.0 -m 'version 1.0'
$ git push origin master
```

## タグ一覧
```
$ git tag
```

## タグ削除
```
$ git tag -d ver1.0
```

## .gitignore
```
$ vi .gitignore
```
```
.DS_Store
*.log
```
