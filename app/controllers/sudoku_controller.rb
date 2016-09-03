class SudokuController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:solve_puzzle]
  before_action :sanitize_puzzle, only: [:solve_puzzle]
  
  def home
  end

  def solve_puzzle
    puzzle = Sudoku.find_or_create_by(puzzle: params[:sudoku_string])
    
    render json: { solution: puzzle.fetch_or_solve(params[:sudoku_string]) }
  end

  private

  def sanitize_puzzle
    params[:sudoku_string] = Sudoku.sanitize(params[:sudoku_string])
    
    case params[:sudoku_string]
      when false
        render json:{ error: "Your sudoku puzzle is invalid."}
      when "more_than_one_solution"
        render json:{ error: "Your sudoku puzzle has more than one solution."}
      when "has_special_characters"
        render json:{ error: "Your input has weird special characters."}
      end
  end

end