class AbstractsController < ApplicationController
	skip_before_filter :login_required, :only => [ :index, :show ]

	def index
		logger.debug "########## #{params[:user_id]}"
		if params[:user_id]
			@abstracts = Abstract.find(:all, :conditions =>[:user_id => params[:user_id] ])
		else
			@abstracts = Abstract.all
		end
		respond_to do |format|
			format.html # index.html.erb
			#format.xml { render :xml => @abstracts }
		end
	end

	def show
		logger.debug "***** #{params[:id]}"
		@abstract = Abstract.find(params[:id])
		#@abstract = Abstract.where(:user_id => current_user.id).find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
			#format.xml { render :xml => @abstract }
		end
	end

	def edit

	end
end
