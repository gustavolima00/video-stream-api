class CreateRawVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :raw_videos do |t|
      t.uuid :uuid, null: false
      t.string :raw_video_path
      t.string :process_subtitles_status
      t.string :process_video_status
      t.string :external_uuid
      t.string :name
      t.references :media, null: false, foreign_key: true

      t.timestamps
    end
  end
end
