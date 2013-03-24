class RemoveConstraintOnUserPassword < ActiveRecord::Migration
  def change
    change_column :users, :encrypted_password, :string, default: '', null: true
  end
end
