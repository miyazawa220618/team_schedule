class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string  :name,          null: false
      t.text    :about
      t.date    :project_start, null: false
      t.date    :project_end,   null: false
      t.integer :member_flag,   null: false, default: 0
      t.timestamps
    end
  end
end
