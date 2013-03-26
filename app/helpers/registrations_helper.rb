module RegistrationsHelper

	def registration_open?
		DateTime.parse(DictyConfig.registration['end']) >= DateTime.now and DateTime.parse(DictyConfig.registration['begin']) <= DateTime.now ? true: false
	end
end
