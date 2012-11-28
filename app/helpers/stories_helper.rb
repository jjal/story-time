module StoriesHelper
  include SessionsHelper
  
  def user_can_edit(story)
    return (!current_user.nil? && story.user_id == current_user.id)
  end
  
end
