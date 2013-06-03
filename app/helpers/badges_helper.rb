module BadgesHelper
  def image_for_badge(badge)
    image_tag("/assets/images/badges/#{badge.name}#{badge.level}.png", alt: badge.description, width: 75, class: "badge")
  end
end