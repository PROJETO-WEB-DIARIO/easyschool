class CreateClassrooms < ActiveRecord::Migration[8.0]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.integer :year
      t.string :series

      t.timestamps
    end
  end
end
