class CreateVideoSteps < ActiveRecord::Migration
  def change
    create_table :video_steps do |t|
      t.integer :video_id
      t.integer :step_id
    end
  end
end
