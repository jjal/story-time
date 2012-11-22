class Game < ActiveRecord::Base
  attr_accessible :active, :fails, :page_id, :pages, :story_id, :user_id, :wins
end
