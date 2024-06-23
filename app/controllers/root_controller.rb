class RootController < ApplicationController
  def index
    @streamers = Streamer.all.group_by(&:talent)
    @streamings = Streaming.order(start_at: :desc)
  end
end
