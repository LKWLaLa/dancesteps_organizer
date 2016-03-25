class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.string :title
      t.integer :year
      t.string :notes
      t.integer :user_id      
    end
  end
end
