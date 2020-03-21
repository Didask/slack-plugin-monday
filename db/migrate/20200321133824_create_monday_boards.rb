class CreateMondayBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :monday_boards do |t|
      t.string :board_id
      t.jsonb :columns
      t.jsonb :modal_blocks
      t.timestamps null: false
    end
  end
end
