class Domain < ActiveRecord::Base
  has_many :events

  has_many :user_domains
  has_many :users, through: :user_domains
  validates_presence_of :name
end
