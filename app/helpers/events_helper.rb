module EventsHelper
  def events_chart_data(start_date = 30.days.ago, end_date = Time.zone.now)
    events_by_day = Event.by_day(start_date, end_date)

    events_by_day.map do |event|
      {
          created_at: event.created_date,
          event_name:      event.event_name,
          domain_name:     event.domain_name,
          property_1: event.total_1,
          property_2: event.total_2
      }
    end

    # events = select("date(created_at) as created_date,
    #                       sum(property_1) as total_1,
    #                       sum(property_2) as total_2,
    #                       events.name as event_name,
    #                       domains.name as domain_name")

    # (start_date..end_date).map do |date|
    #   {
    #     created_at: date,
    #     event: events_by_day,
    #     property_1: events_by_day[date].try(:first).try(:total_1) || 0,
    #     property_2: events_by_day[date].try(:first).try(:total_2) || 0
    #   }
    # end
  end
end
