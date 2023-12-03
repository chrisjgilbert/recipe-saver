class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.text :url, null: false
      t.string :title, null: false
      t.text :description, null: true
      t.text :image_url, null: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
