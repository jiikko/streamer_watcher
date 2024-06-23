class Streamer < ApplicationRecord
  belongs_to :talent
  belongs_to :streaming_platform

  def url
    "#{streaming_platform.url}/#{streamer_key}"
  end
end
