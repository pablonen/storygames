class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.references :author, null: false, foreign_key: true
      t.string :filename
      t.text :topic
      t.timestamps
    end
  end
end
