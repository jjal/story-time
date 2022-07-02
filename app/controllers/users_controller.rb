class UsersController < ApplicationController
	include BadgesHelper
  before_action :signed_in_user, only: [:index, :edit, :update]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: :destroy
	
	def users_params
		params.permit(:page, { user: [:name, :email, :password, :password_confirmation]}, :id, :utf8, :authenticity_token, :commit)
  end

	def index
		@users = User.paginate(page: users_params[:page]).order("name")
	end
	
	def show
		@user = User.find(users_params[:id])
		@microposts = @user.microposts.paginate(page: users_params[:page])
		@stories = (signed_in? and (current_user?(@user) or current_user.admin?)) ? 
			@user.stories : 
			@user.stories.where(["status= ?",Story::PUBLISHED])
	end

	def edit
		#defined in correct_user
    #@user = User.find(users_params[:id])
  	end
	
	def new
		@user = User.new
  end
	
	def create
		#hack to force session load
		session["init"] = true
    	@user = User.new(users_params[:user])
    	if @user.save
			sign_in @user
      		flash[:success] = "Welcome to Story Time! "
      		redirect_to @user
    	else
      		render 'new'
    end
  end
	
	def update
    #defined in correct user
		#@user = User.find(users_params[:id])
    if @user.update_attributes(users_params[:user])
			flash[:success] = "Profile updated"
			sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
	 
	def destroy
    User.find(users_params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
	
	private
		
	def correct_user
      @user = User.find(users_params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
		
		def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
