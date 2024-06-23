class Streamer < ApplicationRecord
  belongs_to :talent
  belongs_to :streaming_platform

  def url
    "#{streaming_platform.url}/#{streamer_key}"
  end

  def notify_and_download_if_streaming
    return unless (streaming = get_streaming) && streaming.streaming?

    notify
    # download
  end

  def get_streaming
    DescribeStreaming.new(url).execute # TODO: twitcastのみに対応
  end

  def notify
  end
end
