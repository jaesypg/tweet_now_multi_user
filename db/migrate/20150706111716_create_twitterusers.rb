class CreateTwitterusers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :username
      t.string :access_token_id
      t.string :access_token_secret_key_id
      t.timestamps null: false
    end
  end
end
