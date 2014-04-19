class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :source_id, null: false
      t.string :title, null: false
      t.text :summary, null: false
      t.string :link_url, null: false
      t.datetime :published_at, null: false

      t.timestamps
      t.datetime :deleted_at

      t.index :published_at
      t.index :source_id
    end
  end
end
