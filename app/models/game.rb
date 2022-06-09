class Game < ActiveRecord::Base

  belongs_to :story
  belongs_to :user
  
  def visit_page (page)
    if(self.page_id != page.id)
      if (page.is_a?(WinPage))
        self.wins = 1
      elsif (page.is_a?(EndPage))
        self.fails += 1
      end
      self.pages += 1
    end
    
    self.page_id = page.id
    self.save!
  end
  
end
