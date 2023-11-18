class CreateMedia < ActiveRecord::Migration[7.1]
  def change
    create_table :medias do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.references :title, null: false, foreign_key: true

      t.timestamps
    end
  end
end
