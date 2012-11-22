class PagesController < ApplicationController
  def index
    @story = Story.find(params[:story_id])
    @pages = story.pages.paginate(page: params[:page])
  end 
  
	def show
    @story = Story.find(params[:story_id])
		@page = Page.find(params[:id])
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
      redirect_to @page
    else
      render 'new'
    end
  end
	
	def update
		@page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
			flash[:success] = "Page updated"
      redirect_to @page
    else
      render 'edit'
    end
  end
	 
	def destroy
    Page.find(params[:id]).destroy
    flash[:success] = "Page destroyed."
    redirect_to pages_url
  end
end
