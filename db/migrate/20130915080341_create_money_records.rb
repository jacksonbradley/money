class CreateMoneyRecords < ActiveRecord::Migration
  def change
    create_table :money_records do |t|
      t.integer :amount
      t.integer :category_id
      t.string :description
      t.integer :day
      t.integer :month
      t.integer :year
      t.integer :user_id

      t.timestamps
    end
  end
end
