class Streamer < ApplicationRecord
  belongs_to :talent
  belongs_to :streaming_platform
  has_many :streamings, dependent: :destroy

  def url
    "#{streaming_platform.url}/#{streamer_key}"
  end

  def action_if_streaming
    streaming = get_streaming
    return unless streaming.streaming?

    streamings.find_or_create_by!(unique_key: streaming.unique_key) do |s|
      s.start_at = streaming.start_at
      s.title = streaming.title
    end
  end

  def get_streaming
    DescribeStreaming.new(url).execute # TODO: twitcastのみに対応
  end
end
