require 'spec_helper'

describe UserSessionsController do

	fixtures :users

	it "should create user session" do
		post :create, :user_session => { :email => "jane_doe@antartica.org" }
		assert user_session = UserSession.find
		users(:one).should == user_session.user
		users(:two).should_not == user_session.user
		assert_redirected_to :home
	end

	it "should destroy existing session" do
		delete :destroy
		assert_nil UserSession.find
		assert_redirected_to new_user_session_url
	end

end
