class Story < ActiveRecord::Base
  attr_accessible :id, :image, :title, :user_id, :description, :image_file_name, :image_content_type, :image_file_size, :image_updated_at
  has_many :pages
  belongs_to :user
   has_attached_file :image,
    styles: { 
      medium: "200x200",
      large: "600x400"
    },
    storage: :dropbox,
    dropbox_credentials: "config/dropbox.yml",
    dropbox_options: { :path => proc { |style| "images/#{id}/#{style}/#{image.original_filename}" } }
end