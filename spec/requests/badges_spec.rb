require 'spec_helper'

describe "Badge allocation" do
  describe "wordsmith" do
    before do 
      @user = User.new 
      @story = @user.stories.create!
      sign_in @user
    end
    
    subject { @user }
    
    # before (:each) do 
    #   @user.stories.each do |s|
    #     s.pages.each do |p|
    #       p.destroy!
    #     end
    #   end
    #   @user.badges.each do |b|
    #     b.destroy!
    #   end
    # end
    
    # describe "level 1" do
    #   expect do
    #     post :create, {:page => { contents: "word " * 1001 }, :story_id => @story.id} 
    #   end.to change(@user.badges, :count).by(1)
    #   @user.badges.last.class { should == 'wordsmith' }
    #   @user.badges.last.level { should == 1 }
    # end
    
    # describe "level 2" do
    #   expect do
    #     post :create, {:page => { contents: "word " * 3001 }, :story_id => @story.id} 
    #   end.to change(@user.badges, :count).by(1)
    #   @user.badges.last.class { should == 'wordsmith' }
    #   @user.badges.last.level { should == 2 }
    # end
    
    # describe "level 3" do
    #   expect do
    #     post :create, {:page => { contents: "word " * 6001 }, :story_id => @story.id} 
    #   end.to change(@user.badges, :count).by(1)
    #   @user.badges.last.class { should == 'wordsmith' }
    #   @user.badges.last.level { should == 3 }
    # end
    
    # describe "no change if already applied"
    #   expect do
    #     post :create, {:page => { contents: "word " * 6001 }, :story_id => @story.id} 
    #   end.to change(@user.badges, :count).by(1)
    #   expect do
    #     post :create, {:page => { contents: "word " * 6001 }, :story_id => @story.id} 
    #   end.to change(@user.badges, :count).by(0)
    # end
    
    # describe "no badge if unworthy"
    #   expect do
    #     post :create, {:page => { contents: "word " * 900 }, :story_id => @story.id} 
    #   end.to change(@user.badges, :count).by(0)
    # end
  end
end
