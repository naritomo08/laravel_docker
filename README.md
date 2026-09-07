# laravel_docker(postgres版)

## 参考URL

[Elixirをdocker環境で立ち上げてみる。](https://qiita.com/naritomo08/items/fecf4ace7b9ca9078102)

## 事前準備

windows11+wsl2+Ubuntu22+DockerCompose+vscodeでの環境を構築してること。

## 環境構築手順

### 本リポジトリをクローンする

```bash
git clone -b tubuyaki-postgres https://github.com/naritomo08/laravel_docker.git laraveldocker
cd laraveldocker
git clone -b postgres https://github.com/naritomo08/laravel9tubu-public.git backend
```

後にファイル編集などをして、git通知が煩わしいときは
作成したフォルダで以下のコマンドを入れる。

```bash
rm -rf .git
```

### 環境構築用のシェルスクリプトを実行する

```bash
chmod u+x build_env.sh && ./build_env.sh
```

### 各種サイト確認する

## サイトURL

### laravel

http://127.0.0.1:8080

### adminer(DB管理ツール)

http://127.0.0.1:8081

* ログイン情報
  - DB種別: PostgreSQL
  - サーバ: db
  - ユーザ名: phper
  - パスワード: secret
  - データベース: laravel_local

### mailhog(メールサーバ)

http://127.0.0.1:8025

## コンテナ起動する方法

`docker-compose.yml`が存在するフォルダーで以下のコマンドを実行する。

```bash
docker compose build && docker compose up -d
```

## コンテナ停止する方法

`docker-compose.yml`が存在するフォルダーで以下のコマンドを実行する。

```bash
docker-compose stop
```

## コンテナ削除する方法

`docker-compose.yml`が存在するフォルダーで以下のコマンドを実行する。

```bash
docker-compose down
```

## 起動中のコンテナに入る

### PHPコンテナ

```bash
docker-compose exec app /bin/bash
```

### DBコンテナ

```bash
docker-compose exec db /bin/bash
```

Laravelサイトの立ち上げ方はlaravel9tubu-public
のREADMEを参照してください。
