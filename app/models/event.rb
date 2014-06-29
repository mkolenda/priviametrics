class DomainValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless (value =~ /\A(http|https):\/\/([a-z0-9\-\.]+\.(com|org|net|mil|edu))/i) || (value =~ /\A(http|https):\/\/(localhost:\d*)/i)
      record.errors[attribute] << (options[:message] || "is not a domain")
    end
  end
end

class Event < ActiveRecord::Base
  belongs_to :domain
  validates :referrer,
                      allow_blank: false,
                      allow_nil: false,
                      domain: true

  before_create :get_domain

  def self.by_day(start_date = 30.days.ago, end_date = Time.zone.now)
    # Method used by the charting page to sum and group property values by day
    # Retrieves data from the start_date to the end_date
    # Groups the data by the day and domain
    events = select("date(created_at) as created_date,
                          sum(property_1) as total_1,
                          sum(property_2) as total_2")
    events = events.where(created_at: start_date.beginning_of_day..end_date)
    events = events.group("date(created_at)")
    events = events.order("date(created_at)")

    # events = select("date(created_at) as created_date,
    #                       sum(property_1) as total_1,
    #                       sum(property_2) as total_2,
    #                       domains.name as domain")
    # events = events.where(created_at: (start_date.beginning_of_day)..(end_date.end_of_day))
    # events = events.joins(:domain)
    # events = events.group("date(created_at), domains.name")
    # events = events.order("date(created_at), domains.name")

    # Build a hash of summary event data to be used by the chart
    events.group_by {|e| e.created_date.to_date }
  end

  def created_on
    # return the date portion of the created_at date
    created_at.to_date
  end

  protected
    def get_domain
      # Look for http(s)://www.somedomain.com/path/etc
      m = /\A(http|https):\/\/([a-z0-9\-\.]+\.(com|org|net|mil|edu))/i.match(referrer)

      # Look for localhost:3000 for tests to pass
      m = /\A(http|https):\/\/(localhost:\d*)/i.match(referrer) unless m

      # Stop if a bad referrer was passed
      return nil unless m

      # Grab the domain from the matchdata and create/set the domain foreign key
      referrer_domain = m[2]
      domain = Domain.find_by_name(referrer_domain)
      if domain
        self.domain = domain
      else
        self.domain = Domain.create(name: referrer_domain)
      end
    end
end
