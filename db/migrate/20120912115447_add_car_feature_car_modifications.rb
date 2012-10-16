class AddCarFeatureCarModifications < ActiveRecord::Migration
  def change
    create_table :car_feature_car_modifications do |t|
      t.references :car_feature
      t.references :car_modification
      t.string :value
    end
    add_index :car_feature_car_modifications, :car_feature_id
    add_index :car_feature_car_modifications, :car_modification_id
  end
end
