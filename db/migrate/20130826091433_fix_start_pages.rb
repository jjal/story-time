class FixStartPages < ActiveRecord::Migration
  def up
  	Story.find(:all).each do |s|
  		s.pages.find(:all, conditions: {type: 'StartPage'}).each do |p|
  			p.type = 'NormalPage'
  			p.save
  		end
  		p = s.pages.find(:first, order: "id")
  		unless(p.nil?)
	  		p.type = 'StartPage'
	  		p.save
  		end
  	end
  end

  def down
  end
end
