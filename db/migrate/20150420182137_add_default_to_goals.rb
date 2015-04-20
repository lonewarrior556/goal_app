class AddDefaultToGoals < ActiveRecord::Migration
  def change
    change_column :goals, :private, :boolean, default: false
  end
end
