class AddOutsideAuthRelatedToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :url, :string
    add_column :users, :gender, :string
    add_index :users, :url
  end
end
