class CreateCarFeatures < ActiveRecord::Migration
  def change
    create_table :car_features do |t|
      t.string :name
      t.references :car_feature_category

      t.timestamps
    end
    add_index :car_features, :car_feature_category_id
    add_index :car_features, :name
  end
end
