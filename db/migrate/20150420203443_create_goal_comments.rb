class CreateGoalComments < ActiveRecord::Migration
  def change
    create_table :goal_comments do |t|
      t.text :body
      t.integer :author_id
      t.references :goal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
