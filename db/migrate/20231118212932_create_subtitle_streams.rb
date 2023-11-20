class CreateSubtitleStreams < ActiveRecord::Migration[7.1]
  def change
    create_table :subtitle_streams do |t|
      t.string :path
      t.string :language
      t.string :name
      t.references :media, null: false, foreign_key: true

      t.timestamps
    end
  end
end
