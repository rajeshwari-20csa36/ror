class CreateUserCommentRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_comment_ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
