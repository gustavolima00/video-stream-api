class CreateVideoStreams < ActiveRecord::Migration[7.1]
  def change
    create_table :video_streams do |t|
      t.string :url
      t.string :language
      t.string :name
      t.references :media, null: false, foreign_key: true

      t.timestamps
    end
  end
end
