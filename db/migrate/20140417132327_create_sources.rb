class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.integer :member_id, null: false
      t.string :name, null: false
      t.string :description
      t.string :source_url
      t.string :link_url
      t.string :image_url
      t.string :parser_class, null: false
      t.datetime :last_published_at

      t.timestamps
      t.datetime :deleted_at

      t.index :last_published_at
      t.index :member_id
    end
  end
end
