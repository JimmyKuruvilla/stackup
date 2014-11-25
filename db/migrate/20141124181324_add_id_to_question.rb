class AddIdToQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :so_id, :string
  end
end
