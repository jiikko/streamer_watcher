class Streamer < ApplicationRecord
  belongs_to :talent
  belongs_to :streaming_platform
  has_many :streamings, dependent: :destroy

  def url
    "#{streaming_platform.url}/#{streamer_key}"
  end

  def action_if_streaming
    fetched_streaming = streaming_platform.fetch_streaming(url)
    return unless fetched_streaming.streaming?

    streaming = streamings.find_or_initialize_by(unique_key: fetched_streaming.unique_key).tap do |s|
      s.start_at = fetched_streaming.start_at
      s.title = fetched_streaming.title
    end
    return if streaming.persisted?

    streaming.save!
    streaming.action_after_create
  end
end
