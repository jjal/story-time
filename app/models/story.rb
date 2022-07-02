# https://github.com/thoughtbot/paperclip/blob/master/MIGRATING.md
require "core_ext/array.rb"
class Story < ActiveRecord::Base
  include StoriesHelper
  
  
  has_many :pages
  has_many :ratings
  has_many :games
  has_many :players, through: :games
  belongs_to :user
  has_one_attached :image
  validates :image, file_content_type: {
    allow: ["image/jpeg", "image/png"],
    if: -> { image.attached? },
  }
  after_initialize :init
  
  
  DRAFT     = 0
  PUBLISHED = 1
  REVIEW    = 2

  STATUSES = {
    DRAFT    => 'Draft',
    PUBLISHED    => 'Published',
    REVIEW => 'Review'
  }

  validates_inclusion_of :status, :in => STATUSES.keys,
      :message => "{{value}} must be in #{STATUSES.values.join ','}"

  def init
    self.status = 0 if self.status.nil?
  end

  def self.sort_by_score(stories)
    
    stories.sort_by { |s|  s.decayed_weighted_score }.reverse

  end

  def decayed_weighted_score
    return 0 if ratings.select{|r| !r.score.nil?}.empty?
    latest = ratings.last.created_at
    return decay_rating(weighted_average_rating, latest)
  end

  def decay_rating(rating, time)
    decay = Math.exp((time.to_datetime - DateTime.now).to_i/40.0)
    return rating/2.0 + (rating-rating/2.0)*decay
  end

  def weighted_average_rating
    get_average_rating * ((ratings.count*4.0)**(1.0/3.0))
  end

  def rating_deviation
    avg = get_average_rating 
    return Math.sqrt(ratings.select {|r| !r.score.nil? }.collect{ |r| (r.score - avg)**2 }.mean||0)
  end

  # just a helper method for the view
  def status_name
    STATUSES[status]
  end
  
  def user_rating(user)
    self.ratings.find_by_user_id(user.id) || self.ratings.build(user_id: user.id)
  end
  
  def get_word_count
    self.pages.collect { |p| p.word_count }.sum
  end
  
  def get_player_count
    self.games.count
  end
  
  def get_winner_count
    
    self.games.where(["wins = 1"]).count
  end

  def get_fail_count
    self.games.sum(:fails)
  end
  
  def first_page
    p = self.pages.where(["type='StartPage'"]).first
    if(p.nil?)
      p = self.pages.order("id").first
    end
    return p
  end
  
  def get_average_rating
    self.ratings.average(:score)
  end
  
  def get_median_rating
    median(self.ratings.select { |r| !r.score.nil? }.collect { |r| r.score })
  end
  
  def get_comment_ratings
    self.ratings.select { |r| !r.comment.blank? }
  end

  def image_safe(size=nil)
    image.file? ? image.url((size.nil? || size > 200) ? :large : :medium) : (image_url.blank? ? "/assets/placeholder.png" : image_url)
  end
  
  def get_game_for_user(user)
    return ((game = self.games.find_by_user_id(user.id)) ? game : self.games.create!(user_id: user.id, wins: 0, fails: 0, pages: 0))
  end
end