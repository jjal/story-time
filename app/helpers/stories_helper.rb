module StoriesHelper
  include SessionsHelper
  
  def user_can_edit(story)
    return (!current_user.nil? && story.user_id == current_user.id) || current_user.admin?
  end
  
  def median(array)
    return nil if array.empty?
    array.select {|v| !v.nil? }.sort!
    middle = array.length / 2
    (array.length % 2 == 1) ? array[middle] : ((array[middle-1] + array[middle])/2)
  end
 
  def image_for_story(story, size=nil, class_name=nil)
    image_url = story.image_safe(size)
    image_tag(image_url, alt: story.title, width: size, class: class_name||"image")
  end
  
  def get_story_title(story)
    if(story.title.empty?)
      return raw '<span class="disabled">Unnamed Story</span>'
    else
      return story.title
    end
  end
end
