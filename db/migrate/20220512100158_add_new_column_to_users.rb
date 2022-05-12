class AddNewColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :todos, :users, foreign_key: true

  end
end
