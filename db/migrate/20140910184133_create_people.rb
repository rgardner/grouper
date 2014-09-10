class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :school
      t.text :skills, array: true, default: []

      t.timestamps
    end
  end
end
