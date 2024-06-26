class PoolingLiveStreamingWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'pooling', retry: 0

  def perform
    Streamer
      .eager_load(:streaming_platform)
      .where('streamers.notify = true or streamers.download_live_stream = true')
      .find_each(&:action_if_streaming)
  end
end
