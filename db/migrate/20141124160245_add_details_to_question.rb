class AddDetailsToQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :view_count, :integer
  	add_column :questions, :owner_id, :string
  	add_column :questions, :owner_reputation, :integer
  	add_column :questions, :owner_accept_rate, :integer
  end
end