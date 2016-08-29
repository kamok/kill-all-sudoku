class Sudoku < ActiveRecord::Base
  attr_reader :board

  def self.solve(data)
    data = parse_import(data)
    @board = Board.new(data)
    @board.set_initial_values
    until @board.no_more_freebies? 
      @board.update_possible_values 
      @board.cells.each(&:solve)
    end
    return false if @board.has_less_than_17_clues?

    answer = @board.solve!
    case @board.solve!
      when false
        "This sudoku puzzle is invalid."
      else
        answer.join
      end
  end

  def detect(unsolved_puzzle)
    if solution.present?
      solution
    else 
      self.solution = Sudoku.solve(unsolved_puzzle)
      self.save
      solution
    end
  end

  private

  def self.parse_import(raw_data)
    raw_data.split("").map do |value|
      value == "." ? value = 0 : value.to_i
    end
  end

end
