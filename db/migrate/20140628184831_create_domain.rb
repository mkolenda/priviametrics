class CreateDomain < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name, null: false
    end
  end
end
