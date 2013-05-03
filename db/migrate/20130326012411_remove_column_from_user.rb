class RemoveColumnFromUser < ActiveRecord::Migration
	def up
		remove_column :users, :crypted_password
		remove_column :users, :password_salt
	end

	def down
		add_column :users, :crypted_password, :null => false
		add_column :users, :password_salt
	end
end
