require 'spec_helper'

describe DomainsController do

  let(:domain) { FactoryGirl.create(:domain) }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:event) { FactoryGirl.create(:event) }

  before do
    ApplicationController.any_instance.stub(:current_user).and_return(admin)
    ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
  end

  describe "index" do
    describe "when an admin" do
      before do
        domain
        get :index
      end

      it "should assign the proper instance variable" do
        assigns(:domains).should eq [domain]
      end
    end

    describe "when a regular user" do
      before do
        User.destroy_all
        ApplicationController.any_instance.stub(:current_user).and_return(user)
        domain
        get :index
      end

      it "should redirect" do
        response.should redirect_to(root_path)
      end
    end
  end

  describe "edit" do
    describe "when an admin" do
      before do
        domain
        get :edit, id: domain
      end

      it "should assign the proper instance variable" do
        assigns(:domain).should eq domain
      end
    end

    describe "when a regular user" do
      before do
        User.destroy_all
        ApplicationController.any_instance.stub(:current_user).and_return(user)
        domain
        get :edit, id: domain
      end

      it "should redirect" do
        response.should redirect_to(root_path)
      end
    end
  end

  describe "update" do
    describe "when an admin" do
      before do
        User.destroy_all
        domain
        user
        put :update, id: domain, domain: {"user_ids" => ["#{user.id}"]}
      end

      it "should create UserDomain records" do
        response.should redirect_to(domains_path)
        UserDomain.count.should eq 1
        UserDomain.first.user.should eq user
        UserDomain.first.domain.should eq domain
      end
    end

  end
end
