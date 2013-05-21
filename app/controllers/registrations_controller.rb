class RegistrationsController < ApplicationController

	def new
		logger.info 'User is ***not*** registered'
		@user = User.new(:email => session[:email])
		render :action => 'new'
	end

	def create
		@user = User.new(params[:user])
		@user.is_registered = 1
		if @user.save
			# logger.info "Sending an email to #{@user.email}"

			# Send confirmation emails to the host and the user
			# RegistrationConfirmation.registration_confirmation_to_user(@user).deliver
			# RegistrationConfirmation.registration_confirmation_to_host(@user).deliver

			logger.info "Registration successful"
			flash[:notice] = "Registration Successful"
			render action: "confirm"
		else
			flash[:notice] = @user.errors
			render action: "new"
		end
	end

	def edit
		logger.info "Editing user registration #{current_user.email}"
		@user = User.find(@current_user.id)
		render action: 'edit'
	end

	def update

	end

	def index
		session[:where_from] = 'registration'
	end

	def show
		@user = User.find(@current_user.id)
	end
end
