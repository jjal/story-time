class Page < ActiveRecord::Base
  attr_accessible :end, :id, :image, :points, :story_id, :success, :text, :title, :links_attributes, :links
  has_many :links, dependent: :destroy
  accepts_nested_attributes_for :links, 
                                :allow_destroy => true, 
                                :reject_if => :all_blank
end
