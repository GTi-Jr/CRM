class AddIdIndex < ActiveRecord::Migration
  def change
    add_column :projects, :user_id, :integer
    add_column :projects, :client_id, :integer
    add_column :emails, :user_id, :integer
    add_column :emails, :client_id, :integer
    add_column :contacts, :client_id, :integer
    add_column :activities, :user_id, :integer
    add_column :activities, :project_id, :integer
  end
end
