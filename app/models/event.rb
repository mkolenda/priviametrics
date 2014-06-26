class Event < ActiveRecord::Base
  def created_on
    # return the date portion of the created_at date
    # this approach is more efficient than storing a redundant date in the database
    created_at.to_date
  end
end
