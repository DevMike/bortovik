class CreateCarModifications < ActiveRecord::Migration
  def change
    create_table :car_modifications do |t|
      t.string :name
      t.references :car_model

      t.timestamps
    end
    add_index :car_modifications, :car_model_id
    add_index :car_modifications, :name
  end
end
