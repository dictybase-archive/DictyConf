class AddDefaultForIsRegisteredToUser < ActiveRecord::Migration

	def change
		change_column :users, :is_registered, :boolean, null: false, default: false
	end
end
