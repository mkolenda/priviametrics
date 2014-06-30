FactoryGirl.define do

  factory :user do
    email                  "user@example.com"
    password               "password"
  end

  factory :event do
    name                   'Click'
    referrer               'http://www.cruftify.com'
    property_1             100
    property_2             200
  end

  factory :domain do
    name                    'www.cruftify.com'
  end

  factory :user_domain do
    association :user
    association :domain
  end


end
