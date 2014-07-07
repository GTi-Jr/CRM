class DateTimeToDate < ActiveRecord::Migration
  def change
    change_column :emails, :date_sent, :string
  end
end
