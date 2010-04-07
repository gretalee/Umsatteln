class CreateBikes < ActiveRecord::Migration
  def self.up
    create_table :bikes do |t|
      t.string :title
      t.string :brand
      t.string :type_of_bike
      t.string :model
      t.string :description
      t.date :date_of_manufacture
      t.integer :size
      t.string :serial_number
      t.string :condition
      t.boolean :bill_exists
      t.boolean :umsatteln_checked
      t.string :zip
      t.string :city
      t.float :price
      t.integer :user_id
      
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :bikes
  end
end
