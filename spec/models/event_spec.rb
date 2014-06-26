require 'spec_helper'

describe Event do
  let(:event) { Event.new(
      name: "an event",
      referrer: "http://cruftify.com",
      property_1: "one value",
      property_2: "another value")
  }

  subject { event }

  it { should be_valid }
end
