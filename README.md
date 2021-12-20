# No Camp No Life

## サイト概要

キャンプ専用 SNS
自分のキャンプの記録をほかのユーザーに公開することで、どんなスタイルでキャンプをしているのか、どんなキャンプ道具を使っているのか、などをユーザー同士で共有することができます。キャンプをもっと楽しんでもらう一助となれば幸いです。

### サイトテーマ

自分のキャンプ用ブログとして、また、自分のキャンプをほかのユーザーに共有することでよりキャンプを楽しんでもらうための交流の場

### テーマを選んだ理由

キャンプをしているとき、その様子や風景の写真をよく撮ります。せっかく撮った写真ですから、自分のキャンプ用ブログに投稿し、行ったキャンプの記録を残したいという思いから、キャンプ専用 SNS の制作に着手しました。

### ターゲットユーザ

キャンプが好きな人、キャンプに興味がある人、キャンプの記録を残したい人
キャンプで撮った写真や使っているキャンプギアなどを紹介・共有したい人

### 主な利用シーン

キャンプ中もしくはキャンプ後
時間があるとき

## 設計書

・[WBS](https://docs.google.com/spreadsheets/d/1VPZKwoelJ6GSsDgHiKasNYXB_mfANHe3QI6CQPriuiY/edit?usp=sharing)

・[UI flows](https://drive.google.com/file/d/1qQozuvA3fvDWsKrJvTJU7UYWbh6AMpf2/view?usp=sharing)

・[ワイヤーフレーム](https://drive.google.com/file/d/12yU_rqsCUPYscLcho9XS0OhT-Zo5guvl/view?usp=sharing)

・[テーブル定義書](https://docs.google.com/spreadsheets/d/1DUOGGpEBQOsvO2HWHn_v371QVekmIizVTrxG4Qts2oU/edit?usp=sharing)

・[アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/1GnXyfU5WRA2kwH7QssCs73HUM0oR-l6e/edit?usp=sharing&ouid=110991163930681200475&rtpof=true&sd=true)


## チャレンジ要素一覧

#### 主な機能
- フォロー・フォロワー機能（非同期通信）
- ユーザー認証（devise使用）
- いいね機能（非同期通信）
- 画像アップロード機能（CarrierWave使用）
- コメント機能（非同期通信）
- 投稿一覧（画像スライダー）
- 環境変数化（dotenv-rails）
- 外部ストレージ導入（AWS S3使用）

機能の詳細は[こちらから](https://docs.google.com/spreadsheets/d/1OdkkPlLWHUi1p8kAkUI4DhZgdOBXfez5NWGoNEY0fGo/edit?usp=sharing)

## 開発環境

- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JS ライブラリ：jQuery
- IDE：Cloud9
- 外部ストレージ：AWS S3