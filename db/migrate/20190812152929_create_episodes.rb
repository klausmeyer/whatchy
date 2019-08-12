class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.belongs_to :season, null: false, foreign_key: true
      t.integer :number
      t.string :title

      t.timestamps
    end
  end
end
