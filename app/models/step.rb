class Step < ActiveRecord::Base

  validates_presence_of :name

  belongs_to :user
  has_many :video_steps
  has_many :videos, through: :video_steps
  has_many :step_styles
  has_many :styles, through: :step_styles

  
  

end