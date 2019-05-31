# Linuxコマンドまとめ
## ディレクトリ操作
### pwd
現在のディレクトリを表示
```
$ pwd
/home/vagrant
```

### cd
ディレクトリ移動
- 絶対パス指定 : /home/vagrant
- 相対パス指定 : ../
- ホームディレクトリ : ~
```
$ pwd
/home/vagrant

$ cd /home
$ pwd
/home

$ cd ~
$ pwd
/home/vagrant

$ cd ..
$ pwd
/home
```

### ls
ファイル一覧表示
- -l : リスト表示
- -a : 隠しファイルも表示
```
$ ls
ubuntu  vagrant

$ ls -l
total 8
drwxr-xr-x 3 ubuntu  ubuntu  4096 May 28 04:58 ubuntu
drwxr-xr-x 5 vagrant vagrant 4096 May 28 05:08 vagrant

$ ls -la
total 16
drwxr-xr-x  4 root    root    4096 May 28 04:58 .
drwxr-xr-x 24 root    root    4096 May 28 04:59 ..
drwxr-xr-x  3 ubuntu  ubuntu  4096 May 28 04:58 ubuntu
drwxr-xr-x  5 vagrant vagrant 4096 May 28 05:08 vagrant
```

### mkdir
ディレクトリ作成
- -p : 存在しないディレクトリも含めて作成
```
$ mkdir testdir
$ ls
testdir

$ mkdir -p dir1/dir2
$ cd dir1/dir2/
$ pwd
/home/vagrant/dir1/dir2
```

### rmdir
空ディレクトリ削除
```
$ rmdir testdir
$ ls
dir1
```

### rm
ファイルを削除
- -r : 再帰的に削除
- -f : 強制的に削除
```
$ rm -rf dir1
```

### mv
ファイルを移動する
- -f : 強制的に移動
```
$ ls
dir1

$ mv dir1 dir2

$ ls
dir2
```

### cp
ファイルをコピー
- -a : 元ファイルの構成と属性を保ったままコピー(-dpRと同じ)
- -d : シンボリックリンクをコピーするときリンクされているファイルではなく自身をコピーする
- -f : 強制的にコピー
- -p : 所有者、グループ、パーミッション、タイムスタンプを保持する
- -r : ディレクトリを再帰的にコピーする(ディレクトリ以外のファイルはすべてファイルとしてコピー)
- -R : ディレクトリを再帰的にコピー
- -u : タイムスタンプが同じか新しい場合はコピーしない
```
$ ls
dir1

$ cp -a dir1 dir2

$ ls 
dir1  dir2
```

### find
ファイルを検索
- -name : ファイル名を指定
```
$ find -name 'dir*'
./dir2
./dir1
```

### ln
リンクを作成
- -s : シンボリックリンクを作成
```
$ ls -l
total 8
drwxrwxr-x 2 vagrant vagrant 4096 May 30 09:37 dir1
drwxrwxr-x 2 vagrant vagrant 4096 May 30 09:37 dir2

$ ln -s dir1 dir3

$ ls -l
total 8
drwxrwxr-x 2 vagrant vagrant 4096 May 30 09:37 dir1
drwxrwxr-x 2 vagrant vagrant 4096 May 30 09:37 dir2
lrwxrwxrwx 1 vagrant vagrant    4 May 30 10:06 dir3 -> dir1
```

### unlink
リンクを削除
```
$ ls -l
total 8
drwxrwxr-x 2 vagrant vagrant 4096 May 30 09:37 dir1
drwxrwxr-x 2 vagrant vagrant 4096 May 30 09:37 dir2
lrwxrwxrwx 1 vagrant vagrant    4 May 30 10:06 dir3 -> dir1

$ unlink dir3

$ ls -l
total 8
drwxrwxr-x 2 vagrant vagrant 4096 May 30 09:37 dir1
drwxrwxr-x 2 vagrant vagrant 4096 May 30 09:37 dir2
```


## ファイル操作
### touch
ファイルのタイムスタンプを変更  
存在しないファイル名を指定することで、内容の入っていないファイルを新規作成
```
$ ls

$ touch file.txt

$ ls
file.txt
```

### cat
ファイルの内容を出力
- -n : 行番号を表示
```
$ echo 'hello' >> file.txt 

$ cat file.txt 
hello

$ cat -n file.txt
     1  hello
```

### grep
パターンに一致する行を表示
- -e : パターンを指定
- -i : 大文字と小文字を区別しない
- -1 : 一致した行と前後の行も表示
- -n : 行数を表示
```
$ cat -n file.txt 
     1  hello
     2  world
     3  hoge
     4  fuga
     5  foo
     6  bar

$ grep -n -1 'hoge' file.txt 
2-world
3:hoge
4-fuga
```

### head
ファイルの先頭を表示
- -n : 表示行数指定
```
$ head -n 3 file.txt 
hello
world
hoge
```

### tail
ファイいるの末尾を表示
- -n : 表示行数指定
- -f : 読み込み続ける
```
$ tail -n 2 file.txt 
foo
bar
```

### more
長いテキスト１画面ずつ表示
```
$ more file.txt
```

### less
長いテキスト１画面ずつ表示
```
$ less file.txt
```

### diff
テキストファイルの違いを出力
- -i : 大文字と小文字の違いを無視
- -r : ディレクトリを再帰的に比較
```
$ diff file.txt file2.txt 
2c2
< world
---
> World
4c4
< fuga
---
> fugafuga
6a7,8
> 
> test
```

### wc
文字数をカウント
```
$ wc file.txt file2.txt 
 6  6 30 file.txt
 8  7 40 file2.txt
14 13 70 total
```

### tar
ファイルの圧縮解凍
- -c : アーカイブを作成
- -f : アーカイブファイル名を指定
- -v : 処理したファイルを表示
- -z : gzipで圧縮
- -x : アーカイブからファイルを抽出する
```
$ tar -cvzf dir1.tar.gz dir1
dir1/
dir1/file.txt
dir1/file2.txt

$ ls
dir1  dir1.tar.gz

$ tar -xvzf dir1.tar.gz 
dir1/
dir1/file.txt
dir1/file2.txt

$ ls
dir1  dir1.tar.gz
$ ls dir1
file.txt  file2.txt
```

## ユーザー操作
### useradd
ユーザーを追加
- -d : ホームディレクトを指定
- -G : グループに登録
- -s : シェルを作成
```
$ sudo useradd -d /home/user1 -s /bin/bash user1
```

### usermod
ユーザー情報を変更
- -d : ホームディレクトを指定
- -G : グループに登録
- -s : シェルを作成
- -l : ユーザー名を変更
```
$ sudo usermod -d /home/user1 -s /bin/bash -l user11 user1
```

### userdel
ユーザーを削除
- -r : ホームディレクトリも削除
```
$ sudo userdel -r user1
```

### groupadd
グループを追加
```
$ sudo groupadd grp1
```

### groupmod
グループ情報を変更
- -n : グループ名を変更
```
$ sudo groupmod -n grp2 grp1
```

### groupdel
グループを削除
```
$ sudo groupdel grp2
```

### su
ユーザを切り替える
- \- : ログイン・シェルを使用してユーザーを切り替える
```
$ su -
```

### chmod
ファイルのアクセス権変更
- 読み(r) 書き(w) 実行(x)
- 読み(4) 書き(2) 実行(1)
- 所有者(u) グループ(g) その他(o)
- 追加(+) 削除(-) 設定(=)
- -R : ディレクトリを再帰的に変更
```
$ chmod u+x file.txt
$ chmod 777 file.txt
```

### chown
ファイルの所有者を変更
- -R : ディレクトリを再帰的に変更
```
$ sudo chown ubuntu:ubuntu file.txt
```

## その他
### echo
メッセージなどを出力
```
$ echo 'hello'
hello
```

### export
環境変数の設定
```
$ export HELLO=world
$ echo $HELLO
world
```

### ;, &, &&, ||
コマンドの連続実行
- ; : 前のコマンドが終わり次第、次のコマンド実行
- & : 前のコマンドの終了を待たずに、次のコマンドを実行
- && : 前のコマンドが正常終了後、次のコマンド実行
- || : 前のコマンドが失敗したら、次のコマンド実行
```
$ echo 'hello';echo 'world'
hello
world

$ echo 'hello'&echo 'world'
[1] 2246
world
hello

$ echo 'hello' && echo 'world'
hello
world

$ cat file4.txt || echo 'hello'
cat: file4.txt: No such file or directory
hello
```

### >, <, >>
リダイレクト
- \> : 出力のリダイレクト
- \< : 入力のリダイレクト
- \>> : ファイルに追記
```
$ ls
file.txt  file2.txt
$ ls > list.txt
$ cat list.txt 
file.txt
file2.txt
list.txt

$ grep fuga < file.txt 
fuga

$ cat list.txt 
file.txt
file2.txt
list.txt

$ cat file.txt >> list.txt 

$ cat list.txt 
file.txt
file2.txt
list.txt
hello
world
hoge
fuga
foo
bar

$ grep 'hoge' < file.txt > result.txt
$ cat result.txt 
hoge
```

### whoami
現在のユーザーを表示
```
$ whoami
vagrant
```

### hostname
ホスト名を表示
```
$ hostname
ubuntu-bionic
```

### date
現在日時を表示
```
$ date
Fri May 31 08:30:05 UTC 2019
```
