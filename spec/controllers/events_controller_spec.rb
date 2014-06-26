require 'spec_helper'

shared_examples_for "any request" do
  context "CORS requests" do
    it "should set the Access-Control-Allow-Origin header to allow CORS from anywhere" do
      response.headers['Access-Control-Allow-Origin'].should eq '*'
    end

    it "should allow general HTTP methods thru CORS (GET/POST/OPTIONS)" do
      allowed_http_methods = response.header['Access-Control-Allow-Methods']
      %w{GET POST OPTIONS}.each do |method|
        allowed_http_methods.should include(method)
      end
    end

    it "should set the Access-Control-Allow-Headers header to 'Content-Type'" do
      response.headers['Access-Control-Allow-Headers'].should eq 'Content-Type'
    end

    it "should set the Access-Control-Max-Age to '1728000'" do
      response.headers['Access-Control-Max-Age'].should eq '1728000'
    end
  end
end

describe EventsController do
  before do
    post :create, format: :json, event: ({name: "Event 1",
                                          property_1: "1000",
                                          property_2: "3000"})
  end

  it_should_behave_like "any request"

  describe "create" do
    it "should create a new event when asked using JSON" do
      expect { post :create, format: :json, event: ({name: "Event 1",
                             property_1: "1000",
                             property_2: "3000"})}.to change(Event, :count)

      response.should be_success
      body = JSON.parse(response.body)
      body.should include("id", "name", "referrer", "property_1", "property_2", "created_at", "updated_at")
    end
  end

  describe "index" do
    before do
      process :index, 'OPTIONS'
    end

    it_should_behave_like "any request"

    it "should respond to an OPTIONS HTTP verb" do
      response.should be_success
    end

  end
end
