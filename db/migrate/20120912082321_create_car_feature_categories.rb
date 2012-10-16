class CreateCarFeatureCategories < ActiveRecord::Migration
  def change
    create_table :car_feature_categories do |t|
      t.string :name

      t.timestamps
    end
    add_index :car_feature_categories, :name
  end
end
