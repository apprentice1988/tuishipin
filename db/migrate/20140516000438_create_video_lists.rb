class CreateVideoLists < ActiveRecord::Migration
  def change
    create_table :video_lists do |t|
      t.string :title
      t.text :description

      t.timestamps
    end

    create_table :videos do |t|
      t.string :type
      t.string :title
      t.integer :ups
      t.integer :downs
      t.integer :last_seconds
      t.integer :played_times
      t.string :ori_id
      t.text :description
      t.references :video_list, index: true
      t.string :tags, array: true, default: '{}'
    end
    add_index :videos, :tags, using: 'gin'
  end
end
