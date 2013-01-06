class RatingsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  
  # GET /ratings
  # GET /ratings.json
  def index
    @story = Story.find(params[:story_id])
    @ratings = @story.ratings

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ratings }
    end
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
    @rating = Rating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rating }
    end
  end

  # GET /ratings/new
  # GET /ratings/new.json
  def new
    @story = Story.find(params[:story_id])
    @rating = @story.ratings.build

    respond_to do |format|
      format.json { render json: @rating }
    end
  end

  # GET /ratings/1/edit
  def edit
    @story = Story.find(params[:story_id])
    @rating = Rating.find(params[:id])
  end

  # POST /ratings
  # POST /ratings.json
  def create
    @rating = Rating.new(params[:rating])

    respond_to do |format|
      if @rating.save
        format.json { render json: @rating, status: :created, location: @rating }
      else
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ratings/1
  # PUT /ratings/1.json
  def update
    @rating = Rating.find(params[:id])

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.json { head :no_content }
      else
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to ratings_url }
      format.json { head :no_content }
    end
  end
end
