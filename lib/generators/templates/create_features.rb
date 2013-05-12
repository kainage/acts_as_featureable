class CreateFeatures < ActiveRecord::Migration
	def change
		create_table :features do |t|
			t.string :title
			t.text :summary
			t.references :featureable, :polymorphic => true
		end
		
		add_index :features, [:commentable_type, :commentable_id]
	end
end