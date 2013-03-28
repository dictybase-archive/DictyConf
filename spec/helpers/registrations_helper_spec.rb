require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the RegistrationsHelper. For example:
#
# describe RegistrationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe RegistrationsHelper do
	before(:each) do
		DictyConfig.registration['begin'] = DateTime.now.to_s
		DictyConfig.registration['end'] = (DateTime.now + 10.days).to_s
	end

	it "registration should be open" do
		registration_open?.should == true
	end

	it "registration should be closed" do
		DictyConfig.registration['end'] = DateTime.now.ago(2.hours).to_s
		registration_open?.should_not == true
	end
end
