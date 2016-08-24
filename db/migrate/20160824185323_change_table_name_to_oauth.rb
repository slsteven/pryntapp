class ChangeTableNameToOauth < ActiveRecord::Migration
  def change
    rename_table :facebooks, :oauth_users
  end
end
