class CreateFeatures < ActiveRecord::Migration
	def change
		create_table :features do |t|
			t.references :featureable, :polymorphic => true
			t.string :title
			t.text :summary
			t.integer :position, :null => false
			t.timestamps
		end
		
		add_index :features, [:featureable_type, :featureable_id]
	end
end