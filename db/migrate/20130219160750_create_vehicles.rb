class CreateVehicles < ActiveRecord::Migration
  def up
    create_table :vehicles do |t|
      t.references :car_modification
      t.float :engine_volume
      t.string :transmission
      t.string :color
      t.integer :mileage

      t.timestamps
    end

    add_attachment :vehicles, :photo
    add_index :vehicles, :car_modification_id
  end

  def down
    drop_table :vehicles
  end
end
