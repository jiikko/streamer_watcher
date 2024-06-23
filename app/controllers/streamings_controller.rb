class StreamingsController < ApplicationController
  def destroy
    streaming = Streaming.find(params[:id])
    streaming.destroy!
    redirect_to root_path, notice: 'Streaming was successfully destroyed.'
  end
end
