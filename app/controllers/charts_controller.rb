class ChartsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  def index
    @domains = current_user.domains
    @event_names = current_user.events.map { |event | event.name.downcase }.uniq
  end

end
