class Streaming < ApplicationRecord
  belongs_to :streamer

  has_one_attached :movie

  enum status: { pending: 0, downloading: 5, downloaded: 10, error: 20 }

  after_create :notify
  after_commit :enqueue_download_streaming, on: :create, if: -> { streamer.download_live_stream }

  def download_movie(url: nil)
    url ||= streamer.url
    DownloadStreaming.new(url).execute do |movie_path|
      movie.attach(io: File.open(movie_path), filename: File.basename(movie_path))
    end
  end

  private

  def notify
    return unless streamer.notify

    Notification::Twitter.send(notification_message)
    update!(notified: true)
  end

  def enqueue_download_streaming
    DownloadStreamingWorker.perform_async(id)
  end

  def notification_message
    <<~TEXT.chomp
      #{streamer.talent.name}の配信が#{streamer.streaming_platform.name}で開始されました!
      #{streamer.url}
    TEXT
  end
end
