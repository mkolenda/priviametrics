class ChartsController < ApplicationController
  def index
    @events = Event.all
    @domains = Domain.order(:name)
    @event_names = Event.get_names_for_user
  end


end
