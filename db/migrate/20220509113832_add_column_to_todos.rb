class AddColumnToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :is_done, :boolean, default: false
  end
end
