class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.date :due_date
      t.boolean :completed, default: false
      t.references :user
      
      t.timestamps
    end
  end
end
