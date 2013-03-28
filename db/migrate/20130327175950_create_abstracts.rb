class CreateAbstracts < ActiveRecord::Migration
	def change
		create_table :abstracts do |t|
			t.integer :user_id
			t.string :title
			t.string :presenter
			t.text :abstract
			t.boolean :agreement
			t.text :note_to_organizers
			t.string :abstract_type
			t.string :authors
			t.text :address
			t.timestamps
		end
	end
end
