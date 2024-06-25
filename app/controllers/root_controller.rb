class RootController < ApplicationController
  def index
    @streamers = Streamer.eager_load(:talent, :streaming_platform).group_by(&:talent)
    @streamings = Streaming.order(start_at: :desc).eager_load(streamer: :talent,
                                                              movie_attachment: :blob).with_attached_movie
  end
end
