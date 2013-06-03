class Page < ActiveRecord::Base
  attr_accessible :end, :id, :image, :points, :story_id, :success, :text, :title, :links_attributes, :links, :image_url
  belongs_to :story
  has_many :links, dependent: :destroy
  accepts_nested_attributes_for :links, 
                                :allow_destroy => true, 
                                :reject_if => :all_blank
  has_attached_file :image,
    styles: { 
      medium: "200x200",
      large: "600x400"
    },
    storage: :dropbox,
    dropbox_credentials: "config/dropbox.yml",
    dropbox_options: { :path => proc { |style| "page_images/#{id}/#{style}/#{image.original_filename}" } }
end