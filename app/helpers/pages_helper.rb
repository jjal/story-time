module PagesHelper
  def image_for_page(page, size=nil)
    image_url = page.image.file? ? (page.image.url( (size.nil? || size > 100) ? :large : :medium)) : (page.image_url.blank? ? nil : page.image_url)
    return image_tag(image_url, alt: page.title, width: size, class: "avatar") unless image_url.nil?
  end

  def content_filter(text)
    filters = ["Stylify", "Youtube"]
    filters.each do |f|
      filter = Object.const_get("HTMLFilter_"+f).new
      text = filter.process(text)
    end
    return text
  end

  def end_message_for(page)
  	page.message.blank? ? 
  		case page.type
  			when Page::NORMAL
  				""
  			when Page::ENDING
  				"The End."
  			when Page::WIN
  				"Winner! Way to go there. Good for you."
  		end
  	: page.message
  end
end