require "minitest/autorun"
require_relative "knapsack"

describe Knapsack do
  describe '#pack' do
    it 'accepts only items that fit' do
      knapsack = Knapsack.new(size: 11)

      # An items hash has size for keys and
      # worth for values
      items = {
        12 => 25,
        15 => 35,
        18 => 67
      }

      knapsack.pack(items).must_be_empty
    end

    it 'optimizes for item value' do
      knapsack = Knapsack.new(size: 11)

      items = {
        2  => 1,
        5  => 10,
        6  => 20,
        9  => 24,
        11 => 28,
        14 => 36
      }

      other_items = {
        3  => 9,
        12 => 29,
        18 => 14,
        2  => 3
      }

      expected_items = {
        5 => 10,
        6 => 20
      }

      expected_other_items = {
        3 => 9,
        2 => 3
      }

      knapsack.pack(items).must_equal expected_items
      knapsack.pack(other_items).must_equal expected_other_items
    end

    it 'doesn\'t get tricked by value/weight ratios' do
      knapsack = Knapsack.new(size: 5)
      items = {
        2 => 2,
        3 => 3,
        4 => 4.5
      }

      result = knapsack.pack(items)

      result.must_equal(2 => 2, 3 => 3)
    end

    it 'can have empty space' do
      knapsack = Knapsack.new(size: 11)

      items = {
        1 => 8,
        3 => 4
      }

      knapsack.pack(items).must_equal items
    end

    it 'ignores negative weights' do
      knapsack = Knapsack.new(size: 11)

      items = {
        -1 => 5,
        -3 => -8,
         2 => -2,
         8 => 10
      }

      expected = {8 => 10}

      knapsack.pack(items).must_equal expected
    end
  end
end
