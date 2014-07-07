class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :facebook
      t.string :twitter
      t.string :occupation
      t.string :linked_in
      t.string :website
      t.text :background

      t.timestamps
    end
  end
end
