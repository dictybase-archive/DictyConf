class UsersController < ApplicationController

	respond_to :xml, :html

	#	before_filter :require_no_user, :only => [:new, :create]
	before_filter :require_user, :only => [:show, :edit, :update]

	def new
		email = params[:user_session][:email] if ! params[:user_session].nil?
		email ||= params[:email]
		@user = User.new(:email => email )
		respond_to do |format|
			format.html # new.html.erb
		end
	end

	def create
		@user = User.new(params[:user])
		@user.is_registered = 0
		respond_to do |format|
			if @user.save
				logger.info "Successfully created profile."
				flash[:notice] = "Successfully created profile."
				if session[:where_from] == 'registration'
					format.html { redirect_to(new_registrations_path(@user.id)) }
					format.xml { render :xml => @user, :status => :created, :location => @user }
				else
					format.html { redirect_to :home }
					format.xml { render :xml => @user, :status => :created, :location => @user }
				end
			else
				flash[:notice] = @user.errors
				if session[:where_from] == 'registration'
					# flash[:notice] = @user.errors
					format.html { redirect_to new_registrations_path }
					# format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
				else
					# flash[:notice] = @user.errors
					format.html { render :action => 'new' }
					# format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
				end
				format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
			end
		end
	end

	def show
		logger.info "Users#show, user credentials ID = #{session[:user_credentials_id]}"
		@user = User.find(session[:user_credentials_id])
	end

	def edit
		@user = User.find(@current_user.id)
		logger.info "Users#edit, user ID -  #{@user.id}"
	end

	def update
		logger.info "ID for User that is being updated #{@current_user.id}" 
		@user = User.find(@current_user.id)
		@user.attributes = params[:user]
		if session[:where_from] == 'registration'
			@user.is_registered = 1
		end

		if params[:commit] != 'Cancel'
			#respond_to do |format|
			if @user.save
				flash[:notice] = "Successfully updated registration"
				logger.info "Successfully updated registration for #{@user.email}"

				# RegistrationConfirmation.update_confirmation_to_host(@user).deliver
				# RegistrationConfirmation.update_confirmation_to_user(@user).deliver

				if session[:where_from] == 'registration'
					#format.html { redirect_to registrations_path(current_user) }
					redirect_to registrations_path(@user)
					#format.xml { render :xml => @user, :status => :created, :location => @user }
				else
					#		format.html {redirect_to :home}
					redirect_to users_path(@user)
				end
			else
				logger.info "Unable to update registration."
				#format.html { render :action => "edit" }
				render :action=>"edit"
				#format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
			end
			#end
		else
			flash[:notice] = "Cancelled"
			redirect_to registrations_path(current_user)
		end
	end
end
