class Event < ActiveRecord::Base
  def created_on
    created_at.to_date
  end
end
