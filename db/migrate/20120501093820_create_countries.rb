class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :russian_name

      t.timestamps
    end
  end
end
