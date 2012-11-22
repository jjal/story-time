class Story < ActiveRecord::Base
  attr_accessible :id, :image, :title, :user_id
end
