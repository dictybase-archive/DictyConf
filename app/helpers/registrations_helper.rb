module RegistrationsHelper

	def registration_open?
		registration_begin = DictyConfig.registration['begin']
		registration_end = DictyConfig.registration['end']
		DateTime.parse(registration_end) >= DateTime.now and DateTime.parse(registration_begin) <= DateTime.now ? true: false
	end
end
