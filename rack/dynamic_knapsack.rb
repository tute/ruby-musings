require 'set'

class Knapsack
  def initialize(size:)
    @size = size
  end

  attr_reader :size

  def pack(items)
    return {} if items.all? { |k, v| k > size }

    items.reject! { |k, v| k < 0 || v < 0 }
    item_arr = items.map { |k,v| { k => v } }

    best_combo = get_combinations(item_arr).keep_if do |c|
      c.keys[0].inject(:+) <= size
    end.max { |c| c.values[0] }

    best_combo.keys.first.each_with_object({}) { |key, h| h[key] = items[key] }
  end

  private

  def get_combinations(a)
    combinations = []

    (1..a.length).each do |i|
      a.combination(i).to_a.each do |arr|
        s1 = Set.new arr.map(&:keys).flatten
        s2 = s1.dup
        val = 0
        if combinations.any? { |com| com.keys[0].intersect? s1 }
          combinations.reverse_each do |combo|
            if combo.keys[0].intersect? s2
              r = s2 - combo.keys[0]
              val += combinations.inject(&:merge).fetch(r) if !r.empty?
              s2 -= r
            end
          end
          combinations << { s1 => val + combinations.inject(&:merge).fetch(s2) }
        else
          combinations << { s1 => arr.map(&:values).flatten.inject(:+) }
        end
      end
    end

    combinations
  end
end
