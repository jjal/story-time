class PagesController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :new, :create]
  before_filter :correct_user,   only: [:destroy, :edit, :update]
  before_filter :correct_story, only: [:destroy, :edit, :update, :show]
  before_filter :create_new_link_pages, only: [:update, :create]

  include StoriesHelper
  def index
    @story = Story.find(params[:story_id])
    @pages = @story.pages.paginate(page: params[:page])
  end 
  
	def show
    game = @story.get_game_for_user(current_user)
    game.visit_page(@page)
    render layout: false
	end
	
	def edit
		
  end
	
	def new
    @story = Story.find(params[:story_id])
		@page = @story.pages.build
  end
	
	def create
    @story = Story.find_by_id(params[:story_id])
		@page = @story.pages.build(params[:page])
    if(@story.pages.count == 0)
      @page.type = 'StartPage'
    end
    if @page.save
			flash[:success] = "Page created!"
       if(@story.status == Story::PUBLISHED)
        current_user.microposts.create({content: "#{current_user.name} just added a new page to <a href='#{story_path(@story)}'>#{@story.title}</a>" })
      end
      redirect_to edit_story_path(@story)
    else
      render 'new'
    end
  end

  
	def update
    if @page.update_attributes(params[:page])
      #logger.debug "************pages merit************************"
      #logger.debug @page.story.user.stories.collect{ |s| s.get_word_count }.sum
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

    def create_new_link_pages
      return unless params[:page].has_key? :links_attributes

      params[:page][:links_attributes].each do |key, link| 
        if(link[:other_page_id].empty? and link[:_destroy] != "1")
          p = create_new_page_from_link(link)
          params[:page][:links_attributes][key][:other_page_id] = p.id
        end
      end
    end

    def create_new_page_from_link(link)
      @story = Story.find_by_id(params[:story_id])
      page = @story.pages.build(title: link[:text])
      page.save!
      return page
    end
end
