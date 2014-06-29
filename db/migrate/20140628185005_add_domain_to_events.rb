class AddDomainToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :domain, index: true, null: false
  end
end
