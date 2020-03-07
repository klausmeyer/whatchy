class AddRatingtoShow < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :rating, :decimal, null: false, precision: 3, scale: 1, default: 0.0
  end
end
