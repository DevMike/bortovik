class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :russian_name

      t.timestamps
    end

    add_index :countries, :name,         unique: true
    add_index :countries, :russian_name, unique: true
  end
end
