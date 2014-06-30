class CreateUserDomains < ActiveRecord::Migration
  def change
    create_table :user_domains do |t|
      t.references :user
      t.references :domain
    end
  end
end
