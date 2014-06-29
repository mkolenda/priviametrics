class ChartsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  def index
    @events = Event.all
    @domains = Domain.order(:name)
    @event_names = Event.get_names_for_user
  end


end
