module StoriesHelper
  include SessionsHelper
  
  def user_can_edit(story)
    return (story.user_id == current_user.id)
  end
  
end
