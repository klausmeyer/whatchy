class AddSlugToShow < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :slug, :string, null: false, default: -> { 'md5(random()::text)' }
    add_index :shows, :slug, unique: true
  end
end
