class Rating < ActiveRecord::Base
  attr_accessible :comment, :score, :story_id, :user_id
  belongs_to :story
  belongs_to :user

  def decayed_score
    decay = Math.exp((DateTime.now - created_at.to_datetime).to_i/-100)
    return score*decay
  end
end
