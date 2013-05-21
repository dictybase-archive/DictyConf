class AddMoreDetailsToUserForRegistration < ActiveRecord::Migration
	def change
		add_column :users, :institute, :string
		add_column :users, :zipcode, :string
		add_column :users, :phone, :integer
	end
end
