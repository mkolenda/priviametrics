require 'spec_helper'

describe EventsHelper do
  describe "#events_chart_data" do
    before do
      (Date.today - 2..Date.today).each do |day|
        %w{Sale Click}.each do |name|
          %w{http://www.bloogle.com http://www.blueocean.com}.each do |referrer|
            2.times do
              Event.create(name: name,
                           referrer: referrer,
                           property_1: 100,
                           property_2: 200,
                           created_at: day
              )
            end
          end
        end
      end
    end

    it "should generate an array of hashes appropriate for the chart javascript to consume" do
      # events_chart_data(start_date = 30.days.ago, end_date = Time.zone.now)
      data = events_chart_data(Date.today - 2, Date.today)
      data.length.should eq 12

      data.each do |h|
        h[:property_1].should eq 200
        h[:property_2].should eq 400
      end
    end
  end

end

