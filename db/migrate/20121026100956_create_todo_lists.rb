class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :description
      t.references :user
      t.timestamps
    end
  end
end
