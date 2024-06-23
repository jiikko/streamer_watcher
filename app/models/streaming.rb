class Streaming < ApplicationRecord
  belongs_to :streamer

  has_one_attached :movie

  after_create :notify_to_slack, :enqueue_download_streaming

  def download_movie
    DownloadStreaming.new(streamer.url).execute do |movie_path|
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
