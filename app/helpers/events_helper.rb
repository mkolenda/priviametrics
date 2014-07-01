module EventsHelper
  def events_chart_data(start_date = 100.days.ago, end_date = 100.days.from_now, user = current_user)
    events_by_day = Event.by_day(start_date, end_date, user)
    events_by_day.map do |event|
      {
          created_at:       event.created_date,
          event_name:       event.event_name,
          domain_name:      event.domain_name,
          property_1:       event.total_1,
          property_2:       event.total_2
      }
    end
  end
end
