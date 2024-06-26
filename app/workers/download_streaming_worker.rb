class DownloadStreamingWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'download', retry: 5

  def perform(streaming_id)
    streaming = Streaming.find(streaming_id)

    begin
      streaming.downloading!
      streaming.download_movie
      streaming.completed!
    rescue StreamingPlatform::TwitcastingDownloadStreaming::DownloadError => e
      Rails.logger.error "Failed to download streaming: #{e.message}"
      streaming.error!
    end
  end
end
