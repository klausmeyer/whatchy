class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.belongs_to :show, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
