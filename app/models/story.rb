class Story < ActiveRecord::Base
  attr_accessible :id, :image, :title, :user_id, :description, :image_file_name, :image_content_type, :image_file_size, :image_updated_at
  # has_attached_file :image,
    # :styles => {
      # :thumb  => "100x100",
      # :medium => "200x200",
      # :large => "600x400"
    # }
    # :storage => :s3,
    # :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    # :path => ":attachment/:id/:style.:extension",
    # :bucket => 'story_pics'
    
end