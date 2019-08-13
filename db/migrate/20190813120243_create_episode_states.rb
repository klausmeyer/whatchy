class CreateEpisodeStates < ActiveRecord::Migration[6.0]
  def change
    create_table :episode_states do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :episode, null: false, foreign_key: true
      t.datetime :seen_at

      t.timestamps
    end
  end
end
