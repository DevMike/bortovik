class AddNamesContactsAndAvatarToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :icq, :string
    add_column :users, :skype, :string
    add_column :users, :phone, :string
    add_attachment :users, :avatar
  end
end
