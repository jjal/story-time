module BadgesHelper
	def full_description(badge)
		"#{badge.custom_fields[:level_name]}: #{badge.description}"
	end
	def badge_image_for(badge)
    image_url = "/assets/badges/#{badge.name}#{badge.level}.png"
      link_to "#", {:rel => 'tooltip', :'data-original-title' => full_description(badge), :class => "atooltip" } do 
        image_tag(image_url, { :alt => badge.description, :class => "merit"})
      end
  end
end