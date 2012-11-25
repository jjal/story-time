class StoriesController < ApplicationController
  before_filter :correct_user,   only: [:destroy, :edit, :update]
  
  def index
    @stories = Story.paginate(page: params[:page])
  end 
  
	def show
		@story = Story.find(params[:id])
	end
	
	def edit
		@story = Story.find(params[:id])
  end
	
	def new
		@story = current_user.stories.build
  end
	
	def create
    @story = current_user.stories.build(params[:story])
    if @story.save
			flash[:success] = "Story created!"
      redirect_to stories_url
    else
      render 'new'
    end
  end
	
	def update
		@story = Story.find(params[:id])
    if @story.update_attributes(params[:story])
			flash[:success] = "Story updated"
    end
    render 'edit'
  end
	 
	def destroy
    Story.find(params[:id]).destroy
    flash[:success] = "Story destroyed."
    redirect_to stories_url
  end
  
  private

    def correct_user
      @story = current_user.stories.find_by_id(params[:id])
      flash[:error] = "You need to be the owner of that story to modify it."
      redirect_to root_url if @story.nil?
    end
end
