require 'set'

a = (1..rand(10)).to_a.map { { rand(100) => rand(100) } }

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
        combinations << {s1 => val + combinations.inject(&:merge).fetch(s2)}
      else
        combinations << {s1 => arr.map(&:values).flatten.inject(:+)}
      end
    end
  end

  combinations
end

def choose_best_combination(a, size)
  get_combinations(a).keep_if do |c|
    c.keys[0].inject(:+) <= size
  end.max { |c| c.values[0] }
end

puts choose_best_combination(a, 25)
