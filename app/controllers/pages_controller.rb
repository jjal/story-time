class PagesController < ApplicationController
  include StoriesHelper
  def index
    @story = Story.find(params[:story_id])
    @pages = @story.pages.paginate(page: params[:page])
  end 
  
	def show
    @story = Story.find(params[:story_id])
		@page = Page.find(params[:id])
    @story.get_game_for_user(current_user).visit_page(@page)
	end
	
	def edit
		@story = Story.find(params[:story_id])
    @page = Page.find(params[:id])
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
      redirect_to edit_story_path(@story)
    else
      render 'new'
    end
  end
	
	def update
    @story = Story.find(params[:story_id])
		@page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
			flash[:success] = "Page updated"
      redirect_to edit_story_path(@story)
    else
      render 'edit'
    end
  end
	 
	def destroy
    @story = Story.find(params[:story_id])
    Page.find(params[:id]).destroy
    flash[:success] = "Page destroyed."
    redirect_to edit_story_path(@story)
  end
end
