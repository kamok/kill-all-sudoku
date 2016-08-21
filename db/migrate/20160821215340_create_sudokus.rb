class CreateSudokus < ActiveRecord::Migration
  def change
    create_table :sudokus do |t|

      t.timestamps null: false
    end
  end
end
