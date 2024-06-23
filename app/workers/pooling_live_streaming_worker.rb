class PoolingLiveStreamingWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'pooling', retry: 0

  def perform
    Rails.logger.info 'Pooling live streaming'
    Streamer.where('notify = true or download_live_stream = true').find_each(&:notify_and_download_if_streaming)
  end
end
