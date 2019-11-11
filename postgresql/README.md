# PostgreSQL
## インストール
```bash
$ brew install postgresql
```

## バージョン確認
```bash
$ postgres --version
postgres (PostgreSQL) 11.5

$ psql --version
psql (PostgreSQL) 11.5
```

## 初回起動
設定ファイルの場所を環境変数に設定していないと警告が表示される
```bash
$ postgres
postgres does not know where to find the server configuration file.
You must specify the --config-file or -D invocation option or set the PGDATA environment variable.
```

## 環境変数の設定
```bash
$ export PGDATA=/usr/local/var/postgres
```
```bash
$ vi ~/.bash_profile

export PGDATA=/usr/local/var/postgres
```

## UTF-8で初期化
```bash
# デフォルトの設定を削除する
$ rm -rf /usr/local/var/postgres/*

$ initdb /usr/local/var/postgres -E utf8
```

## 設定
```bash
$ vi /usr/local/var/postgres/postgresql.conf

listen_addresses = 'localhost'
```

## 起動
```bash
$ postgres
2019-10-29 16:02:10.811 JST [82225] LOG:  listening on IPv6 address "::1", port 5432
2019-10-29 16:02:10.812 JST [82225] LOG:  listening on IPv4 address "127.0.0.1", port 5432
2019-10-29 16:02:10.812 JST [82225] LOG:  listening on Unix socket "/tmp/.s.PGSQL.5432"
2019-10-29 16:02:10.822 JST [82226] LOG:  database system was shut down at 2019-10-29 15:44:06 JST
2019-10-29 16:02:10.827 JST [82225] LOG:  database system is ready to accept connections
```

## 接続
```bash
$ psql -d postgres
psql (11.5)
Type "help" for help.

postgres=# 
```

## DB一覧
```bash
$ psql -l
                              List of databases
   Name    | Owner | Encoding |   Collate   |    Ctype    | Access privileges 
-----------+-------+----------+-------------+-------------+-------------------
 postgres  | user | UTF8     | ja_JP.UTF-8 | ja_JP.UTF-8 | 
 template0 | user | UTF8     | ja_JP.UTF-8 | ja_JP.UTF-8 | =c/user         +
           |       |          |             |             | user=CTc/user
 template1 | user | UTF8     | ja_JP.UTF-8 | ja_JP.UTF-8 | =c/user         +
           |       |          |             |             | user=CTc/user
(3 rows)
```

## ユーザー作成
```bash
$ createuser -P dbuser
Enter password for new role: 
Enter it again:
```

## データベース作成
```
$ createdb -E utf8 -O dbuser sample_db
```

## テーブル一覧
```
$ psql -U dbuser sample_db
sample_db=> \d
```

## データベースのバックアップ
```bash
$ pg_dump database_name > backup_file_name
```

## データベースのリストア
```bash
$ psql database_name < backup_file_name
```
