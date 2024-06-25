# README

- ライブ配信者をウォッチする WEB アプリケーションです
- 配信開始通知、配信終了通知を受け取ることができます
- ライブ配信のダウンロードを行うことができます

## 使用しているソフトウェア

- Ruby 3.X
- MySQL8.X
- redis
- yt-dlp
- MacOS での動作を確認しています

## できること

- 毎分対象ストリーミングプラットフォームに対して API を叩き、配信者の情報を取得します
- ライブ配信中であれば、配信のダウンロードと通知を行います

## セットアップ

### ソフトウェア

- brew install mysql@8 yt-dlp redis

### 通知機能

- 対象の配信者が配信を開始したら、指定した Tweet アカウントからツイートを行うことができます
- https://developer.twitter.com/en/portal/dashboad から API キー、アクセストークンを取得してください
- .env ファイルを作成し、取得した情報を記述してください

```
export TWITTER_API_KEY="XXX"
export TWITTER_API_SECRET="XXX"
export TWITTER_ACCESS_TOKEN="XXX"
export TWITTER_ACCESS_TOKEN_SECRET="XXX"
```

## 使い方

- `bin/s` でサーバーを起動します
- http://localhost:5001 にアクセスします
- ウォッチしたい配信者の ID を入力し、登録します
- ウォッチしたい配信者が配信を開始すると、ダウンロードと通知が行われます
- ウォッチしたい配信者が配信を終了すると、ダウンロードが終了します

## TODO

- youtube へのアップロード機能
