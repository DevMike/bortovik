class AddPreferredCurrencyToUser < ActiveRecord::Migration
  def change
    add_column :users, :preferred_currency, :string
  end
end
