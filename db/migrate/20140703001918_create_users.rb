class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :occupation
      t.string :phone
      t.string :linked_in
      t.string :website
      t.text :background
      t.string :permission

      t.timestamps
    end
  end
end
