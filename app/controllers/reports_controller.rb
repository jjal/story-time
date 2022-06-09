class ReportsController < ApplicationController
	before_action :admin_user

	def recent_activity
		@activity= initialize_grid(Page,
			:order => 'created_at',
  			:order_direction => 'desc',
  			:joins => {:story => :user })
	end

	private
		
		def admin_user
      		redirect_to(root_path) unless !current_user.nil? and current_user.admin?
		end
end