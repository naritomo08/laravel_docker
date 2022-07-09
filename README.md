## 事前準備

自分の端末の公開鍵をgithubの個人設定に登録してあること。

## 環境構築手順

1. 本レポジトリをクロンする。

```bash
$ git clone git@github.com:naritomo08/laravel_docker.git laraveldocker
$ cd laraveldocker
$ git clone git@github.com:naritomo08/laravelapp.git backend
```

2. 環境構築用のシェルスクリプトを実行する。

```bash
$ chmod u+x build_env.sh && ./build_env.sh
```

3. ファイルパーミッションを更新する。

```bash
$ chmod u+x set_permission.sh &&  ./set_permission.sh
```

## コンテナ起動する方法

`docker-compose.yml`が存在するフォルダーで以下のコマンドを実行する。

```bash
$ docker-compose up -d
```

## コンテナ停止する方法

`docker-compose.yml`が存在するフォルダーで以下のコマンドを実行する。

```bash
$ docker-compose down
```


## 起動中のコンテナに入る

1. PHPコンテナ

```bash
$ docker exec -ti laravel_php bash
```

2. DBコンテナ

```bash
$ docker exec -ti laravel_db bash
```

## サイトURL

1. laravel

```
http://127.0.0.1:8080
```

2. adminer

```
http://127.0.0.1:8081
```

* ログイン情報
  - サーバ: db
  - ユーザ名: laravel
  - パスワード: password
  - データベース: laravel

3. mailhog

```
http://127.0.0.1:8025
```

## その他

開発中に以下のコマンドを実行する

```bash
$ docker exec -ti laravel_php bash
$ cd project && npm run watch
```

### npm run watchコマンドとは

npm run watchコマンドはターミナルで実行し続け、関連ファイル全部の変更を監視します。
Webpackは変更を感知すると、アセットを自動的に再コンパイルします。

### cross-env: Permission deniedが発生した場合

以下のコマンドを実行する

```bash
$ npm rebuild
```

### node.jsのアップデートが必要な場合

以下のコマンドを実行する

```bash
$ sudo npm install -g n
$ sudo n latest
PHPコンテナに入りなおし、以下のコマンドでバージョンを確認。
$ node -v
```
