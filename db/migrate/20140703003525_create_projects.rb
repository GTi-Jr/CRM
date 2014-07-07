class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :token
      t.datetime :date_begin
      t.datetime :date_limit
      t.datetime :date_estimated
      t.string :status
      t.integer :percent
      t.string :category
      t.string :priority
      t.float :revenue
      t.text :description

      t.timestamps
    end
  end
end
