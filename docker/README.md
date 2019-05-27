# Dockerまとめ
## インストール
```
$ brew install cask docker
$ docker -v
Docker version 18.06.0-ce, build 0ffa825
```

## イメージ操作
### イメージ一覧
```
$ docker image ls
REPOSITORY              TAG                    IMAGE ID            CREATED             SIZE
php                     7.3.5-apache-stretch   59d2cf691156        2 weeks ago         378MB
```

### イメージ取得
```
$ docker image pull php:7.3.5-apache-stretch
```

### イメージ削除
```
$ docker image rm 59d2c
```

## コンテナ操作
### コンテナ一覧
```
# 起動中のコンテナ
$ docker container ls

# 全てのコンテナ
$ docker container ls -a
```

### コンテナ作成
```
$ docker container create --name php73 59d2cf691156
```

### コンテナ情報
```
$ docker container inspect php73
```

### コンテナ削除
```
$ docker container rm php73
```

### コンテナ起動
```
$ docker container start php73
```

### コンテナ停止
```
$ docker container stop php73
```

### コンテナ再起動
```
$ docker container restart php73
```

### コンテナ作成・起動
- -d : バックグランド実行
- --rm : コンテナ停止のときコンテナを削除
- --name : コンテナ名を付ける
- -p : コンテナのポートをホストに公開
- -v : コンテナとホストの共有ボリュームを設定
```
$ docker container run -d --rm --name php73con -p 8080:80 -v $PWD/vol:/var/www/html php:php73
```

### コンテナ内のシェル起動
```
$ docker container exec -it php73 /bin/bash
```

### コンテナからイメージ作成
```
$ docker container commit php73 php:php73
```

## Dockerfile
### Dockerfile例
```
$ vi Dockerfile
```
```
FROM php:7.3.5-apache-stretch

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

ENV DOCUMENT_ROOT /var/www/html

COPY "./index.php" "$DOCUMENT_ROOT/index.php"

ADD "./phpinfo.php" "$DOCUMENT_ROOT/phpinfo.php"

EXPOSE 80

WORKDIR "$DOCUMENT_ROOT"

CMD ["apache2-foreground"]
```
#### FROM
元となるイメージを指定する
#### RUN
コマンドを実行しミドルウェアのインストール等を行う
#### ENV
環境変数の設定
#### COPY
ホストのファイルをコンテナへコピーする
#### ADD
COPYとの違いは圧縮ファイルを解凍すること
#### EXPOSE
ホストへ公開するポートを指定
#### WORKDIR
作業フォルダへ移動
#### CMD
実行するコマンド

### Dockerfileからイメージ作成
```
$ docker build -t php73name:php73tag .
```
### コンテナ作成・起動
```
$ docker container run -d --rm --name php73con -p 8080:80 php73name:php73tag
```

## Docker Compose
### docker-compose.yml
```
version: '3'
services:
  web:
    build: ./web
    ports:
      - "8080:80"
    volumes:
      - ./src:/var/www/html
    depends_on:
      - db
    links:
      - db
  db:
    image: mysql:5.6
    environment:
      MYSQL_ROOT_PASSWORD: pass
    ports:
      - "3306:3306"
    volumes:
      - ./vol:/var/lib/mysql
```
#### version
Docker Engineが対応するdocker-compose.ymlのフォーマットのバージョン
#### services
webとdbコンテナを作成
#### build
イメージをDockerfileからビルド
#### image
作成済みイメージを指定
#### environment
環境変数の設定
#### ports
ホストに公開するコンテナのポート
#### volumes
コンテナとホストの共有ボリュームを設定
#### depends_on
コンテナの依存関係を設定(webが起動する前にdbを起動する)
#### links
コンテナ間通信を設定

### docker-compose.ymlからイメージ作成
```
$ docker-compose build
```

### コンテナ作成・起動
- -d : バックグランドで実行
```
$ docker-compose up -d
```

### コンテナ停止・削除
```
$ docker-compose down
```

### コンテナ内のシェル起動
```
$ docker-compose exec web /bin/bash
```

## Docker Hub
### ログイン
```
$ docker login
```

### タグ付け
```
$ docker tag docker_web jonki324/web_db:php73_mysql56
```

### イメージ登録
```
$ docker push jonki324/web_db:php73_mysql56
```
