class Video < ActiveRecord::Base

  validates_presence_of :url, :title

  belongs_to :user
  has_many :video_steps
  has_many :steps, through: :video_steps
  has_many :styles, through: :steps
  

end
