class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :referrer
      t.decimal :property_1, precision: 15, scale: 5
      t.decimal :property_2, precision: 15, scale: 5
      t.timestamps
    end
  end
end
