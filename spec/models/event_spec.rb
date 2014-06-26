require 'spec_helper'

describe Event do
  let(:event) { Event.create(
      name: "an event",
      referrer: "http://cruftify.com",
      property_1: "one value",
      property_2: "another value")
  }

  subject { event }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:referrer) }
  it { should respond_to(:property_1) }
  it { should respond_to(:property_2) }
  it { should respond_to(:created_at) }
  it { should respond_to(:created_on) }

  describe "created_on should be today without time" do
    its "created_on property should not have time" do
      event.created_on.should eq DateTime.now.to_date
    end
  end
end
