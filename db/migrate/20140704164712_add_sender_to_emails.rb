class AddSenderToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :sender, :string
  end
end
