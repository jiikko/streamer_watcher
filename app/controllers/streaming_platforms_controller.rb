class StreamingPlatformsController < ApplicationController
  def index
    @talent = Talent.find(params[:talent_id])
    @streaming_platforms = StreamingPlatform.all
    @streamers_by_platform_id = @talent.streamers.index_by(&:streaming_platform_id)
  end
end
