class AddColumnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :owner, :string
  end
end
