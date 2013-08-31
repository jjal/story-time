class Rating < ActiveRecord::Base
  attr_accessible :comment, :score, :story_id, :user_id
  belongs_to :story
  belongs_to :user
  validates_length_of :comment, :maximum => 2000
  
  def subject_user
  	story.user
  end
end
