class FixActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :description
    rename_column :activities, :desciption, :description
  end
end
