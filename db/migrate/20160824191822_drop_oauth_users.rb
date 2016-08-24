class DropOauthUsers < ActiveRecord::Migration
  def change
    drop_table :oauth_users
  end
end
