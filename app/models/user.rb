# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  has_merit

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	has_secure_password
	has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  has_many :stories
  has_many :ratings
  has_many :games
  has_many :current_games, through: :games, class_name: "Story"
	
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token
	
	validates(:name, presence: true, length: { maximum: 50 })
	validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false })
	validates(:password, presence: true, length: { minimum: 6 })
	validates(:password_confirmation, presence: true)
	
  has_attached_file :avatar,
    styles: { 
      medium: "200x200",
      large: "600x400"
    },
    storage: :dropbox,
    dropbox_credentials: "config/dropbox.yml",
    dropbox_options: { :path => proc { |style| "user_images/#{id}/#{style}/#{avatar.original_filename}" } }
    
	def feed
    Micropost.where("user_id = ?", id)
  end
	
	def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
	
	def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def clear_badges(badge_name, level)
    badges.each do |b|
      logger.debug b
      logger.debug "#{badge_name} - #{level}"
      logger.debug (b.name == badge_name and b.level <= level)
      rm_badge(b.id) if(b.name == badge_name and b.level <= level)
    end
  end

	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
