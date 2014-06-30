require 'spec_helper'

describe User do

  let(:domain) { FactoryGirl.create(:domain, name: "www.cruftify.com") }

  let(:user) { FactoryGirl.create(:user, email: 'test@domain.com', password: 'password' ) }

  let(:user_domain) { FactoryGirl.create(:user_domain, domain: domain, user: user) }

  subject { user }

  it { should be_valid }
  it { should respond_to(:domains)}

  describe "a user's domains" do
    before do
      user
      domain
      user_domain
    end

    it "should respond with the correct domains" do
      user.domains.should eq [domain]
    end
  end

end



