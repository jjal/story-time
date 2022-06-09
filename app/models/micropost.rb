# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Micropost < ActiveRecord::Base

  belongs_to :user
  validates :content, presence: true, length: { maximum: 600 }
	validates :user_id, presence: true
	default_scope { order created_at: :desc }
  
  def self.get_recent(num)
    return Micropost.includes(:user).limit(num).order(id: :desc)
  end
  
  def content_without_username
    content.gsub(/^#{self.user.name} just/,'')
  end
end
