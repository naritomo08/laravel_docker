## 参考URL

[Elixirをdocker環境で立ち上げてみる。](https://qiita.com/naritomo08/items/fecf4ace7b9ca9078102)


## 事前準備

windows11+wsl2+Ubuntu22+DockerCompose+vscodeでの環境を構築してること。

## 環境構築手順

### 本リポジトリをクローンする。

```bash
$ git clone https://github.com/naritomo08/laravel_docker.git laraveldocker
$ cd laraveldocker
laravel6の場合
$ git clone https://github.com/naritomo08/laravelapp2.git backend
$ cd backend
laravel8の場合
$ git clone https://github.com/naritomo08/laravelapp.git backend
$ cd backend
```

### 環境構築用のシェルスクリプトを実行する。

```bash
$ chmod u+x build_env.sh && ./build_env.sh
```

### ファイルパーミッションを更新する。

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
$ docker-compose stop
```

## コンテナ削除する方法

`docker-compose.yml`が存在するフォルダーで以下のコマンドを実行する。

```bash
$ docker-compose down
```

## 起動中のコンテナに入る

### PHPコンテナ

```bash
$ docker exec -ti laravel_php bash
```

### DBコンテナ

```bash
$ docker exec -ti laravel_db bash
```

## サイトURL

### laravel

http://127.0.0.1:8080

### adminer(DB管理ツール)

http://127.0.0.1:8081


* ログイン情報
  - サーバ: db
  - ユーザ名: laravel
  - パスワード: password
  - データベース: laravel

### mailhog(メールサーバ)

http://127.0.0.1:8025

## その他

### 開発中に以下のコマンドを実行する

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
又は
$ chmod -R a+x node_modules
```
