class Video < ActiveRecord::Base

  belongs_to :user
  has_many :video_steps
  has_many :steps, through: :video_steps
  has_many :styles, through: :steps
  

end
