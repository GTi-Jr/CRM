class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.string :category
      t.datetime :date_begin
      t.datetime :date_limit
      t.datetime :date_reminder
      t.string :priority
      t.string :status
      t.string :visibility
      t.text :desciption

      t.timestamps
    end
  end
end
