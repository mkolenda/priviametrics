# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

((Date.today - 100)..(Date.today + 100)).each do |day|
  %w{Sale Click Cart View}.each do |name|
    %w{http://www.bloogle.com http://www.blueocean.com http://www.sunset.com http://www.flycaster.com}.each do |referrer|
      Random.new.rand(0..3).times do
        Event.create(name: name,
                     referrer: referrer,
                     property_1: Random.new.rand(0..100),
                     property_2: Random.new.rand(0..50),
                     created_at: day
        )
      end
    end
  end
end

user = User.create(email: 'user@test.com', password: 'password')

Domain.all.each do |domain|
  UserDomain.create(domain: domain, user: user)
end

admin = User.create(email: 'admin@test.com', password: 'password', admin: true)
