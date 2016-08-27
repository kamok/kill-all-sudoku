class SudokuController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:solve_puzzle]

  def home
  end

  def solve_puzzle
    sudoku = Sudoku.new(params[:sudoku_string])
    render json: { solution: sudoku.solve }
  end
end