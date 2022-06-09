class FixPageTypes < ActiveRecord::Migration
  def up
  	Page.find(:all, conditions: {:end => true, :success=> false}).each do |p|
  		p.type='EndPage'
  		p.save
  	end
  	Page.find(:all, conditions: {:success=> true}).each do |p|
  		p.type='WinPage'
  		p.save
  	end
  end

  def down
  	  	Page.find(:all, conditions: {:type => 'WinPage'}).each do |p|
  		p.success=true
  		p.save
  	end
  	  	  	Page.find(:all, conditions: {:type => 'EndPage'}).each do |p|
  		p.end=true
  		p.save
  	end
  end
end
