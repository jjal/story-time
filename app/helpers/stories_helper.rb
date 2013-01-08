module StoriesHelper
  include SessionsHelper
  
  def user_can_edit(story)
    return (!current_user.nil? && story.user_id == current_user.id)
  end
  
  def median(array)
    return nil if array.empty?
    array.sort!
    middle = array.length / 2
    (array.length % 2 == 1) ? array[middle] : ((array[middle-1] + array[middle])/2)
  end

  def htmlify(text)
    return text.gsub(/\n?([^\n]+)(?:\n|$)/, '<p>\1</p>')
    .gsub(/_([^_]+)_/,'<em>\1</em>') #italics
    .gsub(/\*([^_]+)\*/,'<strong>\1</strong>') #bold
  end
  
  def image_for_story(story, size=nil)
    image_url = story.image.file? ? story.image.url((size.nil? || size > 200) ? :large : :medium) : (story.image_url.blank? ? "/assets/placeholder.png" : story.image_url)
    image_tag(image_url, alt: story.title, width: size, class: "image")
  end
  
end
