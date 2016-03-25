class Style < ActiveRecord::Base
 
  has_many :step_styles
  has_many :steps, through: :step_styles
  has_many :videos, through: :steps
end