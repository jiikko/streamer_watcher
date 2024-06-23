class PoolingLiveStreaming
  include Sidekiq::Worker

  sidekiq_options queue: 'pooling', retry: false

  def perform
    Streamer.where('notify = true or download_live_stream = true').find_each(&:notify_and_download_if_streaming)
  end
end
