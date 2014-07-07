class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :facebook
      t.string :twitter

      t.timestamps
    end
  end
end
