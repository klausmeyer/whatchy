class AddImdbRefToShow < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :imdb_ref, :string
  end
end
