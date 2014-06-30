class ChartsController < ApplicationController
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  def index
    @domains = current_user.domains
    @event_names = current_user.events.map { |event | event.name.downcase }.uniq
  end

end
