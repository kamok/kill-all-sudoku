class SudokuController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:solve_puzzle]

  def home
  end

  def solve_puzzle
    found = Sudoku.find_or_create_by(puzzle: params[:sudoku_string])
    
    solution = found.detect(params[:sudoku_string])

    render json: { solution: solution }
  end

  def save_solution(solution)
    Sudoku.find_or_create_by(puzzle: params[:sudoku_string], solution: solution )
  end
  
end