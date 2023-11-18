class CreateTitles < ActiveRecord::Migration[7.1]
  def change
    create_table :titles do |t|
      t.string :name
      t.text :description
      t.string :kind
      t.string :image_url

      t.timestamps
    end
  end
end
