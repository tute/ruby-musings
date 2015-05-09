class Knapsack
  def initialize(size:)
    @size = size
  end

  attr_reader :size

  def pack(items)
    knapsack = {}

    sorted_items(items).each do |item|
      weight = item[0]
      value  = item[1]

      if space(knapsack) >= weight
        knapsack[weight] = value
      end
    end

    return knapsack
  end

  private

  def space(knapsack)
    size - knapsack.keys.inject(:+).to_i
  end

  def sorted_items(items)
    items.reject { |k,v| k < 0 || v < 0 }
      .sort_by { |k,v| v / k }.reverse
  end
end
