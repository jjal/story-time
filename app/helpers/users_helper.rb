module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, size=nil)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, width: size, class: "gravatar")
  end
  
  def avatar_for(user, size=nil)
    image_url = user.avatar.file? ? user.avatar.url((size.nil? || size > 100) ? :large : :medium) : "/assets/default_avatar.png"
    if(user.id.nil?)
      image_tag(image_url, alt: user.name, width: size, class: "avatar")
    else 
      link_to user_path(user) do 
        image_tag(image_url, alt: user.name, width: size, class: "avatar")
      end
    end
  end
end