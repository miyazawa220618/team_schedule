class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string     :title,      null: false
      t.date       :start_date, null: false
      t.date       :end_date,   null: false
      t.integer    :work_id,    null: false
      t.references :project,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
