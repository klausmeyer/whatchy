class AddLanguageToShow < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :language, :string, null: false, default: 'en'
  end
end
