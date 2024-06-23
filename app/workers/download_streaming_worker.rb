class DownloadStreamingWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'download', retry: 5

  def perform(streaming_id)
    streaming = Streaming.find(streaming_id)

    begin
      streaming.download_movie
    rescue DownloadStreaming::DownloadError => e
      Rails.logger.error "Failed to download streaming: #{e.message}"
    end
  end
end
