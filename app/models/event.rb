class DomainValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless (value =~ /\A(http|https):\/\/([a-z0-9\-\.]+\.(com|org|net|mil|edu))/i) ||
           (value =~ /\A(http|https):\/\/(localhost:\d*)/i)
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

  def created_on
    # return the date portion of the created_at date
    created_at.to_date
  end


  class << self
    def by_day(start_date = 30.days.ago, end_date = Time.zone.now)
      # Method used by the chart page to sum and group property values by day, name and domain
      # Retrieves data from the start_date to the end_date
      events = select("date(created_at) as created_date,
                          sum(property_1) as total_1,
                          sum(property_2) as total_2,
                          lower(events.name) as event_name,
                          lower(domains.name) as domain_name")
      events = events.where(created_at: (start_date.beginning_of_day)..(end_date.end_of_day))
      events = events.joins(:domain)
      events = events.group("date(events.created_at), lower(events.name), lower(domains.name)")
      events = events.order("date(events.created_at), lower(events.name), lower(domains.name)")
      events
    end

    def get_names_for_user
      names = select("lower(name) as name").distinct.order('lower(name)')
      names
    end
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
