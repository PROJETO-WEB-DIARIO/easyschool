class AddColumnTransport < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :transport, :boolean
  end
end
