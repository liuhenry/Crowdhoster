class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.text :title
      t.text :body
      t.boolean :published_flag, :null => false, :default => false

      t.string :slug

      t.references :campaign

      t.timestamps
    end
    add_index :updates, :campaign_id
    add_index :updates, [:campaign_id, :slug], :unique => true
  end
end
