class UserSessionsController < ApplicationController

	before_filter :require_no_user, :only => [:new, :create]
	before_filter :require_user, :only => :destroy

	include UserSessionsHelper

	def new
		@user_session = UserSession.new
	end

	def create
		@user = get_user(params[:user_session])

		has_valid_email = valid_email?(params[:user_session][:email])
		has_valid_password = verify_recaptcha

		if !has_valid_email or !has_valid_password
			logger.debug "Invalid email/password"
			render :action => :new
		elsif @user.nil?
			logger.debug "User doesn't exist"
			redirect_to :signup
		else
			@user_session = UserSession.new(@user)
			if @user_session.save
				logger.info "Login succesful"
				flash[:notice] = "Login successful!"
				redirect_back_or_default :home
			else
				logger.debug "Login failed"
				flash[:notice] = "Login failed!"
				render :action => :new
			end
		end
	end

	def destroy
		current_user_session.destroy
		flash[:notice] = "Logout successful!"
		redirect_back_or_default :login
	end
end
