require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the UserHelper. For example:
#
# describe UserHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
# TODO - Find current_user. Fix the two tests
describe UsersHelper do

	fixtures :users

	before(:each) do
		activate_authlogic
	end

	it "should tell if user is admin" do
		UserSession.create(users(:two))
		#helper.stub!(:current_user_session).and_return(UserSession.find)
		is_admin?.should == true
		#UserSession.destroy
		#UserSession.create(users(:one))
		#is_admin?.should_not == true
	end

	it "should tell if user is logged in" do
		logged_in?.should_not == true
		UserSession.create(users(:one))
		logged_in?.should == true
	end

end
