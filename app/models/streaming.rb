class Streaming < ApplicationRecord
  belongs_to :streamer

  has_one_attached :movie
end
