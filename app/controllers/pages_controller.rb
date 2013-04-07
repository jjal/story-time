class PagesController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :new, :create]
  before_filter :correct_user,   only: [:destroy, :edit, :update]
  before_filter :correct_story, only: [:destroy, :edit, :update, :show]
  
  include StoriesHelper
  def index
    @story = Story.find(params[:story_id])
    @pages = @story.pages.paginate(page: params[:page])
  end 
  
	def show
    
	end
	
	def edit
		
  end
	
	def new
    @story = Story.find(params[:story_id])
		@page = @story.pages.build
  end
	
	def create
    @story = Story.find(params[:story_id])
		@page = @story.pages.build(params[:page])
    if @page.save
			flash[:success] = "Page created!"
      current_user.microposts.create({content: "#{current_user.name} just added a new page to <a href='#{story_path(@story)}'>#{@story.title}</a>" })
      redirect_to edit_story_path(@story)
    else
      render 'new'
    end
  end
	
	def update
    
    if @page.update_attributes(params[:page])
			flash[:success] = "Page updated"
      redirect_to edit_story_path(@story)
    else
      render 'edit'
    end
  end
	 
	def destroy
    @page.destroy
    flash[:success] = "Page destroyed."
    redirect_to edit_story_path(@story)
  end
  
    private
    def correct_story 
      @story = Story.find_by_id(params[:story_id])
      @page = @story.pages.find_by_id(params[:id])
      if(@page.nil?)
        flash[:error] = "That page doesn't exist in this story"
        redirect_to story_url(@story)
      end
    end
    
    def correct_user
      story = current_user.stories.select { |s| !s.pages.find_by_id(params[:id]).nil? }
      if(story.empty? and !current_user.admin?)
        flash[:error] = "You need to be the owner of that page to modify it."
        redirect_to root_url if story.empty?
      end
    end
end
