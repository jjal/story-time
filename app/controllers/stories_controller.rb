class StoriesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:destroy, :edit, :update]
  
  def index
    @stories = Story.paginate(page: params[:page], per_page: 10)
  end 
  
	def show
		@story = Story.find(params[:id])
	end
	
	def edit
		@story = Story.find(params[:id])
  end
  
  def graph
    @story = Story.find(params[:story_id])
  end
	
	def new
		@story = current_user.stories.build
  end
	
	def create
    @story = current_user.stories.build(params[:story])
    if @story.save
			flash[:success] = "Cool you created a story. Now add some pages."
      current_user.microposts.create({content: "#{current_user.name} just created a new story, <a href='#{story_path(@story)}'>'#{@story.title}'</a>" })
      redirect_to edit_story_path(@story)
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
    @story = Story.find(params[:id])
    @story.destroy
    flash[:success] = "Story destroyed."
    redirect_to stories_url
  end
  
  private

    def correct_user
      @story = current_user.stories.find_by_id(params[:id])
      if(@story.nil? and !current_user.admin?)
        flash[:error] = "You need to be the owner of that story to modify it."
        redirect_to root_url if @story.nil?
      end
    end
end
