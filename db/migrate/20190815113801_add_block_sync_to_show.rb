class AddBlockSyncToShow < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :block_sync, :boolean, null: false, default: false
  end
end
