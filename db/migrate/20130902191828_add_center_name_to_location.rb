class AddCenterNameToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :center_name, :string
  end
end
