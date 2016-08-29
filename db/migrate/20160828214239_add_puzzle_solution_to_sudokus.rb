class AddPuzzleSolutionToSudokus < ActiveRecord::Migration
  def change
    add_column :sudokus, :puzzle, :string
    add_column :sudokus, :solution, :string
  end
end
