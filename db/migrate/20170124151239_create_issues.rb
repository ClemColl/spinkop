class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.string :content
      t.references :theme, foreign_key: true

      t.timestamps
    end
  end
end
