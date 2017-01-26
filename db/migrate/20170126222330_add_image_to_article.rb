class AddImageToArticle < ActiveRecord::Migration[5.0]
  def change
    change_table :articles do |t|
      t.attachment :image
    end
  end
end
