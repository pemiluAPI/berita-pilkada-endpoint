class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
    	t.integer :candidate_id
      t.integer :region_id
    	t.integer :resource_id
    	t.date :date
    	t.string :link
    	t.text :description

      t.timestamps
    end
  end
end
