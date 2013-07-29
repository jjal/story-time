class Page < ActiveRecord::Base
  attr_accessible :end, :id, :image, :points, :story_id, :success, :text, :title, :links_attributes, :links, :image_url, :message, :type
  has_many :links, dependent: :destroy
  accepts_nested_attributes_for :links, 
                                :allow_destroy => true, 
                                :reject_if => :all_blank
  belongs_to :story
  has_attached_file :image,
    styles: { 
      medium: "200x200",
      large: "600x400"
    },
    storage: :dropbox,
    dropbox_credentials: "config/dropbox.yml",
    dropbox_options: { :path => proc { |style| "page_images/#{id}/#{style}/#{image.original_filename}" } }

  NORMAL = :NormalPage
  ENDING = :EndPage
  WIN    = :WinPage

  TYPES = {
    NORMAL => 'Normal',
    WIN => 'Win',
    ENDING => 'Other ending'
  }

  def image_safe(size=nil)
    image.file? ? image.url((size.nil? || size > 200) ? :large : :medium) : (image_url.blank? ? "/assets/placeholder.png" : image_url)
  end
  

end