class AddPublishDateToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :publish_date, :datetime, :null => false
  end
end
