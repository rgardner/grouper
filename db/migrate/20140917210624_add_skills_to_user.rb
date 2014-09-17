class AddSkillsToUser < ActiveRecord::Migration
  def change
    rename_column :users, :skills, :known_skills
    add_column :users, :wanted_skills, :text, array: true, default: []
  end
end
