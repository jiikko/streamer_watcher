class RootController < ApplicationController
  def index
    @streamers = Streamer.all.group_by(&:talent)
  end
end
