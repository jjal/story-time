module StoriesHelper
  include SessionsHelper
  
  def user_can_edit(story)
    return (!current_user.nil? && story.user_id == current_user.id)
  end
  def htmlify(text)
    return text.gsub(/\n?([^\n]+)(?:\n|$)/, '<p>\1</p>').gsub(/_([^_\s]+)_/,'<em>\1</em>')
  end
end
