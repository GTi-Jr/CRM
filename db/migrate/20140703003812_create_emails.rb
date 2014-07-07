class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.text :message
      t.datetime :date_sent

      t.timestamps
    end
  end
end
