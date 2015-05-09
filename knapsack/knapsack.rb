class Knapsack
  def initialize(size:)
    @knapsack_size = size
  end

  def pack(items)
    # Initialize matrix with zeroes. For knapsack of size zero or for zero
    # elements chosen, first row and column should have zeros.
    initialize_matrix_for(items.count)

    # For each item
    items.each_with_index do |item, i|
      weight, value = item[0], item[1]

      # For knapsacks from size 0 to given size
      (0..knapsack_size).each do |capacity_x|
        if weight > capacity_x
          # Item doesn't fit in knapsack_size of capacity_x, can't select,
          # copy previous (best) value
          matrix[i][capacity_x] = matrix[i-1][capacity_x]
        else
          # hey item fits! What would happen if...
          matrix[i][capacity_x] = [
              # we selected it
              matrix[i-1][capacity_x - weight] + value,
              # we didn't select it
              matrix[i-1][capacity_x]
            ].max # Value in current cell: best of either case
        end
      end
    end

    # Return value for given knapsack_size and number of elements (best maximum)
    matrix[items.count - 1][knapsack_size]
  end

  private

  attr_reader :matrix, :knapsack_size

  def initialize_matrix_for(number_of_items)
    @matrix = [].tap do |m|
      (number_of_items + 1).times { m << Array.new(knapsack_size + 1, 0) }
    end
  end
end
