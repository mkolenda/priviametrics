class Domain < ActiveRecord::Base
  has_many :events

  has_many :user_domains
  has_many :users, through: :user_domains
  validates_uniqueness_of :name, ignore_case: true

  validates :name,
            allow_blank: false,
            allow_nil: false,
            domain: true

  attr_accessor   :user_ids
  after_save      :update_user_domains


  private
    def update_user_domains

      self.user_domains.each do |u|
        # delete all the user_domain records first, then add them back from user_ids later
        u.destroy
      end

      unless user_ids.nil?
        # create the new records
        user_ids.each do |u|
          self.user_domains.create(:user_id => u) unless u.blank?
        end
      end
      reload
    end

end
