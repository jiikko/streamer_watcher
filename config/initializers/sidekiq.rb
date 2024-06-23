redis_config = { url: 'redis://localhost:6380/0' }

Sidekiq.configure_server do |config|
  config.logger.level = Rails.logger.level
  config.on(:startup) do
    Rails.logger = Sidekiq.logger
  end

  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

Sidekiq.strict_args!
