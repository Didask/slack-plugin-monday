class CreateFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :features do |t|
      t.string :feature_name
      t.string :feature_type
      t.string :board_id
      t.string :new_items_group
      t.jsonb :blocks
      t.timestamps null: false
    end
  end
end
