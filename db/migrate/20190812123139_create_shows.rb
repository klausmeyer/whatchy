class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.string :thetvdb_ref
      t.string :title
      t.string :image
      t.text :overview

      t.timestamps
    end
  end
end
