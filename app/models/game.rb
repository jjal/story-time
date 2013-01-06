class Game < ActiveRecord::Base
  attr_accessible :active, :fails, :page_id, :pages, :story_id, :user_id, :wins
  belongs_to :story
  belongs_to :user
  
  def visit_page (page)
    if (page.success?)
      self.wins += 1
    elsif (page.end?)
      self.fails += 1
    end
    
    if(self.page_id != page.id)
      self.pages += 1
    end
    
    self.save!
  end
  
end
