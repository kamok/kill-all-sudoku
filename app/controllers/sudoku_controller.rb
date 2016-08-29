class SudokuController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:solve_puzzle]

  def home
  end

  def solve_puzzle
      # response = fetch_solution || Sudoku.new(params[:sudoku_string]).solve
    found = Sudoku.find_or_create_by(puzzle: params[:sudoku_string])
    if found.solution.present?
      solution = found.solution
    else 
      found.solution = Sudoku.solve(params[:sudoku_string]) 
      found.save
    end 


    # solution = Sudoku.solve(params[:sudoku_string])
    # save_solution(solution)
    render json: { solution: found.solution }
  end

  # def fetch_solution(puzzle)
  #   Sudoku.all.where("puzzle = ? ", params[:sudoku_string]).solution
  # end

  def save_solution(solution)
    Sudoku.find_or_create_by(puzzle: params[:sudoku_string], solution: solution )
  end
  
end