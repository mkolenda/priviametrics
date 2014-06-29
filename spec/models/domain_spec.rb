require 'spec_helper'

describe Domain do
  let(:domain) {
    Domain.new(
        name: "www.cruftify.com"
    )
  }

  subject { domain }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:events) }

  describe "correct values" do
    it "should report the correct values" do
      domain.name.should eq "www.cruftify.com"
    end
  end

  describe "failed validations" do
    it "should require a name" do
      domain.name = nil
      domain.should_not be_valid
    end

    it "should require a not blank name" do
      domain.name = ""
      domain.should_not be_valid
    end
  end

end
