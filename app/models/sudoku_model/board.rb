class Board
  attr_reader :cells, :rows, :columns, :blocks

  ROW_ID = ["A","B","C","D","E","F","G","H","I"]
  COLUMN_ID = ["1","2","3","4","5","6","7","8","9"]
  BLOCK_ID = COLUMN_ID

  def initialize(data)
    @cells, @rows, @columns, @blocks = [], [], [], []
    make_board
    @number_of_solved_cells = 0
    @array_representation = data
  end

  def update_possible_values
    @cells.each {|cell| cell.possible_values.clear if cell.value != 0}

    update_structure(@rows) && update_structure(@columns) && update_structure(@blocks)
  end

  def solve!
    return false unless valid?
    if solved?
      update_array_representation
      return  @array_representation
    end

    next_cell = get_next_cell

    (next_cell.possible_values).each do |attempt|
      next_cell.value = attempt                  
      update_array_representation
      a = Board.new(@array_representation)
      a.set_initial_values
      solution = a.solve!
      return solution if solution
    end

    return false
  end

  def has_no_more_freebies?
    freebies_in_current_iteration = 0
    cells.each do |cell|
      if cell.value != 0
        freebies_in_current_iteration += 1
      end
    end
    if freebies_in_current_iteration == @number_of_solved_cells
      true
    else
      @number_of_solved_cells = freebies_in_current_iteration
      false
    end 
  end

  def set_initial_values
    copy_of_array = @array_representation.dup
    @rows.each do |row|
      row.cells.each do |cell|
        cell.value = copy_of_array.shift
      end
    end
  end

  private

  def make_board
    initialize_default_cells
    initialize_default_structure
  end

  def initialize_default_cells
    cell_counter, row, column = 0, 0, 0
    block = 1
    
    until cell_counter == 81
      1.times do 
        break if cell_counter == 0
        if cell_counter % 1 == 0
          column += 1
        end
        if cell_counter % 3 == 0
          block += 1
        end
        if cell_counter % 9 == 0
          column -= 9
          row += 1
          block -= 3
        end
        if cell_counter % 27 == 0
          block += 3
        end
      end
      @cells << Cell.new(ROW_ID[row], COLUMN_ID[column], block)
      cell_counter += 1
    end
  end

  def initialize_default_structure
    counter = 0
    until counter == 9
      @rows << Row.new(ROW_ID[counter], @cells)
      @columns << Column.new(COLUMN_ID[counter], @cells)
      @blocks << Block.new(BLOCK_ID[counter], @cells)
      counter += 1
    end
  end

  def update_structure(structure)
    structure.each do |struct|
      structure_values = []
      struct.cells.each do |cell|
        structure_values << cell.value if cell.value > 0
      end

      struct.cells.each do |cell|
        cell.possible_values -= structure_values
      end
    end
  end

  def update_array_representation
    @array_representation = 
    [].tap do |string|
      cells.each do |cell|
        string << cell.value
      end
    end
  end

   def get_next_cell
    update_possible_values
    cells.sort_by { |cell| cell.possible_values.count }.each { |cell| return cell if cell.value == 0 }
  end

  def solved?
    cells.each do |cell|
      return false if cell.value == 0
    end
  end

  def valid?
    no_dups?(rows) && no_dups?(columns) && no_dups?(blocks)
  end

  def no_dups?(structure)
    structure.each do |struct|
      return false if struct.values.uniq.length != struct.values.length
    end
    true
  end

end