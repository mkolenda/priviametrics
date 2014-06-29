class ChartsController < ApplicationController
  def index
    @events = Event.all
  end


end
