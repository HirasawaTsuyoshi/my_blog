class CreateAuthers < ActiveRecord::Migration
  def change
    create_table :authers do |t|
      t.string :name
      t.string :description
      t.string :image_url

      t.timestamps null: false
    end
  end
end
