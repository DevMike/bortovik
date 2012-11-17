class RemoveRussianNameFromLocations < ActiveRecord::Migration
  def up
    remove_column :countries, :russian_name
    remove_column :regions, :russian_name
    remove_column :settlements, :russian_name
  end

  def down
    add_column :countries, :russian_name, :string
    add_column :regions, :russian_name, :string
    add_column :settlements, :russian_name, :string
  end
end
