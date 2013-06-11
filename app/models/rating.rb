class Rating < ActiveRecord::Base
  attr_accessible :comment, :score, :story_id, :user_id
  belongs_to :story
  belongs_to :user

  def subject_user
  	story.user
  end
end
