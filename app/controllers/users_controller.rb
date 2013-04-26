class UsersController < ApplicationController

	before_filter :require_no_user, :only => [:new, :create]
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
		if @user.save
			flash[:notice] = "Account registered!"
			redirect_back_or_default :home
		else
			render :action => :new
		end
	end

	def show
		@user = @current_user
	end

	def edit
		@user = @current_user
	end

	def update
		@user = @current_user
		if @user.update_attributes(params[:user])
			flash[:notice] = "Account updated!"
			redirect_to :home
		else
			render :action => :edit
		end
	end
end
