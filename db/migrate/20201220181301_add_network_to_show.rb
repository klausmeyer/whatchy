class AddNetworkToShow < ActiveRecord::Migration[6.1]
  def change
    add_column :shows, :network, :string
  end
end
