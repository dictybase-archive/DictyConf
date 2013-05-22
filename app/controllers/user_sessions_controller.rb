class UserSessionsController < ApplicationController

	before_filter :require_no_user, :only => [:new, :create]
	before_filter :require_user, :only => :destroy

	include UserSessionsHelper, UsersHelper

	def new
		@user_session = UserSession.new
	end

	def create
		@user = get_user(params[:user_session])
		session[:email] = params[:user_session][:email]

		has_valid_email = valid_email?(params[:user_session][:email])
		has_valid_password = verify_recaptcha

		if !has_valid_email or !has_valid_password
			logger.info 'Invalid user name and password'
			flash[:notice] = 'Invalid email and/or password, Please try again'
			@user_session = UserSession.new
			render :action => :new
		else
			if @user.nil?
				if session[:where_from] == 'registration'
					if !is_registered?
						flash[:notice] = "You are not registered"
						redirect_to new_registrations_path
					else
						flash[:notice] = "You are already registered with #{params[:user_session][:email]}"
						redirect_to registrations_path(:id => @user.id)
					end
				end
				redirect_to :signup
			else
				@user_session = UserSession.new(@user)
				if @user_session.save
					logger.info "Successfully logged in user #{params[:user_session][:email]}."
					logger.info "#{session[:where_from]}"

					if session[:where_from] == 'registration'
						if is_registered?
							logger.info "Already registered"
							flash[:notice] = "You are already registered with #{params[:user_session][:email]}"
							redirect_to registrations_path(:id => @user.id)
							return
						elsif !is_registered? and @user.email.empty? == false
							logger.info "NOT registered, but account exists"
							flash[:notice] = "You are NOT registered, but your account exists with email #{params[:user_session][:email]}"
							redirect_to edit_registrations_path(:id => @user.id)
							return
						else
							logger.info "#{session[:email]} is not registered. Taking him to registration form"
							redirect_to new_registrations_path
							return
						end
					else
						if is_admin?
							flash[:notice] = "Logged in as admin"
							redirect_to admin_url
							return
						else
							redirect_to :home
							return
						end
					end
				else
					logger.info 'Login failed !!!'
					flash[:notice_error] = "Unable to login with #{params[:user_session][:email]}, Please try again"
					render :action => :new
				end
			end
		end
	end

	def destroy
		current_user_session.destroy if !current_user_session.nil?
		flash[:notice] = "Logout successful!"
		redirect_back_or_default :login
	end
end
