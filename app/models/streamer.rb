class Streamer < ApplicationRecord
  belongs_to :talent
  belongs_to :streaming_platform

  def url
    "#{streaming_platform.url}/#{streamer_key}"
  end

  def notify_and_download_if_streaming
    if streaming?
      notify
    end
  end

  def streaming?
  end
end
