class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable
  devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable

  has_many :user_domains
  has_many :domains, through: :user_domains
  has_many :events, through: :domains
end
