class CreateCarBrands < ActiveRecord::Migration
  def change
    create_table :car_brands do |t|
      t.string :name

      t.timestamps
    end
    add_index :car_brands, :name
  end
end
