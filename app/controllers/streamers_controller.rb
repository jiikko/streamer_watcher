class StreamersController < ApplicationController
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
    params.require(:streamer).permit(:streamer_key, :notify, :download_live_stream)
  end
end
