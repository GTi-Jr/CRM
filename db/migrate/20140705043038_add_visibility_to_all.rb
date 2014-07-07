class AddVisibilityToAll < ActiveRecord::Migration
  def change
    add_column :emails, :visibility, :string
    add_column :projects, :visibility, :string
  end
end
