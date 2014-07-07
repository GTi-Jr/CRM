class RenameLinkedin < ActiveRecord::Migration
  def change
    rename_column :users, :linked_in, :linkedin
  end
end
