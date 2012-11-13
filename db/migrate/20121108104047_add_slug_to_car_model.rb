class AddSlugToCarModel < ActiveRecord::Migration
  def change
    change_table :car_models do |t|
      t.string :slug
    end
  end
end
