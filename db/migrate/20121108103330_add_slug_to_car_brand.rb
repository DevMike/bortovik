class AddSlugToCarBrand < ActiveRecord::Migration
  def change
    change_table :car_brands do |t|
      t.string :slug
    end
  end
end
