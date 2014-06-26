class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # Removing this check to allow other domains to post to /events
  protect_from_forgery with: :exception

  before_action :set_headers

  private

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Content-Type'
      headers['Access-Control-Max-Age'] = '1728000'
    end
end
