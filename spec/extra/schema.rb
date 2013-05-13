ActiveRecord::Schema.define :version => 0 do
	create_table :features do |t|
		t.references :featureable, :polymorphic => true
		t.string :title
		t.text :summary
		t.integer :position, :null => false
		t.timestamps
	end
	
	add_index :features, [:featureable_type, :featureable_id]
	
	create_table :topics do |t|
		t.string :title
		t.text :summary
	end
end