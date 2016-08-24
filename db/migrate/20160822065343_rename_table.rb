class RenameTable < ActiveRecord::Migration
  def change
    rename_table :Tasks_Users, :tasklist
  end
end
