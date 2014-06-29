require 'spec_helper'

describe Event do
  let(:domain) {
    Domain.new(
        name: "www.cruftify.com"
    )
  }

  let(:event) {
    Event.new(
      name: "an event",
      referrer: "http://www.cruftify.com",
      property_1: 100,
      property_2: 200
    )
  }

  let(:no_domain) {
    Event.new(
        name: "que te quedes decir",
        referrer: "http://some-unknown-domain.com",
        property_1: 100,
        property_2: 200
    )
  }

  subject { event }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:referrer) }
  it { should respond_to(:property_1) }
  it { should respond_to(:property_2) }
  it { should respond_to(:created_at) }
  it { should respond_to(:created_on) }
  it { should respond_to(:domain) }

  describe "correct values" do
    it "should report the correct values" do
      event.name.should eq "an event"
      event.referrer.should eq "http://www.cruftify.com"
      event.property_1.should eq 100
      event.property_2.should eq 200
    end
  end

  describe "associated domains" do
    it "should create a new domain record when the referrer has an new domain" do
      expect{ no_domain.save }.to change(Domain, :count)
    end

    describe "referrer domain already exists" do
      before { domain.save }

      it "should not create a new domain when the referrer's domain already exists in domain" do
        expect {event.save}.to_not change(Domain, :count)
      end

      it "should refer to the right domain" do
        event.save
        event.domain.name.should eq "www.cruftify.com"
      end
    end
  end

  describe "created_on should be today without time" do
    before { event.save }
    its "created_on property should not have time" do
      event.created_on.should eq DateTime.now.to_date
    end
  end

  describe "::by_day" do
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

    it "should generate a hash with the correct keys and values" do
      data = Event.by_day(Date.today - 2, Date.today)
      data.length.should eq 12
      data.each do |event|
        event.total_1.should eq 200
        event.total_2.should eq 400
      end
    end
  end
end
