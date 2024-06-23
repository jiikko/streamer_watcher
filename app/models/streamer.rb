class Streamer < ApplicationRecord
  belongs_to :talent
  belongs_to :streaming_platform
  has_many :streamings, dependent: :destroy

  def url
    "#{streaming_platform.url}/#{streamer_key}"
  end

  def action_if_streaming
    fetched_streaming = fetch_streaming
    return unless fetched_streaming.streaming?

    streamings.find_or_create_by!(unique_key: fetched_streaming.unique_key) do |s|
      s.start_at = fetched_streaming.start_at
      s.title = fetched_streaming.title
    end
  end

  def fetch_streaming
    DescribeStreaming.new(url).execute # TODO: twitcastのみに対応
  end
end
