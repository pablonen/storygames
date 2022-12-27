class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :message
      t.string :author
      t.string :references
      t.timestamp :posted_at
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
