class CreatePossessions < ActiveRecord::Migration
  def change
    create_table :possessions do |t|
      t.integer :gbd_id
      t.references :list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
