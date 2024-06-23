class Talent < ApplicationRecord
  has_many :streamers, dependent: :destroy
  has_many :streaming_platforms, through: :streamers
end
