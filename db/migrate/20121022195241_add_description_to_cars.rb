class AddDescriptionToCars < ActiveRecord::Migration
  def change
    add_column :car_brands, :description, :text
    add_column :car_models, :description, :text
    add_column :car_modifications, :description, :text
  end
end
