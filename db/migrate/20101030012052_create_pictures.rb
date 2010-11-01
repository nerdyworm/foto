class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string    :name
      t.string    :tags
      t.integer   :user_id
      t.boolean   :private, :default => true
      t.string    :pic_file_name
      t.string    :pic_content_type
      t.integer   :pic_file_size
      t.datetime  :pic_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
