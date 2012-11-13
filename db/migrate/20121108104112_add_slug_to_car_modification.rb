class AddSlugToCarModification < ActiveRecord::Migration
  def change
    change_table :car_modifications do |t|
      t.string :slug
    end
  end
end
