class SetUpStartPages < ActiveRecord::Migration
  def up
  	Story.find(:all).each do |s|
  		p = s.pages.first
  		unless(p.nil?)
	  		p.type = 'StartPage'
	  		p.save
  		end
  	end
  end

  def down
  	Page.find(:all, :conditions=>{type: 'StartPage'}).each do |p|
  		p.type = nil
  		p.save
  	end
  end
end
