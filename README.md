# README

- ライブ配信者をウォッチする WEB アプリケーションです
- 配信開始通知、配信終了通知を受け取ることができます
- ライブ配信のダウンロードを行うことができます

## 使用技術

- Ruby 3.X
- MySQL8.X
- yt-dlp

## 通知機能のセットアップ

- 対象の配信者が配信を開始したら、指定したTweetアカウントからツイートを行うことができます
- https://developer.twitter.com/en/portal/dashboad から API キー、アクセストークンを取得してください
- .env ファイルを作成し、取得した情報を記述してください

```
export TWITTER_API_KEY="XXX"
export TWITTER_API_SECRET="XXX"
export TWITTER_ACCESS_TOKEN="XXX"
export TWITTER_ACCESS_TOKEN_SECRET="XXX"
```
