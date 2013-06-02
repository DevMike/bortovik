class CreateVehicles < ActiveRecord::Migration
  def up
    create_table :vehicles do |t|
      t.references :car_modification
      t.float :engine_volume
      t.string :transmission
      t.string :color
      t.integer :mileage
      t.has_attached_file :photo

      t.timestamps
    end

    add_index :vehicles, :car_modification_id
  end

  def down
    drop_table :vehicles
  end
end
