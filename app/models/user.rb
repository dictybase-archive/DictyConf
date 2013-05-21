class User < ActiveRecord::Base

	acts_as_authentic do |c|
		c.login_field :email
		c.validate_password_field(false)
	end

	attr_accessible :firstname, :lastname, :email, :is_admin, :address, :city, :country, :zipcode, :institute, :phone

	validates :email,
		:presence => true,
		:uniqueness => true,
		:format => {
			:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
		}

	def name
		[firstname, lastname].join(' ')
	end
end
