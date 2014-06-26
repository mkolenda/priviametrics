class EventsController < ApplicationController
  # disable CSRF protection
  skip_before_action :verify_authenticity_token

  def index
    @events = Event.all
    @event = Event.new

    respond_to do |format|
      format.html { }

      # CORS requires that the HTTP OPTIONS request verb should respond with headers only
      format.json { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.js   { }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def event_params
      params.require(:event).permit(:name, :property_1, :property_2).merge(referrer: request.env["HTTP_REFERER"])
    end
end
