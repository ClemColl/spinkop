class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :article, foreign_key: true
      t.integer :author_id, index: true
      t.foreign_key :users, column: :author_id
      t.text :content
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
