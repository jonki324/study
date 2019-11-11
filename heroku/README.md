# Heroku
## インストール
```bash
$ brew install heroku/brew/heroku
```

## ログイン
```bash
$ heroku login
```

## プロジェクトフォルダでruntime.txt作成
pipenvで環境構築している場合不要
```bash
$ git clone https://github.com/jonki324/project.git
$ cd project
$ echo 'python-3.7.4' > runtime.txt
```

## アプリ起動用設定ファイル作成
```bash
$ vi Procfile

# Flask
web: gunicorn run:app --log-file -

# Django
web: gunicorn project.wsgi --log-file -
```

## Herokuアプリを作成
```bash
$ heroku create
Creating app... done, ⬢ still-crag-30537
https://still-crag-30537.herokuapp.com/ | https://git.heroku.com/still-crag-30537.git
```

## デプロイ
```bash
$ git push heroku master
Enumerating objects: 585, done.
Counting objects: 100% (585/585), done.
Delta compression using up to 8 threads
Compressing objects: 100% (506/506), done.
Writing objects: 100% (585/585), 1.82 MiB | 1.07 MiB/s, done.
Total 585 (delta 327), reused 131 (delta 49)
remote: Compressing source files... done.
remote: Building source:
remote: 
remote: -----> Python app detected
remote: -----> Installing python-3.7.5
remote: -----> Installing pip
remote: -----> Installing dependencies with Pipenv 2018.5.18…
remote:        Installing dependencies from Pipfile.lock (156306)…
remote: -----> Installing SQLite3
remote: -----> Discovering process types
remote:        Procfile declares types -> (none)
remote: 
remote: -----> Compressing...
remote:        Done: 68.2M
remote: -----> Launching...
remote:        Released v3
remote:        https://still-crag-30537.herokuapp.com/ deployed to Heroku
remote: 
remote: Verifying deploy... done.
To https://git.heroku.com/still-crag-30537.git
 * [new branch]      master -> master
```

## アプリを起動
```bash
$ heroku ps:scale web=1
$ heroku open
```

## ログの確認
```bash
$ heroku logs --tail
```

## アプリの状態確認
```bash
$ heroku ps
```

## ローカル環境で起動
```bash
$ heroku local web
```

## コンソールの起動
```bash
$ heroku run python
$ heroku run bash
```

## 環境変数の定義
```bash
$ heroku config

$ heroku config:add TZ=Asia/Tokyo
$ heroku config:set FLASK_APP=run.py
$ heroku config:set SECRET_KEY=key
$ heroku config:set WTF_CSRF_SECRET_KEY=key
$ heroku config:set FLASK_ENV=development
```

## データベース
```bash
$ heroku addons

$ heroku addons:create heroku-postgresql:hobby-dev
Creating heroku-postgresql:hobby-dev on ⬢ still-crag-30537... free
Database has been created and is available
 ! This database is empty. If upgrading, you can transfer
 ! data from another database with pg:copy
Created postgresql-graceful-23241 as DATABASE_URL
Use heroku addons:docs heroku-postgresql to view documentation

$ heroku pg

$ heroku pg:psql
```

## データベース時刻修正
```bash
$ heroku pg:psql

# 現在の時刻確認
$ select current_timestamp;

# 時刻の修正(修正後再接続して確認)
$ alter database databasename set timezone = 'Asia/Tokyo';
```

## データベースのバックアップ
```bash
# バックアップ
$ heroku pg:backups capture --app appname

# バックアップURLの取得
$ heroku pg:backups public-url --app appname

# ローカルにバックアップ
$ heroku pg:backups:download --app appname
```

## PyCharm連携
[View] -> [Tool Windows] -> [Database] -> [PostgreSQL]

PostgreSQLの設定
- Host : Herokuのデータストアから確認
- User : Herokuのデータストアから確認
- Password : Herokuのデータストアから確認
- Database : Herokuのデータストアから確認

Advancedの設定
- ssl : true
- sslmode : require
- sslfactory : org.postgresql.ssl.NonValidatingFactory

## アプリURLを変更した場合
```bash
$ git remote set-url heroku https://git.heroku.com/appname.git
```

## Flaskアプリ設定
```bash
$ heroku run bash

flask shell
>>> from application.models import db
>>> db.drop_all()
>>> db.create_all()
```
