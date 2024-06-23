class Streaming < ApplicationRecord
  belongs_to :streamer

  has_one_attached :movie

  enum status: { pending: 0, downloading: 5, downloaded: 10, error: 20 }

  after_create :notify_to_slack
  after_create :enqueue_download_streaming, if: -> { streamer.download_live_stream }

  def download_movie(url: nil)
    url ||= streamer.url
    DownloadStreaming.new(url).execute do |movie_path|
      movie.attach(io: File.open(movie_path), filename: File.basename(movie_path))
    end
  end

  private

  def notify_to_slack
    # notify to slack

    update!(notified: true)
  end

  def enqueue_download_streaming
    DownloadStreamingWorker.perform_async(id)
  end
end
