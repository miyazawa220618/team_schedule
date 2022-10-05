class CreateShares < ActiveRecord::Migration[6.0]
  def change
    create_table :shares do |t|
      t.date       :share_date, null: false
      t.integer    :hour_id,    null: false
      t.text       :memo
      t.references :schedule,   null: false, foreign_key: true
      t.references :user,       null: false, foreign_key: true
      t.timestamps
    end
  end
end
