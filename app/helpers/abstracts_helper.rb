module AbstractsHelper
	def abstracts_submission_open?
		submission_begin = DictyConfig.abstracts['begin']
		submission_end = DictyConfig.abstracts['end']
		DateTime.parse(submission_end) >= DateTime.now and DateTime.parse(submission_begin) <= DateTime.now ? true : false
	end

	def can_edit?(record=nil)
		record ||= @abstract || @user
		raise ArgumentError, "No record specified" unless record
		return true if is_admin?
		return true if logged_in? && (current_user.id == record.user_id) && abstracts_submission_open?
	end
end
