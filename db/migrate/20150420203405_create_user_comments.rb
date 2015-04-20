class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.text :body
      t.integer :author_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
