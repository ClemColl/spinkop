class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :issue, foreign_key: true
      t.integer :author_id, index: true
      t.foreign_key :users, column: :author_id
      t.text :content

      t.timestamps
    end
  end
end
