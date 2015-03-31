class CreateUserVehicles < ActiveRecord::Migration
  def change
    create_table :user_vehicles do |t|
      t.references :vehicle
      t.references :user
      t.date :date_of_purchase
      t.date :date_of_sale
      t.integer :mileage_on_purchase

      t.timestamps
    end
    add_index :user_vehicles, :vehicle_id
    add_index :user_vehicles, :user_id
  end
end
