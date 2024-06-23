class StreamingPlatform < ApplicationRecord
  has_many :streamers, dependent: :destroy
  has_many :talents, through: :streamers
end
