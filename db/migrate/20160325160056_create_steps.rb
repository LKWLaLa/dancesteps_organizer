class CreateSteps < ActiveRecord::Migration
  def change
     create_table :steps do |t|
      t.string :name
      t.string :time_marker
      t.integer :level_of_mastery
      t.string :notes
      t.integer :user_id      
    end
  end
end
