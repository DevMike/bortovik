class CreateSettlements < ActiveRecord::Migration
  def change
    create_table :settlements do |t|
      t.string :name
      t.string :russian_name
      t.references :region

      t.timestamps
    end
    add_index :settlements, :region_id
  end
end
