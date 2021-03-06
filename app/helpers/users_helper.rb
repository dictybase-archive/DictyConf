module UsersHelper

	def is_admin?
		return true if logged_in? && current_user.is_admin
	end

	def logged_in?
		!current_user.blank?
	end

	def is_registered? #(user=nil)
		return true if logged_in? && current_user.is_registered
	end

end
