class RanameLinkedin < ActiveRecord::Migration
  def change
    rename_column :contacts, :linked_in, :linkedin
  end
end
