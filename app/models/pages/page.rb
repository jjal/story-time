include PagesHelper

class Page < ActiveRecord::Base

  has_many :links, dependent: :destroy
  accepts_nested_attributes_for :links, 
                                :allow_destroy => true, 
                                :reject_if => :all_blank
  belongs_to :story
  after_initialize :init

  validate :audio_is_valid
  
  has_one_attached :image
  validates :image, file_content_type: {
    allow: ["image/jpeg", "image/png"],
    if: -> { image.attached? },
  }

  NORMAL = :NormalPage
  ENDING = :EndPage
  WIN    = :WinPage
  START  = :StartPage

  TYPES = {
    NORMAL => 'Normal',
    START => 'Start',
    WIN => 'Win',
    ENDING => 'Other ending'
  }

  def audio_is_valid
    if (!audio.blank?)
      if(!can_retrieve_sound audio)
        errors.add(:audio, "That audio url won't work. Check that it's publically shared.")
      end
    end
  end

  def image_safe(size=nil)
    image.file? ? image.url((size.nil? || size > 200) ? :large : :medium) : (image_url.blank? ? "/assets/placeholder.png" : image_url)
  end

  def word_count
    text.scan(/\w+/).size
  end
  
  def self.attributes_protected_by_default
    # default is ["id","type"]
    ["id"]
  end
  def init
      self.text  ||= ""
  end
end