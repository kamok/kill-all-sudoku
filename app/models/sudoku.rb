class Sudoku < ActiveRecord::Base
  attr_reader :board
  def initialize(data)
    data = parse_import(data)
    @board = Board.new(data)
    @board.set_initial_values
    until @board.no_more_freebies? 
      @board.update_possible_values 
      @board.cells.each(&:solve)
    end
  end

  def solve
    answer = @board.solve!
    case answer 
      when false
        "This sudoku puzzle is invalid."
      else
        answer.join
      end
  end

  private

  def parse_import(raw_data)
    raw_data.split("").map do |value|
      value == "." ? value = 0 : value.to_i
    end
  end

end
