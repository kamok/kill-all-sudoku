class SudokuController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def home
  end

  def solve_puzzle
    sudoku = Sudoku.new(params[:sudoku_string])
    render json: { solution: sudoku.solve }
  end
end
