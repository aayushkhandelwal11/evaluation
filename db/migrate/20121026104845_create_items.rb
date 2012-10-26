class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.integer :priority
      t.references :todo_list
      t.timestamps
    end
  end
end
