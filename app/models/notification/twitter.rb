class Notification::Twitter
  POST_TWEET_ENDPOINT = 'https://api.twitter.com/2/tweets'.freeze

  HEADERS = {
    "Content-Type": 'application/json',
    "User-Agent": 'My-Tweet-Bot'
  }.freeze

  def self.send(text)
    client = HTTP.auth(auth_header('POST', POST_TWEET_ENDPOINT, {
                                     consumer_key: ENV.fetch('TWITTER_API_KEY', nil),
                                     consumer_secret: ENV.fetch('TWITTER_API_SECRET', nil),
                                     token: ENV.fetch('TWITTER_ACCESS_TOKEN', nil),
                                     token_secret: ENV.fetch('TWITTER_ACCESS_TOKEN_SECRET', nil)
                                   }))
    client.post(POST_TWEET_ENDPOINT, headers: HEADERS, json: { text: })
  end

  # OAuth1.0aで Authentication ヘッダのシグネチャを生成します。これにSimpleOAuthを利用
  def self.auth_header(method, url, auth_params)
    SimpleOAuth::Header.new(method, url, {}, auth_params).to_s
  end
end
