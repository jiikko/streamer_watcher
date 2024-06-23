class StreamersController < ApplicationController
  def edit
    @talent = Talent.find(params[:talent_id])
  end
end
