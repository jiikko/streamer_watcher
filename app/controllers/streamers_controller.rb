class StreamersController < ApplicationController
  def new
    @talent = Talent.find(params[:talent_id])
    @streamer = @talent.streamers.new
  end

  def create
    @talent = Talent.find(params[:talent_id])
    @streamer = @talent.streamers.new(streamer_params)
    if @streamer.save
      redirect_to root_path, notice: 'Streamer was successfully created.'
    else
      render :new
    end
  end

  def edit
    @talent = Talent.find(params[:talent_id])
    @streamer = @talent.streamers.find(params[:id])
  end

  def update
    @talent = Talent.find(params[:talent_id])
    @streamer = @talent.streamers.find(params[:id])
    if @streamer.update(streamer_params)
      redirect_to root_path, notice: 'Streamer was successfully updated.'
    else
      render :edit
    end
  end

  private

  def streamer_params
    params.require(:streamer).permit(:streamer_key, :streaming_platform_id, :notify, :download_live_stream)
  end

  def available_streaming_platforms
    StreamingPlatform.all
  end

  helper_method :available_streaming_platforms
end
