class AddOmniAuthToUser < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :admin, :boolean
  end
end
