class AddFirstAiredToEpisode < ActiveRecord::Migration[6.0]
  def change
    add_column :episodes, :first_aired, :date
  end
end
