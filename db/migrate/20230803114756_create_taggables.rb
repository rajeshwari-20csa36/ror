class CreateTaggables < ActiveRecord::Migration[6.1]
  def change
    create_table :taggables do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
