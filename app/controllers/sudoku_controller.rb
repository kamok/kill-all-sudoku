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

  def sanitize_puzzle
    params[:sudoku_string] = Sudoku.sanitize(params[:sudoku_string])
    
    if params[:sudoku_string] == false
      render json: { error: "Your sudoku puzzle is invalid."}
    end
  end

end