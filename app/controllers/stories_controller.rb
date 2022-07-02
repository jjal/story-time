require 'will_paginate/array'
require 'core_ext/array'

class StoriesController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :new, :create, :graph, :destroy]
  before_action :correct_user,   only: [:destroy, :edit, :update]
  
  def stories_params
    params.permit(:sort,:page,:id,:story_id,:story)
  end

  def index
    @stories = Story.where(
      signed_in? ? 
        (current_user.admin?) ? {} : ["status = 1 or user_id = ?", current_user.id]
      :
        ["status = 1"]
    )
    stories_params[:sort] = "rating" if(!["rating","title","date"].include? (stories_params[:sort]||"").downcase)

    case stories_params[:sort]
      when "rating"
        @stories = Story.sort_by_score(@stories)
      when "title"
        @stories = @stories.sort_by &:title
      when "date"
        @stories = @stories.sort_by(&:created_at).reverse
    end
    @stories = @stories.paginate(page: stories_params[:page], per_page: 10)
    @activity = Micropost.get_recent(10)
  end 
  
  def show
    @story = Story.find(stories_params[:id])
  end
  
  def edit
    @story = Story.find(stories_params[:id])
  end
  
  def graph
    @story = Story.find(stories_params[:story_id])
  end
  
  def new
    @story = current_user.stories.build
  end
  
  def create
    @story = current_user.stories.build(stories_params[:story])
    if @story.save
      flash[:success] = "Cool you created a story. Now add some pages."
      redirect_to edit_story_path(@story)
    else
      render 'new'
    end
  end
  
  def update
    @story = Story.find(stories_params[:id])
    if(@story.status != Story::PUBLISHED and !stories_params[:story][:status].nil? and stories_params[:story][:status].to_i == Story::PUBLISHED)
      current_user.microposts.create({content: "#{current_user.name} just published a new story, <a href='#{story_path(@story)}'>'#{@story.title}'</a>" })
    end
    if @story.update_attributes(stories_params[:story])
      flash[:success] = "Story updated"
    end
    redirect_to edit_story_path(@story)
  end
   
  def destroy
    @story = Story.find(stories_params[:id])
    @story.destroy
    flash[:success] = "Story destroyed."
    redirect_to stories_url
  end
  
  private

    def correct_user
      @story = current_user.stories.find_by_id(stories_params[:id])
      if(@story.nil? and !current_user.admin?)
        flash[:error] = "You need to be the owner of that story to modify it."
        redirect_to root_url if @story.nil?
      end
    end
end