class Link < ActiveRecord::Base

  belongs_to :from_page, foreign_key: :page_id, class_name: "Page"
  belongs_to :to_page, foreign_key: :other_page_id, class_name: "Page"
end
