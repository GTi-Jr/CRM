class AddTourToUser < ActiveRecord::Migration
  def change
    add_column :users, :tour, :boolean
  end
end
