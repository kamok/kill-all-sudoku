class Sudoku < ActiveRecord::Base
  attr_reader :board

  def detect(unsolved_puzzle)
    if !solution.present? 
      self.solution = Sudoku.solve(unsolved_puzzle)
      self.save
    end
    solution
  end

  def self.solve(data)
    @board = Board.new(data)
    @board.set_initial_values
    
    until @board.has_no_more_freebies? 
      @board.update_possible_values 
      @board.cells.each(&:solve)
    end

    @board.solve!
  end

  # Sudoku.solve('.2...7..5.........6...95..1.7...413.......2....1.5...67...1.8...8..7.......2...49')

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
