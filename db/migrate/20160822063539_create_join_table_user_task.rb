class CreateJoinTableUserTask < ActiveRecord::Migration
  def change
    create_join_table :Users, :Tasks do |t|
      # t.index [:user_id, :task_id]
      # t.index [:task_id, :user_id]
    end
  end
end
