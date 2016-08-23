class Row
  attr_reader :cells, :id

  def initialize(row_id, all_cells)
    @cells = []
    all_cells.map do |cell|
      if cell.row == row_id
        @cells << cell
      end
    end
    @id = row_id
  end

  def values
    [].tap do |value_collection|
      @cells.each do |cell|
        value_collection << cell.value if cell.value != 0
      end
    end
  end
end