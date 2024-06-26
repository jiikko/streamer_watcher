class Notification::Twitter
  POST_TWEET_ENDPOINT = 'https://api.twitter.com/2/tweets'.freeze

  HEADERS = {
    "Content-Type": 'application/json',
    "User-Agent": 'My-Tweet-Bot'
  }.freeze

  def self.send(text)
    unless has_access_token?
      Rails.logger.error('Twitter access token is not set')
      return
    end

    client = HTTP.auth(auth_header('POST', POST_TWEET_ENDPOINT, params))
    client.post(POST_TWEET_ENDPOINT, headers: HEADERS, json: { text: })
  rescue StandardError => e
    Rails.logger.error(e)
  end

  def self.has_access_token?
    params.compact.keys == %i[consumer_key consumer_secret token token_secret]
  end

  # OAuth1.0aで Authentication ヘッダのシグネチャを生成します。これにSimpleOAuthを利用
  def self.auth_header(method, url, auth_params)
    SimpleOAuth::Header.new(method, url, {}, auth_params).to_s
  end

  def self.params
    {
      consumer_key: Rails.application.config.x.twitter_api_key,
      consumer_secret: Rails.application.config.x.twitter_api_secret,
      token: Rails.application.config.x.twitter_access_token,
      token_secret: Rails.application.config.x.twitter_access_token_secret
    }
  end
end
