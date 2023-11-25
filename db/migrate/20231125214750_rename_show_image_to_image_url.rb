class RenameShowImageToImageUrl < ActiveRecord::Migration[7.1]
  def change
    rename_column :shows, :image, :image_url
  end
end
