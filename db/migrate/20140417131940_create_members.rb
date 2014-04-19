class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :description
      t.string :link_url
      t.string :image_url
      t.datetime :last_published_at

      t.timestamps
      t.datetime :deleted_at

      t.index :last_published_at
    end
  end
end
