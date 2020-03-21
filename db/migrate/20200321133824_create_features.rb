class CreateFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :features do |t|
      t.string :feature_name
      t.string :board_id
      t.jsonb :columns
      t.jsonb :modal_blocks
      t.timestamps null: false
    end
  end
end
