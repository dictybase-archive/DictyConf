class AbstractsController < ApplicationController
	skip_before_filter :login_required, :only => [ :index, :show ]

	def index
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

	def new
		@abstract = Abstract.new( :user_id => params[:user_id] )
		respond_to do |format|
			format.html # new.html.erb
			format.xml { render :xml => @abstract }
		end
	end

	def create

		@abstract = Abstract.new(params[:abstract])

		respond_to do |format|
			if @abstract.save
				logger.info "Abstract submission successful"
				format.html { redirect_to(@abstract, :notice => 'Abstract was successfully created.') }
				format.xml { render :xml => @abstract, :status => :created, :location => @abstract }
			else
				format.html { render :action => "new" }
				format.xml { render :xml => @abstract.errors, :status => :unprocessable_entity }
			end
		end
	end

	def show
		@abstract = Abstract.find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
			#format.xml { render :xml => @abstract }
		end
	end

	def edit

	end

	def update

	end

	def destroy

	end
end
