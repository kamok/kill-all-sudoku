class SudokuController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:solve_puzzle]
  before_action :sanitize_puzzle, only: [:solve_puzzle]
  def home
  end

  def solve_puzzle
    found = Sudoku.find_or_create_by(puzzle: params[:sudoku_string])
    solution = found.detect(params[:sudoku_string])

    render json: { solution: solution }
  end

  private

  # should move this to a helper
  def sanitize_puzzle
    puzzle = params[:sudoku_string].split("")

    puzzle.map! do |value|
      value = 0 if value == "."
      unless value.is_a_number?
        render json: { error: "Your sudoku puzzle is invalid."}
      end
      value
    end

    params[:sudoku_string] = puzzle.join
  end
  
end