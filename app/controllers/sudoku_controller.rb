class SudokuController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def home
  end

  def solve_puzzle
    render json: Sudoku.new.solve(params[:sudoku_string])
  end
end
