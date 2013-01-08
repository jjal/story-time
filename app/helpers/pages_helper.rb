module PagesHelper
  def image_for_page(page, size=nil)
    image_url = page.image.file? ? (page.image.url( (size.nil? || size > 100) ? :large : :medium)) : (page.image_url.blank? ? nil : page.image_url)
    return image_tag(image_url, alt: page.title, width: size, class: "avatar") unless image_url.nil?
  end
end