class Streaming < ApplicationRecord
  belongs_to :streamer

  has_one_attached :movie

  enum status: { pending: 0, downloading: 5, completed: 10, error: 20 }

  def download_movie(url: nil)
    url ||= streamer.url
    streamer.streaming_platform.download_movie(url) do |movie_path|
      movie.attach(io: File.open(movie_path), filename: File.basename(movie_path))
    end
  end

  def action_after_create
    enqueue_download_streaming_if_needed
    notify_if_needed
  end

  private

  def notify_if_needed
    return unless streamer.notify

    Notification::Twitter.send(notification_message)
  end

  def enqueue_download_streaming_if_needed
    return unless streamer.download_live_stream

    DownloadStreamingWorker.perform_async(id)
  end

  def notification_message
    <<~TEXT.chomp
      #{streamer.talent.name}が配信を#{streamer.streaming_platform.name}で開始しました!
      #{streamer.url}
    TEXT
  end
end
