class TalentsController < ApplicationController
  def index
    @talents = Talent.all
  end
end
