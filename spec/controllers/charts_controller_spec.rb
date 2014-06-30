require 'spec_helper'

describe ChartsController do

  let(:domain) { FactoryGirl.create(:domain) }
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }
  let(:user_domain) { FactoryGirl.create(:user_domain, user: user, domain: domain) }

  before do
    ApplicationController.any_instance.stub(:current_user).and_return(user)
    ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
  end

  describe "index" do
    before do
      user_domain
      event
      get :index
    end
    it "should set the appropriate instance variables" do
      assigns(:domains).should eq [domain]
      assigns(:event_names)[0].should eq event.name.downcase
    end
  end

end
