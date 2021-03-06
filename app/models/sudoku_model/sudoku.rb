class Sudoku < ActiveRecord::Base
  attr_reader :board

  def self.fetch_or_solve(puzzle)
    if solution = Sudoku.find_by(puzzle: puzzle)
      return solution.solution
    else
      solution = Sudoku.solve(puzzle)
    end

    if solution != false
      Sudoku.create(puzzle: puzzle, solution: solution).save
    end

    return solution
  end

  def self.solve(data)
    board = Board.new(data)
    
    board.set_initial_values
    board.fill_in_freebies
    board.solve!
  end

  def self.sanitize(puzzle)
    puzzle = puzzle.split("")

    puzzle.map! { |value| value == "." ? value = 0 : value }
    
    puzzle.each do |value| 
      return "has_special_characters" unless is_a_number?(value)
    end
    
    if has_more_than_one_solution?(puzzle.join)
      return "more_than_one_solution"
    end

    puzzle.join
  end

  private

  def self.is_a_number?(value)
    value.to_f.to_s == value.to_s || value.to_i.to_s == value.to_s
  end

  def self.has_more_than_one_solution?(puzzle_string)
    puzzle_string.count("1-9") < 17 ? true : false
  end

end
