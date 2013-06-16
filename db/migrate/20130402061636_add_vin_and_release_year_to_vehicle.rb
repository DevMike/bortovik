class AddVinAndReleaseYearToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :vin, :string
    add_column :vehicles, :release_year, :integer
  end
end
