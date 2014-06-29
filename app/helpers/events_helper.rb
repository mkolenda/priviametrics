module EventsHelper
  def events_chart_data
    events_by_day = Event.by_day(30.days.ago)
    (30.days.ago.to_date..Date.today).map do |date|
      {
        created_at: date,
        property_1: events_by_day[date].try(:first).try(:total_1) || 0,
        property_2: events_by_day[date].try(:first).try(:total_2) || 0
      }
    end
  end
end
